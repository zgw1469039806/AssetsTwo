package avicit.cadreselect.util;


public class ResponseData<T> {

    private int code = Consts.Result.SUCCESS.getCode();

    private String msg = Consts.Result.SUCCESS.getMsg();

    private Boolean flag;

    private T data;

    public ResponseData(T data) {
        this.data = data;
    }

    public ResponseData() {
    }

    public int getCode() {
        return code;
    }

    public void setCode(int code) {
        this.code = code;
    }

    public String getMsg() {
        return msg;
    }

    public void setMsg(String msg) {
        this.msg = msg;
    }

    public Boolean getFlag() {
        return flag;
    }

    public void setFlag(Boolean flag) {
        this.flag = flag;
    }

    public T getData() {
        return data;
    }

    public void setData(T data) {
        this.data = data;
    }
}
