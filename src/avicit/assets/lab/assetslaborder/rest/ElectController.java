package avicit.assets.lab.assetslaborder.rest;


import avicit.assets.assetsattachment.controller.AssetsAttachmentController;
import avicit.assets.assetsattachment.dto.*;
import avicit.elect.dynelect.dto.DynElectDTO;
import avicit.elect.dynelect.dto.DynElectInfoVo;
import avicit.elect.dynelect.service.DynElectService;
import avicit.elect.dynelectlog.dto.DynElectLogDTO;
import avicit.elect.dynelectlog.service.DynElectLogService;
import avicit.elect.dynelectperson.dto.DynElectPersonDTO;
import avicit.elect.dynelectperson.service.DynElectPersonService;
import avicit.elect.dynnumplate.dto.DynNumPlateDTO;
import avicit.elect.dynnumplate.service.DynNumPlateService;
import avicit.elect.dynpersons.dto.DynPersonsDTO;
import avicit.elect.dynpersons.service.DynPersonsService;
import avicit.platform6.core.rest.resteasy.RestEasyController;
import com.alibaba.fastjson.JSONObject;
import org.apache.commons.collections.CollectionUtils;
import org.apache.commons.lang3.ArrayUtils;
import org.apache.commons.lang3.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;

import javax.ws.rs.POST;
import javax.ws.rs.Path;
import javax.ws.rs.Produces;
import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;

@RestEasyController
@Path("/assets/lab/assetslaborder/ElectContoller")
public class ElectController {
    private static final Logger logger = LoggerFactory.getLogger(AssetsAttachmentController.class);

    @Autowired
    private DynNumPlateService dynNumPlateService;
    @Autowired
    private DynElectService dynElectService;
    @Autowired
    private DynElectPersonService dynElectPersonService;
    @Autowired
    private DynPersonsService dynPersonsService;
    @Autowired
    private DynElectLogService dynElectLogService;

