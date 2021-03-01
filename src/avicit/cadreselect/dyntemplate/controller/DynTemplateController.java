package avicit.cadreselect.dyntemplate.controller;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.*;
import java.util.stream.Collectors;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import avicit.cadreselect.dynperson.dao.DynPersonDAO;
import avicit.cadreselect.dynperson.dto.DynPersonDTO;
import avicit.cadreselect.dyntemitem.dto.DynTemItemDTO;
import avicit.cadreselect.dyntemitem.service.DynTemItemService;
import avicit.cadreselect.dyntemplate.dto.*;
import avicit.cadreselect.dynvote.dao.DynVoteDAO;
import avicit.cadreselect.dynvote.dto.DynVoteDTO;
import avicit.cadreselect.dynvote.dto.QueryVoteByIdDTO;
import avicit.cadreselect.dynvote.dto.VoteItem;
import avicit.cadreselect.dynvote.service.DynVoteService;
import avicit.cadreselect.dyntemplate.dto.DynRecord;
import avicit.cadreselect.dyntemplate.dto.DynTemplateBO;
import avicit.cadreselect.dynvote.dto.DynVoteDTO;
import avicit.cadreselect.dynvote.service.DynVoteService;
import avicit.cadreselect.util.BizException;
import avicit.cadreselect.util.ResponseData;
import org.apache.poi.hssf.usermodel.*;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.util.CellRangeAddress;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.apache.commons.lang.StringUtils;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.BeanFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.ServletRequestUtils;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import avicit.platform6.commons.utils.ComUtil;
import avicit.platform6.api.application.SysApplicationAPI;
import avicit.platform6.api.session.SessionHelper;
import avicit.platform6.api.syspermissionresource.permissionanalysis.core.support.LoaderConstant;
import avicit.platform6.commons.utils.JsonHelper;
import avicit.platform6.core.properties.PlatformConstant.OpResult;
import avicit.platform6.core.rest.msg.PageParameter;
import avicit.platform6.core.rest.msg.QueryReqBean;
import avicit.platform6.core.rest.msg.QueryRespBean;

import avicit.cadreselect.dyntemplate.service.DynTemplateService;
import com.fasterxml.jackson.core.type.TypeReference;

/**
 * @金航数码科技有限责任公司
 * @作者：one
 * @邮箱：邮箱
 * @创建时间： 2021-02-24 12:56
 * @类说明：模板表Controller
 * @修改记录：
 */
@Controller
@RequestMapping("avicit/cadreselect/dynTemplate/dynTemplateController")
public class DynTemplateController implements LoaderConstant {
    private static final Logger LOGGER = LoggerFactory.getLogger(DynTemplateController.class);

    @Autowired
    private SysApplicationAPI sysApplicationAPI;
    @Autowired
    private DynTemplateService dynTemplateService;

    @Autowired
    DynTemItemService dynTemItemService;

	@Autowired
	DynVoteService dynVoteService;

    @Autowired
    DynVoteService voteService;

    //region 自动生成

    /**
     * 跳转到列表页面
     *
     * @return ModelAndView
     */
    @RequestMapping(value = "toDynTemplateManage")
    public ModelAndView toDynTemplateManage() {
        ModelAndView mav = new ModelAndView();
        mav.setViewName("avicit/cadreselect/dyntemplate/DynTemplateManage");
        mav.addObject("url", "platform/avicit/cadreselect/dynTemplate/dynTemplateController/operation/");
        return mav;
    }

