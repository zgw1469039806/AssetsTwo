//
// Source code recreated from a .class file by IntelliJ IDEA
// (powered by Fernflower decompiler)
//

package avicit.platform6.msystem.personalmenu.service;

import avicit.platform6.api.sysmenu.MenuAPI;
import avicit.platform6.api.sysmenu.MenuAPI.MenuFluentAPI;
import avicit.platform6.api.sysmenu.dto.MenuDto;
import avicit.platform6.commons.utils.ComUtil;
import avicit.platform6.commons.utils.JsonHelper;
import avicit.platform6.commons.utils.JsonUtil;
import avicit.platform6.commons.utils.PojoUtil;
import avicit.platform6.core.exception.DaoException;
import avicit.platform6.core.mybatis.pagehelper.Page;
import avicit.platform6.core.mybatis.pagehelper.PageHelper;
import avicit.platform6.core.properties.PlatformConstant.OpType;
import avicit.platform6.core.redis.JedisSentinelPool;
import avicit.platform6.core.rest.msg.QueryReqBean;
import avicit.platform6.core.rest.msg.QueryRespBean;
import avicit.platform6.modules.system.syslog.service.SysLogUtil;
import avicit.platform6.msystem.personalmenu.dao.SysMenuPersonalDao;
import avicit.platform6.msystem.personalmenu.dto.SysMenuPersonalDTO;
import avicit.platform6.msystem.personalmenu.vo.MenuDtoMin;
import com.fasterxml.jackson.core.type.TypeReference;
import org.apache.commons.lang3.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import redis.clients.jedis.ShardedJedis;

import java.io.Serializable;
import java.util.*;

@Service
public class SysMenuPersonalService implements Serializable {
    protected static final String PLATFROM6_PERSONAL_MENU_USER_ = "PLATFROM6_PERSONAL_MENU_USER_";
    protected static final String PLATFROM6_PERSONAL_MENU_MENU_ = "PLATFROM6_PERSONAL_MENU_MENU_";
    private static final Logger LOGGER = LoggerFactory.getLogger(SysMenuPersonalService.class);
    private static final long serialVersionUID = 1L;
    @Autowired
    private SysMenuPersonalDao sysMenuPersonalDao;
    @Autowired
    private JedisSentinelPool jedisSentinelPool;
    @Autowired
    private MenuAPI menuAPI;

    public SysMenuPersonalService() {
    }

    public QueryRespBean<SysMenuPersonalDTO> searchSysMenuPersonalByPage(QueryReqBean<SysMenuPersonalDTO> queryReqBean, String oderby) throws Exception {
        try {
            PageHelper.startPage(queryReqBean.getPageParameter());
            SysMenuPersonalDTO searchParams = (SysMenuPersonalDTO)queryReqBean.getSearchParams();
            Page<SysMenuPersonalDTO> dataList = this.sysMenuPersonalDao.searchSysMenuPersonalByPage(searchParams, oderby);
            QueryRespBean<SysMenuPersonalDTO> queryRespBean = new QueryRespBean();
            queryRespBean.setResult(dataList);
            return queryRespBean;
        } catch (Exception var6) {
            LOGGER.error("searchSysMenuPersonalByPage出错：", var6);
            throw new DaoException(var6.getMessage(), var6);
        }
    }

    public QueryRespBean<SysMenuPersonalDTO> searchSysMenuPersonalByPageOr(QueryReqBean<SysMenuPersonalDTO> queryReqBean, String oderby) throws Exception {
        try {
            PageHelper.startPage(queryReqBean.getPageParameter());
            SysMenuPersonalDTO searchParams = (SysMenuPersonalDTO)queryReqBean.getSearchParams();
            Page<SysMenuPersonalDTO> dataList = this.sysMenuPersonalDao.searchSysMenuPersonalByPageOr(searchParams, oderby);
            QueryRespBean<SysMenuPersonalDTO> queryRespBean = new QueryRespBean();
            queryRespBean.setResult(dataList);
            return queryRespBean;
        } catch (Exception var6) {
            LOGGER.error("searchSysMenuPersonalByPage出错：", var6);
            throw new DaoException(var6.getMessage(), var6);
        }
    }

