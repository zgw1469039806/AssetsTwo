//
// Source code recreated from a .class file by IntelliJ IDEA
// (powered by Fernflower decompiler)
//

package avicit.platform6.msystem.personalmenu.rest;

import avicit.platform6.api.sysmenu.MenuAPI;
import avicit.platform6.api.sysmenu.MenuAPI.MenuFluentAPI;
import avicit.platform6.api.sysmenu.dto.MenuDto;
import avicit.platform6.core.rest.msg.QueryReqBean;
import avicit.platform6.core.rest.msg.QueryRespBean;
import avicit.platform6.core.rest.msg.ResponseMsg;
import avicit.platform6.core.rest.resteasy.RestEasyController;
import avicit.platform6.msystem.personalmenu.dto.SysMenuPersonalDTO;
import avicit.platform6.msystem.personalmenu.service.SysMenuPersonalService;
import avicit.platform6.msystem.personalmenu.vo.MenuDtoMin;
import org.apache.commons.lang3.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;

import javax.ws.rs.*;
import java.util.*;

@RestEasyController
@Path("/api/platform6/msystem/portal/SysMenuPersonalRest")
public class SysMenuPersonalRest {
    private static final Logger LOGGER = LoggerFactory.getLogger(SysMenuPersonalRest.class);
    @Autowired
    private SysMenuPersonalService sysMenuPersonalService;
    @Autowired
    private MenuAPI menuAPI;

    public SysMenuPersonalRest() {
    }

    @GET
    @Path("/get/v1/{id}")
    @Produces({"application/json;charset=UTF-8"})
    public ResponseMsg<SysMenuPersonalDTO> get(@PathParam("id") String id) throws Exception {
        ResponseMsg<SysMenuPersonalDTO> responseMsg = new ResponseMsg();
        SysMenuPersonalDTO dto = this.sysMenuPersonalService.querySysMenuPersonalByPrimaryKey(id);
        responseMsg.setResponseBody(dto);
        return responseMsg;
    }

    @POST
    @Path("/save/v1")
    @Produces({"application/json;charset=UTF-8"})
    @Consumes({"application/json;charset=UTF-8"})
    public ResponseMsg<String> save(SysMenuPersonalDTO dto) throws Exception {
        ResponseMsg<String> responseMsg = new ResponseMsg();
        String id = this.sysMenuPersonalService.insertSysMenuPersonal(dto);
        responseMsg.setResponseBody(id);
        return responseMsg;
    }

    @POST
    @Path("/updateSensitive/v1")
    @Produces({"application/json;charset=UTF-8"})
    @Consumes({"application/json;charset=UTF-8"})
    public ResponseMsg<Integer> updateSensitive(SysMenuPersonalDTO dto) throws Exception {
        ResponseMsg<Integer> responseMsg = new ResponseMsg();
        int count = this.sysMenuPersonalService.updateSysMenuPersonalSensitive(dto);
        responseMsg.setResponseBody(count);
        return responseMsg;
    }

    @POST
    @Path("/updateAll/v1")
    @Produces({"application/json;charset=UTF-8"})
    @Consumes({"application/json;charset=UTF-8"})
    public ResponseMsg<Integer> updateAll(SysMenuPersonalDTO dto) throws Exception {
        ResponseMsg<Integer> responseMsg = new ResponseMsg();
        int count = this.sysMenuPersonalService.updateSysMenuPersonal(dto);
        responseMsg.setResponseBody(count);
        return responseMsg;
    }

    @POST
    @Path("/deleteById/v1")
    @Produces({"application/json;charset=UTF-8"})
    @Consumes({"application/json;charset=UTF-8"})
    public ResponseMsg<Integer> deleteById(String id) throws Exception {
        ResponseMsg<Integer> responseMsg = new ResponseMsg();
        int count = this.sysMenuPersonalService.deleteSysMenuPersonalById(id);
        responseMsg.setResponseBody(count);
        return responseMsg;
    }

    @POST
    @Path("/searchByPage/v1")
    @Produces({"application/json;charset=UTF-8"})
    @Consumes({"application/json;charset=UTF-8"})
    public ResponseMsg<QueryRespBean<SysMenuPersonalDTO>> searchByPage(QueryReqBean<SysMenuPersonalDTO> queryReqBean) throws Exception {
        ResponseMsg<QueryRespBean<SysMenuPersonalDTO>> responseMsg = new ResponseMsg();
        QueryRespBean<SysMenuPersonalDTO> queryRespBean = this.sysMenuPersonalService.searchSysMenuPersonalByPage(queryReqBean, "");
        responseMsg.setResponseBody(queryRespBean);
        return responseMsg;
    }

