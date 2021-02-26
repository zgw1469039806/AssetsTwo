package avicit.assets.device.excelutil.dto;

public class ExcelUploadTempleteDTO {

    private String prop;
    private String name;

    private int rownum;
    private String dropdown;
    private String lookupType;

    public String getProp() {
        return prop;
    }

    public void setProp(String prop) {
        this.prop = prop;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public int getRownum() {
        return rownum;
    }

    public void setRownum(int rownum) {
        this.rownum = rownum;
    }

    public String getDropdown() {
        return dropdown;
    }

    public void setDropdown(String dropdown) {
        this.dropdown = dropdown;
    }

    public String getLookupType() {
        return lookupType;
    }

    public void setLookupType(String lookupType) {
        this.lookupType = lookupType;
    }

    @Override
    public String toString() {
        return "ExcelUploadTempleteDTO{" +
                "prop='" + prop + '\'' +
                ", name='" + name + '\'' +
                ", rownum=" + rownum +
                ", dropdown='" + dropdown + '\'' +
                ", lookupType='" + lookupType + '\'' +
                '}';
    }
}