    /**
     * 列表页面分页查询
     *
     * @param pageParameter 查询条件
     * @param request       请求
     * @return Map<String, Object>
     */
    @RequestMapping(value = "/operation/getDynTemplatesByPage")
    @ResponseBody
    public Map<String, Object> togetDynTemplateByPage(PageParameter pageParameter, HttpServletRequest request) {
        QueryReqBean<DynTemplateDTO> queryReqBean = new QueryReqBean<DynTemplateDTO>();
        queryReqBean.setPageParameter(pageParameter);
        //表单数据
        String json = ServletRequestUtils.getStringParameter(request, "param", "");
        //字段查询条件
        String keyWord = ServletRequestUtils.getStringParameter(request, "keyWord", "");
        //排序方式
        String sord = ServletRequestUtils.getStringParameter(request, "sord", "");
        //排序字段
        String sidx = ServletRequestUtils.getStringParameter(request, "sidx", "");
        if (StringUtils.isNotEmpty(keyWord)) {
            json = keyWord;
        }
        String orderBy = "";
        String cloumnName = "";
        if (sidx != null && sord != null && !"".equals(sord) && !"".equals(sidx)) {
            cloumnName = ComUtil.getColumn(DynTemplateDTO.class, sidx);
            //这里先进行判断是否有对应的数据库字段
            if (cloumnName != null) {
                orderBy = " " + cloumnName + " " + sord;
            } else {
                //判断是否为特殊控件导致字段无法匹配
                if (sidx.indexOf("Alias") != -1) {
                    cloumnName = ComUtil.getColumn(DynTemplateDTO.class,
                            sidx.substring(0, sidx.lastIndexOf("Alias")));
                } else if (sidx.indexOf("Name") != -1) {
                    cloumnName = ComUtil.getColumn(DynTemplateDTO.class,
                            sidx.substring(0, sidx.lastIndexOf("Name")));
                }
                if (cloumnName != null) {
                    orderBy = " " + cloumnName + " " + sord;
                }
            }
        }
        HashMap<String, Object> map = new HashMap<String, Object>();
        DynTemplateDTO param = null;
        DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
        QueryRespBean<DynTemplateDTO> result = null;
        if (json != null && !"".equals(json)) {
            param = JsonHelper.getInstance().readValue(json, dateFormat, new TypeReference<DynTemplateDTO>() {
            });
        } else {
            param = new DynTemplateDTO();
        }
        queryReqBean.setSearchParams(param);
//		param.setOrgIdentity(SessionHelper.getCurrentOrgIdentity(request));
        try {
            result = dynTemplateService.searchDynTemplateByPage(queryReqBean, orderBy, keyWord);
        } catch (Exception ex) {
            return map;
        }
        map.put("records", result.getPageParameter().getTotalCount());
        map.put("page", result.getPageParameter().getPage());
        map.put("total", result.getPageParameter().getTotalPage());
        map.put("rows", result.getResult());
        LOGGER.info("成功获取DynTemplateDTO分页数据");
        return map;
    }

    /**
     * 根据传入的的类型跳转到对应页面
     *
     * @param type，包括三个值，分别是Add:新建；Edit：编辑；Detail：详情
     * @param id                                     数据的id
     * @return ModelAndView
     * @throws Exception
     */
    @RequestMapping(value = "/operation/{type}/{id}")
    public ModelAndView toOpertionPage(@PathVariable String type, @PathVariable String id)
            throws Exception {
        ModelAndView mav = new ModelAndView();
        //编辑窗口或者详细页窗口
        if (!"Add".equals(type)) {
            DynTemplateDTO dto = dynTemplateService.queryDynTemplateByPrimaryKey(id);
            mav.addObject("dynTemplateDTO", dto);
        }
        mav.setViewName("avicit/cadreselect/dyntemplate/DynTemplate" + type);
        return mav;
    }


