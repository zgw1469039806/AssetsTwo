package avicit.assets.device.dynassetsreconst.service;

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
import avicit.platform6.core.properties.PlatformConstant.OpType;
import avicit.platform6.core.exception.DaoException;
import avicit.platform6.core.mybatis.pagehelper.Page;
import avicit.platform6.core.mybatis.pagehelper.PageHelper;
import avicit.platform6.core.rest.msg.QueryReqBean;
import avicit.platform6.core.rest.msg.QueryRespBean;
import avicit.assets.device.dynassetsreconst.dto.AssetsReconstructionRDTO;
import avicit.assets.device.dynassetsreconst.dao.AssetsReconstructionRDao;
import avicit.platform6.modules.system.syslog.service.SysLogUtil;

/**
 * @科技有限责任公司
 * @作者：请填写</p>
 * @邮箱：avicitdev@avicit.com
 * @创建时间： 2020-09-03 18:52
 * @类说明：请填写
 * @修改记录： 
 */
@Service
public class AssetsReconstructionRService implements Serializable {

	private static final Logger LOGGER = LoggerFactory.getLogger(AssetsReconstructionRService.class);

	private static final long serialVersionUID = 1L;

	@Autowired
	private AssetsReconstructionRDao assetsReconstructionRDao;

	/**
	 * 按条件分页查询
	 * @param queryReqBean 分页
	 * @param orderBy 排序
	 * @return QueryRespBean<AssetsReconstructionRDTO>
	 * @throws Exception
	 */
	public QueryRespBean<AssetsReconstructionRDTO> searchAssetsReconstructionRByPage(
			QueryReqBean<AssetsReconstructionRDTO> queryReqBean, String orderBy) throws Exception {
		try {
			PageHelper.startPage(queryReqBean.getPageParameter());
			AssetsReconstructionRDTO searchParams = queryReqBean.getSearchParams();
			Page<AssetsReconstructionRDTO> dataList = assetsReconstructionRDao
					.searchAssetsReconstructionRByPage(searchParams, orderBy);
			QueryRespBean<AssetsReconstructionRDTO> queryRespBean = new QueryRespBean<AssetsReconstructionRDTO>();

			queryRespBean.setResult(dataList);
			return queryRespBean;
		} catch (Exception e) {
			LOGGER.error("searchAssetsReconstructionRByPage出错：", e);
			throw new DaoException(e.getMessage(), e);
		}
	}

	/**
	 * 按条件or查询的分页查询
	 * @param queryReqBean 分页 
	 * @param orderBy 排序
	 * @return QueryRespBean<AssetsReconstructionRDTO>
	 * @throws Exception
	 */
	public QueryRespBean<AssetsReconstructionRDTO> searchAssetsReconstructionRByPageOr(
			QueryReqBean<AssetsReconstructionRDTO> queryReqBean, String orderBy) throws Exception {
		try {
			PageHelper.startPage(queryReqBean.getPageParameter());
			AssetsReconstructionRDTO searchParams = queryReqBean.getSearchParams();
			Page<AssetsReconstructionRDTO> dataList = assetsReconstructionRDao
					.searchAssetsReconstructionRByPageOr(searchParams, orderBy);
			QueryRespBean<AssetsReconstructionRDTO> queryRespBean = new QueryRespBean<AssetsReconstructionRDTO>();

			queryRespBean.setResult(dataList);
			return queryRespBean;
		} catch (Exception e) {
			LOGGER.error("searchAssetsReconstructionRByPage出错：", e);
			throw new DaoException(e.getMessage(), e);
		}
	}

	/**
	 * 通过主键查询单条记录
	 * @param id 主键id
	 * @return AssetsReconstructionRDTO
	 * @throws Exception
	 */
	public AssetsReconstructionRDTO queryAssetsReconstructionRByPrimaryKey(String id) throws Exception {
		try {
			AssetsReconstructionRDTO dto = assetsReconstructionRDao.findAssetsReconstructionRById(id);
			//记录日志
			if (dto != null) {
				SysLogUtil.log4Query(dto);
			}
			return dto;
		} catch (Exception e) {
			LOGGER.error("queryAssetsReconstructionRByPrimaryKey出错：", e);
			throw new DaoException(e.getMessage(), e);
		}
	}

