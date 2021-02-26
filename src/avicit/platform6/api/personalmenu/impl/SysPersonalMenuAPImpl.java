//
// Source code recreated from a .class file by IntelliJ IDEA
// (powered by Fernflower decompiler)
//

package avicit.platform6.api.personalmenu.impl;

import avicit.platform6.api.personalmenu.SysPersonalMenuAPI;
import avicit.platform6.core.rest.client.RestClient;
import avicit.platform6.core.rest.client.RestClientConfig;
import avicit.platform6.core.rest.msg.ResponseMsg;
import org.springframework.stereotype.Service;

import javax.ws.rs.core.GenericType;
import java.util.HashMap;
import java.util.List;

@Service
public class SysPersonalMenuAPImpl implements SysPersonalMenuAPI {
    public SysPersonalMenuAPImpl() {
    }

    public List<HashMap<String, Object>> getPersonalMenu(String orgIdentity, String userId) {
        StringBuffer url = new StringBuffer();
        url.append(RestClientConfig.getRestHost("syspersonalmenu"));
        url.append("/api/platform6/msystem/portal/SysMenuPersonalRest/getPersonalMenu/v1");
        url.append("/" + orgIdentity);
        url.append("/" + userId);
        ResponseMsg<List<HashMap<String, Object>>> responseMsg = RestClient.doGet(url.toString(), new GenericType<ResponseMsg<List<HashMap<String, Object>>>>() {
        });
        if (!responseMsg.getRetCode().equals("200")) {
            throw new RuntimeException(responseMsg.getErrorDesc());
        } else {
            return (List)responseMsg.getResponseBody();
        }
    }

    public List<HashMap<String, Object>> getAvailableMenu(String orgIdentity, String userId) {
        StringBuffer url = new StringBuffer();
        url.append(RestClientConfig.getRestHost("syspersonalmenu"));
        url.append("/api/platform6/msystem/portal/SysMenuPersonalRest/getAvailableMenu/v1");
        url.append("/" + orgIdentity);
        url.append("/" + userId);
        ResponseMsg<List<HashMap<String, Object>>> responseMsg = RestClient.doGet(url.toString(), new GenericType<ResponseMsg<List<HashMap<String, Object>>>>() {
        });
        if (!responseMsg.getRetCode().equals("200")) {
            throw new RuntimeException(responseMsg.getErrorDesc());
        } else {
            return (List)responseMsg.getResponseBody();
        }
    }

    public String saveMenu(String menuIds, String userId) {
        StringBuffer url = new StringBuffer();
        url.append(RestClientConfig.getRestHost("syspersonalmenu"));
        url.append("/api/platform6/msystem/portal/SysMenuPersonalRest/saveMenu/v1");
        HashMap<String, String> map = new HashMap();
        map.put("menuIds", menuIds);
        map.put("userId", userId);
        ResponseMsg<String> responseMsg = RestClient.doPost(url.toString(), map, new GenericType<ResponseMsg<String>>() {
        });
        if (!responseMsg.getRetCode().equals("200")) {
            throw new RuntimeException(responseMsg.getErrorDesc());
        } else {
            return (String)responseMsg.getResponseBody();
        }
    }

    public int updateOrderBy(String menuId, String userId, String orderBy) {
        StringBuffer url = new StringBuffer();
        url.append(RestClientConfig.getRestHost("syspersonalmenu"));
        url.append("/api/platform6/msystem/portal/SysMenuPersonalRest/updateOrderBy/v1");
        HashMap<String, String> map = new HashMap();
        map.put("menuId", menuId);
        map.put("userId", userId);
        map.put("orderBy", orderBy);
        ResponseMsg<Integer> responseMsg = RestClient.doPost(url.toString(), map, new GenericType<ResponseMsg<Integer>>() {
        });
        if (!responseMsg.getRetCode().equals("200")) {
            throw new RuntimeException(responseMsg.getErrorDesc());
        } else {
            return (Integer)responseMsg.getResponseBody();
        }
    }