    @PostMapping("/saveDynTemplate")
    @ResponseBody
    public ResponseData<Void> saveDynTemplate(@RequestBody DynTemplateBO dynTemplateBO) {

        dynTemplateBO.setId(ComUtil.getId());
        dynTemplateBO.setCreationDate(new Date());
        dynTemplateBO.setCreationDateEnd(new Date());
        dynTemplateBO.setLastUpdateDate(new Date());
        dynTemplateBO.setLastUpdateDateEnd(new Date());
        try {
            this.dynTemplateService.saveDynTem(dynTemplateBO);
            List<DynTemItemDTO> dynPersonDAOList = dynTemplateBO.getDynTemItemDTOArrayList();
            if (dynPersonDAOList.size() > 0) {
                Map<String, String> map = new HashMap<>();
                dynPersonDAOList.forEach(item -> {
                    try {
                        item.setTemId(dynTemplateBO.getId());
                        item.setId(ComUtil.getId());
                        dynTemItemService.insertDynTemItem(item);
                        for (int i = 0; i < Integer.parseInt(dynTemplateBO.getTemShouldInvestNum().toString()); i++) {
                            if (map.get(i + "") == null || map.get(i + "").equals("")) {
                                StringBuilder random = new StringBuilder((1 + (int) (Math.random() * 1000)) + "");
                                int c = 4 - random.length();
                                if (c > 0) {
                                    for (int j = 0; j < c; j++) {
                                        random.insert(0, "0");
                                    }
                                }
                                map.put(i + "", random.toString());
                            }
                            DynVoteDTO dto = new DynVoteDTO();
                            dto.setId(ComUtil.getId());
                            dto.setDynItId(item.getId());
                            dto.setDynVoteOpinion("0");
                            dto.setDynVoteId(map.get(i + ""));
                            dto.setCreationDate(new Date());
                            dto.setCreationDateEnd(new Date());
                            dto.setLastUpdateDateEnd(new Date());
                            dto.setLastUpdateDate(new Date());
                            dto.setCreatedBy("1");
                            dto.setLastUpdatedBy("1");
                            dto.setLastUpdateIp("1");
                            dto.setVersion((long) 0);
                            dto.setOrgIdentity("ORG_ROOT");
                            dto.setTemId(dynTemplateBO.getId());
                            voteService.insertDynVote(dto);
                        }
                    } catch (Exception e) {
                        e.printStackTrace();
                    }
                });
            }

        } catch (Exception e) {
            e.printStackTrace();
            throw new BizException("出现异常:" + e);
        }

        return new ResponseData<>();
    }