    @POST
    @Path("/search/v1/")
    @Produces({"application/json;charset=UTF-8"})
    @Consumes({"application/json;charset=UTF-8"})
    public ResponseMsg<List<SysMenuPersonalDTO>> search(QueryReqBean<SysMenuPersonalDTO> queryReqBean) throws Exception {
        ResponseMsg<List<SysMenuPersonalDTO>> responseMsg = new ResponseMsg();
        List<SysMenuPersonalDTO> queryRespBean = this.sysMenuPersonalService.searchSysMenuPersonal(queryReqBean);
        responseMsg.setResponseBody(queryRespBean);
        return responseMsg;
    }

    @GET
    @Path("/getPersonalMenu/v1/{orgIdentity}/{userId}")
    @Produces({"application/json;charset=UTF-8"})
    public ResponseMsg<List<HashMap<String, Object>>> getPersonalMenu(@PathParam("orgIdentity") String orgIdentity, @PathParam("userId") String userId) throws Exception {
        ResponseMsg<List<HashMap<String, Object>>> responseMsg = new ResponseMsg();
        List<HashMap<String, Object>> data = new ArrayList();
        List<SysMenuPersonalDTO> list = this.sysMenuPersonalService.searchSysMenuPersonalFromCache(userId);
        if (list != null && list.size() > 0) {
            Iterator var6 = list.iterator();

            while(var6.hasNext()) {
                SysMenuPersonalDTO dto = (SysMenuPersonalDTO)var6.next();
                HashMap<String, Object> map = new HashMap();
                map.put("id", dto.getId());
                map.put("menuId", dto.getMenuId());
                MenuDto menuDto = this.menuAPI.builder().orgIndentity(orgIdentity).getById(dto.getMenuId());
                if (menuDto != null) {
                    map.put("menuName", menuDto.getMenuName());
                    map.put("menuUrl", menuDto.getMenuUrl());
                    data.add(map);
                }
            }
        }

        responseMsg.setResponseBody(data);
        return responseMsg;
    }

    @GET
    @Path("/getPersonalMenuByModuleId/v1/{orgIdentity}/{userId}/{moduleId}")
    @Produces({"application/json;charset=UTF-8"})
    public ResponseMsg<List<HashMap<String, Object>>> getPersonalMenuByModuleId(@PathParam("orgIdentity") String orgIdentity, @PathParam("userId") String userId, @PathParam("moduleId") String moduleId) throws Exception {
        ResponseMsg<List<HashMap<String, Object>>> responseMsg = new ResponseMsg();
        List<HashMap<String, Object>> data = new ArrayList();
        List<SysMenuPersonalDTO> list = this.sysMenuPersonalService.searchSysMenuPersonalByModuleIdFromCache(userId,moduleId);
        if (list != null && list.size() > 0) {
            Iterator var6 = list.iterator();

            while(var6.hasNext()) {
                SysMenuPersonalDTO dto = (SysMenuPersonalDTO)var6.next();
                HashMap<String, Object> map = new HashMap();
                map.put("id", dto.getId());
                map.put("menuId", dto.getMenuId());
                MenuDto menuDto = this.menuAPI.builder().orgIndentity(orgIdentity).getById(dto.getMenuId());
                if (menuDto != null) {
                    map.put("menuName", menuDto.getMenuName());
                    map.put("menuUrl", menuDto.getMenuUrl());
                    data.add(map);
                }
            }
        }

        responseMsg.setResponseBody(data);
        return responseMsg;
    }


    @GET
    @Path("/getAvailableMenu/v1/{orgIdentity}/{userId}")
    @Produces({"application/json;charset=UTF-8"})
    public ResponseMsg<List<HashMap<String, Object>>> getAvailableMenu(@PathParam("orgIdentity") String orgIdentity, @PathParam("userId") String userId) throws Exception {
        ResponseMsg<List<HashMap<String, Object>>> responseMsg = new ResponseMsg();
        MenuFluentAPI menuFluentAPI = this.menuAPI.builder().orgIndentity(orgIdentity);
        List<MenuDto> list = menuFluentAPI.listPortalFistLevel();
        new ArrayList();
        List<String> menuList = new ArrayList();
        List<SysMenuPersonalDTO> personalDTOList = this.sysMenuPersonalService.searchSysMenuPersonalFromCache(userId);
        if (personalDTOList != null && personalDTOList.size() > 0) {
            Iterator var8 = personalDTOList.iterator();

            while(var8.hasNext()) {
                SysMenuPersonalDTO dto = (SysMenuPersonalDTO)var8.next();
                menuList.add(dto.getMenuId());
            }
        }

        List<HashMap<String, Object>> data = new ArrayList();
        if (list != null && list.size() > 0) {
            Iterator var14 = list.iterator();

            while(var14.hasNext()) {
                MenuDto menuDto = (MenuDto)var14.next();
                List<MenuDtoMin> temp = new ArrayList();
                this.sysMenuPersonalService.findAllChildByParentId(menuDto.getId(), temp, menuList, menuFluentAPI);
                HashMap<String, Object> map = new HashMap();
                map.put("menuId", menuDto.getId());
                map.put("menuCode", menuDto.getMenuCode());
                map.put("menuName", menuDto.getMenuName());
                map.put("subMenu", temp);
                data.add(map);
            }
        }

        responseMsg.setResponseBody(data);
        return responseMsg;
    }

