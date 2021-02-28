package avicit.cadreselect.dynvote.service;

import java.io.Serializable;
import java.util.*;
import java.util.stream.Collectors;
import java.util.stream.Stream;

import avicit.cadreselect.dynvote.bo.SendVoteBO;
import avicit.cadreselect.dynvote.dto.QueryVoteByIdDTO;
import avicit.cadreselect.dynvote.dto.VoteItem;
import avicit.cadreselect.util.BizException;
import avicit.platform6.fastdfs.common.MyException;
import org.apache.commons.lang.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import avicit.platform6.commons.utils.ComUtil;
import avicit.platform6.commons.utils.PojoUtil;
import avicit.platform6.core.properties.PlatformConstant.OpType;
import avicit.platform6.core.exception.DaoException;
import avicit.platform6.core.mybatis.pagehelper.Page;
import avicit.platform6.core.mybatis.pagehelper.PageHelper;
import avicit.platform6.core.rest.msg.QueryReqBean;
import avicit.platform6.core.rest.msg.QueryRespBean;
import avicit.cadreselect.dynvote.dao.DynVoteDAO;
import avicit.cadreselect.dynvote.dto.DynVoteDTO;
import avicit.platform6.modules.system.syslog.service.SysLogUtil;
import org.springframework.transaction.annotation.Transactional;

/**
 * @金航数码科技有限责任公司
 * @作者：one
 * @邮箱：邮箱
 * @创建时间： 2021-02-24 12:58
 * @类说明：DYN_VOTEService
 * @修改记录：
 */
@Service
public class DynVoteService implements Serializable {

    private static final Logger logger = LoggerFactory.getLogger(DynVoteService.class);

    private static final long serialVersionUID = 1L;

    @Autowired
    private DynVoteDAO dynVoteDAO;

    //region 后台接口

    /**
     * 查询（分页）
     *
     * @param queryReqBean 分页
     * @param orderBy      排序语句
     * @param keyWord      快速查询条件
     * @return QueryRespBean<DynVoteDTO>
     * @throws Exception
     */
    public QueryRespBean<DynVoteDTO> searchDynVoteByPage(QueryReqBean<DynVoteDTO> queryReqBean, String orderBy, String keyWord) throws Exception {
        try {
            PageHelper.startPage(queryReqBean.getPageParameter());
            DynVoteDTO searchParams = queryReqBean.getSearchParams();
            //表单数据查询
            Page<DynVoteDTO> dataList = dynVoteDAO.searchDynVoteByPage(searchParams, orderBy, keyWord);
            QueryRespBean<DynVoteDTO> queryRespBean = new QueryRespBean<DynVoteDTO>();
            queryRespBean.setResult(dataList);
            return queryRespBean;
        } catch (Exception e) {
            e.printStackTrace();
            logger.error("searchDynVoteByPage出错：", e);
            throw new DaoException(e.getMessage(), e);
        }
    }

    /**
     * 查询（不分页）
     *
     * @param queryReqBean 条件
     * @return List<DynVoteDTO>
     * @throws Exception
     */
    public List<DynVoteDTO> searchDynVote(DynVoteDTO searchParams)
            throws Exception {
        try {
            List<DynVoteDTO> dataList = dynVoteDAO.searchDynVote(searchParams);
            return dataList;
        } catch (Exception e) {
            e.printStackTrace();
            logger.error("searchDynVote出错：", e);
            throw new DaoException(e.getMessage(), e);
        }
    }

    /**
     * 主键查询
     *
     * @param id 主键id
     * @return DynVoteDTO
     * @throws Exception
     */
    public DynVoteDTO queryDynVoteByPrimaryKey(String id) throws Exception {
        try {
            DynVoteDTO dto = dynVoteDAO.findDynVoteById(id);
            //记录日志
            if (dto != null) {
                SysLogUtil.log4Query(dto);
            }
            return dto;
        } catch (Exception e) {
            e.printStackTrace();
            logger.error("queryDynVoteByPrimaryKey出错：", e);
            throw new DaoException(e.getMessage(), e);
        }
    }