	/**
	 * 通过父键查询单条记录
	 * @param pid 父id
	 * @return List<AssetsReconstructionRDTO>
	 * @throws Exception
	 */
	public List<AssetsReconstructionRDTO> queryAssetsReconstructionRByPid(String pid) throws Exception {
		try {
			List<AssetsReconstructionRDTO> dto = assetsReconstructionRDao.findAssetsReconstructionRByPid(pid);
			return dto;
		} catch (Exception e) {
			LOGGER.error("queryAssetsReconstructionRByPid出错：", e);
			throw new DaoException(e.getMessage(), e);
		}
	}

	/**
	 * 新增对象
	 * @param dto 保存对象
	 * @return String
	 * @throws Exception
	 */
	public String insertAssetsReconstructionR(AssetsReconstructionRDTO dto) throws Exception {
		try {
			String id = ComUtil.getId();
			dto.setId(id);
			PojoUtil.setSysProperties(dto, OpType.insert);
			assetsReconstructionRDao.insertAssetsReconstructionR(dto);
			//记录日志
			if (dto != null) {
				SysLogUtil.log4Insert(dto);
			}
			return id;
		} catch (Exception e) {
			LOGGER.error("insertAssetsReconstructionR出错：", e);
			throw new DaoException(e.getMessage(), e);
		}
	}

	/**
	 * 批量新增对象
	 * @param dtoList 保存对象集合
	 * @return int
	 * @throws Exception
	 */
	public int insertAssetsReconstructionRList(List<AssetsReconstructionRDTO> dtoList, String pid) throws Exception {
		List<AssetsReconstructionRDTO> beanList = new ArrayList<AssetsReconstructionRDTO>();
		for (AssetsReconstructionRDTO dto : dtoList) {
			String id = ComUtil.getId();
			dto.setId(id);
			dto.setAttribute01(pid);
			PojoUtil.setSysProperties(dto, OpType.insert);
			//记录日志
			if (dto != null) {
				SysLogUtil.log4Insert(dto);
			}
			beanList.add(dto);
		}
		try {
			return assetsReconstructionRDao.insertAssetsReconstructionRList(beanList);
		} catch (Exception e) {
			LOGGER.error("insertAssetsReconstructionRList出错：", e);
			throw new DaoException(e.getMessage(), e);
		}
	}

	/**
	 * 新增或修改对象
	 * @param dtos 对象集合
	 * @return void
	 * @throws Exception
	 */
	public void insertOrUpdateAssetsReconstructionR(List<AssetsReconstructionRDTO> dtos, String pid) throws Exception {
		for (AssetsReconstructionRDTO dto : dtos) {
			if ("".equals(dto.getId()) || null == dto.getId()) {
				dto.setAttribute01(pid);
				this.insertAssetsReconstructionR(dto);
			} else {
				this.updateAssetsReconstructionR(dto);
			}
		}
	}

	/**
	 * 修改对象全部字段
	 * @param dto 修改对象
	 * @return int
	 * @throws Exception
	 */
	public int updateAssetsReconstructionR(AssetsReconstructionRDTO dto) throws Exception {
		try {
			//记录日志
			AssetsReconstructionRDTO old = findById(dto.getId());
			if (old != null) {
				SysLogUtil.log4Update(dto, old);
			}
			PojoUtil.setSysProperties(dto, OpType.update);
			PojoUtil.copyProperties(old, dto, true);
			int count = assetsReconstructionRDao.updateAssetsReconstructionRAll(old);
			if (count == 0) {
				throw new DaoException("数据失效，请重新更新");
			}
			return count;
		} catch (Exception e) {
			LOGGER.error("updateAssetsReconstructionR出错：", e);
			throw new DaoException(e.getMessage(), e);
		}
	}