    /**
     * 根据号码牌获取当前选举活动规则
     *
     * @param electRuleVo
     */
    @POST
    @Path("/electActivityRule")
    @Produces("application/json;charset=UTF-8")
    public String getElectActivityRuleByNumPlate(ElectRuleVo electRuleVo) throws Exception {
        // 取得活动规则-当前最大轮数
        DynElectDTO dynElectDTO = dynElectService.getCurrentElectDTO();
        if (dynElectDTO == null) {
            return returnError("当前活动已结束！");
        }

        // 当前活动未开始的场合，取得上一轮活动信息
        if ("0".equals(dynElectDTO.getStatus())) {
            dynElectDTO = dynElectService.getLastElectDTO();

            if (dynElectDTO == null) {
                return returnError("当前活动未开始！");
            }
        }

        // 候选人名单
        List<DynElectPersonDTO> dynElectPersonDTOS = dynElectPersonService.getElectPersonByElectId(dynElectDTO.getId());
        if (CollectionUtils.isEmpty(dynElectPersonDTOS)) {
            logger.warn("候选人名单信息空!" + "------" + dynElectDTO.getId());
            return returnError("候选人名单信息空！");
        }

        // 根据活动规则取得号码牌信息
        DynNumPlateDTO dynNumPlateDTO = null;
        // 多个号码牌的场合
        if (1 == dynElectDTO.getScanPlan().intValue()) {
            if (StringUtils.isBlank(electRuleVo.getNumPlateId())) {
                return returnError("号码牌不能为空！");
            }
            dynNumPlateDTO = dynNumPlateService.queryDynNumPlateByPrimaryKey(electRuleVo.getNumPlateId());
        } else if (2 == dynElectDTO.getScanPlan().intValue()) {
            if (StringUtils.isBlank(electRuleVo.getToken())) {
                dynNumPlateDTO = getNewDynNumPlateDTO(dynElectDTO.getShouldInvestNum());
            } else {
                String[] tokenArr = electRuleVo.getToken().split("_");
                if (tokenArr.length != 3) {
                    logger.warn("token值有误!" + "------" + electRuleVo.getToken());
                    return returnError("token值有误！");
                }
                String groupId = tokenArr[0];
                String electId = tokenArr[1];
                String numId = tokenArr[2];

                // 活动组ID 和当前活动组一致的场合
                if (groupId.equals(dynElectDTO.getGroupId())) {
                    dynNumPlateDTO = dynNumPlateService.queryDynNumPlateByPrimaryKey(numId);
                } else {
                    dynNumPlateDTO = getNewDynNumPlateDTO(dynElectDTO.getShouldInvestNum());
                }
            }
        }

        if (dynNumPlateDTO == null) {
            return returnError("号码牌已失效，无法参与选举活动！");
        }

        // 未登录的状态时，更新状态
        if ("0".equals(dynNumPlateDTO.getLoginStatus())) {
            dynNumPlateDTO.setLoginStatus("1"); //已登录
            dynNumPlateService.updateDynNumPlateSensitive(dynNumPlateDTO);
        }

        // 查询号码牌是否已参与本次投票
        DynElectLogDTO dynElectPersonDTO = new DynElectLogDTO();
        dynElectPersonDTO.setNumPlate(dynNumPlateDTO.getId());
        dynElectPersonDTO.setElectId(dynElectDTO.getId());
        List<DynElectLogDTO> dynElectLogDTOList = dynElectLogService.searchDynElectLog(dynElectPersonDTO);

        DynElectInfoVo dynElectInfoVo = new DynElectInfoVo();
        dynElectInfoVo.setNumPlate(dynNumPlateDTO.getNum());
        dynElectInfoVo.setDynElectDTO(dynElectDTO);
        dynElectInfoVo.setDynElectPersonDTOS(dynElectPersonDTOS);
        dynElectInfoVo.setDynElectLogDTOList(dynElectLogDTOList);
        return returnSuccessData(dynElectInfoVo);
    }

    /**
     * 提交投票
     *
     * @param submitElectVo
     */
    @POST
    @Path(value = "/submitElect")
    @Produces("application/json;charset=UTF-8")
    public String submitElect(SubmitElectVo submitElectVo) throws Exception {
        if (StringUtils.isBlank(submitElectVo.getNumPlate()) || StringUtils.isBlank(submitElectVo.getElectId())) {
            return returnError("访问地址有误，无法参与选举活动！");
        }

        // 查询号码牌是否已参与本次投票
        DynElectLogDTO dynElectPersonDTO = new DynElectLogDTO();
        dynElectPersonDTO.setNumPlate(submitElectVo.getNumPlate());
        dynElectPersonDTO.setElectId(submitElectVo.getElectId());
        List<DynElectLogDTO> dynElectLog = dynElectLogService.searchDynElectLog(dynElectPersonDTO);
        if (CollectionUtils.isNotEmpty(dynElectLog)) {
            return returnError("您已参与过本次选举活动！");
        }

        // 取得活动信息
        DynElectDTO dynElectDTO = dynElectService.queryDynElectByPrimaryKey(submitElectVo.getElectId());
        if (!"1".equals(dynElectDTO.getStatus())) {
            return returnError("当前活动状态不可以投票！");
        }
        List<DynElectLogDTO> dynElectLogDTOList = new ArrayList<>();
        // 循环插入投票记录
        if (CollectionUtils.isNotEmpty(submitElectVo.getDynElectLogDTOS())) {
            for (DynElectLogDTO dynPersonsDTO : submitElectVo.getDynElectLogDTOS()) {
                DynElectLogDTO electLogDTO = new DynElectLogDTO();
                electLogDTO.setElectId(submitElectVo.getElectId());
                electLogDTO.setElectName(dynElectDTO.getName());
                electLogDTO.setPersonId(dynPersonsDTO.getPersonId());
                electLogDTO.setPersonName(dynPersonsDTO.getPersonName());
                electLogDTO.setPersonDeptName(dynPersonsDTO.getPersonDeptName());
                electLogDTO.setNumPlate(submitElectVo.getNumPlate());
                //根据传递的投票意见进行赋值
                if (dynPersonsDTO.getAgreeNum().compareTo(new BigDecimal(1)) == 0) {
                    electLogDTO.setAgreeNum(new BigDecimal(1));
                    electLogDTO.setUnagreeNum(new BigDecimal(0));
                    electLogDTO.setGiveupNum(new BigDecimal(0));
                }
                if (dynPersonsDTO.getUnagreeNum().compareTo(new BigDecimal(1)) == 0) {
                    electLogDTO.setUnagreeNum(new BigDecimal(1));
                    electLogDTO.setAgreeNum(new BigDecimal(0));
                    electLogDTO.setGiveupNum(new BigDecimal(0));
                }
                if (dynPersonsDTO.getGiveupNum().compareTo(new BigDecimal(1)) == 0) {
                    electLogDTO.setAgreeNum(new BigDecimal(0));
                    electLogDTO.setUnagreeNum(new BigDecimal(0));
                    electLogDTO.setGiveupNum(new BigDecimal(1));
                }
                electLogDTO.setOrgIdentity("ORG_ROOT");
                dynElectLogDTOList.add(electLogDTO);
                logger.info("插入信息：" + electLogDTO);
            }
        }
        dynElectLogService.insertDynElectLogList(dynElectLogDTOList);
        logger.info("插入了" + dynElectLogDTOList.size() + "条！");
        dynElectService.updateDynElectInvestNum(submitElectVo.getElectId());
        return returnSuccess();
    }