    /**
     * 新增
     *
     * @param dto 保存对象
     * @return String
     * @throws Exception
     */
    public String insertDynVote(DynVoteDTO dto) throws Exception {
        try {
            String id = ComUtil.getId();
            dto.setId(id);
            PojoUtil.setSysProperties(dto, OpType.insert);
            dynVoteDAO.insertDynVote(dto);
            //记录日志
            if (dto != null) {
                SysLogUtil.log4Insert(dto);
            }
            return id;
        } catch (Exception e) {
            e.printStackTrace();
            logger.error("insertDynVote出错：", e);
            throw new DaoException(e.getMessage(), e);
        }
    }

    /**
     * 批量新增
     *
     * @param dtoList 保存对象集合
     * @return int
     * @throws Exception
     */
    public int insertDynVoteList(List<DynVoteDTO> dtoList) throws Exception {
        try {
            List<DynVoteDTO> beanList = new ArrayList<DynVoteDTO>();
            for (DynVoteDTO dto : dtoList) {
                String id = ComUtil.getId();
                dto.setId(id);
                PojoUtil.setSysProperties(dto, OpType.insert);
                //记录日志
                if (dto != null) {
                    SysLogUtil.log4Insert(dto);
                }
                beanList.add(dto);
            }
            return dynVoteDAO.insertDynVoteList(beanList);
        } catch (Exception e) {
            e.printStackTrace();
            logger.error("insertDynVoteList出错：", e);
            throw new DaoException(e.getMessage(), e);
        }
    }

    /**
     * 全部更新
     *
     * @param dto 修改对象
     * @return int
     * @throws Exception
     */
    public int updateDynVoteAll(DynVoteDTO dto) throws Exception {
        try {
            //记录日志
            DynVoteDTO old = findById(dto.getId());
            if (old != null) {
                SysLogUtil.log4Update(dto, old);
            }
            PojoUtil.setSysProperties(dto, OpType.update);
            int count = dynVoteDAO.updateDynVoteAll(dto);
            if (count == 0) {
                throw new DaoException("数据失效，请重新更新");
            }
            return count;
        } catch (Exception e) {
            e.printStackTrace();
            logger.error("updateDynVoteAll出错：", e);
            throw new DaoException(e.getMessage(), e);
        }
    }

    /**
     * 部分更新
     *
     * @param dto 修改对象
     * @return int
     * @throws Exception
     */
    public int updateDynVoteSensitive(DynVoteDTO dto) throws Exception {
        try {
            //记录日志
            DynVoteDTO old = findById(dto.getId());
            if (old != null) {
                SysLogUtil.log4Update(dto, old);
            }
            PojoUtil.setSysProperties(dto, OpType.update);
            PojoUtil.copyProperties(old, dto, true);
            int count = dynVoteDAO.updateDynVoteSensitive(old);
            if (count == 0) {
                throw new DaoException("数据失效，请重新更新");
            }
            return count;
        } catch (Exception e) {
            e.printStackTrace();
            logger.error("updateDynVoteSensitive出错：", e);
            throw new DaoException(e.getMessage(), e);
        }
    }

    /**
     * 批量更新
     *
     * @param dtoList 修改对象集合
     * @return int
     * @throws Exception
     */
    public int updateDynVoteList(List<DynVoteDTO> dtoList) throws Exception {
        try {
            return dynVoteDAO.updateDynVoteList(dtoList);
        } catch (Exception e) {
            e.printStackTrace();
            logger.error("updateDynVoteList出错：", e);
            throw new DaoException(e.getMessage(), e);
        }

    }

    /**
     * 删除
     *
     * @param id 主键id
     * @return int
     * @throws Exception
     */
    public int deleteDynVoteById(String id) throws Exception {
        try {
            if (StringUtils.isEmpty(id)) {
                throw new Exception("删除失败！传入的参数主键为null");
            }
            //记录日志
            DynVoteDTO dto = findById(id);
            if (dto != null) {
                SysLogUtil.log4Delete(dto);
            }
            return dynVoteDAO.deleteDynVoteById(id);
        } catch (Exception e) {
            e.printStackTrace();
            logger.error("deleteDynVoteById出错：", e);
            throw new DaoException(e.getMessage(), e);
        }
    }

