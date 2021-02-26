package avicit.platform6.msystem.portal.controller;

import avicit.platform6.api.personalmenu.SysPersonalMenuAPI;
import avicit.platform6.api.session.SessionHelper;
import avicit.platform6.api.sysmenu.MenuAPI;
import avicit.platform6.api.sysmenu.dto.MenuDto;
import avicit.platform6.menu.syshistmenus.dto.SysHistMenusDTO;
import avicit.platform6.menu.syshistmenus.service.SysHistMenusService;
import avicit.platform6.msystem.portal.model.PortalMenuModel;
import com.google.gson.Gson;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.CookieValue;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.*;

@Controller
public class PortalExtendController {
    @Autowired
    private MenuAPI menuApi;

    @Autowired
    private SysHistMenusService sysHistMenusService;

    @Autowired
    private SysPersonalMenuAPI sysPersonalMenuAPI;

    private Gson gson=new Gson();

    public PortalExtendController() {
    }


    /**
     * 记录浏览历史
     */
    @RequestMapping({"portal/viewHistory/{menuId}"})
    @ResponseBody
    public void viewHistory(@PathVariable("menuId") String  menuId, HttpServletRequest request){
        String userId = SessionHelper.getLoginSysUser(request).getId();

        if(!isExist(userId,menuId)){
            MenuDto menuDto = this.menuApi.getMenusById(menuId, "zh_CN");

            SysHistMenusDTO histMenusDTO=new SysHistMenusDTO();
            histMenusDTO.setUserId(userId);
            histMenusDTO.setMenuCode(menuDto.getMenuCode());
            histMenusDTO.setMenuId(menuId);
            histMenusDTO.setMenuName(menuDto.getMenuName());
            histMenusDTO.setMenuUrl(menuDto.getMenuUrl());
            histMenusDTO.setViewTime(new Date());

            try {
                this.sysHistMenusService.insertSysHistMenus(histMenusDTO);
            } catch (Exception e) {
                e.printStackTrace();
            }
        }

    }

