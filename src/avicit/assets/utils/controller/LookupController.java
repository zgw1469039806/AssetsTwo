package avicit.assets.utils.controller;

import avicit.assets.device.classifydata.dto.ClassifyTreeDTO;
import avicit.platform6.api.syslookup.SysLookupAPI;
import avicit.platform6.api.syslookup.dto.SysLookupSimpleVo;
import avicit.platform6.api.syspermissionresource.permissionanalysis.core.support.LoaderConstant;
import avicit.platform6.core.properties.PlatformConstant;
import avicit.platform6.core.rest.client.RestClientConfig;
import com.alibaba.fastjson.JSON;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.ServletRequestUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import java.util.ArrayList;
import java.util.Collection;
import java.util.Iterator;
import java.util.List;

/**
 * @科技有限责任公司
 * @作者：请填写
 * @邮箱：avicitdev@avicit.com
 * @创建时间： 2020-07-21 17:02
 * @类说明：请填写
 * @修改记录：
 */
@Controller
@Scope("prototype")
@RequestMapping("assets/utils/lookup/lookupController")
public class LookupController implements LoaderConstant {
    @Autowired
    private SysLookupAPI sysLookupAPI;

    private String languageCode = "zh_CN";

    /**
     * 获取通用代码
     *
     * @param request 请求
     * @return ModelAndView
     */
    @RequestMapping(value = "/getLookupCode", method = RequestMethod.POST)
    public ModelAndView getClassifyTree(HttpServletRequest request) {
        ModelAndView mav = new ModelAndView();
        String lookupCode = ServletRequestUtils.getStringParameter(request, "lookupCode", "");

        Collection<SysLookupSimpleVo> values = sysLookupAPI.getLookUpListByTypeByAppIdWithLg(lookupCode, RestClientConfig.systemid, languageCode);
        List<ClassifyTreeDTO> classifyTreeList = new ArrayList<>();

        Iterator var12 = values.iterator();
        while(var12.hasNext()) {
            SysLookupSimpleVo vo = (SysLookupSimpleVo)var12.next();
            ClassifyTreeDTO dto = new ClassifyTreeDTO();

            dto.setId(vo.getLookupCode());
            dto.setName(vo.getLookupName());
            dto.setId(vo.getLookupCode());

            classifyTreeList.add(dto);
        }

        if((classifyTreeList != null) && (classifyTreeList.size() > 0)){
            mav.addObject("lookupJson", JSON.toJSONString(classifyTreeList));
        }
        else{
            mav.addObject("lookupJson", "[]");
        }
        mav.addObject("flag", PlatformConstant.OpResult.success);
        return mav;
    }
}
