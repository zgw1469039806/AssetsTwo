package avicit.assets.device.assetstdeviceupgradesub.service;

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
import avicit.assets.device.assetstdeviceupgradesub.dao.AssetsTdeviceUpgradeSubDao;
import avicit.assets.device.assetstdeviceupgradesub.dto.AssetsTdeviceUpgradeSubDTO;
import avicit.platform6.modules.system.syslog.service.SysLogUtil;

/**
 * @科技有限责任公司
 * @作者：请填写
 * @邮箱：avicitdev@avicit.com
 * @创建时间： 2020-07-28 08:43
 * @类说明：请填写
 * @修改记录：
 */
@Service
public class AssetsTdeviceUpgradeSubService implements Serializable {

	private static final Logger logger = LoggerFactory.getLogger(AssetsTdeviceUpgradeSubService.class);

	private static final long serialVersionUID = 1L;

	@Autowired
	private AssetsTdeviceUpgradeSubDao assetsTdeviceUpgradeSubDao;

	@Autowired
	private SwfUploadService sysAttachmentAPI;

	/**
	* 按条件分页查询
	* @param queryReqBean 分页
	* @param orderBy 排序
	* @return QueryRespBean<AssetsTdeviceUpgradeSubDTO>
	* @throws Exception
	*/
	public QueryRespBean<AssetsTdeviceUpgradeSubDTO> searchAssetsTdeviceUpgradeSubByPage(
			QueryReqBean<AssetsTdeviceUpgradeSubDTO> queryReqBean, String orderBy) throws Exception {
		try {
			PageHelper.startPage(queryReqBean.getPageParameter());
			AssetsTdeviceUpgradeSubDTO searchParams = queryReqBean.getSearchParams();
			Page<AssetsTdeviceUpgradeSubDTO> dataList = assetsTdeviceUpgradeSubDao
					.searchAssetsTdeviceUpgradeSubByPage(searchParams, orderBy);
			QueryRespBean<AssetsTdeviceUpgradeSubDTO> queryRespBean = new QueryRespBean<AssetsTdeviceUpgradeSubDTO>();
			queryRespBean.setResult(dataList);
			return queryRespBean;
		} catch (Exception e) {
			logger.error("searchAssetsTdeviceUpgradeSubByPage出错：", e);
			e.printStackTrace();
			throw new DaoException(e.getMessage(), e);
		}
	}

	/**
	* 按条件or查询的分页查询
	* @param queryReqBean 分页 
	* @param orderBy 排序
	* @return QueryRespBean<AssetsTdeviceUpgradeSubDTO>
	* @throws Exception
	*/
	public QueryRespBean<AssetsTdeviceUpgradeSubDTO> searchAssetsTdeviceUpgradeSubByPageOr(
			QueryReqBean<AssetsTdeviceUpgradeSubDTO> queryReqBean, String orderBy) throws Exception {
		try {
			PageHelper.startPage(queryReqBean.getPageParameter());
			AssetsTdeviceUpgradeSubDTO searchParams = queryReqBean.getSearchParams();
			Page<AssetsTdeviceUpgradeSubDTO> dataList = assetsTdeviceUpgradeSubDao
					.searchAssetsTdeviceUpgradeSubByPageOr(searchParams, orderBy);
			QueryRespBean<AssetsTdeviceUpgradeSubDTO> queryRespBean = new QueryRespBean<AssetsTdeviceUpgradeSubDTO>();

			queryRespBean.setResult(dataList);
			return queryRespBean;
		} catch (Exception e) {
			logger.error("searchAssetsTdeviceUpgradeSubByPage出错：", e);
			e.printStackTrace();
			throw new DaoException(e.getMessage(), e);
		}
	}

	/**
	 * 按条件查询
	 * @param queryReqBean 条件
	 * @return List<AssetsTdeviceUpgradeSubDTO>
	 * @throws Exception
	 */
	public List<AssetsTdeviceUpgradeSubDTO> searchAssetsTdeviceUpgradeSub(
			QueryReqBean<AssetsTdeviceUpgradeSubDTO> queryReqBean) throws Exception {
		try {
			AssetsTdeviceUpgradeSubDTO searchParams = queryReqBean.getSearchParams();
			List<AssetsTdeviceUpgradeSubDTO> dataList = assetsTdeviceUpgradeSubDao
					.searchAssetsTdeviceUpgradeSub(searchParams);
			return dataList;
		} catch (Exception e) {
			logger.error("searchAssetsTdeviceUpgradeSub出错：", e);
			e.printStackTrace();
			throw new DaoException(e.getMessage(), e);
		}
	}

