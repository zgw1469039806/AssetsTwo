package avicit.assets.assetsattachment.dto;

public class PersonLogVo {
    // ID
    private String id;
    // 姓名
    private String name;
    // 编号
    private String no;
    // 轮次
    private Integer turnNum;
    // 部门
    private String deptName;
    // 专业
    private String major;
    // 标记
    private String ifMark;
    // 赞成数量
    private Integer agreeNum;
    // 反对数量
    private Integer unAgreeNum;
    // 弃权数量
    private Integer giveUpNum;

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getNo() {
        return no;
    }

    public void setNo(String no) {
        this.no = no;
    }

    public Integer getTurnNum() {
        return turnNum;
    }

    public void setTurnNum(Integer turnNum) {
        this.turnNum = turnNum;
    }

    public String getDeptName() {
        return deptName;
    }

    public void setDeptName(String deptName) {
        this.deptName = deptName;
    }

    public String getMajor() {
        return major;
    }

    public void setMajor(String major) {
        this.major = major;
    }

    public String getIfMark() {
        return ifMark;
    }

    public void setIfMark(String ifMark) {
        this.ifMark = ifMark;
    }

    public Integer getAgreeNum() {
        return agreeNum;
    }

    public void setAgreeNum(Integer agreeNum) {
        this.agreeNum = agreeNum;
    }

    public Integer getUnAgreeNum() {
        return unAgreeNum;
    }

    public void setUnAgreeNum(Integer unAgreeNum) {
        this.unAgreeNum = unAgreeNum;
    }

    public Integer getGiveUpNum() {
        return giveUpNum;
    }

    public void setGiveUpNum(Integer giveUpNum) {
        this.giveUpNum = giveUpNum;
    }
}
