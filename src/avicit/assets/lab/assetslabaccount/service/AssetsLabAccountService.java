package avicit.assets.lab.assetslabaccount.service;

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
import avicit.assets.lab.assetslabaccount.dao.AssetsLabAccountDao;
import avicit.assets.lab.assetslabaccount.dto.AssetsLabAccountDTO;
import avicit.platform6.modules.system.syslog.service.SysLogUtil;

/**
 * @科技有限责任公司
 * @作者：请填写
 * @邮箱：avicitdev@avicit.com
 * @创建时间： 2020-08-21 16:08
 * @类说明：请填写
 * @修改记录：
 */
@Service
public class AssetsLabAccountService implements Serializable {

	private static final Logger logger = LoggerFactory.getLogger(AssetsLabAccountService.class);

	private static final long serialVersionUID = 1L;

	@Autowired
	private AssetsLabAccountDao assetsLabAccountDao;

	@Autowired
	private SwfUploadService sysAttachmentAPI;

	/**
	* 按条件分页查询
	* @param queryReqBean 分页
	* @param orderBy 排序
	* @return QueryRespBean<AssetsLabAccountDTO>
	* @throws Exception
	*/
	public QueryRespBean<AssetsLabAccountDTO> searchAssetsLabAccountByPage(
			QueryReqBean<AssetsLabAccountDTO> queryReqBean, String orderBy) throws Exception {
		try {
			PageHelper.startPage(queryReqBean.getPageParameter());
			AssetsLabAccountDTO searchParams = queryReqBean.getSearchParams();
			Page<AssetsLabAccountDTO> dataList = assetsLabAccountDao.searchAssetsLabAccountByPage(searchParams,
					orderBy);
			QueryRespBean<AssetsLabAccountDTO> queryRespBean = new QueryRespBean<AssetsLabAccountDTO>();
			queryRespBean.setResult(dataList);
			return queryRespBean;
		} catch (Exception e) {
			logger.error("searchAssetsLabAccountByPage出错：", e);
			e.printStackTrace();
			throw new DaoException(e.getMessage(), e);
		}
	}

	/**
	* 按条件or查询的分页查询
	* @param queryReqBean 分页 
	* @param orderBy 排序
	* @return QueryRespBean<AssetsLabAccountDTO>
	* @throws Exception
	*/
	public QueryRespBean<AssetsLabAccountDTO> searchAssetsLabAccountByPageOr(
			QueryReqBean<AssetsLabAccountDTO> queryReqBean, String orderBy) throws Exception {
		try {
			PageHelper.startPage(queryReqBean.getPageParameter());
			AssetsLabAccountDTO searchParams = queryReqBean.getSearchParams();
			Page<AssetsLabAccountDTO> dataList = assetsLabAccountDao.searchAssetsLabAccountByPageOr(searchParams,
					orderBy);
			QueryRespBean<AssetsLabAccountDTO> queryRespBean = new QueryRespBean<AssetsLabAccountDTO>();

			queryRespBean.setResult(dataList);
			return queryRespBean;
		} catch (Exception e) {
			logger.error("searchAssetsLabAccountByPage出错：", e);
			e.printStackTrace();
			throw new DaoException(e.getMessage(), e);
		}
	}

	/**
	 * 按条件查询
	 * @param queryReqBean 条件
	 * @return List<AssetsLabAccountDTO>
	 * @throws Exception
	 */
	public List<AssetsLabAccountDTO> searchAssetsLabAccount(QueryReqBean<AssetsLabAccountDTO> queryReqBean)
			throws Exception {
		try {
			AssetsLabAccountDTO searchParams = queryReqBean.getSearchParams();
			List<AssetsLabAccountDTO> dataList = assetsLabAccountDao.searchAssetsLabAccount(searchParams);
			return dataList;
		} catch (Exception e) {
			logger.error("searchAssetsLabAccount出错：", e);
			e.printStackTrace();
			throw new DaoException(e.getMessage(), e);
		}
	}

