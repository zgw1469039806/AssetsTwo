package avicit.assets.device.assetsdeviceborrow.condition;

import atg.taglib.json.util.JSONObject;
import avicit.assets.device.assetsdeviceaccount.dto.AssetsDeviceAccountDTO;
import avicit.assets.device.assetsdeviceaccount.service.AssetsDeviceAccountService;
import avicit.assets.device.assetsdeviceborrow.dto.AssetsDeviceBorrowDTO;
import avicit.assets.device.assetsdeviceborrow.service.AssetsDeviceBorrowService;
import avicit.platform6.api.application.SysApplicationAPI;
import avicit.platform6.api.syslookup.SysLookupAPI;
import avicit.platform6.api.sysmsg.dto.SysMsgDTO;
import avicit.platform6.api.sysuser.SysUserAPI;
import avicit.platform6.api.sysuser.SysUserDeptPositionAPI;
import avicit.platform6.api.sysuser.dto.SysDept;
import avicit.platform6.api.sysuser.dto.SysUser;
import avicit.platform6.bpm.api.listener.EventListener;
import avicit.platform6.bpm.api.listener.EventListenerExecution;
import avicit.platform6.commons.utils.JsonHelper;
import avicit.platform6.core.properties.PlatformConstant;
import avicit.platform6.core.rest.client.RestClient;
import avicit.platform6.core.rest.client.RestClientConfig;
import avicit.platform6.core.rest.msg.ResponseMsg;
import avicit.platform6.core.spring.SpringFactory;
import avicit.platform6.msystem.sysmsg.controller.SysMsgConstant;
import com.fasterxml.jackson.core.type.TypeReference;

import javax.ws.rs.core.GenericType;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

public class BorrowChangeAccount implements EventListener {
//    @Autowired
//    SysMsgController sysMsgController;
    @Override
    public void notify(EventListenerExecution eventListenerExecution) throws Exception {
        /* 从eventListenerExecution中获取表单ID */
        String id = eventListenerExecution.getVariable("id").toString();


        AssetsDeviceBorrowService deviceBorrowService = SpringFactory.getBean("assetsDeviceBorrowService");
        SysUserAPI sysUserAPI = SpringFactory.getBean("sysUserAPI");
        /* 通过表单ID从主表中查出对应的deviceBorrowDTO */
        AssetsDeviceBorrowDTO deviceBorrowDTO = deviceBorrowService.queryAssetsDeviceBorrowByPrimaryKey(id);

        String unifiedId = deviceBorrowDTO.getUnifiedId();      /* 从deviceBorrowDTO中获取设备统一编码 */
        String person = deviceBorrowDTO.getCreatedByPerson();   /* 从deviceBorrowDTO中获取创建人 */
        String dept = deviceBorrowDTO.getCreatedByDept();       /* 从deviceBorrowDTO中获取创建人部门 */

        //获取流程创建人
        //String createdBy=eventListenerExecution.getVariable("createdBy").toString();
        //获取流程的formId
        String formId = eventListenerExecution.getVariable("id").toString();
        //获取流程ID（flowId）
        String flowId = eventListenerExecution.getProcessDefinitionId();

        /* 需要调assetsDeviceAccountService里面的方法，必须建立SpringFactory */
        AssetsDeviceAccountService deviceAccountService = SpringFactory.getBean("assetsDeviceAccountService");

        /* 通过设备统一编码查询到设备台账的对应实体 */
        AssetsDeviceAccountDTO assetsDeviceAccountDTO = deviceAccountService.queryAssetsDeviceAccountByUnifiedId(unifiedId);

        /* 获取节点的名称，赋值给activityName*/
        String activityName = eventListenerExecution.getActivityName();

        java.util.Date sysDate = new java.util.Date();  /* 获取系统当前时间 */
        java.sql.Time date = new java.sql.Time(sysDate.getTime());

        /* 借出时改写台账的统管设备状态为 借出 */
        if ("task2".equals(activityName)) {
            assetsDeviceAccountDTO.setManageState("2");     /* 将设备台账实体的统管设备状态设置为 借出：2 （从通用代码管理里面查询闲置的代码） */
            assetsDeviceAccountDTO.setUserId(person);       /* 借出时改写台账的使用人为申请人 */
            assetsDeviceAccountDTO.setUserDept(dept);       /* 借出时改写台账的使用部门为申请人部门 */

            deviceBorrowDTO.setBorrowDate(date);            /* 设置当前时间为实际借用时间 */


            /* 调用修改台账的函数，将修改后的DTO传给台账的修改方法，成功后返回修改成功的数量 */
            int updateNum = deviceAccountService.updateFlowAssetsDeviceAccountSensitive(assetsDeviceAccountDTO, "", formId, "设备借用", flowId);

            int count = deviceBorrowService.updateAssetsDeviceBorrowSensitive(deviceBorrowDTO);     /* 更新数据到统管设备借用表 */

            /* 发送定时消息需要的消息体字段函数 */

            /* 从通用代码中 */
            SysLookupAPI sysLookup = SpringFactory.getBean("sysLookupAPI");
            SysApplicationAPI sysApplicationAPI = SpringFactory.getBean("sysApplicationAPI");
            String dayStr = sysLookup.getNameByLooupTypeCodeAndLooupCodeByAppId("BORROW_REMINDER_DAY", "day",
                    sysApplicationAPI.getCurrentAppId());
            int day = Integer.parseInt(dayStr);

            Date expectReturnDate = new Date(deviceBorrowDTO.getExpectReturnDate().getTime() - 1000 * 60 * 60 * 24 * day);     /* 获取预计归还日期前3天的日期 */
            Date expectReturnDateEnd = new Date(deviceBorrowDTO.getExpectReturnDate().getTime() - 1000 * 60 * 60 * 24 * (day-1));     /* 获取预计归还日期前3天的日期 */
            SimpleDateFormat sp = new SimpleDateFormat("yyyy-MM-dd HH:mm"); /* 格式化日期 */
            String sendDate = sp.format(expectReturnDate);     /* 发送时间 */
            String disappearDate = sp.format(expectReturnDateEnd);    /* 消失时间 为 发送时间 */
            String title = "借用归还提醒";        /* 消息提醒标题 */
            String content = "您借用的统管设备:"+unifiedId+"，还有3天到期，如已归还请忽略此消息";     /* 消息提醒内容 */
            String recvUser = deviceBorrowDTO.getCreatedByPerson();                /* 消息接收人ID */
            String recvUsersAlias = deviceBorrowDTO.getCreatedByPersonAlias();     /* 消息接收人Alias */

            /* 将发送消息的字段封装为JSON */
            JSONObject json = new JSONObject();
            json.put("id","");
            json.put("sourceCode","personal");
            json.put("title",title);
            json.put("content",content);
            json.put("msgType","0");
            json.put("recvUser",recvUser);
            json.put("recvUsersAlias",recvUsersAlias);
            json.put("sendDate",sendDate);
            json.put("disappearDate",disappearDate);

            Map<String, Object> mav = new HashMap();
            SysUser sendUser = sysUserAPI.getSysUserById("1");
            String jsonData = json.toString();

            try {
                SysMsgDTO msgDTO = (SysMsgDTO)JsonHelper.getInstance().readValue(jsonData, new TypeReference<SysMsgDTO>() {
                });
                msgDTO.setRecvDate(msgDTO.getDisappearDate());
                String persional = SysMsgConstant.SOURCE_CODE_PERSONAL;
                if (SysMsgConstant.SOURCE_CODE_PERSONAL.equals(msgDTO.getSourceCode()) && "".equals(msgDTO.getId())) {
                    if (this.insertPersonalMsg(msgDTO, sendUser)) {
                        mav.put("flag", PlatformConstant.OpResult.success);
                    } else {
                        mav.put("flag", PlatformConstant.OpResult.failure);
                    }
                }

            } catch (Exception var7) {
                mav.put("error", var7.getMessage());
                mav.put("flag", PlatformConstant.OpResult.failure);
            }
        }

        /* 归还时改写台账的统管设备状态为 在库*/
        else if ("end1".equals(activityName)) {
            assetsDeviceAccountDTO.setManageState("1");     /* 将设备台账实体的统管设备状态设置为 在库：1 （从通用代码管理里面查询闲置的代码） */
            assetsDeviceAccountDTO.setUserId("");           /* 归还时改写台账的使用人为 空 */
            assetsDeviceAccountDTO.setUserDept("");         /* 归还时改写台账的使用部门为 空 */

            deviceBorrowDTO.setReturnDate(date);            /* 设置当前时间为实际归还时间 */

            /* 调用修改台账的函数，将修改后的DTO传给台账的修改方法，成功后返回修改成功的数量 */
            int updateNum = deviceAccountService.updateFlowAssetsDeviceAccountSensitive(assetsDeviceAccountDTO, "", formId, "设备借用", flowId);

            int count = deviceBorrowService.updateAssetsDeviceBorrowSensitive(deviceBorrowDTO);     /* 更新数据到统管设备借用表 */
        } else {
            System.out.println("后置事件节点状态异常");
        }
    }

