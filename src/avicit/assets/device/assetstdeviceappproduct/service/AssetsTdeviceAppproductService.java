package avicit.assets.device.assetstdeviceappproduct.service;

import java.io.Serializable;
import java.util.List;
import java.util.ArrayList;
import org.apache.commons.lang3.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import avicit.platform6.commons.utils.ComUtil;
import avicit.platform6.commons.utils.PojoUtil;
import avicit.platform6.core.exception.DaoException;
import avicit.platform6.core.mybatis.pagehelper.Page;
import avicit.platform6.core.mybatis.pagehelper.PageHelper;
import avicit.platform6.core.properties.PlatformConstant.OpType;
import avicit.platform6.core.rest.msg.QueryReqBean;
import avicit.platform6.core.rest.msg.QueryRespBean;
import avicit.assets.device.assetstdeviceappproduct.dao.AssetsTdeviceAppproductDao;
import avicit.assets.device.assetstdeviceappproduct.dto.AssetsTdeviceAppproductDTO;
import avicit.platform6.modules.system.syslog.service.SysLogUtil;

/**
 * @科技有限责任公司
 * @作者：请填写
 * @邮箱：avicitdev@avicit.com
 * @创建时间： 2020-07-14 17:31
 * @类说明：请填写
 * @修改记录： 
 */
@Service
public class AssetsTdeviceAppproductService implements Serializable {

	private static final Logger logger = LoggerFactory.getLogger(AssetsTdeviceAppproductService.class);

	private static final long serialVersionUID = 1L;

	@Autowired
	private AssetsTdeviceAppproductDao assetsTdeviceAppproductDao;

	/**
	* 按条件分页查询
	* @param queryReqBean 分页
	* @param orderBy 排序
	* @return QueryRespBean<AssetsTdeviceAppproductDTO>
	* @throws Exception
	*/
	public QueryRespBean<AssetsTdeviceAppproductDTO> searchAssetsTdeviceAppproductByPage(
			QueryReqBean<AssetsTdeviceAppproductDTO> queryReqBean, String orderBy) throws Exception {
		try {
			PageHelper.startPage(queryReqBean.getPageParameter());
			AssetsTdeviceAppproductDTO searchParams = queryReqBean.getSearchParams();
			Page<AssetsTdeviceAppproductDTO> dataList = assetsTdeviceAppproductDao
					.searchAssetsTdeviceAppproductByPage(searchParams, orderBy);
			QueryRespBean<AssetsTdeviceAppproductDTO> queryRespBean = new QueryRespBean<AssetsTdeviceAppproductDTO>();
			queryRespBean.setResult(dataList);
			return queryRespBean;
		} catch (Exception e) {
			logger.error("searchAssetsTdeviceAppproductByPage出错：", e);
			throw new DaoException(e.getMessage(), e);
		}

	}

	/**
	* 按条件or查询的分页查询
	* @param queryReqBean 分页 
	* @param orderBy 排序
	* @return QueryRespBean<AssetsTdeviceAppproductDTO>
	* @throws Exception
	*/
	public QueryRespBean<AssetsTdeviceAppproductDTO> searchAssetsTdeviceAppproductByPageOr(
			QueryReqBean<AssetsTdeviceAppproductDTO> queryReqBean, String orderBy) throws Exception {
		try {
			PageHelper.startPage(queryReqBean.getPageParameter());
			AssetsTdeviceAppproductDTO searchParams = queryReqBean.getSearchParams();
			Page<AssetsTdeviceAppproductDTO> dataList = assetsTdeviceAppproductDao
					.searchAssetsTdeviceAppproductByPageOr(searchParams, orderBy);
			QueryRespBean<AssetsTdeviceAppproductDTO> queryRespBean = new QueryRespBean<AssetsTdeviceAppproductDTO>();
			queryRespBean.setResult(dataList);
			return queryRespBean;
		} catch (Exception e) {
			logger.error("searchAssetsTdeviceAppproductByPage出错：", e);
			throw new DaoException(e.getMessage(), e);
		}
	}

