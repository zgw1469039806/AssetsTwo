package avicit.cadreselect.util;



/**
 * 常量类
 **/
public class Consts {


    public enum Result {
        /**
         * 成功
         */
        SUCCESS(0, "处理成功"),


        /**
         * 业务错误
         */
        BIZ_ERROR(101, "业务错误"),
        /**
         * 请求参数错误
         */
        ERROR_PARAM(100, "请求参数错误"),
        /**
         * 请求参数错误
         */
        STAT_DISABLED(102, "处于被禁用状态"),


        SIGN_ERROR(103, "签名错误"),

        SERVER_ERROR(106, "服务内部错误"),

        EXPIRED_REQUEST(104, "过期的请求方法");


        private int code;
        private String msg;

        public int getCode() {
            return code;
        }

        public String getMsg() {
            return msg;
        }

        Result(int code, String msg) {
            this.code = code;
            this.msg = msg;
        }


    }

}
