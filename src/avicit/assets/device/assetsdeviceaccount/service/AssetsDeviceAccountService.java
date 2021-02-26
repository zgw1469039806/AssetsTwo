package avicit.assets.device.assetsdeviceaccount.service;

import java.io.Serializable;
import java.util.HashMap;
import java.util.List;
import java.util.ArrayList;

import avicit.assets.device.assetsuserlog.service.AssetsUserLogService;
import avicit.platform6.core.jdbc.JdbcAvicit;
import avicit.platform6.core.spring.SpringFactory;
import org.apache.commons.lang3.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Service;

import avicit.platform6.commons.utils.ComUtil;
import avicit.platform6.commons.utils.PojoUtil;
import avicit.platform6.core.properties.PlatformConstant.OpType;
import avicit.platform6.core.exception.DaoException;
import avicit.platform6.core.mybatis.pagehelper.Page;
import avicit.platform6.core.mybatis.pagehelper.PageHelper;
import avicit.platform6.core.rest.msg.QueryReqBean;
import avicit.platform6.core.rest.msg.QueryRespBean;
import avicit.assets.device.assetsdeviceaccount.dao.AssetsDeviceAccountDao;
import avicit.assets.device.assetsdeviceaccount.dto.AssetsDeviceAccountDTO;
import avicit.platform6.modules.system.syslog.service.SysLogUtil;

/**
 * @科技有限责任公司
 * @作者：请填写
 * @邮箱：avicitdev@avicit.com
 * @创建时间： 2020-06-20 17:59
 * @类说明：请填写
 * @修改记录： 
 */
@Service
public class AssetsDeviceAccountService implements Serializable {

	private static final Logger logger = LoggerFactory.getLogger(AssetsDeviceAccountService.class);

	private static final long serialVersionUID = 1L;

	@Autowired
	private AssetsDeviceAccountDao assetsDeviceAccountDao;

	/**
	* 按条件分页查询
	* @param queryReqBean 分页
	* @param orderBy 排序
	* @return QueryRespBean<AssetsDeviceAccountDTO>
	* @throws Exception
	*/
	public QueryRespBean<AssetsDeviceAccountDTO> searchAssetsDeviceAccountByPage(
			QueryReqBean<AssetsDeviceAccountDTO> queryReqBean, String orderBy) throws Exception {
		try {
			PageHelper.startPage(queryReqBean.getPageParameter());
			AssetsDeviceAccountDTO searchParams = queryReqBean.getSearchParams();
			Page<AssetsDeviceAccountDTO> dataList = assetsDeviceAccountDao.searchAssetsDeviceAccountByPage(searchParams,
					orderBy);
			QueryRespBean<AssetsDeviceAccountDTO> queryRespBean = new QueryRespBean<AssetsDeviceAccountDTO>();

			queryRespBean.setResult(dataList);
			return queryRespBean;
		} catch (Exception e) {
			logger.error("searchAssetsDeviceAccountByPage出错：", e);
			throw new DaoException(e.getMessage(), e);
		}
	}

	/**
	 * 按子表条件查询
	 */
	public List subSearch(HashMap<String, String> mapPram)  throws Exception{
		JdbcAvicit jdbc = SpringFactory.getBean(JdbcAvicit.class);
		JdbcTemplate jt = jdbc.getJdbcTemplate();
		List list = new ArrayList();
		if(!mapPram.isEmpty()){
			String tComponentName = "";
			String tSoftwareName =  "";
			if(mapPram.get("tComponentName") != null) tComponentName = mapPram.get("tComponentName");
			if(mapPram.get("tSoftwareName") != null) tSoftwareName = mapPram.get("tSoftwareName");
			try {
				String subSearchSql =
						"select distinct tt.unified_id from ASSETS_DEVICE_ACCOUNT tt,assets_tdevice_component ct, assets_tdevice_software st" +
								" where ct.component_name like '%" + tComponentName+ "%'" +
								" and st.software_name like '%" + tSoftwareName + "%'" +
								" and tt.unified_id = ct.unified_id and tt.unified_id = st.unified_id";
				list = jt.queryForList(subSearchSql);
				return list;
			} catch (Exception e) {
				logger.error("subSearch出错：", e);
				throw new DaoException(e.getMessage(), e);
			}
		}
		return list;
	}


