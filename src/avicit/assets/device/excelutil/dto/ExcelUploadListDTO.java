package avicit.assets.device.excelutil.dto;

import java.util.ArrayList;
import java.util.List;

public class ExcelUploadListDTO {
    List<ExcelUploadTempleteDTO> headers = new ArrayList();
    String fileName;


    public List<ExcelUploadTempleteDTO> getHeaders() {
        return headers;
    }

    public void setHeaders(List<ExcelUploadTempleteDTO> headers) {
        this.headers = headers;
    }

    public String getFileName() {
        return fileName;
    }

    public void setFileName(String fileName) {
        this.fileName = fileName;
    }
}