	/**
	 * 修改对象部分字段
	 * @param dto 修改对象
	 * @return int
	 * @throws Exception
	 */
	public int updateAssetsReconstructionRSensitive(AssetsReconstructionRDTO dto) throws Exception {
		try {
			//记录日志
			AssetsReconstructionRDTO old = findById(dto.getId());
			if (old != null) {
				SysLogUtil.log4Update(dto, old);
			}
			PojoUtil.setSysProperties(dto, OpType.update);
			PojoUtil.copyProperties(old, dto, true);
			int count = assetsReconstructionRDao.updateAssetsReconstructionRSensitive(old);
			if (count == 0) {
				throw new DaoException("数据失效，请重新更新");
			}
			return count;
		} catch (Exception e) {
			LOGGER.error("updateAssetsReconstructionRSensitive出错：", e);
			throw new DaoException(e.getMessage(), e);
		}

	}

	/**
	 * 批量更新对象
	 * @param dtoList 修改对象集合
	 * @return int
	 * @throws Exception
	 */
	public int updateAssetsReconstructionRList(List<AssetsReconstructionRDTO> dtoList) throws Exception {
		try {
			return assetsReconstructionRDao.updateAssetsReconstructionRList(dtoList);
		} catch (Exception e) {
			LOGGER.error("updateAssetsReconstructionRList出错：", e);
			throw new DaoException(e.getMessage(), e);
		}
	}

	/**
	 * 按主键单条删除
	 * @param id 主键id
	 * @return int
	 * @throws Exception
	 */
	public int deleteAssetsReconstructionRById(String id) throws Exception {
		if (StringUtils.isEmpty(id)) {
			throw new Exception("删除失败！传入的参数主键为null");
		}
		try {
			//记录日志
			AssetsReconstructionRDTO obje = findById(id);
			if (obje != null) {
				SysLogUtil.log4Delete(obje);
			}
			return assetsReconstructionRDao.deleteAssetsReconstructionRById(id);
		} catch (Exception e) {
			LOGGER.error("deleteAssetsReconstructionRById出错：", e);
			throw new DaoException(e.getMessage(), e);
		}
	}

	/**
	 * 按条件删除数据
	 * @param dto 对象条件
	 * @return int
	 * @throws Exception
	 */
	public int deleteAssetsReconstructionR(AssetsReconstructionRDTO dto) throws Exception {
		try {
			//记录日志
			if (dto != null) {
				SysLogUtil.log4Delete(dto);
			}
			return assetsReconstructionRDao.deleteAssetsReconstructionRById(dto.getId());
		} catch (Exception e) {
			LOGGER.error("deleteAssetsReconstructionR出错：", e);
			throw new DaoException(e.getMessage(), e);
		}
	}

	/**
	 * 批量删除数据
	 * @param ids id的数组
	 * @return int
	 * @throws Exception
	 */
	public int deleteAssetsReconstructionRByIds(String[] ids) throws Exception {
		int result = 0;
		for (String id : ids) {
			deleteAssetsReconstructionRById(id);
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
	public int deleteAssetsReconstructionRList(List<String> idList) throws Exception {
		try {
			return assetsReconstructionRDao.deleteAssetsReconstructionRList(idList);
		} catch (Exception e) {
			LOGGER.error("deleteAssetsReconstructionRList出错：", e);
			throw e;
		}
	}

	/**
	 * 日志专用，内部方法，不再记录日志
	 * @param id 主键id
	 * @return AssetsReconstructionRDTO
	 * @throws Exception
	 */
	private AssetsReconstructionRDTO findById(String id) throws Exception {
		try {
			AssetsReconstructionRDTO dto = assetsReconstructionRDao.findAssetsReconstructionRById(id);
			//记录日志
			if (dto != null) {
				SysLogUtil.log4Query(dto);
			}
			return dto;
		} catch (Exception e) {
			LOGGER.error("findById出错：", e);
			throw new DaoException(e.getMessage(), e);
		}
	}

}
