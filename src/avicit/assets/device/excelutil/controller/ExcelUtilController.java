package avicit.assets.device.excelutil.controller;
import avicit.assets.device.excelutil.ExcelSheetPO;
import avicit.assets.device.excelutil.ExcelUtil;
import avicit.assets.device.excelutil.ExcelVersion;
import avicit.assets.device.excelutil.dto.ExcelUploadListDTO;
import avicit.assets.device.excelutil.dto.ExcelUploadTempleteDTO;
import avicit.platform6.api.syslookup.dto.SysLookupSimpleVo;
import avicit.platform6.api.syspermissionresource.permissionanalysis.core.support.LoaderConstant;
import avicit.platform6.commons.utils.JsonHelper;
import com.fasterxml.jackson.core.type.TypeReference;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import javax.servlet.http.HttpServletRequest;
import java.io.IOException;
import java.util.*;

@Controller
@Scope("prototype")
@RequestMapping("assets/device/excelutil/controller")
public class ExcelUtilController  implements LoaderConstant {
    @RequestMapping(value = "/operation/generateExel")
    public  void generateExel(HttpServletRequest request, @RequestBody ExcelUploadListDTO excelUploadListDTO) throws Exception {
        List<ExcelUploadTempleteDTO> excelUploadTempleteDTOList  = excelUploadListDTO.getHeaders();
        String fileName = excelUploadListDTO.getFileName();
        try {
            ExcelSheetPO temple_sheet =new ExcelSheetPO();
            List<List<Object>> temp_list = new ArrayList();
            List<Object> temp_list_obj = new ArrayList();
            List<String[]> downData = new ArrayList();
            String dropdown="";
            String lookupType="";
            int rowNum;
            ArrayList downRows = new ArrayList();//下拉的列序号数组(序号从0开始)
            for(ExcelUploadTempleteDTO dto:excelUploadTempleteDTOList){
                temp_list_obj.add(dto.getName());
                dropdown = dto.getDropdown();
                if(dropdown.equals("true"))
                {
                    lookupType = dto.getLookupType();
                    rowNum =  dto.getRownum();
                    Collection<SysLookupSimpleVo> lookupTypeCollection = sysLookupLoader.getLookUpListByTypeByAppId(lookupType, "1");
                    /*获取下拉*/
                    HashMap<String, String> secretLevelMap = new LinkedHashMap<String, String>();
                    for (SysLookupSimpleVo vo : lookupTypeCollection) {
                        secretLevelMap.put(vo.getLookupCode(), vo.getLookupName());
                    }
                    String[] lookupList = new String[lookupTypeCollection.size()];
                    int i=0;
                    for (SysLookupSimpleVo vo : lookupTypeCollection)
                    {
                        lookupList[i] = vo.getLookupName();
                        i++;
                    }
                    downData.add(lookupList);
                    downRows.add(rowNum);
                }
            }
            temp_list.add( temp_list_obj);
            temple_sheet.setDataList(temp_list);
            temple_sheet.setSheetName("sheet1");
            List<ExcelSheetPO> list = new ArrayList<ExcelSheetPO>();
            list.add(temple_sheet);

            //调用createWorkbookAtDisk()生成excel
            ExcelUtil.createWorkbookAtDisk(ExcelVersion.V2007, list, "E:/v6_code/Assets/out/artifacts/Assets_Web_exploded/static/sysexceltemplate/"+fileName+".xlsx",downData,downRows);
        } catch (IOException e) {
            e.printStackTrace();
        }
    }
}