    public List<SysMenuPersonalDTO> searchSysMenuPersonal(QueryReqBean<SysMenuPersonalDTO> queryReqBean) throws Exception {
        try {
            SysMenuPersonalDTO searchParams = (SysMenuPersonalDTO)queryReqBean.getSearchParams();
            List<SysMenuPersonalDTO> dataList = this.sysMenuPersonalDao.searchSysMenuPersonal(searchParams);
            return dataList;
        } catch (Exception var4) {
            LOGGER.error("searchSysMenuPersonal出错：", var4);
            throw new DaoException(var4.getMessage(), var4);
        }
    }

    public void findAllChildByParentId(String parentId, List<MenuDtoMin> list, List<String> addedList, MenuFluentAPI menuFluentAPI) {
        List<String> temp = menuFluentAPI.listIdsByPid(parentId);
        if (temp != null && temp.size() > 0) {
            Iterator var8 = temp.iterator();

            while(var8.hasNext()) {
                String s = (String)var8.next();
                this.findAllChildByParentId(s, list, addedList, menuFluentAPI);
            }
        } else {
            MenuDto dto = menuFluentAPI.getById(parentId);
            MenuDtoMin menuDtoMin = new MenuDtoMin();
            menuDtoMin.setMenuId(dto.getId());
            menuDtoMin.setMenuCode(dto.getMenuCode());
            menuDtoMin.setMenuName(dto.getMenuName());
            if (addedList.contains(dto.getId())) {
                menuDtoMin.setSelect(true);
            } else {
                menuDtoMin.setSelect(false);
            }

            list.add(menuDtoMin);
        }

    }

    public List<SysMenuPersonalDTO> searchSysMenuPersonalFromCache(String userId) {
        ShardedJedis shardedJedis = this.jedisSentinelPool.getResource();
        ArrayList result = new ArrayList();

        try {
            Map<String, String> map = shardedJedis.hgetAll("PLATFROM6_PERSONAL_MENU_USER_" + userId);
            if (map != null && map.size() > 0) {
                Set<String> set = map.keySet();
                Iterator it = set.iterator();

                while(it.hasNext()) {
                    String next =(String) it.next();
                    String s = map.get(next);
                    result.add((SysMenuPersonalDTO)JsonHelper.getInstance().readValue(s, new TypeReference<SysMenuPersonalDTO>() {
                    }));
                }
            }

            Collections.sort(result, new Comparator<SysMenuPersonalDTO>() {
                public int compare(SysMenuPersonalDTO o1, SysMenuPersonalDTO o2) {
                    Long orderBy1 = o1.getOrderBy() != null ? o1.getOrderBy() : 0L;
                    Long orderBy2 = o2.getOrderBy() != null ? o2.getOrderBy() : 0L;
                    return orderBy1.compareTo(orderBy2);
                }
            });
        } finally {
            this.jedisSentinelPool.returnResource(shardedJedis);
        }

        return result;
    }

    public List<SysMenuPersonalDTO> searchSysMenuPersonalByModuleIdFromCache(String userId,String moduleId) {
        ShardedJedis shardedJedis = this.jedisSentinelPool.getResource();
        ArrayList result = new ArrayList();

        try {
            Map<String, String> map = shardedJedis.hgetAll("PLATFROM6_PERSONAL_MENU_USER_" + userId);
            if (map != null && map.size() > 0) {
                Set<String> set = map.keySet();
                Iterator it = set.iterator();

                while(it.hasNext()) {
                    String next =(String) it.next();
                    String s = map.get(next);
                    if(moduleId!=null&&moduleId!=""&&!moduleId.equals("null")){
                        Map<String, Object> stringObjectMap = JsonUtil.parseJSON2Map(s);
                        String dataModuleId = (String) stringObjectMap.get("moduleId");
                        if(!moduleId.equals(dataModuleId)){
                            continue;
                        }
                    }
                    result.add((SysMenuPersonalDTO)JsonHelper.getInstance().readValue(s, new TypeReference<SysMenuPersonalDTO>() {
                    }));
                }
            }

            Collections.sort(result, new Comparator<SysMenuPersonalDTO>() {
                public int compare(SysMenuPersonalDTO o1, SysMenuPersonalDTO o2) {
                    Long orderBy1 = o1.getOrderBy() != null ? o1.getOrderBy() : 0L;
                    Long orderBy2 = o2.getOrderBy() != null ? o2.getOrderBy() : 0L;
                    return orderBy1.compareTo(orderBy2);
                }
            });
        } finally {
            this.jedisSentinelPool.returnResource(shardedJedis);
        }

        return result;
    }


