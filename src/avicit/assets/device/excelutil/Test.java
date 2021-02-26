package avicit.assets.device.excelutil;



import avicit.platform6.api.application.SysApplicationAPI;
import avicit.platform6.api.application.impl.SysApplicationAPImpl;
import avicit.platform6.api.syslookup.SysLookupAPI;
import avicit.platform6.api.syslookup.dto.SysLookupSimpleVo;
import avicit.platform6.api.syslookup.impl.SysLookupAPImpl;
import avicit.platform6.core.spring.SpringFactory;
import org.springframework.beans.factory.annotation.Autowired;
import avicit.platform6.api.syspermissionresource.permissionanalysis.core.support.LoaderConstant;
import org.springframework.stereotype.Service;

import java.io.File;
import java.io.IOException;
import java.util.*;

@Service
public class Test  {

//    @org.junit.Test
//
//    public void set() {
//
//        String file = "C:/TEST.xlsx";
//        File file1 = new File(file);
//        try {
//            //传入一个文件,调用readExcel()读取文件,返回List<ExcelSheetPO>
//            List<ExcelSheetPO> list = ExcelUtil.readExcel(file1, null, null);
//            for (ExcelSheetPO a : list) {
//                System.out.println(a.getHeaders() + ".." + a.getTitle() + ".." + a.getSheetName());
//                for (List<Object> b : a.getDataList()) {
//                    System.out.println(b);
//                }
//            }
//            /*设置下拉*/
//            List<String[]> downData = new ArrayList();
//            String[] str1 = {"男","女","未知"};
//            String[] str2 = {"北京","上海","广州","深圳","武汉","长沙","湘潭"};
//            String[] str3 = {"01-汉族","02-蒙古族","03-回族","04-藏族","05-维吾尔族","06-苗族","07-彝族","08-壮族","09-布依族","10-朝鲜族","11-满族","12-侗族","13-瑶族","14-白族","15-土家族","16-哈尼族","17-哈萨克族","18-傣族","19-黎族","20-傈僳族","21-佤族","22-畲族","23-高山族","24-拉祜族","25-水族","26-东乡族","27-纳西族","28-景颇族","29-柯尔克孜族","30-土族","31-达斡尔族","32-仫佬族","33-羌族","34-布朗族","35-撒拉族","36-毛难族","37-仡佬族","38-锡伯族","39-阿昌族","40-普米族","41-塔吉克族","42-怒族","43-乌孜别克族","44-俄罗斯族","45-鄂温克族","46-德昂族","47-保安族","48-裕固族","49-京族","50-塔塔尔族","51-独龙族","52-鄂伦春族","53-赫哲族","54-门巴族","55-珞巴族","56-基诺族","98-外国血统","99-其他"};
//            downData.add(str1);
//            downData.add(str2);
//            downData.add(str3);
//
//
//
//            /*获取下拉*/
//          //  String appId = sysApplicationAPI.getCurrentAppId();
//         //   SysLookupAPI sysLookupLoader = new SysLookupAPImpl();
//         //   SysApplicationAPI sysApplicationAPI = new SysApplicationAPImpl();
//         //   Collection<SysLookupSimpleVo> secretLevelList = sysLookupLoader.getLookUpListByTypeByAppId("SECRET_LEVEL", "1");
//           /* HashMap<String, String> secretLevelMap = new LinkedHashMap<String, String>();
//            for (SysLookupSimpleVo vo : secretLevelList) {
//                secretLevelMap.put(vo.getLookupCode(), vo.getLookupName());
//            }*/
////           String str4[]=null;
////            for (SysLookupSimpleVo vo : secretLevelList)
////           {
////               int i=0;
////               str4[i] = vo.getLookupName();
////               i++;
////           }
//
//            String [] downRows = {"1","2","3"}; //下拉的列序号数组(序号从0开始)
//           // downData.add(str4);
//            //调用createWorkbookAtDisk()生成excel
//            ExcelUtil.createWorkbookAtDisk(ExcelVersion.V2007, list, "E:/TESTBORN.xlsx",downData,downRows);
//        } catch (IOException e) {
//            e.printStackTrace();
//        }
//    }


}