	/**
	 * 通过主键查询单条记录
	 * @param id 主键id
	 * @return AssetsLabAccountDTO
	 * @throws Exception
	 */
	public AssetsLabAccountDTO queryAssetsLabAccountByPrimaryKey(String id) throws Exception {
		try {
			AssetsLabAccountDTO dto = assetsLabAccountDao.findAssetsLabAccountById(id);
			//记录日志
			if (dto != null) {
				SysLogUtil.log4Query(dto);
			}
			return dto;
		} catch (Exception e) {
			logger.error("queryAssetsLabAccountByPrimaryKey出错：", e);
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
	public String insertAssetsLabAccount(AssetsLabAccountDTO dto) throws Exception {
		try {
			String id = ComUtil.getId();
			dto.setId(id);
			PojoUtil.setSysProperties(dto, OpType.insert);
			assetsLabAccountDao.insertAssetsLabAccount(dto);
			//记录日志
			if (dto != null) {
				SysLogUtil.log4Insert(dto);
			}
			return id;
		} catch (Exception e) {
			logger.error("insertAssetsLabAccount出错：", e);
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
	public int insertAssetsLabAccountList(List<AssetsLabAccountDTO> dtoList) throws Exception {
		List<AssetsLabAccountDTO> beanList = new ArrayList<AssetsLabAccountDTO>();
		for (AssetsLabAccountDTO dto : dtoList) {
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
			return assetsLabAccountDao.insertAssetsLabAccountList(beanList);
		} catch (Exception e) {
			logger.error("insertAssetsLabAccountList出错：", e);
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
	public int updateAssetsLabAccount(AssetsLabAccountDTO dto) throws Exception {
		//记录日志
		AssetsLabAccountDTO old = findById(dto.getId());
		if (old != null) {
			SysLogUtil.log4Update(dto, old);
		}
		PojoUtil.setSysProperties(dto, OpType.update);
		PojoUtil.copyProperties(old, dto, true);
		int ret = assetsLabAccountDao.updateAssetsLabAccountAll(old);
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
	public int updateAssetsLabAccountSensitive(AssetsLabAccountDTO dto) throws Exception {
		try {
			//记录日志
			AssetsLabAccountDTO old = findById(dto.getId());
			if (old != null) {
				SysLogUtil.log4Update(dto, old);
			}
			PojoUtil.setSysProperties(dto, OpType.update);
			PojoUtil.copyProperties(old, dto, true);
			int count = assetsLabAccountDao.updateAssetsLabAccountSensitive(old);
			if (count == 0) {
				throw new DaoException("数据失效，请重新更新");
			}
			return count;
		} catch (Exception e) {
			logger.error("updateAssetsLabAccountSensitive出错：", e);
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
	public int updateAssetsLabAccountList(List<AssetsLabAccountDTO> dtoList) throws Exception {
		try {
			return assetsLabAccountDao.updateAssetsLabAccountList(dtoList);
		} catch (Exception e) {
			logger.error("updateAssetsLabAccountList出错：", e);
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
	public int deleteAssetsLabAccountById(String id) throws Exception {
		if (StringUtils.isEmpty(id)) {
			throw new Exception("删除失败！传入的参数主键为null");
		}
		try {
			//记录日志
			AssetsLabAccountDTO obje = findById(id);
			if (obje != null) {
				SysLogUtil.log4Delete(obje);
			}
			return assetsLabAccountDao.deleteAssetsLabAccountById(id);
		} catch (Exception e) {
			logger.error("deleteAssetsLabAccountById出错：", e);
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
	public int deleteAssetsLabAccountByIds(String[] ids) throws Exception {
		int result = 0;
		for (String id : ids) {
			sysAttachmentAPI.deleteAttachByFormId(id);
			deleteAssetsLabAccountById(id);
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
	public int deleteAssetsLabAccountList(List<String> idList) throws Exception {
		try {
			return assetsLabAccountDao.deleteAssetsLabAccountList(idList);
		} catch (Exception e) {
			logger.error("deleteAssetsLabAccountList出错：", e);
			e.printStackTrace();
			throw e;
		}
	}

	/**
	* 日志专用，内部方法，不再记录日志
	* @param id 主键id
	* @return AssetsLabAccountDTO
	* @throws Exception
	*/
	private AssetsLabAccountDTO findById(String id) throws Exception {
		try {
			AssetsLabAccountDTO dto = assetsLabAccountDao.findAssetsLabAccountById(id);
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
