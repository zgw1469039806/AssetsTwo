package avicit.cadreselect.dyntemplate.dto;

import java.util.ArrayList;
import java.util.List;

public class PrintingDTO {

    private String temTitle;

    List<String> list = new ArrayList<>();

    public String getTemTitle() {
        return temTitle;
    }

    public void setTemTitle(String temTitle) {
        this.temTitle = temTitle;
    }

    public List<String> getList() {
        return list;
    }

    public void setList(List<String> list) {
        this.list = list;
    }
}