	/**
	 * 根据规则ID查询
	 * @param id
	 * @return
	 */
	@PostMapping("/searchById")
	@ResponseBody
	public ResponseData<DynTemplateBO> searchById(@RequestBody String id)
	{
		DynTemplateBO dynTemplateBO = new DynTemplateBO();
		try {

            DynTemplateDTO dynTemplateDTO = this.dynTemplateService.queryDynTemplateByPrimaryKey(id);
            if (dynTemplateBO == null) {
                throw new BizException("未查到数据");
            }
            BeanUtils.copyProperties(dynTemplateBO, dynTemplateBO);
            DynTemItemDTO dynTemItemDTO = new DynTemItemDTO();
            dynTemItemDTO.setTemId(dynTemplateDTO.getId());
            List<DynTemItemDTO> dynTemItemDTOS = this.dynTemItemService.searchDynTemItem(dynTemItemDTO);
            if (dynTemItemDTOS.size() > 0) {
                dynTemplateBO.setDynTemItemDTOArrayList(dynTemItemDTOS);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return new ResponseData<>(dynTemplateBO);
    }

    /**
     * 保存数据
     *
     * @param id      主键id
     * @param request 请求
     * @return ModelAndView
     */
    @RequestMapping(value = "/operation/save", method = RequestMethod.POST)
    public ModelAndView toSaveDynTemplate(HttpServletRequest request) {
        ModelAndView mav = new ModelAndView();
        String jsonData = ServletRequestUtils.getStringParameter(request, "data", "");
        DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
        try {
            DynTemplateDTO dynTemplateDTO = JsonHelper.getInstance().readValue(jsonData, dateFormat,
                    new TypeReference<DynTemplateDTO>() {
                    });
            if (StringUtils.isEmpty(dynTemplateDTO.getId())) {
                //新增
                dynTemplateDTO.setOrgIdentity(SessionHelper.getCurrentOrgIdentity(request));
                String id = dynTemplateService.insertDynTemplate(dynTemplateDTO);
                mav.addObject("id", id);
            } else {
                //修改
                dynTemplateService.updateDynTemplateSensitive(dynTemplateDTO);
                mav.addObject("id", dynTemplateDTO.getId());
            }
            mav.addObject("flag", OpResult.success);
        } catch (Exception ex) {
            mav.addObject("flag", OpResult.failure);
            return mav;
        }
        return mav;

    }

    /**
     * 按照id批量删除数据
     *
     * @param ids id数组
     * @return ModelAndView
     */
    @RequestMapping(value = "/operation/delete", method = RequestMethod.POST)
    public ModelAndView toDeleteDynTemplate(@RequestBody String[] ids) {
        ModelAndView mav = new ModelAndView();
        try {
            dynTemplateService.deleteDynTemplateByIds(ids);
            mav.addObject("flag", OpResult.success);
        } catch (Exception ex) {
            mav.addObject("flag", OpResult.failure);
            return mav;
        }
        return mav;
    }
    //endregion

    //region 开发
    @ResponseBody
    @RequestMapping(value = "/queryRecord")
    public ResponseData<List<DynRecord>> toDeleteDynTemplate() {
        List<DynRecord> list = dynTemplateService.toDeleteDynTemplate();
        return new ResponseData<>(list);
    }

    @ResponseBody
    @PostMapping(value = "/queryDetails")
    public ResponseData<QueryDetailsDTO> queryDetails(@RequestBody String id) {
        QueryDetailsDTO dto = dynTemplateService.queryDetails(id);
        dto.getList().forEach(l -> {
            List<VoteItem> collect = l.getItems().stream().filter(item -> item.getDynVoteOpinion().equals("-1")).collect(Collectors.toList());
            l.setUp(collect.size());//推荐
            collect = l.getItems().stream().filter(item -> item.getDynVoteOpinion().equals("-2")).collect(Collectors.toList());
            l.setDown(collect.size());//反对
            collect = l.getItems().stream().filter(item -> item.getDynVoteOpinion().equals("-3")).collect(Collectors.toList());
            l.setLost(collect.size());//反对
        });
        return new ResponseData<>(dto);
    }

    @ResponseBody
    @PostMapping(value = "/printing")
    public ResponseData<PrintingDTO> printing(@RequestBody String id) {
        PrintingDTO list = dynTemplateService.printing(id);
        return new ResponseData<>(list);
    }
    //endregion


    @GetMapping("/exportTem")
    public void exportTem(HttpServletResponse response,String id)
    {
        try {
            List<DynTemAndTIMEDTO> timedtos = this.dynTemplateService.queryTemAndTime(id);
            HSSFWorkbook workbook = new HSSFWorkbook();
            HSSFSheet sheet = workbook.createSheet(timedtos.get(0).getTemTitle()+"----投票基本信息");
            String fileName = timedtos.get(0).getTemTitle()+"----投票基本信息" + ".xls";// 设置要导出的文件的名字
            String[] headers = { "候选人", "部门", "职务", "性别", "出生年月", "同意人数", "反对人数", "弃权人数"};

            CellRangeAddress region = new CellRangeAddress(0, 0, 0, 9);
            sheet.addMergedRegion(region);
            HSSFRow rowTitle = sheet.createRow(0);
            Cell oneCell = rowTitle.createCell(0);
            oneCell.setCellValue(timedtos.get(0).getTemTitle()+"----投票基本信息");// 设置标题内容
           // 合并的单元格样式
            HSSFCellStyle boderStyle = workbook.createCellStyle();
            boderStyle.setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER);
            boderStyle.setAlignment(HSSFCellStyle.ALIGN_CENTER); // 创建一个居中格式
            oneCell.setCellStyle(boderStyle);
            HSSFRow row = sheet.createRow(1);
            // 在excel表中添加表头
            for (int i = 0; i < headers.length; i++) {
                HSSFCell cell = row.createCell(i);
                HSSFRichTextString text = new HSSFRichTextString(headers[i]);
                cell.setCellValue(text);
            }
            int rowNum = 2;
            // 在表中存放查询到的数据放入对应的列
            for (DynTemAndTIMEDTO teacher : timedtos) {
                HSSFRow row1 = sheet.createRow(rowNum);
                row1.createCell(0).setCellValue(teacher.getTiUserName());
                row1.createCell(1).setCellValue(teacher.getTiUserDept());
                row1.createCell(2).setCellValue(teacher.getTiUserPost());
                if (teacher.getTiUserSex() == 0){
                    row1.createCell(3).setCellValue("女");
                }else {
                    row1.createCell(3).setCellValue("男");
                }


                row1.createCell(4).setCellValue(teacher.getTiUserBirth());


                rowNum++;
            }
            response.setContentType("application/octet-stream");
            response.setHeader("Content-disposition",
                    "attachment;filename=" + java.net.URLEncoder.encode(fileName, "UTF-8"));
            response.flushBuffer();
            workbook.write(response.getOutputStream());


        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}

