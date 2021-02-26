package avicit.assets.device.usertreejson.service;

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
import avicit.assets.device.usertreejson.dao.UserTreeJsonDao;
import avicit.assets.device.usertreejson.dto.UserTreeJsonDTO;
import avicit.platform6.modules.system.syslog.service.SysLogUtil;

/**
 * @科技有限责任公司
 * @作者：请填写
 * @邮箱：avicitdev@avicit.com @创建时间： 2020-06-05 10:55
 * @类说明：请填写 @修改记录：
 */
@Service
public class UserTreeJsonService implements Serializable {

	private static final Logger LOGGER = LoggerFactory.getLogger(UserTreeJsonService.class);

	private static final long serialVersionUID = 1L;

	@Autowired
	private UserTreeJsonDao userTreeJsonDao;

	/**
	 * 按条件分页查询
	 * @param queryReqBean  分页
	 * @param oderby  排序
	 * @return QueryRespBean<UserTreeJsonDTO>
	 * @throws Exception
	 */
	public QueryRespBean<UserTreeJsonDTO> searchUserTreeJsonByPage(QueryReqBean<UserTreeJsonDTO> queryReqBean,
			String oderby) throws Exception {
		try {
			PageHelper.startPage(queryReqBean.getPageParameter());
			UserTreeJsonDTO searchParams = queryReqBean.getSearchParams();
			Page<UserTreeJsonDTO> dataList = userTreeJsonDao.searchUserTreeJsonByPage(searchParams, oderby);
			QueryRespBean<UserTreeJsonDTO> queryRespBean = new QueryRespBean<UserTreeJsonDTO>();

			queryRespBean.setResult(dataList);
			return queryRespBean;
		} catch (Exception e) {
			LOGGER.error("searchUserTreeJsonByPage出错：", e);
			e.printStackTrace();
			throw new DaoException(e.getMessage(), e);
		}
	}

	/**
	 * 按条件or查询的分页查询
	 * @param queryReqBean  分页
	 * @param oderby   排序
	 * @return QueryRespBean<UserTreeJsonDTO>
	 * @throws Exception
	 */
	public QueryRespBean<UserTreeJsonDTO> searchUserTreeJsonByPageOr(QueryReqBean<UserTreeJsonDTO> queryReqBean,
			String oderby) throws Exception {
		try {
			PageHelper.startPage(queryReqBean.getPageParameter());
			UserTreeJsonDTO searchParams = queryReqBean.getSearchParams();
			Page<UserTreeJsonDTO> dataList = userTreeJsonDao.searchUserTreeJsonByPageOr(searchParams, oderby);
			QueryRespBean<UserTreeJsonDTO> queryRespBean = new QueryRespBean<UserTreeJsonDTO>();

			queryRespBean.setResult(dataList);
			return queryRespBean;
		} catch (Exception e) {
			LOGGER.error("searchUserTreeJsonByPage出错：", e);
			e.printStackTrace();
			throw new DaoException(e.getMessage(), e);
		}
	}

	/**
	 * 按条件查询
	 * @param queryReqBean  条件
	 * @return List<UserTreeJsonDTO>
	 * @throws Exception
	 */
	public List<UserTreeJsonDTO> searchUserTreeJson(QueryReqBean<UserTreeJsonDTO> queryReqBean) throws Exception {
		try {
			UserTreeJsonDTO searchParams = queryReqBean.getSearchParams();
			List<UserTreeJsonDTO> dataList = userTreeJsonDao.searchUserTreeJson(searchParams);
			return dataList;
		} catch (Exception e) {
			LOGGER.error("searchUserTreeJson出错：", e);
			e.printStackTrace();
			throw new DaoException(e.getMessage(), e);
		}
	}

	/**
	 * 通过主键查询单条记录
	 * @param id  主键id
	 * @return UserTreeJsonDTO
	 * @throws Exception
	 */
	public UserTreeJsonDTO queryUserTreeJsonByPrimaryKey(String id) throws Exception {
		try {
			UserTreeJsonDTO dto = userTreeJsonDao.findUserTreeJsonById(id);
			// 记录日志
			if (dto != null) {
				SysLogUtil.log4Query(dto);
			}
			return dto;
		} catch (Exception e) {
			LOGGER.error("queryUserTreeJsonByPrimaryKey出错：", e);
			e.printStackTrace();
			throw new DaoException(e.getMessage(), e);
		}
	}
	
	/**
	 * 通过所属对象的id、所属对象的类型、树对象的表名获取TreeJson
	 * @param：objectId(所属对象的id)、obejctType(所属对象的类型)、treeName(树对象的表名)
	 * @return UserTreeJsonDTO
	 * @throws Exception
	 */
	public UserTreeJsonDTO getTreeJson(String objectId, String obejctType, String treeName) throws Exception {
		try {
			List<UserTreeJsonDTO> dataList = userTreeJsonDao.getTreeJson(objectId, obejctType, treeName);

			if (dataList != null) {
				return dataList.get(0);
			}
			return null;
		} catch (Exception e) {
			LOGGER.error("getTreeJson出错：", e);
			e.printStackTrace();
			throw new DaoException(e.getMessage(), e);
		}
	}

