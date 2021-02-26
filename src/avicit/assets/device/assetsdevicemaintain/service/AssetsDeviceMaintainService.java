package avicit.assets.device.assetsdevicemaintain.service;

import java.io.Serializable;
import java.util.List;
import java.util.ArrayList;

import avicit.assets.device.assetsdeviceacccheck.dto.AssetsDeviceAccCheckDTO;
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
import avicit.assets.device.assetsdevicemaintain.dao.AssetsDeviceMaintainDao;
import avicit.assets.device.assetsdevicemaintain.dto.AssetsDeviceMaintainDTO;
import avicit.platform6.modules.system.syslog.service.SysLogUtil;

/**
 * @科技有限责任公司
 * @作者：请填写
 * @邮箱：avicitdev@avicit.com
 * @创建时间： 2020-07-02 17:46
 * @类说明：请填写
 * @修改记录： 
 */
@Service
public class AssetsDeviceMaintainService implements Serializable {

	private static final Logger logger = LoggerFactory.getLogger(AssetsDeviceMaintainService.class);

	private static final long serialVersionUID = 1L;

	@Autowired
	private AssetsDeviceMaintainDao assetsDeviceMaintainDao;

	/**
	* 按条件分页查询
	* @param queryReqBean 分页
	* @param orderBy 排序
	* @return QueryRespBean<AssetsDeviceMaintainDTO>
	* @throws Exception
	*/
	public QueryRespBean<AssetsDeviceMaintainDTO> searchAssetsDeviceMaintainByPage(
			QueryReqBean<AssetsDeviceMaintainDTO> queryReqBean, String orderBy) throws Exception {
		try {
			PageHelper.startPage(queryReqBean.getPageParameter());
			AssetsDeviceMaintainDTO searchParams = queryReqBean.getSearchParams();
			Page<AssetsDeviceMaintainDTO> dataList = assetsDeviceMaintainDao
					.searchAssetsDeviceMaintainByPage(searchParams, orderBy);
			QueryRespBean<AssetsDeviceMaintainDTO> queryRespBean = new QueryRespBean<AssetsDeviceMaintainDTO>();
			queryRespBean.setResult(dataList);
			return queryRespBean;
		} catch (Exception e) {
			logger.error("searchAssetsDeviceMaintainByPage出错：", e);
			throw new DaoException(e.getMessage(), e);
		}

	}

	/**
	* 按条件or查询的分页查询
	* @param queryReqBean 分页 
	* @param orderBy 排序
	* @return QueryRespBean<AssetsDeviceMaintainDTO>
	* @throws Exception
	*/
	public QueryRespBean<AssetsDeviceMaintainDTO> searchAssetsDeviceMaintainByPageOr(
			QueryReqBean<AssetsDeviceMaintainDTO> queryReqBean, String orderBy) throws Exception {
		try {
			PageHelper.startPage(queryReqBean.getPageParameter());
			AssetsDeviceMaintainDTO searchParams = queryReqBean.getSearchParams();
			Page<AssetsDeviceMaintainDTO> dataList = assetsDeviceMaintainDao
					.searchAssetsDeviceMaintainByPageOr(searchParams, orderBy);
			QueryRespBean<AssetsDeviceMaintainDTO> queryRespBean = new QueryRespBean<AssetsDeviceMaintainDTO>();
			queryRespBean.setResult(dataList);
			return queryRespBean;
		} catch (Exception e) {
			logger.error("searchAssetsDeviceMaintainByPage出错：", e);
			throw new DaoException(e.getMessage(), e);
		}
	}

	/**
	* 新增或修改对象
	* @param dtos 对象集合
	* @return void
	* @throws Exception
	*/
	public void insertOrUpdateAssetsDeviceMaintain(List<AssetsDeviceMaintainDTO> dtos) throws Exception {
		for (AssetsDeviceMaintainDTO dto : dtos) {
			if ("".equals(dto.getId()) || null == dto.getId()) {
				this.insertAssetsDeviceMaintain(dto);
			} else {
				this.updateAssetsDeviceMaintain(dto);
			}
		}
	}

