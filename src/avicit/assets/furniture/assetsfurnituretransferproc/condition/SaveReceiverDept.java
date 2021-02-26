package avicit.assets.furniture.assetsfurnituretransferproc.condition;

import avicit.assets.furniture.assetsfurnituretransferproc.dto.AssetsFurnitureTransferProcDTO;
import avicit.assets.furniture.assetsfurnituretransferproc.service.AssetsFurnitureTransferProcService;
import avicit.platform6.bpm.api.listener.EventListener;
import avicit.platform6.bpm.api.listener.EventListenerExecution;
import avicit.platform6.core.spring.SpringFactory;
import avicit.platform6.api.sysuser.SysUserDeptPositionAPI;



public class SaveReceiverDept implements EventListener {

    @Override
    public void notify(EventListenerExecution eventListenerExecution) throws Exception {
        /* 根据表单接收人的ID将接收人的部门ID查询出来，写入设备移交主表 */
        String receiverId = eventListenerExecution.getVariable("RECEIVER").toString();	/* 获取接收人的ID */
        /* 通过接收人的ID在sysUserDeptPositionAPI接口里的方法查询接收人的部门ID，再写入到DTO实体中 */
        SysUserDeptPositionAPI sysUserDeptPositionAPI = SpringFactory.getBean("sysUserDeptPositionAPI");
        String deptId = sysUserDeptPositionAPI.getChiefDeptIdBySysUserId(receiverId);
        /* 从eventListenerExecution中获取主表ID */
        String id = eventListenerExecution.getVariable("id").toString();
        /* 建立设备移交主表的SpringFactory */
        AssetsFurnitureTransferProcService furnitureTransferProcService = SpringFactory.getBean("assetsFurnitureTransferProcService");
        /* 通过主表的ID查询移交流程对应ID的一条记录 */
        AssetsFurnitureTransferProcDTO furnitureTransferProcDTO = furnitureTransferProcService.queryAssetsFurnitureTransferProcByPrimaryKey(id);
        /* 将查询到的部门ID存储到DTO中 */
        furnitureTransferProcDTO.setReceiverDept(deptId);
        /* 返回更新成功的数量 */
        int count = furnitureTransferProcService.updateAssetsFurnitureTransferProcSensitive(furnitureTransferProcDTO);
    }
}