    /**
     * 候选人状态变更
     *
     * @param updatePersonStatus
     */
    @POST
    @Path(value = "/personStatusChange")
    @Produces("application/json;charset=UTF-8")
    public String personStatusChange(UpdatePersonStatus updatePersonStatus) throws Exception {
        if (StringUtils.isBlank(updatePersonStatus.getId()) || StringUtils.isBlank(updatePersonStatus.getStatus())) {
            return returnError("必填项目不能为空");
        }
        if (!ArrayUtils.contains(new String[]{"0", "1", "2"}, updatePersonStatus.getStatus())) {
            return returnError("输入参数有误！");
        }

        DynPersonsDTO dto = new DynPersonsDTO();
        dto.setId(updatePersonStatus.getId());
        dto.setStatus(updatePersonStatus.getStatus());

        // 0:候选 1：晋级 2： 淘汰
        if ("0".equals(updatePersonStatus.getStatus())) {
            dto.setTurnNum(BigDecimal.ZERO);
        } else {
            // 取得活动规则
            DynElectDTO dynElectDTO = dynElectService.getCurrentElectDTO();
            if (dynElectDTO == null) {
                return returnError("当前活动已结束！");
            }
            dto.setTurnNum(dynElectDTO.getRoundNum());
        }
        dto.setOperationDate(new Date());
        dynPersonsService.updateDynPersonsSensitive(dto);
        return returnSuccess();
    }

