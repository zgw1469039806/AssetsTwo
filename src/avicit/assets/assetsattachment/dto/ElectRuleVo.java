package avicit.assets.assetsattachment.dto;

public class ElectRuleVo {
    private String numPlateId;

    // token 格式：活动ID_号码牌
    private String token;

    public String getNumPlateId() {
        return numPlateId;
    }

    public void setNumPlateId(String numPlateId) {
        this.numPlateId = numPlateId;
    }

    public String getToken() {
        return token;
    }

    public void setToken(String token) {
        this.token = token;
    }
}