	/**
	* 按条件or查询的分页查询
	* @param queryReqBean 分页 
	* @param orderBy 排序
	* @return QueryRespBean<AssetsDeviceAccountDTO>
	* @throws Exception
	*/
	public QueryRespBean<AssetsDeviceAccountDTO> searchAssetsDeviceAccountByPageOr(
			QueryReqBean<AssetsDeviceAccountDTO> queryReqBean, String orderBy) throws Exception {
		try {
			PageHelper.startPage(queryReqBean.getPageParameter());
			AssetsDeviceAccountDTO searchParams = queryReqBean.getSearchParams();
			Page<AssetsDeviceAccountDTO> dataList = assetsDeviceAccountDao
					.searchAssetsDeviceAccountByPageOr(searchParams, orderBy);
			QueryRespBean<AssetsDeviceAccountDTO> queryRespBean = new QueryRespBean<AssetsDeviceAccountDTO>();

			queryRespBean.setResult(dataList);
			return queryRespBean;
		} catch (Exception e) {
			logger.error("searchAssetsDeviceAccountByPage出错：", e);
			throw new DaoException(e.getMessage(), e);
		}
	}

	/**
	* 按条件查询
	* @param queryReqBean 条件
	* @return List<AssetsDeviceAccountDTO>
	* @throws Exception
	*/
	public List<AssetsDeviceAccountDTO> searchAssetsDeviceAccount(QueryReqBean<AssetsDeviceAccountDTO> queryReqBean)
			throws Exception {
		try {
			AssetsDeviceAccountDTO searchParams = queryReqBean.getSearchParams();
			List<AssetsDeviceAccountDTO> dataList = assetsDeviceAccountDao.searchAssetsDeviceAccount(searchParams);
			return dataList;
		} catch (Exception e) {
			logger.error("searchAssetsDeviceAccount出错：", e);
			throw new DaoException(e.getMessage(), e);
		}
	}

	/**
	 * 通过主键查询单条记录
	 * @param id 主键id
	 * @return AssetsDeviceAccountDTO
	 * @throws Exception
	 */
	public AssetsDeviceAccountDTO queryAssetsDeviceAccountByPrimaryKey(String id) throws Exception {
		try {
			AssetsDeviceAccountDTO dto = assetsDeviceAccountDao.findAssetsDeviceAccountById(id);
			//记录日志
			if (dto != null) {
				SysLogUtil.log4Query(dto);
			}
			return dto;
		} catch (Exception e) {
			logger.error("queryAssetsDeviceAccountByPrimaryKey出错：", e);
			throw new DaoException(e.getMessage(), e);
		}
	}


	/**
	* 新增对象
	* @param dto 保存对象
	* @return String
	* @throws Exception
	*/
	public String insertAssetsDeviceAccount(AssetsDeviceAccountDTO dto) throws Exception {
		AssetsUserLogService assetsUserLogService= SpringFactory.getBean(  "assetsUserLogService");
		try {
			String id = ComUtil.getId();
			dto.setId(id);
			PojoUtil.setSysProperties(dto, OpType.insert);
			assetsDeviceAccountDao.insertAssetsDeviceAccount(dto);
			//记录日志
			if (dto != null) {
				SysLogUtil.log4Insert(dto);
				assetsUserLogService.log4Insert(dto);
			}
			return id;
		} catch (Exception e) {
			logger.error("insertAssetsDeviceAccount出错：", e);
			throw new DaoException(e.getMessage(), e);
		}
	}

	/**
	 * 批量新增对象
	 * @param dtoList 保存对象集合
	 * @return int
	 * @throws Exception
	 */
	public int insertAssetsDeviceAccountList(List<AssetsDeviceAccountDTO> dtoList) throws Exception {
		List<AssetsDeviceAccountDTO> beanList = new ArrayList<AssetsDeviceAccountDTO>();
		for (AssetsDeviceAccountDTO dto : dtoList) {
			String id = ComUtil.getId();
			dto.setId(id);
			PojoUtil.setSysProperties(dto, OpType.insert);
			//记录日志
			if (dto != null) {
				SysLogUtil.log4Insert(dto);
			}
			beanList.add(dto);
		}
		try {
			return assetsDeviceAccountDao.insertAssetsDeviceAccountList(beanList);
		} catch (Exception e) {
			logger.error("insertAssetsDeviceAccountList出错：", e);
			throw new DaoException(e.getMessage(), e);
		}
	}