	/**
	 * 新增对象
	 * @param dto   保存对象
	 * @return String
	 * @throws Exception
	 */
	public String insertUserTreeJson(UserTreeJsonDTO dto) throws Exception {
		try {
			String id = ComUtil.getId();
			dto.setId(id);
			PojoUtil.setSysProperties(dto, OpType.insert);
			userTreeJsonDao.insertUserTreeJson(dto);
			// 记录日志
			if (dto != null) {
				SysLogUtil.log4Insert(dto);
			}
			return id;
		} catch (Exception e) {
			LOGGER.error("insertUserTreeJson出错：", e);
			e.printStackTrace();
			throw new DaoException(e.getMessage(), e);
		}
	}

	/**
	 * 批量新增对象
	 * @param dtoList  保存对象集合
	 * @return int
	 * @throws Exception
	 */
	public int insertUserTreeJsonList(List<UserTreeJsonDTO> dtoList) throws Exception {
		List<UserTreeJsonDTO> demo = new ArrayList<UserTreeJsonDTO>();
		for (UserTreeJsonDTO dto : dtoList) {
			String id = ComUtil.getId();
			dto.setId(id);
			PojoUtil.setSysProperties(dto, OpType.insert);
			// 记录日志
			if (dto != null) {
				SysLogUtil.log4Insert(dto);
			}
			demo.add(dto);
		}
		try {
			return userTreeJsonDao.insertUserTreeJsonList(demo);
		} catch (Exception e) {
			LOGGER.error("insertUserTreeJsonList出错：", e);
			e.printStackTrace();
			throw new DaoException(e.getMessage(), e);
		}
	}

	/**
	 * 修改对象全部字段
	 * @param dto   修改对象
	 * @return int
	 * @throws Exception
	 */
	public int updateUserTreeJson(UserTreeJsonDTO dto) throws Exception {
		// 记录日志
		UserTreeJsonDTO old = findById(dto.getId());
		if (old != null) {
			SysLogUtil.log4Update(dto, old);
		}
		PojoUtil.setSysProperties(dto, OpType.update);
		PojoUtil.copyProperties(old, dto, true);
		int ret = userTreeJsonDao.updateUserTreeJsonAll(old);
		if (ret == 0) {
			throw new DaoException("数据失效，请重新更新");
		}
		return ret;
	}

	/**
	 * 修改对象部分字段
	 * @param dto   修改对象
	 * @return int
	 * @throws Exception
	 */
	public int updateUserTreeJsonSensitive(UserTreeJsonDTO dto) throws Exception {
		try {
			// 记录日志
			UserTreeJsonDTO old = findById(dto.getId());
			if (old != null) {
				SysLogUtil.log4Update(dto, old);
			}
			PojoUtil.setSysProperties(dto, OpType.update);
			PojoUtil.copyProperties(old, dto, true);
			int count = userTreeJsonDao.updateUserTreeJsonSensitive(old);
			if (count == 0) {
				throw new DaoException("数据失效，请重新更新");
			}
			return count;
		} catch (Exception e) {
			LOGGER.error("updateUserTreeJsonSensitive出错：", e);
			e.printStackTrace();
			throw new DaoException(e.getMessage(), e);
		}
	}

	/**
	 * 批量更新对象
	 * @param dtoList  修改对象集合
	 * @return int
	 * @throws Exception
	 */
	public int updateUserTreeJsonList(List<UserTreeJsonDTO> dtoList) throws Exception {
		try {
			return userTreeJsonDao.updateUserTreeJsonList(dtoList);
		} catch (Exception e) {
			LOGGER.error("updateUserTreeJsonList出错：", e);
			e.printStackTrace();
			throw new DaoException(e.getMessage(), e);
		}

	}

	/**
	 * 按主键单条删除
	 * @param id   主键id
	 * @return int
	 * @throws Exception
	 */
	public int deleteUserTreeJsonById(String id) throws Exception {
		if (StringUtils.isEmpty(id)) {
			throw new Exception("删除失败！传入的参数主键为null");
		}
		try {
			// 记录日志
			UserTreeJsonDTO obje = findById(id);
			if (obje != null) {
				SysLogUtil.log4Delete(obje);
			}
			return userTreeJsonDao.deleteUserTreeJsonById(id);
		} catch (Exception e) {
			LOGGER.error("deleteUserTreeJsonById出错：", e);
			e.printStackTrace();
			throw new DaoException(e.getMessage(), e);
		}
	}

	/**
	 * 批量删除数据
	 * @param ids  id的数组
	 * @return int
	 * @throws Exception
	 */
	public int deleteUserTreeJsonByIds(String[] ids) throws Exception {
		int result = 0;
		for (String id : ids) {
			deleteUserTreeJsonById(id);
			result++;
		}
		return result;
	}

	/**
	 * 批量删除数据2
	 * @param idlist  主键集合
	 * @return int
	 * @throws Exception
	 */
	public int deleteUserTreeJsonList(List<String> idlist) throws Exception {
		try {
			return userTreeJsonDao.deleteUserTreeJsonList(idlist);
		} catch (Exception e) {
			LOGGER.error("deleteUserTreeJsonList出错：", e);
			e.printStackTrace();
			throw e;
		}
	}

	/**
	 * 日志专用，内部方法，不再记录日志
	 * @param id  主键id
	 * @return UserTreeJsonDTO
	 * @throws Exception
	 */
	private UserTreeJsonDTO findById(String id) throws Exception {
		try {
			UserTreeJsonDTO dto = userTreeJsonDao.findUserTreeJsonById(id);
			// 记录日志
			if (dto != null) {
				SysLogUtil.log4Query(dto);
			}
			return dto;
		} catch (Exception e) {
			LOGGER.error("findById出错：", e);
			e.printStackTrace();
			throw new DaoException(e.getMessage(), e);
		}
	}
}
