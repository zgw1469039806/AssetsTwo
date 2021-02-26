package avicit.assets.device.classifydata.service;

import java.util.ArrayList;
import java.util.List;
import java.util.Random;

import avicit.assets.device.classifydata.dto.ClassifyTreeDTO;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import avicit.platform6.commons.utils.ComUtil;
import avicit.platform6.commons.utils.PojoUtil;
import avicit.platform6.core.exception.DaoException;
import avicit.platform6.core.properties.PlatformConstant.OpType;
import avicit.assets.device.classifydata.dao.ClassifyDataDao;
import avicit.assets.device.classifydata.dto.ClassifyDataDTO;
import avicit.platform6.modules.system.syslog.service.SysLogUtil;

/**
 * @科技有限责任公司
 * @作者：请填写
 * @邮箱：avicitdev@avicit.com
 * @创建时间： 2020-07-21 17:02
 * @类说明：请填写
 * @修改记录：
 */
@Service
public class ClassifyDataService {
    private static final Logger LOGGER = LoggerFactory.getLogger(ClassifyDataService.class);

    @Autowired
    private ClassifyDataDao classifyDataDao;

    /*
    * 生成指定长度随机字符串
    * @param len 要生成的字符串长度
    */
    public static String getRandomString(int len) {
        String[] baseString = { "0", "1", "2", "3", "4", "5", "6", "7", "8", "9", "a", "b", "c", "d", "e", "f", "g",
                "h", "i", "j", "k", "l", "m", "n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z", "A", "B",
                "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W",
                "X", "Y", "Z" };

        Random random = new Random();
        int length = baseString.length;
        String randomString = "";
        for (int i = 0; i < length; i++) {
            randomString += baseString[random.nextInt(length)];
        }
        random = new Random(System.currentTimeMillis());
        String resultStr = "";
        for (int i = 0; i <len; i++) {
            resultStr += randomString.charAt(random.nextInt(randomString.length() - 1));
        }
        return resultStr;
    }

    /**
     * 根据所属类别获取相应的分类树
     * @param belongCategory 所属类别
     * @return List<ClassifyTreeDTO>
     * @throws Exception
     */
    public List<ClassifyTreeDTO> getClassifyTree(String belongCategory) throws Exception {
        try{
            List<ClassifyTreeDTO> dataList =  classifyDataDao.getClassifyTree(belongCategory);
            return dataList;
        }
        catch(Exception e){
            LOGGER.error("getClassifyTree出错：", e);
            e.printStackTrace();
            throw new DaoException(e.getMessage(),e);
        }
    }

    /**
     * 通过主键查询单条记录
     * @param id 主键id
     * @return ClassifyDataDTO
     * @throws Exception
     */
    public ClassifyDataDTO queryClassifyDataById(String id){
        try {
            ClassifyDataDTO dto = classifyDataDao.findClassifyDataById(id);

            //记录日志
            if (dto != null) {
                SysLogUtil.log4Query(dto);
            }
            return dto;
        } catch (Exception e) {
            LOGGER.error("queryClassifyDataByPrimaryKey出错：", e);
            throw new DaoException(e.getMessage(), e);
        }
    }

