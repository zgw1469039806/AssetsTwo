package avicit.platform6.controller;

import avicit.platform6.api.session.SessionHelper;
import avicit.platform6.modules.system.sysfileupload.domain.SysFileUpload;
import avicit.platform6.modules.system.sysfileupload.service.SwfUploadService;
import org.apache.commons.io.FileUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.File;
import java.util.List;

/**
 * @Auther: yangxd
 * @Date: 2020/9/9
 */

@Controller
@RequestMapping("/attachmentsDownload")
public class AttachmentsDownloadController {

    @Autowired
    private SwfUploadService swfUploadService;

    @RequestMapping("/zad")
    public void zipAndDownload(HttpServletRequest request, HttpServletResponse responsenload, @RequestBody List<String> idList){

        boolean isWindows=this.isWindows();

        String userId = SessionHelper.getLoginSysUser(request).getId();



        //FileUtils.deleteDirectory(null);

        System.out.println(System.getProperty("user.dir"));//user.dir指定了当前的路径

        System.out.println("idList:"+idList);
        //获取所有的blob数据
        //List<SysFileUpload> sysFileUploadList = swfUploadService.getAttachByAttIds(idList);
    }


    private boolean isWindows(){
        String os = System.getProperty("os.name").toLowerCase();
        System.out.println("OS:"+os);
        return os.indexOf("windows")>=0;
    }

    //按照用户ID创建临时目录
    private File createFileDir(boolean isWindows,String userId){
        File folder=null;
        if(isWindows){
            //在D盘创建临时目录
            folder =new File("D:"+File.separator+"zip_temp"+File.separator+userId+File.separator);
        }else{
            folder=new File("/opt/zip_temp/"+userId+"/");
        }
        if(!folder.exists()){
            folder.mkdirs();
        }
        folder.delete();

        return folder;
    }
}