    public String deleteByMenuId(String menuIds, String userId) {
        StringBuffer url = new StringBuffer();
        url.append(RestClientConfig.getRestHost("syspersonalmenu"));
        url.append("/api/platform6/msystem/portal/SysMenuPersonalRest/deleteByMenuId/v1");
        HashMap<String, String> map = new HashMap();
        map.put("menuIds", menuIds);
        map.put("userId", userId);
        ResponseMsg<String> responseMsg = RestClient.doPost(url.toString(), map, new GenericType<ResponseMsg<String>>() {
        });
        if (!responseMsg.getRetCode().equals("200")) {
            throw new RuntimeException(responseMsg.getErrorDesc());
        } else {
            return (String)responseMsg.getResponseBody();
        }
    }

    public String trunkMenu(String userId) {
        StringBuffer url = new StringBuffer();
        url.append(RestClientConfig.getRestHost("syspersonalmenu"));
        url.append("/api/platform6/msystem/portal/SysMenuPersonalRest/trunkMenu/v1");
        HashMap<String, String> map = new HashMap();
        map.put("userId", userId);
        ResponseMsg<String> responseMsg = RestClient.doPost(url.toString(), map, new GenericType<ResponseMsg<String>>() {
        });
        if (!responseMsg.getRetCode().equals("200")) {
            throw new RuntimeException(responseMsg.getErrorDesc());
        } else {
            return (String)responseMsg.getResponseBody();
        }
    }

    @Override
    public String saveMenuAddModuleId(String menuId, String userId, String moduleId) {
        StringBuffer url = new StringBuffer();
        url.append(RestClientConfig.getRestHost("syspersonalmenu"));
        url.append("/api/platform6/msystem/portal/SysMenuPersonalRest/saveMenuAddModuleId/v1");
        HashMap<String, String> map = new HashMap();
        map.put("menuId", menuId);
        map.put("userId", userId);
        map.put("moduleId",moduleId);
        ResponseMsg<String> responseMsg = RestClient.doPost(url.toString(), map, new GenericType<ResponseMsg<String>>() {
        });
        if (!responseMsg.getRetCode().equals("200")) {
            throw new RuntimeException(responseMsg.getErrorDesc());
        } else {
            return (String)responseMsg.getResponseBody();
        }
    }

    @Override
    public String saveMenuIdsAddModuleId(String menuIds, String userId, String moduleId) {
        StringBuffer url = new StringBuffer();
        url.append(RestClientConfig.getRestHost("syspersonalmenu"));
        url.append("/api/platform6/msystem/portal/SysMenuPersonalRest/saveMenuIdsAndModuleId/v1");
        HashMap<String, String> map = new HashMap();
        map.put("menuIds", menuIds);
        map.put("userId", userId);
        map.put("moduleId", moduleId);
        ResponseMsg<String> responseMsg = RestClient.doPost(url.toString(), map, new GenericType<ResponseMsg<String>>() {
        });
        if (!responseMsg.getRetCode().equals("200")) {
            throw new RuntimeException(responseMsg.getErrorDesc());
        } else {
            return (String)responseMsg.getResponseBody();
        }
    }

    @Override
    public List<HashMap<String, Object>> getPersonalMenuByModuleId(String orgIdentity, String userId,String moduleId) {
        StringBuffer url = new StringBuffer();
        url.append(RestClientConfig.getRestHost("syspersonalmenu"));
        url.append("/api/platform6/msystem/portal/SysMenuPersonalRest/getPersonalMenuByModuleId/v1");
        url.append("/" + orgIdentity);
        url.append("/" + userId);
        url.append("/" + moduleId);
        ResponseMsg<List<HashMap<String, Object>>> responseMsg = RestClient.doGet(url.toString(), new GenericType<ResponseMsg<List<HashMap<String, Object>>>>() {
        });
        if (!responseMsg.getRetCode().equals("200")) {
            throw new RuntimeException(responseMsg.getErrorDesc());
        } else {
            return (List)responseMsg.getResponseBody();
        }
    }
}