	/**
	 * 修改对象全部字段
	 * @param dto 修改对象
	 * @return int
	 * @throws Exception
	 */
	public int updateAssetsDeviceAccount(AssetsDeviceAccountDTO dto) throws Exception {
		AssetsUserLogService assetsUserLogService= SpringFactory.getBean(  "assetsUserLogService");
		//记录日志
		AssetsDeviceAccountDTO old = findById(dto.getId());
		if (old != null) {
			SysLogUtil.log4Update(dto, old);
			assetsUserLogService.log4Update(dto,old);
		}
		PojoUtil.setSysProperties(dto, OpType.update);
		PojoUtil.copyProperties(old, dto, true);
		int ret = assetsDeviceAccountDao.updateAssetsDeviceAccountAll(old);
		if (ret == 0) {
			throw new DaoException("数据失效，请重新更新");
		}
		return ret;
	}

	/**
	 * 修改对象部分字段
	 * @param dto 修改对象
	 * @return int
	 * @throws Exception
	 */
	public int updateAssetsDeviceAccountSensitive(AssetsDeviceAccountDTO dto) throws Exception {
		AssetsUserLogService assetsUserLogService= SpringFactory.getBean(  "assetsUserLogService");
		try {
			//记录日志
			AssetsDeviceAccountDTO old = findById(dto.getId());
			if (old != null) {
				SysLogUtil.log4Update(dto, old);
				assetsUserLogService.log4Update(dto,old);
			}
			PojoUtil.setSysProperties(dto, OpType.update);
			PojoUtil.copyProperties(old, dto, true);
			int count = assetsDeviceAccountDao.updateAssetsDeviceAccountSensitive(old);
			if (count == 0) {
				throw new DaoException("数据失效，请重新更新");
			}
			return count;
		} catch (Exception e) {
			logger.error("updateAssetsDeviceAccountSensitive出错：", e);
			throw new DaoException(e.getMessage(), e);
		}
	}



	public int updateAssetsDeviceAccountSensitive4WS(AssetsDeviceAccountDTO dto) throws Exception {
		AssetsUserLogService assetsUserLogService= SpringFactory.getBean(  "assetsUserLogService");
		try{
			//记录日志
			AssetsDeviceAccountDTO old = findById(dto.getId());
			if (old != null) {
				SysLogUtil.log4Update(dto, old);
				assetsUserLogService.log4Update(dto,old);
			}
		}catch(Exception e){
		    e.printStackTrace();
		}

		try {

			PojoUtil.setSysProperties(dto, OpType.update);
			int count = assetsDeviceAccountDao.updateAssetsDeviceAccountSensitive4WS(dto);
			if (count == 0) {
				throw new DaoException("数据失效，请重新更新");
			}
			return count;
		} catch (Exception e) {
			logger.error("updateAssetsDeviceAccountSensitive4WS出错：", e);
			throw new DaoException(e.getMessage(), e);
		}
	}
    /**
     * 流程修改对象部分字段
     * @param dto 修改对象
     * @return int
     * @throws Exception
     */
    public int updateFlowAssetsDeviceAccountSensitive(AssetsDeviceAccountDTO dto,String created_by,String formId,String flowName,String flowID) throws Exception {
        AssetsUserLogService assetsUserLogService= SpringFactory.getBean(  "assetsUserLogService");
        try {
            //记录日志
            AssetsDeviceAccountDTO old = findById(dto.getId());
            if (old != null) {
                SysLogUtil.log4Update(dto, old);
                assetsUserLogService.log4FlowUpdate(dto,old,created_by,formId,flowName,flowID);
            }
            PojoUtil.setSysProperties(dto, OpType.update);
            PojoUtil.copyProperties(old, dto, true);
            int count = assetsDeviceAccountDao.updateAssetsDeviceAccountSensitive(old);
            if (count == 0) {
                throw new DaoException("数据失效，请重新更新");
            }
            return count;
        } catch (Exception e) {
            logger.error("updateAssetsDeviceAccountSensitive出错：", e);
            throw new DaoException(e.getMessage(), e);
        }
    }

