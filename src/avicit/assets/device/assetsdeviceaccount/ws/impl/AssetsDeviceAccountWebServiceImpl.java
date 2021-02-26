package avicit.assets.device.assetsdeviceaccount.ws.impl;


import avicit.assets.assetsapplymodule.ws.impl.AssetsApplyModuleWebServiceImpl;
import avicit.assets.device.assetsdeviceaccount.dto.AssetsDeviceAccountDTO;
import avicit.assets.device.assetsdeviceaccount.service.AssetsDeviceAccountService;
import avicit.assets.device.assetsdeviceaccount.ws.AssetsDeviceAccountWebService;
import avicit.platform6.commons.utils.DateUtil;
import avicit.platform6.core.redis.RedisCallback;
import avicit.platform6.core.redis.RedisTemplate;
import avicit.platform6.core.spring.SpringFactory;
import org.apache.commons.lang.time.DateUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.util.StringUtils;
import redis.clients.jedis.ShardedJedis;

import javax.jws.WebService;
import java.util.Date;
import java.util.List;
import java.util.concurrent.Executors;
import java.util.concurrent.ScheduledExecutorService;
import java.util.concurrent.TimeUnit;

/**
 * @Auther: yangxd
 * @Date: 2020/9/2
 */
@WebService(endpointInterface = "avicit.assets.device.assetsdeviceaccount.ws.AssetsDeviceAccountWebService")
public class AssetsDeviceAccountWebServiceImpl implements AssetsDeviceAccountWebService {

    private static final Logger log = LoggerFactory.getLogger(AssetsDeviceAccountWebServiceImpl.class);
    private static final AssetsDeviceAccountService accountService= SpringFactory.getBean("assetsDeviceAccountService");
    private static RedisTemplate redis = (RedisTemplate)SpringFactory.getBean(RedisTemplate.class);

    private static final String yyyyMMdd="yyyy-MM-dd";
    private static final String yyyyMMddHHmmss="yyyy-MM-dd HH:mm:ss";


    private String getCache(final String key ) {
        return (String)redis.execute(new RedisCallback<String>() {
            public String doRedisOptions(ShardedJedis jedis) throws Exception {
                return jedis.get(key);
            }
        });
    }

    private void setCache(final String key, final String value,final int exSecond) {
        redis.execute(new RedisCallback<Void>() {
            public Void doRedisOptions(ShardedJedis jedis) throws Exception {
                try{
                    jedis.set(key,value);
                    jedis.expire(key,exSecond);
                }catch(Exception e){
                    System.out.println(key+"设置缓存失败");
                    e.printStackTrace();
                }

                return null;
            }
        });
    }

    @Override
    public String finishAccount(List<AssetsDeviceAccountDTO> accountList) {
        log.info("finishAccount的传入参数,accountList:"+accountList);
        try{
            for(int i=0;i<accountList.size();i++){
                this.accountService.updateAssetsDeviceAccountSensitive4WS(accountList.get(i));
            }
            return AssetsApplyModuleWebServiceImpl.SUCCESS;
        }catch(Exception e){
            e.printStackTrace();
            log.error("调用finishAccount错误",e);
        }

        return AssetsApplyModuleWebServiceImpl.ERROR;
    }

    @Override
    public String readyExecute() {
        String redisPrifix="AssetsDeviceAccountWebServiceImpl_readyExecute";
        try{
            //此任务每天最多一次
            Date date=new Date();
            String yyyyMMDD=DateUtil.format(date,"yyyyMMdd");
            String redisKey=redisPrifix+yyyyMMDD;
            String redisVal=this.getCache(redisKey);
            if(StringUtils.isEmpty(redisVal)){
                this.setCache(redisPrifix+yyyyMMDD,"1",24*60*60);

                //第二天凌晨2点执行同步任务
                Date executeTime = getExecuteTime(date);
                log.info("****************executeTime:"+executeTime);

                executeJob(date,executeTime,redisKey);


                return AssetsApplyModuleWebServiceImpl.SUCCESS;
            }else{
                //今天已经发过执行请求了
                log.info("今天已经发过执行请求了");
                return "hasRequested";
            }
        }catch(Exception e){
            e.printStackTrace();

            return AssetsApplyModuleWebServiceImpl.ERROR;
        }



    }

    private void executeJob(Date date, Date executeTime,String redisKey) {
        ScheduledExecutorService exe = Executors.newSingleThreadScheduledExecutor();
        long delay=DateUtil.getDiffDateTime(date,executeTime)/1000;
        exe.schedule(new BatchSyncGSData(redisKey), delay , TimeUnit.SECONDS);
        exe.shutdown();
    }

    private Date getExecuteTime(Date date) throws Exception{
        //模拟数据，当前时间+2分钟后执行
        //return DateUtils.addMinutes(date,2);

        Date tomorrow=DateUtils.addDays(date,1);
        String dateStr=DateUtil.format(tomorrow,yyyyMMdd)+" 02:00:00";
        return DateUtil.parseDate(dateStr,yyyyMMddHHmmss);
    }


    /*public void testCrontab()throws Exception{
        System.out.println(DateUtil.format(new Date(),"yyyy-MM-dd HH:mm:ss")+"**********************************testCrontab*************");
    }*/





}
