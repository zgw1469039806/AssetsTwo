//
// Source code recreated from a .class file by IntelliJ IDEA
// (powered by Fernflower decompiler)
//

package avicit.platform6.api.personalmenu;

import java.util.HashMap;
import java.util.List;

public interface SysPersonalMenuAPI {
    List<HashMap<String, Object>> getPersonalMenu(String var1, String var2);

    List<HashMap<String, Object>> getAvailableMenu(String var1, String var2);

    String saveMenu(String var1, String var2);

    int updateOrderBy(String var1, String var2, String var3);

    String deleteByMenuId(String var1, String var2);

    String trunkMenu(String var1);

    String saveMenuAddModuleId(String var1, String var2,String moduleId);

    String saveMenuIdsAddModuleId(String var1, String var2,String moduleId);

    List<HashMap<String, Object>> getPersonalMenuByModuleId(String var1, String var2,String moduleId);
}
