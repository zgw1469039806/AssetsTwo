package avicit.assets.assetsattachment.dto;

import avicit.platform6.core.annotation.log.FieldRemark;
import avicit.platform6.core.annotation.log.LogField;
import avicit.platform6.core.annotation.log.PojoRemark;
import avicit.platform6.core.domain.BeanDTO;
import avicit.platform6.core.properties.PlatformConstant.LogType;

import javax.persistence.Id;

/**
 * @科技有限责任公司
 * @作者：请填写
 * @邮箱：请填写
 * @创建时间： 2020-08-11 17:30 
 * @类说明：获取人员列表参数类
 * @修改记录： 
 */
public class GetPersonDTO{
	private String electId; // 选举活动id
	private String status; // 状态：0：待选，1:晋级，2：淘汰
	private String sortType; // dept:部门，major:专业, date:轮次
	private String sort; // 1、正序； 2、倒序

	public String getElectId() {
		return electId;
	}

	public void setElectId(String electId) {
		this.electId = electId;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public String getSortType() {
		return sortType;
	}

	public void setSortType(String sortType) {
		this.sortType = sortType;
	}

	public String getSort() {
		return sort;
	}

	public void setSort(String sort) {
		this.sort = sort;
	}
}