    /**
     * 批量删除
     *
     * @param ids id的数组
     * @return int
     * @throws Exception
     */
    public int deleteDynVoteByIds(String[] ids) throws Exception {
        int result = 0;
        for (String id : ids) {
            deleteDynVoteById(id);
            result++;
        }
        return result;
    }

    /**
     * 日志专用查询
     *
     * @param id 主键id
     * @return DynVoteDTO
     * @throws Exception
     */
    private DynVoteDTO findById(String id) throws Exception {
        try {
            DynVoteDTO dto = dynVoteDAO.findDynVoteById(id);
            return dto;
        } catch (Exception e) {
            e.printStackTrace();
            logger.error("findById出错：", e);
            throw new DaoException(e.getMessage(), e);
        }
    }

    //endregion

    //region web接口

    //region 根据扫码id查询投票信息

    /**
     * 根据扫码id查询投票信息
     *
     * @param id : 标识
     * @return
     */
    public QueryVoteByIdDTO queryVoteById(String id) {
        QueryVoteByIdDTO dto = dynVoteDAO.queryVoteById(id);
        if (dto.getList() != null) {
            List<VoteItem> recommends = dto.getList().stream().filter(l -> l.getDynVoteType().equals("1")).collect(Collectors.toList());
            List<VoteItem> list = dto.getList().stream().filter(l -> l.getDynVoteType().equals("0")).collect(Collectors.toList());
            dto.setList(list);
            dto.setRecommends(recommends);
            if (!dto.getList().get(0).getDynVoteOpinion().equals("0")) {
                dto.setIs(1);
            }
        }
        return dto;
    }
    //endregion

    //region 投票

    /**
     * 投票
     *
     * @param bo
     */
    @Transactional
    public void sendVote(SendVoteBO bo) {
        int type = dynVoteDAO.findByVoteId(bo.getId());
        if (type == 0) {//第一套
            List<VoteItem> collect = bo.getList().stream().filter(l -> l.getDynVoteOpinion().equals("0")).collect(Collectors.toList());
            if (collect != null && collect.size() > 0) {
                throw new BizException("您的投票未完成，请继续投票");
            }
        } else if (type == 1) {
            List<VoteItem> collect = bo.getList().stream().filter(l -> l.getDynVoteOpinion().equals("-1")).collect(Collectors.toList());
            if (collect.size() > 1) {
                throw new BizException("仅可赞同一位候选人");
            }

            if (collect.size() == 0) {
                collect = bo.getList().stream().filter(l -> l.getDynVoteOpinion().equals("-2")).collect(Collectors.toList());
                if (collect.size() > 0) {
                    collect = bo.getList().stream().filter(l -> l.getDynVoteOpinion().equals("-3")).collect(Collectors.toList());
                    if (collect.size()>0){
                        throw new BizException("只有弃权与反对属于无效票！");
                    }else{
                        if (bo.getRecommends().size() <= 0) {
                            throw new BizException("全部反对时必须添加推荐人");
                        }
                    }
                } else if (collect.size() == 0) {
//                    if (bo.getRecommends().size() <= 0) {
//                        throw new BizException("全部反对时必须添加推荐人");
//                    }
                }
            }
        } else if (type == 2) {
            if (bo.getRecommends().size()>0){
                throw new BizException("不可自定义推荐人");
            }
        }

        dynVoteDAO.sendVote(bo);


        bo.getRecommends().forEach(i -> {
            i.setTemId(bo.getTemId());
            Map<String, String> map = dynVoteDAO.queryItemByName(i);
            if (map == null || map.get("ID") == null || map.get("ID").equals("")) {
                map = new HashMap<>();
                map.put("ID", UUID.randomUUID().toString());
                i.setDynItId(map.get("ID"));
                dynVoteDAO.sendTemItem(i, "投票");
            }
            i.setDynItId(map.get("ID"));
            i.setDynVoteId(bo.getId());
            dynVoteDAO.sendVoteRecommends(i);
        });
    }
    //endregion

    //endregion
}