    /**
     * 验证是否已经有过历史记录
     * @param userId
     * @param menuId
     * @return
     */
    private boolean isExist(String userId,String menuId){
        try {
            List<SysHistMenusDTO> menusDTOList = this.sysHistMenusService.searchMySysHistMenus(userId);
            for(int i=0;i<menusDTOList.size();i++){
                if(menuId.equals(menusDTOList.get(i).getId())){
                    return true;
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            return true;
        }
        return false;
    }

    @RequestMapping({"portal/themes_simple"})
    @ResponseBody
    public String portal( HttpServletRequest request,HttpSession session, String id, @CookieValue(value = "P_L_CODE",defaultValue = "zh_CN") String langcode) throws Exception {
        MenuDto menuDto=menuApi.getMenusById(id,langcode);
        PortalMenuModel parentModel=new PortalMenuModel();
        parentModel.setId(id);
        parentModel.setMenuName(menuDto.getMenuName());
        parentModel.setMenuCode(menuDto.getMenuCode());
        List<PortalMenuModel> secondSubMenuList = this.getSecondSubMenuList(id, langcode);
        if(secondSubMenuList!=null && secondSubMenuList.size()>0){
            parentModel.setSubMenu(secondSubMenuList);
        }

        for(int i=0;i<secondSubMenuList.size();i++){
            PortalMenuModel secondModel = secondSubMenuList.get(i);
            List<PortalMenuModel> thirdSubMenuList = this.getThirdSubMenuList(secondModel.getId(), langcode);
            if(thirdSubMenuList!=null && thirdSubMenuList.size()>0){
                secondModel.setSubMenu(thirdSubMenuList);
            }

        }

        String menuTree="["+gson.toJson(parentModel)+"]";


        String myPersonalMenuList = searchMyPersonalMenuList(request,id);
        Map<String, String> map = new HashMap<>();
        map.put("menuTree",menuTree);
        map.put("myPersonalMenu",myPersonalMenuList);
        String s = gson.toJson(map);
        return s;

        /*StringBuffer buffer = new StringBuffer();
        List<PortalMenuModel> secondMenus = this.getSecondSubMenuList(id, langcode);
        if (secondMenus != null && secondMenus.size() > 0) {
            for(Iterator var6 = secondMenus.iterator(); var6.hasNext(); buffer.append("</li>\n")) {
                PortalMenuModel secondMenu = (PortalMenuModel)var6.next();
                List<PortalMenuModel> thirdMenus = this.getThirdSubMenuList(secondMenu.getId(), langcode);
                String chevron = thirdMenus != null && thirdMenus.size() > 0 ? "fa-chevron-down" : "";
                buffer.append("<li>\n");
                buffer.append("<div class=\"link taburl\" openType='").append(secondMenu.getMenuOpenType()).append("' id=\"").append(secondMenu.getId()).append("\" title=\"").append(secondMenu.getMenuName()).append("\" ").append(this.getUrl(secondMenu)).append("><i class=\"icon icon-xinwenfabu\"></i>").append(secondMenu.getMenuName()).append("<i class=\"fa ").append(chevron).append("\"></i></div>\n");
                if (thirdMenus != null && thirdMenus.size() > 0) {
                    buffer.append("<ul class=\"submenu\">\n");
                    Iterator var10 = thirdMenus.iterator();

                    while(var10.hasNext()) {
                        PortalMenuModel thirdMenu = (PortalMenuModel)var10.next();
                        buffer.append("<li class=\"afont taburl\" openType='").append(thirdMenu.getMenuOpenType()).append("' title=\"").append(thirdMenu.getMenuName()).append("\" ").append(this.getUrl(thirdMenu)).append(">").append(thirdMenu.getMenuName()).append("</li>\n");
                    }

                    buffer.append("</ul>\n");
                }
            }
        }

        return buffer.toString();*/
    }


    //我的收藏菜单
    private String searchMyPersonalMenuList(HttpServletRequest request,String moduleId)throws Exception{
        SysHistMenusDTO parentSysMenu=new SysHistMenusDTO();
        parentSysMenu.setMenuName("我的收藏");
        parentSysMenu.setParent(true);
        parentSysMenu.setId("-1");
        List<HashMap<String, Object>> personalMenuList = this.sysPersonalMenuAPI.getPersonalMenuByModuleId(SessionHelper.getCurrentOrgIdentity(request), SessionHelper.getLoginSysUserId(request),moduleId);
/*
        List<HashMap<String, Object>> personalMenuList = this.sysPersonalMenuAPI.getPersonalMenu(SessionHelper.getCurrentOrgIdentity(request), SessionHelper.getLoginSysUserId(request));
*/
        List<SysHistMenusDTO> subSysMenuList=new ArrayList<>();
        for(int i=0;i<personalMenuList.size();i++){
            HashMap<String, Object> map = personalMenuList.get(i);
            SysHistMenusDTO menu=new SysHistMenusDTO();
            menu.setMenuName((String)map.get("menuName"));
            menu.setMenuUrl((String)map.get("menuUrl"));
            menu.setId((String)map.get("menuId"));
            subSysMenuList.add(menu);
        }
        if(subSysMenuList.size()>0){
            parentSysMenu.setSubMenu(subSysMenuList);
        }
        return "["+gson.toJson(parentSysMenu)+"]";
    }


    private String getUrl(PortalMenuModel model) {
        String rel = "";
        if (model.getMenuUrl() != null && model.getMenuUrl().trim().length() > 0) {
            rel = "rel=\"" + model.getMenuUrl() + "\"";
        }

        return rel;
    }

    private List<PortalMenuModel> getSecondSubMenuList(String parentId, String langcode) {
        List<MenuDto> list = this.menuApi.builder().orderBy().langCode(langcode).authorize().listByPid(parentId);
        List<PortalMenuModel> menuList = new ArrayList();

        for(int i = 0; i < list.size(); ++i) {
            MenuDto menu = (MenuDto)list.get(i);
            if (menu != null) {
                PortalMenuModel model = new PortalMenuModel();
                model.setId(menu.getId());
                model.setMenuCode(menu.getMenuCode());
                model.setMenuName(menu.getMenuName());
                model.setMenuUrl(menu.getMenuUrl());
                model.setMenuOpenType(menu.getOpenType());
                menuList.add(model);
            }
        }

        return menuList;
    }

    private List<PortalMenuModel> getThirdSubMenuList(String parentId, String langcode) {
        List<MenuDto> list = this.menuApi.builder().orderBy().langCode(langcode).authorize().listByPid(parentId);
        List<PortalMenuModel> menuList = new ArrayList();

        for(int i = 0; i < list.size(); ++i) {
            MenuDto menu = (MenuDto)list.get(i);
            if (menu != null) {
                PortalMenuModel model = new PortalMenuModel();
                model.setId(menu.getId());
                model.setMenuCode(menu.getMenuCode());
                model.setMenuUrl(menu.getMenuUrl());
                model.setMenuName(menu.getMenuName());
                model.setMenuOpenType(menu.getOpenType());
                menuList.add(model);
            }
        }

        return menuList;
    }
}