    @POST
    @Path("/saveMenu/v1")
    @Produces({"application/json;charset=UTF-8"})
    @Consumes({"application/json;charset=UTF-8"})
    public ResponseMsg<String> saveMenu(Map<String, String> map) throws Exception {
        ResponseMsg<String> responseMsg = new ResponseMsg();
        String menuIds = (String)map.get("menuIds");
        String userId = (String)map.get("userId");
        if (menuIds != null && !menuIds.isEmpty()) {
            List<String> menuArray = Arrays.asList(menuIds.split(";"));
            List<SysMenuPersonalDTO> usedToList = this.sysMenuPersonalService.searchSysMenuPersonalFromCache(userId);
            HashMap<String, String> tempMap = new HashMap();
            List<String> toDelList = new ArrayList();
            Iterator var9;
            if (usedToList != null && usedToList.size() > 0) {
                var9 = usedToList.iterator();

                while(var9.hasNext()) {
                    SysMenuPersonalDTO bean = (SysMenuPersonalDTO)var9.next();
                    tempMap.put(bean.getMenuId(), bean.getId());
                }
            }

            var9 = menuArray.iterator();

            String s;
            while(var9.hasNext()) {
                s = (String)var9.next();
                SysMenuPersonalDTO bean = new SysMenuPersonalDTO();
                bean.setUserId(userId);
                bean.setMenuId(s);
                SysMenuPersonalDTO sysMenuPersonalDTO = this.sysMenuPersonalService.searchSysMenuPersonalFromCache(userId, s);
                if (sysMenuPersonalDTO == null) {
                    this.sysMenuPersonalService.insertSysMenuPersonal(bean);
                }
            }

            if (tempMap != null && tempMap.size() > 0) {
                Set<String> set = tempMap.keySet();
                Iterator var15 = set.iterator();

                while(var15.hasNext()) {
                    s = (String)var15.next();
                    if (!menuArray.contains(s)) {
                        toDelList.add(tempMap.get(s));
                    }
                }
            }

            if (toDelList != null && toDelList.size() > 0) {
                var9 = toDelList.iterator();

                while(var9.hasNext()) {
                    s = (String)var9.next();
                    this.sysMenuPersonalService.deleteSysMenuPersonalById(s);
                }
            }

            responseMsg.setResponseBody("success");
            return responseMsg;
        } else {
            return responseMsg;
        }
    }


    @POST
    @Path("/saveMenuIdsAndModuleId/v1")
    @Produces({"application/json;charset=UTF-8"})
    @Consumes({"application/json;charset=UTF-8"})
    public ResponseMsg<String> saveMenuIdsAndModuleId(Map<String, String> map) throws Exception {
        ResponseMsg<String> responseMsg = new ResponseMsg();
        String menuIds = (String)map.get("menuIds");
        String userId = (String)map.get("userId");
        String moduleId=(String)map.get("moduleId");
        if (menuIds != null && !menuIds.isEmpty()) {
            List<String> menuArray = Arrays.asList(menuIds.split(";"));
            List<SysMenuPersonalDTO> usedToList = this.sysMenuPersonalService.searchSysMenuPersonalFromCache(userId);
            HashMap<String, String> tempMap = new HashMap();
            List<String> toDelList = new ArrayList();
            Iterator var9;
            if (usedToList != null && usedToList.size() > 0) {
                var9 = usedToList.iterator();

                while(var9.hasNext()) {
                    SysMenuPersonalDTO bean = (SysMenuPersonalDTO)var9.next();
                    tempMap.put(bean.getMenuId(), bean.getId());
                }
            }

            var9 = menuArray.iterator();

            String s;
            while(var9.hasNext()) {
                s = (String)var9.next();
                SysMenuPersonalDTO bean = new SysMenuPersonalDTO();
                bean.setUserId(userId);
                bean.setMenuId(s);
                bean.setModuleId(moduleId);
                SysMenuPersonalDTO sysMenuPersonalDTO = this.sysMenuPersonalService.searchSysMenuPersonalFromCache(userId, s);
                if (sysMenuPersonalDTO == null) {
                    this.sysMenuPersonalService.insertSysMenuPersonal(bean);
                }
            }

            if (tempMap != null && tempMap.size() > 0) {
                Set<String> set = tempMap.keySet();
                Iterator var15 = set.iterator();

                while(var15.hasNext()) {
                    s = (String)var15.next();
                    if (!menuArray.contains(s)) {
                        toDelList.add(tempMap.get(s));
                    }
                }
            }

            if (toDelList != null && toDelList.size() > 0) {
                var9 = toDelList.iterator();

                while(var9.hasNext()) {
                    s = (String)var9.next();
                    this.sysMenuPersonalService.deleteSysMenuPersonalById(s);
                }
            }

            responseMsg.setResponseBody("success");
            return responseMsg;
        } else {
            return responseMsg;
        }
    }



