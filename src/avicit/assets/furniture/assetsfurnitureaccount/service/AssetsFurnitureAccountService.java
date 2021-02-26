package avicit.assets.furniture.assetsfurnitureaccount.service;

import java.io.Serializable;
import java.util.List;
import java.util.ArrayList;
import org.apache.commons.lang3.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import avicit.platform6.modules.system.sysfileupload.service.SwfUploadService;

import avicit.platform6.commons.utils.ComUtil;
import avicit.platform6.commons.utils.PojoUtil;
import avicit.platform6.core.properties.PlatformConstant.OpType;
import avicit.platform6.core.exception.DaoException;
import avicit.platform6.core.mybatis.pagehelper.Page;
import avicit.platform6.core.mybatis.pagehelper.PageHelper;
import avicit.platform6.core.rest.msg.QueryReqBean;
import avicit.platform6.core.rest.msg.QueryRespBean;
import avicit.assets.furniture.assetsfurnitureaccount.dao.AssetsFurnitureAccountDao;
import avicit.assets.furniture.assetsfurnitureaccount.dto.AssetsFurnitureAccountDTO;
import avicit.platform6.modules.system.syslog.service.SysLogUtil;

/**
 * @科技有限责任公司
 * @作者：请填写
 * @邮箱：avicitdev@avicit.com
 * @创建时间： 2020-08-13 14:05
 * @类说明：请填写
 * @修改记录：
 */
@Service
public class AssetsFurnitureAccountService implements Serializable {

	private static final Logger logger = LoggerFactory.getLogger(AssetsFurnitureAccountService.class);

	private static final long serialVersionUID = 1L;

	@Autowired
	private AssetsFurnitureAccountDao assetsFurnitureAccountDao;

	@Autowired
	private SwfUploadService sysAttachmentAPI;

	/**
	* 按条件分页查询
	* @param queryReqBean 分页
	* @param orderBy 排序
	* @return QueryRespBean<AssetsFurnitureAccountDTO>
	* @throws Exception
	*/
	public QueryRespBean<AssetsFurnitureAccountDTO> searchAssetsFurnitureAccountByPage(
			QueryReqBean<AssetsFurnitureAccountDTO> queryReqBean, String orderBy) throws Exception {
		try {
			PageHelper.startPage(queryReqBean.getPageParameter());
			AssetsFurnitureAccountDTO searchParams = queryReqBean.getSearchParams();
			Page<AssetsFurnitureAccountDTO> dataList = assetsFurnitureAccountDao
					.searchAssetsFurnitureAccountByPage(searchParams, orderBy);
			QueryRespBean<AssetsFurnitureAccountDTO> queryRespBean = new QueryRespBean<AssetsFurnitureAccountDTO>();
			queryRespBean.setResult(dataList);
			return queryRespBean;
		} catch (Exception e) {
			logger.error("searchAssetsFurnitureAccountByPage出错：", e);
			e.printStackTrace();
			throw new DaoException(e.getMessage(), e);
		}
	}

	/**
	* 按条件or查询的分页查询
	* @param queryReqBean 分页 
	* @param orderBy 排序
	* @return QueryRespBean<AssetsFurnitureAccountDTO>
	* @throws Exception
	*/
	public QueryRespBean<AssetsFurnitureAccountDTO> searchAssetsFurnitureAccountByPageOr(
			QueryReqBean<AssetsFurnitureAccountDTO> queryReqBean, String orderBy) throws Exception {
		try {
			PageHelper.startPage(queryReqBean.getPageParameter());
			AssetsFurnitureAccountDTO searchParams = queryReqBean.getSearchParams();
			Page<AssetsFurnitureAccountDTO> dataList = assetsFurnitureAccountDao
					.searchAssetsFurnitureAccountByPageOr(searchParams, orderBy);
			QueryRespBean<AssetsFurnitureAccountDTO> queryRespBean = new QueryRespBean<AssetsFurnitureAccountDTO>();

			queryRespBean.setResult(dataList);
			return queryRespBean;
		} catch (Exception e) {
			logger.error("searchAssetsFurnitureAccountByPage出错：", e);
			e.printStackTrace();
			throw new DaoException(e.getMessage(), e);
		}
	}