    /**
     * 人员列表接口
     *
     * @param getPersonDTO
     */
    @POST
    @Path(value = "/getPersonList")
    @Produces("application/json;charset=UTF-8")
    public String getPersonList(GetPersonDTO getPersonDTO) throws Exception {
        if (StringUtils.isBlank(getPersonDTO.getElectId())) {
            return returnError("必填项目不能为空");
        }
        if (!ArrayUtils.contains(new String[]{"0", "1", "2"}, getPersonDTO.getStatus())
            || !ArrayUtils.contains(new String[]{"", "dept", "major", "date"}, getPersonDTO.getSortType())
            || !ArrayUtils.contains(new String[]{"1", "2"}, getPersonDTO.getSort())) {
            return returnError("输入参数有误！");
        }
        // 取得活动规则
        DynElectDTO dynElectDTO = dynElectService.queryDynElectByPrimaryKey(getPersonDTO.getElectId());

       /*  排名
         1：排名正序，2：排名倒序，
         3：人员编号正序，4：人员编号倒序，
         5：轮次正序，6：轮次倒序，
         7：部门正序，8：部门倒序，
         9：专业正序，10：专业倒序
      */

        // 候选人列表
        if ("0".equals(getPersonDTO.getStatus())) {
            // 未开始状态，按照人员编号排序
            if ("0".equals(dynElectDTO.getStatus())) {
                // 正序的场合
                if ("1".equals(getPersonDTO.getSort())) {
                    getPersonDTO.setSort("3");
                } else {
                    getPersonDTO.setSort("4");
                }
            } else if ("1".equals(dynElectDTO.getStatus())) {
                // 开始状态，排序开启的场合
                if (BigDecimal.ONE.compareTo(dynElectDTO.getIsShowRanking()) == 0) {
                    if ("1".equals(getPersonDTO.getSort())) {
                        getPersonDTO.setSort("1");
                    } else {
                        getPersonDTO.setSort("2");
                    }
                } else {
                    // 开始状态，排序关闭的场合
                    if ("1".equals(getPersonDTO.getSort())) {
                        getPersonDTO.setSort("3");
                    } else {
                        getPersonDTO.setSort("4");
                    }
                }
            } else if ("2".equals(dynElectDTO.getStatus())) {
                // 正序的场合
                if ("1".equals(getPersonDTO.getSort())) {
                    getPersonDTO.setSort("1");
                } else {
                    getPersonDTO.setSort("2");
                }
            }
        } else {
            // 晋级，淘汰列表 显示所有的晋级，淘汰人员名单
            getPersonDTO.setElectId(null);
            // 晋级，淘汰列表
             if ("date".equals(getPersonDTO.getSortType())) {
                if ("1".equals(getPersonDTO.getSort())) {
                    getPersonDTO.setSort("5");
                } else {
                    getPersonDTO.setSort("6");
                }
            } else if ("dept".equals(getPersonDTO.getSortType())) {
                if ("1".equals(getPersonDTO.getSort())) {
                    getPersonDTO.setSort("7");
                } else {
                    getPersonDTO.setSort("8");
                }
            } else if ("major".equals(getPersonDTO.getSortType())) {
                if ("1".equals(getPersonDTO.getSort())) {
                    getPersonDTO.setSort("9");
                } else {
                    getPersonDTO.setSort("10");
                }
            }
        }

        //根据状态查询候选人列表 无参数表示所有列表
        List<PersonLogVo> list = dynPersonsService.searchDynPersonsBySort(getPersonDTO);
        return returnSuccessData(list);
    }

    /**
     * 选举活动基本信息接口
     *
     * @param
     */
    @POST
    @Path(value = "/putActivityRuleInfo")
    @Produces("application/json;charset=UTF-8")
    public String putActivityRuleInfo(DynElectDTO electDTO) throws Exception{
        // 取得最新活动规则
        DynElectDTO newDynElectDTO = dynElectService.getCurrentElectDTO();

        DynElectDTO dynElectDTO = null;
        if (StringUtils.isBlank(electDTO.getId())) {
            dynElectDTO = newDynElectDTO;
        } else {
            dynElectDTO = dynElectService.queryDynElectByPrimaryKey(electDTO.getId());
            if (dynElectDTO == null) {
                return returnError("活动信息不存在！");
            }
        }

        // 候选总人数
        int personNum = dynElectPersonService.queryEPNum();
        // 登录数量
        int loginNum = dynNumPlateService.searchLoginNum("1");
        // 投票数量
        Integer votedNum = dynElectLogService.searchByElectId(dynElectDTO.getId());

        HashMap<String, Object> map = new HashMap<>();
        map.put("dynElectDTO", dynElectDTO);
        map.put("personNum", personNum);
        map.put("loginNum", loginNum);
        map.put("votedNum", votedNum);
        map.put("newElectId", newDynElectDTO.getId());
        return returnSuccessData(map);
    }