    public SysMenuPersonalDTO searchSysMenuPersonalFromCache(String userId, String menuId) {
        ShardedJedis shardedJedis = this.jedisSentinelPool.getResource();

        SysMenuPersonalDTO var5;
        try {
            String s = shardedJedis.hget("PLATFROM6_PERSONAL_MENU_USER_" + userId, "PLATFROM6_PERSONAL_MENU_MENU_" + menuId);
            if (s != null && !s.isEmpty()) {
                var5 = (SysMenuPersonalDTO)JsonHelper.getInstance().readValue(s, new TypeReference<SysMenuPersonalDTO>() {
                });
                return var5;
            }

            var5 = null;
        } finally {
            this.jedisSentinelPool.returnResource(shardedJedis);
        }

        return var5;
    }

    public SysMenuPersonalDTO querySysMenuPersonalByPrimaryKey(String id) throws Exception {
        try {
            SysMenuPersonalDTO dto = this.sysMenuPersonalDao.findSysMenuPersonalById(id);
            SysLogUtil.log4Query(dto);
            return dto;
        } catch (Exception var3) {
            LOGGER.error("querySysMenuPersonalByPrimaryKey出错：", var3);
            throw new DaoException(var3.getMessage(), var3);
        }
    }

    public String insertSysMenuPersonal(SysMenuPersonalDTO dto) throws Exception {
        try {
            String id = ComUtil.getId();
            dto.setId(id);
            PojoUtil.setSysProperties(dto, OpType.insert);
            this.sysMenuPersonalDao.insertSysMenuPersonal(dto);
            SysLogUtil.log4Insert(dto);
            ShardedJedis shardedJedis = this.jedisSentinelPool.getResource();
            String json = JsonHelper.getInstance().writeValueAsString(dto);

            try {
                shardedJedis.hset("PLATFROM6_PERSONAL_MENU_USER_" + dto.getUserId(), "PLATFROM6_PERSONAL_MENU_MENU_" + dto.getMenuId(), json);
            } finally {
                this.jedisSentinelPool.returnResource(shardedJedis);
            }

            return id;
        } catch (Exception var9) {
            LOGGER.error("insertSysMenuPersonal出错：", var9);
            throw new DaoException(var9.getMessage(), var9);
        }
    }

    public int insertSysMenuPersonalList(List<SysMenuPersonalDTO> dtoList) throws Exception {
        List<SysMenuPersonalDTO> demo = new ArrayList();
        Iterator var3 = dtoList.iterator();

        while(var3.hasNext()) {
            SysMenuPersonalDTO dto = (SysMenuPersonalDTO)var3.next();
            String id = ComUtil.getId();
            dto.setId(id);
            PojoUtil.setSysProperties(dto, OpType.insert);
            demo.add(dto);
        }

        try {
            return this.sysMenuPersonalDao.insertSysMenuPersonalList(demo);
        } catch (Exception var6) {
            LOGGER.error("insertSysMenuPersonalList出错：", var6);
            throw new DaoException(var6.getMessage(), var6);
        }
    }

    public int updateSysMenuPersonal(SysMenuPersonalDTO dto) throws Exception {
        SysMenuPersonalDTO old = this.findById(dto.getId());
        SysLogUtil.log4Update(dto, old);
        PojoUtil.setSysProperties(dto, OpType.update);
        PojoUtil.copyProperties(old, dto, true);
        int ret = this.sysMenuPersonalDao.updateSysMenuPersonalAll(old);
        if (ret == 0) {
            throw new DaoException("数据失效，请重新更新");
        } else {
            return ret;
        }
    }

