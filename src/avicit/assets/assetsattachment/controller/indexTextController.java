package avicit.assets.assetsattachment.controller;

import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
@Scope("prototype")
@RequestMapping("/indexTextController")
public class indexTextController {


    @ResponseBody
    @RequestMapping(value = "/text")
    public String text()
    {
        return "success";
    }


}