    /* 发送定时消息的函数(复制SysMsgController.class文件的方法) */
    private boolean insertPersonalMsg(SysMsgDTO msgDto, SysUser sendUser) throws Exception {
        SysUserDeptPositionAPI sysUserDeptPositionAPI =  SpringFactory.getBean("sysUserDeptPositionAPI");
        SysApplicationAPI sysApplicationAPI = SpringFactory.getBean("sysApplicationAPI");
        SysDept sendDept = sysUserDeptPositionAPI.getChiefDeptBySysUserId(sendUser.getId());

        String sysApplicationId = sysApplicationAPI.getCurrentAppId();
        msgDto.setSendUser(sendUser.getId());
        msgDto.setSendDeptid(sendDept.getId());
        msgDto.setOrgIdentity(sendDept.getOrgId());
        msgDto.setSysApplicationId(sysApplicationId);
        msgDto.setSourceCode(SysMsgConstant.SOURCE_CODE_PERSONAL);
        msgDto.setSourceName(SysMsgConstant.SOURCE_NAME_PERSONAL);
        msgDto.setSendType(SysMsgConstant.SEND_TYPE_PC);
        boolean result = false;

        try {
            String urlx = RestClientConfig.getRestHost("sysmsg") + "/api/sysmsg/SysMsgRest" + "/save/v1";
            ResponseMsg<Boolean> responseMsg = RestClient.doPost(urlx, JsonHelper.getInstance().writeValueAsString(msgDto), new GenericType<ResponseMsg<Boolean>>() {
            });
            if (!responseMsg.getRetCode().equals("200")) {
                throw new Exception(responseMsg.getErrorDesc());
            }

            result = (Boolean)responseMsg.getResponseBody();
        } catch (Exception var8) {
        }

        return result;
    }

}
