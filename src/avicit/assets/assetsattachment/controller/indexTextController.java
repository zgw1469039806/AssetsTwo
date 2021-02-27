package avicit.assets.assetsattachment.controller;

import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

/**
* @Author:maomao
* @Description: 测试
* @Date: 4:54 下午 2021/2/26
*/
@Controller
@Scope("prototype")
@RequestMapping("/indexTextController")
public class indexTextController {


    /**
    * @Author:maomao
    * @Description:
    * @Date: 4:54 下午 2021/2/26
    */
    @ResponseBody
    @RequestMapping(value = "/text")
    public String text()
    {
        return "success";
    }


}