	/**
	* 新增或修改对象
	* @param dtos 对象集合
	* @return void
	* @throws Exception
	*/
	public void insertOrUpdateAssetsTdeviceAppproduct(List<AssetsTdeviceAppproductDTO> dtos) throws Exception {
		for (AssetsTdeviceAppproductDTO dto : dtos) {
			if ("".equals(dto.getId()) || null == dto.getId()) {
				this.insertAssetsTdeviceAppproduct(dto);
			} else {
				this.updateAssetsTdeviceAppproduct(dto);
			}
		}
	}

	/**
	* 新增对象
	* @param dto 保存对象
	* @return int
	* @throws Exception
	*/
	public int insertAssetsTdeviceAppproduct(AssetsTdeviceAppproductDTO dto) throws Exception {
		try {
			String id = ComUtil.getId();
			dto.setId(id);
			PojoUtil.setSysProperties(dto, OpType.insert);
			int ret = assetsTdeviceAppproductDao.insertAssetsTdeviceAppproduct(dto);
			//记录日志
			if (dto != null) {
				SysLogUtil.log4Insert(dto);
			}
			return ret;
		} catch (Exception e) {
			logger.error("insertAssetsTdeviceAppproduct出错：", e);
			throw new DaoException(e.getMessage(), e);
		}
	}

	/**
	 * 批量新增对象
	 * @param dtoList 保存对象集合
	 * @return int
	 * @throws Exception
	 */
	public int insertAssetsTdeviceAppproductList(List<AssetsTdeviceAppproductDTO> dtoList) throws Exception {
		List<AssetsTdeviceAppproductDTO> beanList = new ArrayList<AssetsTdeviceAppproductDTO>();
		for (AssetsTdeviceAppproductDTO dto : dtoList) {
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
			return assetsTdeviceAppproductDao.insertAssetsTdeviceAppproductList(beanList);
		} catch (Exception e) {
			logger.error("insertAssetsTdeviceAppproductList出错：", e);
			throw new DaoException(e.getMessage(), e);
		}
	}

	/**
	 * 修改对象全部字段
	 * @param dto 修改对象
	 * @return int
	 * @throws Exception
	 */
	public int updateAssetsTdeviceAppproduct(AssetsTdeviceAppproductDTO dto) throws Exception {
		//记录日志
		AssetsTdeviceAppproductDTO old = findById(dto.getId());
		if (old != null) {
			SysLogUtil.log4Update(dto, old);
		}
		PojoUtil.setSysProperties(dto, OpType.update);
		PojoUtil.copyProperties(old, dto, true);
		int ret = assetsTdeviceAppproductDao.updateAssetsTdeviceAppproductSensitive(old);
		if (ret == 0) {
			throw new DaoException("数据失效，请重新更新");
		}
		return ret;
	}

	/**
	 * 批量更新对象
	 * @param dtoList 修改对象集合
	 * @return int
	 * @throws Exception
	 */
	public int updateAssetsTdeviceAppproductList(List<AssetsTdeviceAppproductDTO> dtoList) throws Exception {
		try {
			return assetsTdeviceAppproductDao.updateAssetsTdeviceAppproductList(dtoList);
		} catch (Exception e) {
			logger.error("updateAssetsTdeviceAppproductList出错：", e);
			throw new DaoException(e.getMessage(), e);
		}

	}

	/**
	 * 按主键单条删除
	 * @param id 主键id
	 * @return int
	 * @throws Exception
	 */
	public int deleteAssetsTdeviceAppproductById(String id) throws Exception {
		if (StringUtils.isEmpty(id)) {
			return 0;
		}
		try {
			//记录日志
			AssetsTdeviceAppproductDTO obje = findById(id);
			if (obje != null) {
				SysLogUtil.log4Delete(obje);
			}
			return assetsTdeviceAppproductDao.deleteAssetsTdeviceAppproductById(id);
		} catch (Exception e) {
			logger.error("deleteAssetsTdeviceAppproductById出错：", e);
			throw new DaoException(e.getMessage(), e);
		}
	}