	/**
	* 新增对象
	* @param dto 保存对象
	* @return int
	* @throws Exception
	*/
	public int insertAssetsDeviceMaintain(AssetsDeviceMaintainDTO dto) throws Exception {
		try {
			String id = ComUtil.getId();
			dto.setId(id);
			PojoUtil.setSysProperties(dto, OpType.insert);
			int ret = assetsDeviceMaintainDao.insertAssetsDeviceMaintain(dto);
			//记录日志
			if (dto != null) {
				SysLogUtil.log4Insert(dto);
			}
			return ret;
		} catch (Exception e) {
			logger.error("insertAssetsDeviceMaintain出错：", e);
			throw new DaoException(e.getMessage(), e);
		}
	}

	/**
	 * 批量新增对象
	 * @param dtoList 保存对象集合
	 * @return int
	 * @throws Exception
	 */
	public int insertAssetsDeviceMaintainList(List<AssetsDeviceMaintainDTO> dtoList) throws Exception {
		List<AssetsDeviceMaintainDTO> beanList = new ArrayList<AssetsDeviceMaintainDTO>();
		for (AssetsDeviceMaintainDTO dto : dtoList) {
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
			return assetsDeviceMaintainDao.insertAssetsDeviceMaintainList(beanList);
		} catch (Exception e) {
			logger.error("insertAssetsDeviceMaintainList出错：", e);
			throw new DaoException(e.getMessage(), e);
		}
	}

	/**
	 * 修改对象全部字段
	 * @param dto 修改对象
	 * @return int
	 * @throws Exception
	 */
	public int updateAssetsDeviceMaintain(AssetsDeviceMaintainDTO dto) throws Exception {
		//记录日志
		AssetsDeviceMaintainDTO old = findById(dto.getId());
		if (old != null) {
			SysLogUtil.log4Update(dto, old);
		}
		PojoUtil.setSysProperties(dto, OpType.update);
		PojoUtil.copyProperties(old, dto, true);
		int ret = assetsDeviceMaintainDao.updateAssetsDeviceMaintainSensitive(old);
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
	public int updateAssetsDeviceMaintainList(List<AssetsDeviceMaintainDTO> dtoList) throws Exception {
		try {
			return assetsDeviceMaintainDao.updateAssetsDeviceMaintainList(dtoList);
		} catch (Exception e) {
			logger.error("updateAssetsDeviceMaintainList出错：", e);
			throw new DaoException(e.getMessage(), e);
		}

	}

	/**
	 * 按主键单条删除
	 * @param id 主键id
	 * @return int
	 * @throws Exception
	 */
	public int deleteAssetsDeviceMaintainById(String id) throws Exception {
		if (StringUtils.isEmpty(id)) {
			return 0;
		}
		try {
			//记录日志
			AssetsDeviceMaintainDTO obje = findById(id);
			if (obje != null) {
				SysLogUtil.log4Delete(obje);
			}
			return assetsDeviceMaintainDao.deleteAssetsDeviceMaintainById(id);
		} catch (Exception e) {
			logger.error("deleteAssetsDeviceMaintainById出错：", e);
			throw new DaoException(e.getMessage(), e);
		}
	}

	/**
	 * 批量删除数据
	 * @param ids id的数组
	 * @return int
	 * @throws Exception
	 */
	public int deleteAssetsDeviceMaintainByIds(String[] ids) throws Exception {
		int result = 0;
		for (String id : ids) {
			deleteAssetsDeviceMaintainById(id);
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
	public int deleteAssetsDeviceMaintainList(List<String> idList) throws Exception {
		try {
			return assetsDeviceMaintainDao.deleteAssetsDeviceMaintainList(idList);
		} catch (Exception e) {
			logger.error("deleteAssetsDeviceMaintainList出错：", e);
			throw e;
		}
	}

	/**
	 * 日志专用，内部方法，不再记录日志
	 * @param id 主键id
	 * @return AssetsDeviceMaintainDTO
	 * @throws Exception
	 */
	public AssetsDeviceMaintainDTO findById(String id) throws Exception {
		try {
			AssetsDeviceMaintainDTO dto = assetsDeviceMaintainDao.findAssetsDeviceMaintainById(id);
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
	 * 更新全部对象 设备定检
	 * @param assetsDeviceMaintainDTO
	 * @return
	 * @throws Exception
	 */
	public  int updateAssetsDeviceMaintainAll(AssetsDeviceMaintainDTO assetsDeviceMaintainDTO) throws  Exception{
		try {
			return assetsDeviceMaintainDao.updateAssetsDeviceMaintainAll(assetsDeviceMaintainDTO);
		}catch (Exception e){
			logger.error("deleteAssetsDeviceRegularCheckList出错：", e);
			throw e;
		}

	}
}