	/**
	 * 通过主键查询单条记录
	 * @param id 主键id
	 * @return AssetsTdeviceUpgradeSubDTO
	 * @throws Exception
	 */
	public AssetsTdeviceUpgradeSubDTO queryAssetsTdeviceUpgradeSubByPrimaryKey(String id) throws Exception {
		try {
			AssetsTdeviceUpgradeSubDTO dto = assetsTdeviceUpgradeSubDao.findAssetsTdeviceUpgradeSubById(id);
			//记录日志
			if (dto != null) {
				SysLogUtil.log4Query(dto);
			}
			return dto;
		} catch (Exception e) {
			logger.error("queryAssetsTdeviceUpgradeSubByPrimaryKey出错：", e);
			e.printStackTrace();
			throw new DaoException(e.getMessage(), e);
		}
	}

	/**
	 * 通过外键查询单条记录
	 * @param foreignkey 外键id
	 * @return List<AssetsTdeviceUpgradeSubDTO>
	 * @throws Exception
	 */
	public List<AssetsTdeviceUpgradeSubDTO> queryAssetsTdeviceUpgradeSubByForeignKey(String foreignkey) throws Exception {
		try {
			List<AssetsTdeviceUpgradeSubDTO> dtos = assetsTdeviceUpgradeSubDao.findAssetsTdeviceUpgradeSubByForeignKey(foreignkey);
			for(AssetsTdeviceUpgradeSubDTO dto:dtos){
				//记录日志
				if (dto != null) {
					SysLogUtil.log4Query(dto);
				}
			}
			return dtos;
		} catch (Exception e) {
			logger.error("queryAssetsTdeviceUpgradeSubByForeign出错：", e);
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
	public String insertAssetsTdeviceUpgradeSub(AssetsTdeviceUpgradeSubDTO dto) throws Exception {
		try {
			String id = ComUtil.getId();
			dto.setId(id);
			/* 根据表单formId通过getFileUrl函数获取到弹出页面访问连接，并存储到数据库的附件地址字段中 */
			/* getFileUrl方法在文件avicit/assets/device/assetstdeviceupgradesub/js/AssetsTdeviceUpgradeSub.js */
			/* 点击 查看附件 的连接时，触发onclick函数 */
			String fileUrl ="<a href=\"javascript:void(0);\" onclick=\"getFileUrl('"+id+"');\">查看附件</a>";
			dto.setAttachementUrl(fileUrl);

			PojoUtil.setSysProperties(dto, OpType.insert);

			/* 新增软件的唯一ID */
			String addId = dto.getTdeviceSoftwareId();
			/* 新增软件的子表外键（主表ID） */
			String addForeignKey = dto.getTdeviceForeign();
			/* 用新增软件的ID，在数据库中查询是否有相同ID的数据 */
			List<AssetsTdeviceUpgradeSubDTO> tdeviceUpgradeSubDTOs = assetsTdeviceUpgradeSubDao.findTdeviceUpgradeByTdeviceSoftwareId(addId);
			/* 如果查询结果不为空，则判断是否是同一个父表 */
			if(tdeviceUpgradeSubDTOs.size()!=0){
				for(AssetsTdeviceUpgradeSubDTO tdeviceUpgradeSubDTO:tdeviceUpgradeSubDTOs){
					String existForeignKey = tdeviceUpgradeSubDTO.getTdeviceForeign();	/* 现存软件的子表外键（主表ID） */
					if(existForeignKey.equals(addForeignKey)){
						return null;
					}
				}
			}



			assetsTdeviceUpgradeSubDao.insertAssetsTdeviceUpgradeSub(dto);
			//记录日志
			if (dto != null) {
				SysLogUtil.log4Insert(dto);
			}
			return id;
		} catch (Exception e) {
			logger.error("insertAssetsTdeviceUpgradeSub出错：", e);
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
	public int insertAssetsTdeviceUpgradeSubList(List<AssetsTdeviceUpgradeSubDTO> dtoList) throws Exception {
		List<AssetsTdeviceUpgradeSubDTO> beanList = new ArrayList<AssetsTdeviceUpgradeSubDTO>();
		for (AssetsTdeviceUpgradeSubDTO dto : dtoList) {
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
			return assetsTdeviceUpgradeSubDao.insertAssetsTdeviceUpgradeSubList(beanList);
		} catch (Exception e) {
			logger.error("insertAssetsTdeviceUpgradeSubList出错：", e);
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
	public int updateAssetsTdeviceUpgradeSub(AssetsTdeviceUpgradeSubDTO dto) throws Exception {
		//记录日志
		AssetsTdeviceUpgradeSubDTO old = findById(dto.getId());
		if (old != null) {
			SysLogUtil.log4Update(dto, old);
		}
		PojoUtil.setSysProperties(dto, OpType.update);
		PojoUtil.copyProperties(old, dto, true);
		int ret = assetsTdeviceUpgradeSubDao.updateAssetsTdeviceUpgradeSubAll(old);
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
	public int updateAssetsTdeviceUpgradeSubSensitive(AssetsTdeviceUpgradeSubDTO dto) throws Exception {
		try {
			//记录日志
			AssetsTdeviceUpgradeSubDTO old = findById(dto.getId());
			if (old != null) {
				SysLogUtil.log4Update(dto, old);
			}
			PojoUtil.setSysProperties(dto, OpType.update);
			PojoUtil.copyProperties(old, dto, true);
			int count = assetsTdeviceUpgradeSubDao.updateAssetsTdeviceUpgradeSubSensitive(old);
			if (count == 0) {
				throw new DaoException("数据失效，请重新更新");
			}
			return count;
		} catch (Exception e) {
			logger.error("updateAssetsTdeviceUpgradeSubSensitive出错：", e);
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
	public int updateAssetsTdeviceUpgradeSubList(List<AssetsTdeviceUpgradeSubDTO> dtoList) throws Exception {
		try {
			return assetsTdeviceUpgradeSubDao.updateAssetsTdeviceUpgradeSubList(dtoList);
		} catch (Exception e) {
			logger.error("updateAssetsTdeviceUpgradeSubList出错：", e);
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
	public int deleteAssetsTdeviceUpgradeSubById(String id) throws Exception {
		if (StringUtils.isEmpty(id)) {
			throw new Exception("删除失败！传入的参数主键为null");
		}
		try {
			//记录日志
			AssetsTdeviceUpgradeSubDTO obje = findById(id);
			if (obje != null) {
				SysLogUtil.log4Delete(obje);
			}
			return assetsTdeviceUpgradeSubDao.deleteAssetsTdeviceUpgradeSubById(id);
		} catch (Exception e) {
			logger.error("deleteAssetsTdeviceUpgradeSubById出错：", e);
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
	public int deleteAssetsTdeviceUpgradeSubByIds(String[] ids) throws Exception {
		int result = 0;
		for (String id : ids) {
			sysAttachmentAPI.deleteAttachByFormId(id);
			deleteAssetsTdeviceUpgradeSubById(id);
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
	public int deleteAssetsTdeviceUpgradeSubList(List<String> idList) throws Exception {
		try {
			return assetsTdeviceUpgradeSubDao.deleteAssetsTdeviceUpgradeSubList(idList);
		} catch (Exception e) {
			logger.error("deleteAssetsTdeviceUpgradeSubList出错：", e);
			e.printStackTrace();
			throw e;
		}
	}

	/**
	* 日志专用，内部方法，不再记录日志
	* @param id 主键id
	* @return AssetsTdeviceUpgradeSubDTO
	* @throws Exception
	*/
	private AssetsTdeviceUpgradeSubDTO findById(String id) throws Exception {
		try {
			AssetsTdeviceUpgradeSubDTO dto = assetsTdeviceUpgradeSubDao.findAssetsTdeviceUpgradeSubById(id);
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