    /**
     * 新增对象
     * @param dto 保存对象
     * @return String
     * @throws Exception
     */
    public String insertClassifyData(ClassifyDataDTO dto) throws Exception {
        try {
            long classifyCount = getClassifyCount(dto.getName(), "", "", dto.getBelongCategory());
            if(classifyCount > 0){
                return "Fail:已存在同名的分类！";
            }

            classifyCount = getClassifyCount("", dto.getCode(), "", dto.getBelongCategory());
            if(classifyCount > 0){
                return "Fail:已存在同编号的分类！";
            }

            dto.setId(getRandomString(10));
            dto.setClassifyState("Y");

            //添加的节点为根分类
            if((dto.getParentId() == null) || ("null".equals(dto.getParentId())) || ("".equals(dto.getParentId()))){
                dto.setParentId("null");
                dto.setParentCode("");
                dto.setTreePath(dto.getId());

                //获取当前数据库中排序号最大的根分类
                ClassifyDataDTO lastChild = getLastChildByPid("null", dto.getBelongCategory());
                if(lastChild == null){
                    dto.setSn(1L);
                }
                else{
                    dto.setSn(lastChild.getSn() + 1);
                }
            }
            //添加的节点不为根分类
            else{
                //获取父分类
                ClassifyDataDTO parentDto = queryClassifyDataById(dto.getParentId());
                if(parentDto == null){
                    return "Fail:数据库中未查到对应的父分类！";
                }
                else{
                    dto.setParentCode(parentDto.getCode());
                    dto.setTreePath(parentDto.getTreePath() + "," + dto.getId());
                }

                //获取当前数据库中排序号最大的兄弟分类
                ClassifyDataDTO lastChild = getLastChildByPid(dto.getParentId(), dto.getBelongCategory());
                if(lastChild == null){
                    dto.setSn(1L);
                }
                else{
                    dto.setSn(lastChild.getSn() + 1);
                }
            }

            //补充分类的部分字段信息
            PojoUtil.setSysProperties(dto, OpType.insert);

            //保存分类信息
            classifyDataDao.insertClassifyData(dto);

            //记录日志
            if (dto != null) {
                SysLogUtil.log4Insert(dto);
            }
            return dto.getId();
        } catch (Exception e) {
            LOGGER.error("insertClassifyData出错：", e);
            throw new DaoException(e.getMessage(), e);
        }
    }

    /**
     * 修改对象部分字段
     * @param dto 修改对象
     * @return int
     * @throws Exception
     */
    public String updateClassifyDataSensitive(ClassifyDataDTO dto) throws Exception {
        try {
            long classifyCount = getClassifyCount(dto.getName(), "", dto.getId(), dto.getBelongCategory());
            if(classifyCount > 0){
                return "Fail:已存在同名的分类！";
            }

            classifyCount = getClassifyCount("", dto.getCode(), dto.getId(), dto.getBelongCategory());
            if(classifyCount > 0){
                return "Fail:已存在同编号的分类！";
            }

            //记录日志
            ClassifyDataDTO old = queryClassifyDataById(dto.getId());

            if (old != null) {
                SysLogUtil.log4Update(dto, old);
            }
            PojoUtil.setSysProperties(dto, OpType.update);
            PojoUtil.copyProperties(old, dto, true);
            classifyDataDao.updateClassifyDataSensitive(old);

            return "Success";
        } catch (Exception e) {
            LOGGER.error("updateClassifyDataSensitive出错：", e);
            throw new DaoException(e.getMessage(), e);
        }
    }

    /**
     * 根据父节点id获取其排序最后一个直接子节点分类
     * @param parentId 父节点id
     * @return ClassifyDataDTO
     * @throws Exception
     */
    public ClassifyDataDTO getLastChildByPid(String parentId, String belongCategory) throws Exception {
        try{
            List<ClassifyDataDTO> dataList =  classifyDataDao.getChildrenByPid(parentId, belongCategory);

            if((dataList != null) && (dataList.size()>0)){
                return dataList.get(0);
            }
            return null;
        }catch(Exception e){
            LOGGER.error("getLastChildByPid出错：", e);
            e.printStackTrace();
            throw new DaoException(e.getMessage(),e);
        }
    }

    /**
     * 根据父节点id获取其激活状态的子节点数目
     * @param parentId 父节点id
     * @return Integer
     * @throws Exception
     */
    public long getValidChildrenCountByPid(String parentId, String belongCategory) throws Exception {
        try{
            long childrenCount =  classifyDataDao.getValidChildrenCountByPid(parentId, belongCategory);
            return childrenCount;
        }catch(Exception e){
            LOGGER.error("getValidChildrenCountByPid出错：", e);
            e.printStackTrace();
            throw new DaoException(e.getMessage(),e);
        }
    }

    /**
     * 根据分类名称、分类编号、分类id、所属类别获取分类的数目
     * @param name(分类名称)、code(分类编号)、id(分类id)、belongCategory(所属类别)
     * @return Integer
     * @throws Exception
     */
    public long getClassifyCount(String name, String code, String id, String belongCategory)throws Exception {
        try{
            long classifyCount = classifyDataDao.getClassifyCount(name, code, id, belongCategory);
            return classifyCount;
        }catch(Exception e){
            LOGGER.error("getClassifyCount出错：", e);
            e.printStackTrace();
            throw new DaoException(e.getMessage(),e);
        }
    }
}