	/**
	 * 按条件查询
	 * @param queryReqBean 条件
	 * @return List<AssetsFurnitureAccountDTO>
	 * @throws Exception
	 */
	public List<AssetsFurnitureAccountDTO> searchAssetsFurnitureAccount(
			QueryReqBean<AssetsFurnitureAccountDTO> queryReqBean) throws Exception {
		try {
			AssetsFurnitureAccountDTO searchParams = queryReqBean.getSearchParams();
			List<AssetsFurnitureAccountDTO> dataList = assetsFurnitureAccountDao
					.searchAssetsFurnitureAccount(searchParams);
			return dataList;
		} catch (Exception e) {
			logger.error("searchAssetsFurnitureAccount出错：", e);
			e.printStackTrace();
			throw new DaoException(e.getMessage(), e);
		}
	}

	/**
	 * 通过主键查询单条记录
	 * @param id 主键id
	 * @return AssetsFurnitureAccountDTO
	 * @throws Exception
	 */
	public AssetsFurnitureAccountDTO queryAssetsFurnitureAccountByPrimaryKey(String id) throws Exception {
		try {
			AssetsFurnitureAccountDTO dto = assetsFurnitureAccountDao.findAssetsFurnitureAccountById(id);
			//记录日志
			if (dto != null) {
				SysLogUtil.log4Query(dto);
			}
			return dto;
		} catch (Exception e) {
			logger.error("queryAssetsFurnitureAccountByPrimaryKey出错：", e);
			e.printStackTrace();
			throw new DaoException(e.getMessage(), e);
		}
	}

	/**
	 * 通过统一编号查询单条记录
	 * @param unifiedId 统一编码
	 * @return AssetsFurnitureAccountDTO
	 * @throws Exception
	 */
	public AssetsFurnitureAccountDTO queryAssetsFurnitureAccountByUnifiedId(String unifiedId) throws Exception {
		try {
			AssetsFurnitureAccountDTO dto = assetsFurnitureAccountDao.findAssetsFurnitureAccountByUnifiedId(unifiedId);
			//记录日志
			if (dto != null) {
				SysLogUtil.log4Query(dto);
			}
			return dto;
		} catch (Exception e) {
			logger.error("queryAssetsFurnitureAccountByUnifiedId出错：", e);
			e.printStackTrace();
			throw new DaoException(e.getMessage(), e);
		}
	}

	/**
	 * 新增对象
	 * @param dto 保存对象
	 * @return String
	 * @throws Exception
	 */
	public String insertAssetsFurnitureAccount(AssetsFurnitureAccountDTO dto) throws Exception {
		try {
			String id = ComUtil.getId();
			dto.setId(id);
			PojoUtil.setSysProperties(dto, OpType.insert);
			assetsFurnitureAccountDao.insertAssetsFurnitureAccount(dto);
			//记录日志
			if (dto != null) {
				SysLogUtil.log4Insert(dto);
			}
			return id;
		} catch (Exception e) {
			logger.error("insertAssetsFurnitureAccount出错：", e);
			e.printStackTrace();
			throw new DaoException(e.getMessage(), e);
		}
	}

	/**
	 * 批量新增对象
	 * @param dtoList 保存对象集合
	 * @return int
	 * @throws Exception
	 */
	public int insertAssetsFurnitureAccountList(List<AssetsFurnitureAccountDTO> dtoList) throws Exception {
		List<AssetsFurnitureAccountDTO> beanList = new ArrayList<AssetsFurnitureAccountDTO>();
		for (AssetsFurnitureAccountDTO dto : dtoList) {
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
			return assetsFurnitureAccountDao.insertAssetsFurnitureAccountList(beanList);
		} catch (Exception e) {
			logger.error("insertAssetsFurnitureAccountList出错：", e);
			e.printStackTrace();
			throw new DaoException(e.getMessage(), e);
		}
	}

