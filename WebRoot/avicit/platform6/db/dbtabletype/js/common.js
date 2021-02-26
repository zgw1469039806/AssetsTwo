/**
 * Created by xb on 2017/5/10.
 */
/**
 * 将表单序列化值字符串转换为json格式，用于后台获取参数直接转换为实体对象
 * @param formSerializeValue
 * @returns {string}
 */
function convertFormSerializeValueToJson(formSerializeValue) {
    var formDataArray = formSerializeValue.split("&");

    var formDataJson = "";
    formDataJson += "{";
    for (var i = 0; i < formDataArray.length; i++) {
        var key = formDataArray[i].split("=")[0];
        var value = formDataArray[i].split("=")[1];

        formDataJson += "\"" + key + "\"";
        formDataJson += ":";
        formDataJson += "\"" + value + "\"";

        if (i != formDataArray.length - 1) {
            formDataJson += ", ";
        }
    }
    formDataJson += "}";

    return formDataJson;
}