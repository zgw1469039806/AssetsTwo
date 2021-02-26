package avicit.assets.assetsapplymodule.ws.impl;

import avicit.assets.assetsapplymodule.dto.AssetsApplyModuleDTO;
import avicit.assets.assetsapplymodule.service.AssetsApplyModuleService;
import avicit.assets.assetsapplymodule.ws.AssetsApplyModuleWebService;
import avicit.assets.device.assetsaccidentproc.controller.AssetsAccidentProcController;
import avicit.platform6.core.mybatis.pagehelper.Page;
import avicit.platform6.core.mybatis.pagehelper.PageHelper;
import avicit.platform6.core.redis.RedisCallback;
import avicit.platform6.core.redis.RedisTemplate;
import avicit.platform6.core.rest.msg.QueryReqBean;
import avicit.platform6.core.rest.msg.QueryRespBean;
import avicit.platform6.core.spring.SpringFactory;
import avicit.platform6.msystem.portal.skins.ThemesSkinsAbst;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import redis.clients.jedis.ShardedJedis;

import javax.jws.WebParam;
import javax.jws.WebService;
import java.util.List;

@WebService(endpointInterface = "avicit.assets.assetsapplymodule.ws.AssetsApplyModuleWebService")
public class AssetsApplyModuleWebServiceImpl implements AssetsApplyModuleWebService {
    public static final String SUCCESS="success";
    public static final String ERROR="error";

    private AssetsApplyModuleService applyModuleService = SpringFactory.getBean("assetsApplyModuleService");
    private static final Logger log = LoggerFactory.getLogger(AssetsApplyModuleWebServiceImpl.class);




   @Override
    public QueryRespBean<AssetsApplyModuleDTO> findAssetsApplyModules(QueryReqBean<AssetsApplyModuleDTO> queryReqBean, String orderBy) {
       log.debug("findAssetsApplyModules传入参数："+queryReqBean.getSearchParams().toString());
       try{
            return this.applyModuleService.searchAssetsApplyModuleByPage(queryReqBean,orderBy);
        }catch(Exception e){
            e.printStackTrace();
            log.error("访问findAssetsApplyModules失败",e);
        }
        return null;
    }

    @Override
    public String  relateGS(@WebParam(name="applyList")List<AssetsApplyModuleDTO> applyList ) {
       log.debug("relateGS传入参数:"+applyList);
        try{
            this.applyModuleService.relateGS(applyList);
            return SUCCESS;
        }catch(Exception e){
            e.printStackTrace();
            log.error("访问relateGS失败",e);
        }
        return ERROR;
    }

    @Override
    public String approvalFinish(@WebParam(name="applyList")List<AssetsApplyModuleDTO> applyList) {
        log.debug("approvalFinish传入参数:"+applyList);
        try{
            int sum=this.applyModuleService.approvalFinish(applyList);
            log.info("approvalFinish更新成功的记录数量:"+sum);
            if(sum>0){
                return SUCCESS;
            }else{
                return ERROR;
            }

        }catch(Exception e){
            e.printStackTrace();
            log.error("访问approvalFinish失败",e);
        }
        return ERROR;
    }
}