	/**
	 * 批量更新对象
	 * @param dtoList 修改对象集合
	 * @return int
	 * @throws Exception
	 */
	public int updateAssetsDeviceAccountList(List<AssetsDeviceAccountDTO> dtoList) throws Exception {
		try {
			return assetsDeviceAccountDao.updateAssetsDeviceAccountList(dtoList);
		} catch (Exception e) {
			logger.error("updateAssetsDeviceAccountList出错：", e);
			throw new DaoException(e.getMessage(), e);
		}

	}

	/**
	 * 按主键单条删除
	 * @param id 主键id
	 * @return int
	 * @throws Exception
	 */
	public int deleteAssetsDeviceAccountById(String id) throws Exception {
		if (StringUtils.isEmpty(id)) {
			throw new Exception("删除失败！传入的参数主键为null");
		}
		try {
			//记录日志
			AssetsDeviceAccountDTO obje = findById(id);
			if (obje != null) {
				SysLogUtil.log4Delete(obje);
			}
			return assetsDeviceAccountDao.deleteAssetsDeviceAccountById(id);
		} catch (Exception e) {
			logger.error("deleteAssetsDeviceAccountById出错：", e);
			throw new DaoException(e.getMessage(), e);
		}
	}

	/**
	 * 批量删除数据
	 * @param ids id的数组
	 * @return int
	 * @throws Exception
	 */
	public int deleteAssetsDeviceAccountByIds(String[] ids) throws Exception {
		int result = 0;
		for (String id : ids) {
			deleteAssetsDeviceAccountById(id);
			result++;
		}
		return result;
	}

	/**
	 * 批量删除数据2
	 * @param idList 主键集合
	 * @return int
	 * @throws Exception
	 */
	public int deleteAssetsDeviceAccountList(List<String> idList) throws Exception {
		try {
			return assetsDeviceAccountDao.deleteAssetsDeviceAccountList(idList);
		} catch (Exception e) {
			logger.error("deleteAssetsDeviceAccountList出错：", e);
			throw e;
		}
	}

	/**
	* 日志专用，内部方法，不再记录日志
	* @param id 主键id
	* @return AssetsDeviceAccountDTO
	* @throws Exception
	*/
	private AssetsDeviceAccountDTO findById(String id) throws Exception {
		try {
			AssetsDeviceAccountDTO dto = assetsDeviceAccountDao.findAssetsDeviceAccountById(id);
			//记录日志
			if (dto != null) {
				SysLogUtil.log4Query(dto);
			}
			return dto;
		} catch (Exception e) {
			logger.error("findById出错：", e);
			throw new DaoException(e.getMessage(), e);
		}
	}
	/**
	 * 通过统一编号查询单条记录
	 * @param unifiedId 统一编号id
	 * @return AssetsDeviceAccountDTO
	 * @throws Exception
	 */
	public AssetsDeviceAccountDTO queryAssetsDeviceAccountByUnifiedId(String unifiedId) throws Exception {
		try {
			AssetsDeviceAccountDTO dto = assetsDeviceAccountDao.findAssetsDeviceAccountByUnifiedId(unifiedId);
			//记录日志
			if (dto != null) {
				SysLogUtil.log4Query(dto);
			}
			return dto;
		} catch (Exception e) {
			logger.error("queryAssetsDeviceAccountByUnifiedId出错：", e);
			throw new DaoException(e.getMessage(), e);
		}
	}

	/**
	 * 通过流水号查询单条记录
	 * @param serialNumber 流水号
	 * @return List<AssetsDeviceAccountDTO>
	 * @throws Exception
	 */
	public List<AssetsDeviceAccountDTO> getAssetsDeviceAccountBySerialNumber(Long serialNumber) throws Exception {
		try {
			List<AssetsDeviceAccountDTO> dataList = assetsDeviceAccountDao.getAssetsDeviceAccountBySerialNumber(serialNumber);
			return dataList;
		} catch (Exception e) {
			logger.error("getAssetsDeviceAccountBySerialNumber出错：", e);
			throw new DaoException(e.getMessage(), e);
		}
	}

	/**
	 * 获取当前台账的最大流水号
	 * @return Long
	 * @throws Exception
	 */
	public Long getMaxSerialNumber() throws Exception {
		try {
			Long maxSerialNumber = assetsDeviceAccountDao.getMaxSerialNumber();
			return maxSerialNumber;
		} catch (Exception e) {
			logger.error("getMaxSerialNumber出错：", e);
			throw new DaoException(e.getMessage(), e);
		}
	}
}