    /**
     * 修改活动状态
     *
     * @param
     */
    @POST
    @Path(value = "/updateLoginStatus")
    @Produces("application/json;charset=UTF-8")
    public String updateLoginStatus() throws Exception {
        dynNumPlateService.updateAllDynNumPlateLoginStatus("0");
        return returnSuccess();
    }

    /**
     * 修改活动状态
     *
     * @param
     */
    @POST
    @Path(value = "/updateElectStatus")
    @Produces("application/json;charset=UTF-8")
    public String updateElectStatus(UpdateElectStatusDto updateElectStatusDto) throws Exception {
        if (!ArrayUtils.contains(new String[]{"1", "2"}, updateElectStatusDto.getStatus())) {
            return returnError("输入参数有误！");
        }
        // 取得进行中的活动规则
        DynElectDTO dynElectDTO = dynElectService.getCurrentElectDTO();
        if (!dynElectDTO.getId().equals(updateElectStatusDto.getId())) {
            return returnError("当前活动信息有误!");
        }
        dynElectDTO.setStatus(updateElectStatusDto.getStatus());
        dynElectService.updateDynElectSensitive(dynElectDTO);
        return returnSuccess();
    }

    /**
     * 取得部门晋级人数
     *
     * @param
     */
    @POST
    @Path(value = "/getAgreeNumByDept")
    @Produces("application/json;charset=UTF-8")
    public String getAgreeNumByDept() {
        List<PersonTotalVo> list = dynPersonsService.searchPersonsTotalGroupByDept();
        return returnSuccessData(list);
    }

    /**
     * 取得专业晋级人数
     *
     * @param
     */
    @POST
    @Path(value = "/getAgreeNumByMajor")
    @Produces("application/json;charset=UTF-8")
    public String getAgreeNumByMajor() {
        List<PersonTotalVo> list = dynPersonsService.searchPersonsTotalGroupByMajor();
        return returnSuccessData(list);
    }

    /**
     * 正常返回场合
     *
     * @return
     */
    private String returnSuccess() {
        ResponseResult rs = new ResponseResult();
        rs.setCode("200");
        rs.setMsg("成功");
        return JSONObject.toJSONString(rs);
    }

    /**
     * 正常返回场合
     *
     * @param obj
     * @return
     */
    private String returnSuccessData(Object obj) {
        ResponseResult rs = new ResponseResult();
        rs.setCode("200");
        rs.setMsg("成功");
        rs.setObject(obj);
        return JSONObject.toJSONString(rs);
    }

    /**
     * 错误返回的场合
     *
     * @param msg
     * @return
     */
    private String returnError(String msg) {
        ResponseResult rs = new ResponseResult();
        rs.setCode("400");
        rs.setMsg(msg);
        return JSONObject.toJSONString(rs);
    }

    /**
     * 取得新的号码牌
     *
     * @param maxCtn
     * @return
     * @throws Exception
     */
    private DynNumPlateDTO getNewDynNumPlateDTO(BigDecimal maxCtn) throws Exception {
        DynNumPlateDTO searchParams = new DynNumPlateDTO();
        searchParams.setLoginStatus("0");
        List<DynNumPlateDTO> numPlateDTOList = dynNumPlateService.searchDynNumPlate(searchParams);
        for (DynNumPlateDTO item : numPlateDTOList) {
            int row = dynNumPlateService.updateNumPlateLoginStatus(item.getId(), maxCtn);
            if (row > 0) {
                // 修改entity 登录状态
                item.setLoginStatus("1");
                return item;
            }
        }
        return null;
    }
}
