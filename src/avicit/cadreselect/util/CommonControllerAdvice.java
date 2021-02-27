package avicit.cadreselect.util;

import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.ResponseBody;


/**
 * @Description: 异常捕获
 * @Author: Mao.mao
 * @date: 2020/6/6
 */
//@ControllerAdvice
public class CommonControllerAdvice {

    @ExceptionHandler({Exception.class})
    @ResponseBody
    public ResponseData<Void> errorHandle(Exception e) {

        if (e instanceof BizException) {
            ResponseData<Void> responseData = new ResponseData<>();
            responseData.setMsg(e.getMessage());
            responseData.setCode(Consts.Result.BIZ_ERROR.getCode());
            return responseData;
        }else {
            ResponseData<Void> responseData = new ResponseData<>();
            responseData.setMsg(Consts.Result.BIZ_ERROR.getMsg());
            responseData.setCode(Consts.Result.BIZ_ERROR.getCode());
            return responseData;
        }
    }
}

