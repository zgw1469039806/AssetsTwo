package avicit.assets.device.assetsdeviceaccount.ws.impl;

import avicit.assets.device.assetsdeviceaccount.dto.AssetsDeviceAccountDTO;
import avicit.assets.device.assetsdeviceaccount.service.AssetsDeviceAccountService;
import avicit.platform6.commons.utils.DateUtil;
import avicit.platform6.core.redis.RedisCallback;
import avicit.platform6.core.redis.RedisTemplate;
import avicit.platform6.core.spring.SpringFactory;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import redis.clients.jedis.ShardedJedis;

import java.util.Date;

/**
 * @Auther: yangxd
 * @Date: 2020/9/3
 * 批量同步财务数据
 */
public class BatchSyncGSData implements Runnable{

    private static final Logger log = LoggerFactory.getLogger(BatchSyncGSData.class);
    private  AssetsDeviceAccountService accountService= SpringFactory.getBean("assetsDeviceAccountService");
    private static RedisTemplate redis = (RedisTemplate)SpringFactory.getBean(RedisTemplate.class);

    private String redisKey;
    public BatchSyncGSData(String redisKey){
        this.redisKey=redisKey;
    }


    private void deleteCache(final String key) {
        redis.execute(new RedisCallback<Void>() {
            public Void doRedisOptions(ShardedJedis jedis) throws Exception {
                try{
                    jedis.del(key);
                    System.out.println("********************************删除"+key);
                }catch(Exception e){
                    e.printStackTrace();
                }

                return null;
            }
        });
    }
    @Override
    public void run() {
        try{
            log.info("任务开始执行："+ DateUtil.format(new Date(),"yyyy-MM-dd HH:mm:ss"));

            AssetsDeviceAccountDTO dto = this.accountService.queryAssetsDeviceAccountByPrimaryKey("402880e573565ea801735660c95a0217");

            log.debug("dto:"+dto);

            this.deleteCache(redisKey);
            log.info("任务结束执行："+ DateUtil.format(new Date(),"yyyy-MM-dd HH:mm:ss"));
        }catch(Exception e){
            e.printStackTrace();
        }

    }
}