    @POST
    @Path("/saveMenuAddModuleId/v1")
    @Produces({"application/json;charset=UTF-8"})
    @Consumes({"application/json;charset=UTF-8"})
    public ResponseMsg<String> saveMenuAddModuleId(Map<String, String> map) throws Exception {
        ResponseMsg<String> responseMsg = new ResponseMsg();
        String menuId = (String)map.get("menuId");
        String userId = (String)map.get("userId");
        String moduleId = (String)map.get("moduleId");
        if (StringUtils.isNotEmpty(menuId)) {
            SysMenuPersonalDTO bean = new SysMenuPersonalDTO();
            bean.setUserId(userId);
            bean.setMenuId(menuId);
            bean.setModuleId(moduleId);
            SysMenuPersonalDTO sysMenuPersonalDTO = this.sysMenuPersonalService.searchSysMenuPersonalFromCache(userId, menuId);
            if (sysMenuPersonalDTO == null) {
                this.sysMenuPersonalService.insertSysMenuPersonal(bean);
            }
            responseMsg.setResponseBody("success");
            return responseMsg;
        } else {
            return responseMsg;
        }
    }



    @POST
    @Path("/deleteByMenuId/v1")
    @Produces({"application/json;charset=UTF-8"})
    @Consumes({"application/json;charset=UTF-8"})
    public ResponseMsg<String> deleteByMenuId(Map<String, String> map) throws Exception {
        ResponseMsg<String> responseMsg = new ResponseMsg();
        String menuIds = (String)map.get("menuIds");
        String userId = (String)map.get("userId");
        String[] menuArray = menuIds.split(";");
        String[] var6 = menuArray;
        int var7 = menuArray.length;

        for(int var8 = 0; var8 < var7; ++var8) {
            String menuId = var6[var8];
            SysMenuPersonalDTO bean = this.sysMenuPersonalService.searchSysMenuPersonalFromCache(userId, menuId);
            if (bean != null) {
                this.sysMenuPersonalService.deleteSysMenuPersonalById(bean.getId());
            }
        }

        responseMsg.setResponseBody("success");
        return responseMsg;
    }

    @POST
    @Path("/trunkMenu/v1")
    @Produces({"application/json;charset=UTF-8"})
    @Consumes({"application/json;charset=UTF-8"})
    public ResponseMsg<String> trunkMenu(Map<String, String> map) throws Exception {
        String userId = (String)map.get("userId");
        ResponseMsg<String> responseMsg = new ResponseMsg();
        List<SysMenuPersonalDTO> list = this.sysMenuPersonalService.searchSysMenuPersonalFromCache(userId);
        if (list != null && list.size() > 0) {
            Iterator var5 = list.iterator();

            while(var5.hasNext()) {
                SysMenuPersonalDTO sysMenuPersonalVo = (SysMenuPersonalDTO)var5.next();
                this.sysMenuPersonalService.deleteSysMenuPersonalById(sysMenuPersonalVo.getId());
            }
        }

        responseMsg.setResponseBody("success");
        return responseMsg;
    }

    @POST
    @Path("/updateOrderBy/v1")
    @Produces({"application/json;charset=UTF-8"})
    @Consumes({"application/json;charset=UTF-8"})
    public ResponseMsg<Integer> updateSensitive(Map<String, String> map) throws Exception {
        ResponseMsg<Integer> responseMsg = new ResponseMsg();
        String menuId = (String)map.get("menuId");
        String userId = (String)map.get("userId");
        Long orderBy = Long.parseLong((String)map.get("orderBy"));
        SysMenuPersonalDTO bean = this.sysMenuPersonalService.searchSysMenuPersonalFromCache(userId, menuId);
        bean.setOrderBy(orderBy);
        int count = this.sysMenuPersonalService.updateSysMenuPersonalSensitive(bean);
        responseMsg.setResponseBody(count);
        return responseMsg;
    }
}
