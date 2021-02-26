package avicit.assets.device.classifydata.dao;

import java.util.List;
import java.util.Map;

import avicit.assets.device.classifydata.dto.ClassifyTreeDTO;
import org.apache.ibatis.annotations.Param;

import avicit.platform6.core.mybatis.MyBatisRepository;
import avicit.assets.device.classifydata.dto.ClassifyDataDTO;

/**
 * @科技有限责任公司
 * @作者：请填写
 * @邮箱：avicitdev@avicit.com
 * @创建时间： 2020-07-21 17:02
 * @类说明：请填写
 * @修改记录：
 */
@MyBatisRepository
public interface ClassifyDataDao {
    /**
     * 根据所属类别获取相应的分类树
     * @param belongCategory 所属类别
     * @return List<ClassifyTreeDTO>
     * @throws Exception
     */
    List<ClassifyTreeDTO> getClassifyTree(@Param("belongCategory") String belongCategory);

    /**
     * 查询 CLASSIFY_DATA
     * @param id 主键id
     * @return ClassifyDataDTO
     */
    public ClassifyDataDTO findClassifyDataById(@Param("id") String id);

    /**
     * 新增CLASSIFY_DATA
     * @param classifyDataDTO 保存对象
     * @return int
     */
    public int insertClassifyData(ClassifyDataDTO classifyDataDTO);

    /**
     * 更新部分对象 CLASSIFY_DATA
     * @param classifyDataDTO 更新对象
     * @return int
     */
    public int updateClassifyDataSensitive(ClassifyDataDTO classifyDataDTO);

    /**
     * 根据父节点id获取其子节点,并按排序号降序排序
     * @param parentId 父节点id
     * @return List<ClassifyDataDTO>
     * @throws Exception
     */
    public List<ClassifyDataDTO> getChildrenByPid(@Param("parentId") String parentId, @Param("belongCategory") String belongCategory);

    /**
     * 根据父节点id获取其激活状态的子节点数目
     * @param parentId 父节点id
     * @return Integer
     * @throws Exception
     */
    public long getValidChildrenCountByPid(@Param("parentId") String parentId, @Param("belongCategory") String belongCategory);

    /**
     * 根据分类名称、分类编号、分类id、所属类别获取分类的数目
     * @param name(分类名称)、code(分类编号)、id(分类id)、belongCategory(所属类别)
     * @return Integer
     * @throws Exception
     */
    public long getClassifyCount(@Param("name") String name, @Param("code") String code, @Param("id") String id, @Param("belongCategory") String belongCategory);
}