    public int updateSysMenuPersonalSensitive(SysMenuPersonalDTO dto) throws Exception {
        try {
            SysMenuPersonalDTO old = this.findById(dto.getId());
            SysLogUtil.log4Update(dto, old);
            PojoUtil.setSysProperties(dto, OpType.update);
            PojoUtil.copyProperties(old, dto, true);
            int count = this.sysMenuPersonalDao.updateSysMenuPersonalSensitive(old);
            if (count == 0) {
                throw new DaoException("数据失效，请重新更新");
            } else {
                ShardedJedis shardedJedis = this.jedisSentinelPool.getResource();
                old.setVersion(old.getVersion() + 1L);
                String json = JsonHelper.getInstance().writeValueAsString(old);

                try {
                    shardedJedis.hdel("PLATFROM6_PERSONAL_MENU_USER_" + dto.getUserId(), new String[]{"PLATFROM6_PERSONAL_MENU_MENU_" + dto.getMenuId()});
                    shardedJedis.hset("PLATFROM6_PERSONAL_MENU_USER_" + dto.getUserId(), "PLATFROM6_PERSONAL_MENU_MENU_" + dto.getMenuId(), json);
                } finally {
                    this.jedisSentinelPool.returnResource(shardedJedis);
                }

                return count;
            }
        } catch (Exception var10) {
            LOGGER.error("updateSysMenuPersonalSensitive出错：", var10);
            throw new DaoException(var10.getMessage(), var10);
        }
    }

    public int updateSysMenuPersonalList(List<SysMenuPersonalDTO> dtoList) throws Exception {
        try {
            return this.sysMenuPersonalDao.updateSysMenuPersonalList(dtoList);
        } catch (Exception var3) {
            LOGGER.error("updateSysMenuPersonalList出错：", var3);
            throw new DaoException(var3.getMessage(), var3);
        }
    }

    public int deleteSysMenuPersonalById(String id) throws Exception {
        if (StringUtils.isEmpty(id)) {
            throw new Exception("删除失败！传入的参数主键为null");
        } else {
            try {
                SysMenuPersonalDTO sysMenuPersonalDTO = this.findById(id);
                SysLogUtil.log4Delete(sysMenuPersonalDTO);
                String userId = sysMenuPersonalDTO.getUserId();
                String menuId = sysMenuPersonalDTO.getMenuId();
                int temp = this.sysMenuPersonalDao.deleteSysMenuPersonalById(id);
                ShardedJedis shardedJedis = this.jedisSentinelPool.getResource();

                try {
                    shardedJedis.hdel("PLATFROM6_PERSONAL_MENU_USER_" + userId, new String[]{"PLATFROM6_PERSONAL_MENU_MENU_" + menuId});
                } finally {
                    this.jedisSentinelPool.returnResource(shardedJedis);
                }

                return temp;
            } catch (Exception var11) {
                LOGGER.error("deleteSysMenuPersonalById出错：", var11);
                throw new DaoException(var11.getMessage(), var11);
            }
        }
    }

    public int deleteSysMenuPersonalByIds(String[] ids) throws Exception {
        int result = 0;
        String[] var3 = ids;
        int var4 = ids.length;

        for(int var5 = 0; var5 < var4; ++var5) {
            String id = var3[var5];
            this.deleteSysMenuPersonalById(id);
            ++result;
        }

        return result;
    }

    public int deleteSysMenuPersonalList(List<String> idlist) throws Exception {
        try {
            return this.sysMenuPersonalDao.deleteSysMenuPersonalList(idlist);
        } catch (Exception var3) {
            LOGGER.error("deleteSysMenuPersonalList出错：", var3);
            throw var3;
        }
    }

    private SysMenuPersonalDTO findById(String id) throws Exception {
        try {
            SysMenuPersonalDTO dto = this.sysMenuPersonalDao.findSysMenuPersonalById(id);
            return dto;
        } catch (Exception var3) {
            LOGGER.error("findById出错：", var3);
            throw new DaoException(var3.getMessage(), var3);
        }
    }
}