	/**
	 * 修改对象全部字段
	 * @param dto 修改对象
	 * @return int
	 * @throws Exception
	 */
	public int updateAssetsFurnitureAccount(AssetsFurnitureAccountDTO dto) throws Exception {
		//记录日志
		AssetsFurnitureAccountDTO old = findById(dto.getId());
		if (old != null) {
			SysLogUtil.log4Update(dto, old);
		}
		PojoUtil.setSysProperties(dto, OpType.update);
		PojoUtil.copyProperties(old, dto, true);
		int ret = assetsFurnitureAccountDao.updateAssetsFurnitureAccountAll(old);
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
	public int updateAssetsFurnitureAccountSensitive(AssetsFurnitureAccountDTO dto) throws Exception {
		try {
			//记录日志
			AssetsFurnitureAccountDTO old = findById(dto.getId());
			if (old != null) {
				SysLogUtil.log4Update(dto, old);
			}
			PojoUtil.setSysProperties(dto, OpType.update);
			PojoUtil.copyProperties(old, dto, true);
			int count = assetsFurnitureAccountDao.updateAssetsFurnitureAccountSensitive(old);
			if (count == 0) {
				throw new DaoException("数据失效，请重新更新");
			}
			return count;
		} catch (Exception e) {
			logger.error("updateAssetsFurnitureAccountSensitive出错：", e);
			e.printStackTrace();
			throw new DaoException(e.getMessage(), e);
		}

	}

	/**
	 * 批量更新对象
	 * @param dtoList 修改对象集合
	 * @return int
	 * @throws Exception
	 */
	public int updateAssetsFurnitureAccountList(List<AssetsFurnitureAccountDTO> dtoList) throws Exception {
		try {
			return assetsFurnitureAccountDao.updateAssetsFurnitureAccountList(dtoList);
		} catch (Exception e) {
			logger.error("updateAssetsFurnitureAccountList出错：", e);
			e.printStackTrace();
			throw new DaoException(e.getMessage(), e);
		}

	}

	/**
	 * 按主键单条删除
	 * @param id 主键id
	 * @return int
	 * @throws Exception
	 */
	public int deleteAssetsFurnitureAccountById(String id) throws Exception {
		if (StringUtils.isEmpty(id)) {
			throw new Exception("删除失败！传入的参数主键为null");
		}
		try {
			//记录日志
			AssetsFurnitureAccountDTO obje = findById(id);
			if (obje != null) {
				SysLogUtil.log4Delete(obje);
			}
			return assetsFurnitureAccountDao.deleteAssetsFurnitureAccountById(id);
		} catch (Exception e) {
			logger.error("deleteAssetsFurnitureAccountById出错：", e);
			e.printStackTrace();
			throw new DaoException(e.getMessage(), e);
		}
	}

	/**
	 * 批量删除数据
	 * @param ids id的数组
	 * @return int
	 * @throws Exception
	 */
	public int deleteAssetsFurnitureAccountByIds(String[] ids) throws Exception {
		int result = 0;
		for (String id : ids) {
			sysAttachmentAPI.deleteAttachByFormId(id);
			deleteAssetsFurnitureAccountById(id);
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
	public int deleteAssetsFurnitureAccountList(List<String> idList) throws Exception {
		try {
			return assetsFurnitureAccountDao.deleteAssetsFurnitureAccountList(idList);
		} catch (Exception e) {
			logger.error("deleteAssetsFurnitureAccountList出错：", e);
			e.printStackTrace();
			throw e;
		}
	}

	/**
	* 日志专用，内部方法，不再记录日志
	* @param id 主键id
	* @return AssetsFurnitureAccountDTO
	* @throws Exception
	*/
	private AssetsFurnitureAccountDTO findById(String id) throws Exception {
		try {
			AssetsFurnitureAccountDTO dto = assetsFurnitureAccountDao.findAssetsFurnitureAccountById(id);
			//记录日志
			if (dto != null) {
				SysLogUtil.log4Query(dto);
			}
			return dto;
		} catch (Exception e) {
			logger.error("findById出错：", e);
			e.printStackTrace();
			throw new DaoException(e.getMessage(), e);
		}
	}

}