	/**
	 * 批量删除数据
	 * @param ids id的数组
	 * @return int
	 * @throws Exception
	 */
	public int deleteAssetsTdeviceAppproductByIds(String[] ids) throws Exception {
		int result = 0;
		for (String id : ids) {
			deleteAssetsTdeviceAppproductById(id);
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
	public int deleteAssetsTdeviceAppproductList(List<String> idList) throws Exception {
		try {
			return assetsTdeviceAppproductDao.deleteAssetsTdeviceAppproductList(idList);
		} catch (Exception e) {
			logger.error("deleteAssetsTdeviceAppproductList出错：", e);
			throw e;
		}
	}

	/**
	 * 日志专用，内部方法，不再记录日志
	 * @param id 主键id
	 * @return AssetsTdeviceAppproductDTO
	 * @throws Exception
	 */
	private AssetsTdeviceAppproductDTO findById(String id) throws Exception {
		try {
			AssetsTdeviceAppproductDTO dto = assetsTdeviceAppproductDao.findAssetsTdeviceAppproductById(id);
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
	 * 日志专用，内部方法，不再记录日志
	 * @作者：柯嘉
	 * @param id 主键id
	 * @return String
	 * @throws Exception
	 */
	public String findPlaneModelByUnifiedId(String id) throws Exception {
		try {
			List<AssetsTdeviceAppproductDTO> dtos = assetsTdeviceAppproductDao.findAssetsTdeviceAppproductByUnifiedId(id);

			/* 将多个dto中的PlaneModel组成数组 */
			List<String> list = new ArrayList<>();
			for (AssetsTdeviceAppproductDTO dto : dtos) {
				String model = dto.getPlaneModel();
				if(model!=null&&!"".equals(model)){
					list.add(model);
				}

			}
			/* list去重 */
			for(int i =0;i<list.size()-1;i++){
				for(int j=list.size()-1;j>i;j--){
					if(list.get(i).equals(list.get(j)))
						list.remove(j);
				}
			}

			/* 将list转换为String并以 ， 分隔 */
			String str= null;
			for(String listStr : list){
				if(str == null){
					str = listStr;
				}
				else{
					str += "," + listStr;
				}
			}

			for (AssetsTdeviceAppproductDTO dto : dtos) {
				//记录日志
				if (dto != null) {
					SysLogUtil.log4Query(dto);
				}
			}
			return str;
		} catch (Exception e) {
			logger.error("findByUnifiedId出错：", e);
			throw new DaoException(e.getMessage(), e);
		}
	}

	/**
	 * 日志专用，内部方法，不再记录日志
	 * @作者：柯嘉
	 * @param id 主键id
	 * @return String
	 * @throws Exception
	 */
	public String findProductNameByUnifiedId(String id) throws Exception {
		try {
			List<AssetsTdeviceAppproductDTO> dtos = assetsTdeviceAppproductDao.findAssetsTdeviceAppproductByUnifiedId(id);

			/* 将多个dto中的PlaneModel组成数组 */
			List<String> list = new ArrayList<>();
			for (AssetsTdeviceAppproductDTO dto : dtos) {
				String ProductName = dto.getProductName();
				if(ProductName!=null&&!"".equals(ProductName)){
					list.add(ProductName);
				}

			}
			/* list去重 */
			for(int i =0;i<list.size()-1;i++){
				for(int j=list.size()-1;j>i;j--){
					if(list.get(i).equals(list.get(j)))
						list.remove(j);
				}
			}

			/* 将list转换为String并以 ， 分隔 */
			String str= null;
			for(String listStr : list){
				if(str == null){
					str = listStr;
				}
				else{
					str += "," + listStr;
				}
			}


			for (AssetsTdeviceAppproductDTO dto : dtos) {
				//记录日志
				if (dto != null) {
					SysLogUtil.log4Query(dto);
				}
			}
			return str;
		} catch (Exception e) {
			logger.error("findByUnifiedId出错：", e);
			throw new DaoException(e.getMessage(), e);
		}
	}
}
