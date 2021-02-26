package avicit.assets.furniture.furnitureclassify.controller;

import avicit.assets.furniture.furnitureclassify.dto.FurnitureClassifyDTO;
import avicit.assets.furniture.furnitureclassify.dto.FurnitureClassifyTreeDTO;
import avicit.assets.furniture.furnitureclassify.service.FurnitureClassifyService;
import avicit.assets.furniture.furniturecollect.dto.FurnitureCollectTreeDTO;
import avicit.assets.furniture.furniturecollect.service.FurnitureCollectService;
import avicit.assets.device.usertreejson.dto.UserTreeJsonDTO;
import avicit.assets.device.usertreejson.service.UserTreeJsonService;
import avicit.platform6.api.session.SessionHelper;
import avicit.platform6.api.syspermissionresource.permissionanalysis.core.support.LoaderConstant;
import avicit.platform6.api.sysuser.dto.SysUser;
import avicit.platform6.commons.utils.ComUtil;
import avicit.platform6.commons.utils.JsonHelper;
import avicit.platform6.core.properties.PlatformConstant.OpResult;
import avicit.platform6.core.rest.msg.PageParameter;
import avicit.platform6.core.rest.msg.QueryReqBean;
import avicit.platform6.core.rest.msg.QueryRespBean;
import com.alibaba.fastjson.JSON;
import com.fasterxml.jackson.core.type.TypeReference;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.ServletRequestUtils;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.*;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * @科技有限责任公司
 * @作者：请填写
 * @邮箱：avicitdev@avicit.com @创建时间： 2020-05-28 09:07
 * @类说明：请填写 @修改记录：
 */
@Controller
@Scope("prototype")
@RequestMapping("assets/furniture/furnitureclassify/furnitureClassifyController")
public class FurnitureClassifyController implements LoaderConstant {
	private static final Logger LOGGER = LoggerFactory.getLogger(FurnitureClassifyController.class);

	@Autowired
	private FurnitureClassifyService furnitureClassifyService;
	
	@Autowired
	private UserTreeJsonService userTreeJsonService;
	
	@Autowired
	private FurnitureCollectService furnitureCollectService;
	
	private String jsonFilePath = "D:/v6_demo/test.json";

	//根据文件路径读取文件中的内容
    public String ReadFile(String path) throws IOException{
        File file=new File(path);
        if(!file.exists()||file.isDirectory()){
        	return "";
        }
        
        BufferedReader br = new BufferedReader(new FileReader(file));
        StringBuffer sb = new StringBuffer();
        
        String temp = null;
        temp = br.readLine();
        
        while(temp!=null){
            sb.append(temp);
            temp = br.readLine();
        }
        
        return sb.toString();
    }
    
	//更新指定文件的文件内容
    public void WriteFile(String path, String fileContent) throws IOException{
        File file = new File(path);
        if(!file.exists()){
             file.createNewFile();
        }
        
        FileWriter fileWriter =new FileWriter(file);
        fileWriter.write(fileContent);
        fileWriter.flush();
        fileWriter.close();
    }

	/**
	 * 跳转到管理页面
	 * @param request  请求
	 * @param reponse  响应
	 * @return ModelAndView
	 */
	@RequestMapping(value = "toFurnitureClassifyManage")
	public ModelAndView toFurnitureClassifyManage(HttpServletRequest request, HttpServletResponse reponse) {
		ModelAndView mav = new ModelAndView();
		String classifyTree = "";

		//获取家具分类树
		try {
			long startTime = System.currentTimeMillis();    //获取开始时间
//		    mav.addObject("classifyTree", ReadFile(jsonFilePath));
			
			List<FurnitureClassifyTreeDTO> classifyDataList = furnitureClassifyService.getFurnitureClassifyTree("");
			classifyTree = JSON.toJSONString(classifyDataList).substring(1);
			
		    long endTime = System.currentTimeMillis();    //获取结束时间
        	System.out.println("Controller：" + (endTime - startTime) + "ms");    //输出程序运行时间
		} 
		catch (Exception e) {
			e.printStackTrace();
		}
		
		//获取我的收藏树
		try {
			SysUser user = SessionHelper.getLoginSysUser(request);
			
			List<FurnitureCollectTreeDTO> collectDataList = furnitureCollectService.getMyCollectList(user.getId());
			String tempStr = "[";
			if(collectDataList != null && collectDataList.size() > 0){
				for(int i=0; i<collectDataList.size(); i++){
					if((collectDataList.get(i).getName() != null) && !("".equals(collectDataList.get(i).getName()))){
						collectDataList.get(i).setId(collectDataList.get(i).getId() + "-1");
						collectDataList.get(i).setPId(collectDataList.get(i).getPId() + "-1");
						continue;
					}
					else{
						FurnitureClassifyDTO dto = furnitureClassifyService.queryFurnitureClassifyByPrimaryKey(collectDataList.get(i).getId());
						collectDataList.get(i).setName(dto.getName());
						collectDataList.get(i).setId(collectDataList.get(i).getId() + "-1");
						collectDataList.get(i).setPId(collectDataList.get(i).getPId() + "-1");
					}
				}

				tempStr = JSON.toJSONString(collectDataList);
				tempStr = tempStr.replace("[{", "[{open:true,");
				tempStr = tempStr.replace("}]", "},");
			}

			classifyTree = tempStr + classifyTree;
		} 
		catch (Exception e) {
			e.printStackTrace();
		}

		mav.addObject("classifyTree", classifyTree);
		mav.setViewName("avicit/assets/furniture/furnitureclassify/FurnitureClassifyManage");
		request.setAttribute("url", "platform/assets/furniture/furnitureclassify/furnitureClassifyController/operation/");
		return mav;
	}

	/**
	 * 分页查询方法
	 * @param pageParameter  查询条件
	 * @param request  请求
	 * @return Map<String,Object>
	 */
	@RequestMapping(value = "/operation/getFurnitureClassifysByPage")
	@ResponseBody
	public Map<String, Object> togetFurnitureClassifyByPage(PageParameter pageParameter, HttpServletRequest request) {
		QueryReqBean<FurnitureClassifyDTO> queryReqBean = new QueryReqBean<FurnitureClassifyDTO>();
		queryReqBean.setPageParameter(pageParameter);
		HashMap<String, Object> map = new HashMap<String, Object>();
		String json = ServletRequestUtils.getStringParameter(request, "param", "");
		String keyWord = ServletRequestUtils.getStringParameter(request, "keyWord", "");// 字段查询条件
		String sord = ServletRequestUtils.getStringParameter(request, "sord", "");// 排序方式
		String sidx = ServletRequestUtils.getStringParameter(request, "sidx", "");// 排序字段
		if (!"".equals(keyWord)) {
			json = keyWord;
		}
		String oderby = "";
		if (sidx != null && sord != null && !"".equals(sord) && !"".equals(sidx)) {
			String cloumnName = ComUtil.getColumn(FurnitureClassifyDTO.class, sidx);
			if (cloumnName != null) {
				oderby = " " + cloumnName + " " + sord;
			}
		}

		FurnitureClassifyDTO param = null;
		DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
		QueryRespBean<FurnitureClassifyDTO> result = null;
		if (json != null && !"".equals(json)) {
			param = JsonHelper.getInstance().readValue(json, dateFormat, new TypeReference<FurnitureClassifyDTO>() {
			});
			queryReqBean.setSearchParams(param);
		}
		try {
			if (!"".equals(keyWord)) {
				result = furnitureClassifyService.searchFurnitureClassifyByPageOr(queryReqBean, oderby);
			} else {
				result = furnitureClassifyService.searchFurnitureClassifyByPage(queryReqBean, oderby);
			}
		} catch (Exception ex) {
			return map;
		}

		map.put("records", result.getPageParameter().getTotalCount());
		map.put("page", result.getPageParameter().getPage());
		map.put("total", result.getPageParameter().getTotalPage());
		map.put("rows", result.getResult());
		LOGGER.info("成功获取NationalClassifyDTO分页数据");
		return map;
	}

	/**
	 * 根据id选择跳转到新建页还是编辑页
	 * 
	 * @param type  操作类型新建还是编辑
	 * @param id    编辑数据的id
	 * @param request   请求
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping(value = "/operation/{type}/{id}")
	public ModelAndView toOpertionPage(@PathVariable String type, @PathVariable String id, HttpServletRequest request)
			throws Exception {
		ModelAndView mav = new ModelAndView();
		if (!"null".equals(id)) {// 编辑窗口或者详细页窗口
			// 主表数据
			// LogBase logBase = LogBaseFactory.getLogBase(request);
			FurnitureClassifyDTO dto = furnitureClassifyService.queryFurnitureClassifyByPrimaryKey(id);

			mav.addObject("nationalClassifyDTO", dto);
		}
		mav.setViewName("avicit/assets/furniture/furnitureclassify/" + "FurnitureClassify" + type);
		return mav;
	}

	/**
	 * 保存数据
	 * @param request  请求
	 * @return ModelAndView
	 */
	@RequestMapping(value = "/operation/save", method = RequestMethod.POST)
	public ModelAndView toSaveFurnitureClassifyDTO(HttpServletRequest request) {
		ModelAndView mav = new ModelAndView();
		String jsonData = ServletRequestUtils.getStringParameter(request, "data", "");
		DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
		try {
			long startTime = System.currentTimeMillis();    //获取结束时间
			
			//将前台传递过来的form对象转换为NationalClassifyDTO
			FurnitureClassifyDTO nationalClassifyDTO = JsonHelper.getInstance().readValue(jsonData, dateFormat, new TypeReference<FurnitureClassifyDTO>() {});
			
			if ("".equals(nationalClassifyDTO.getId())) {// 新增
				//获取当前父节点的最后一个直系子节点
				FurnitureClassifyDTO lastChildDto = furnitureClassifyService.getLastChildNodeByPID(nationalClassifyDTO.getParentid());
				
				//计算新节点的序号
				if(lastChildDto != null){	//存在兄弟节点，则编号为最小的兄弟的编号+1
					nationalClassifyDTO.setSn(lastChildDto.getSn() + 1);
				}
				else
				{	//不存在兄弟节点，则编号为+1
					nationalClassifyDTO.setSn(1L);
					lastChildDto = furnitureClassifyService.queryFurnitureClassifyByPrimaryKey(nationalClassifyDTO.getParentid());
				}
				
				//存储节点数据
				FurnitureClassifyDTO dto = furnitureClassifyService.insertFurnitureClassify(nationalClassifyDTO);
				mav.addObject("id", dto.getId());
				
				//提取新创建的节点信息构建json
				String newNodeStr = "{\"id\":\"" + dto.getId() 
									+ "\",\"itemNum\":\"" + dto.getItemNum()
									+"\",\"name\":\"" + dto.getName()
									+"\",\"pId\":\"" + dto.getParentid()
									+ "\",\"treePath\":\"" + dto.getTreePath()
									+ "\"}";
				
				//创建需要被替换的json
				String oldNodeStr = "{\"id\":\"" + lastChildDto.getId() 
									+ "\",\"itemNum\":\"" + lastChildDto.getItemNum()
									+"\",\"name\":\"" + lastChildDto.getName()
									+"\",\"pId\":\"" + lastChildDto.getParentid()
									+ "\",\"treePath\":\"" + lastChildDto.getTreePath()
									+ "\"}";
				
				//获取当前用户对应的树json数据
				String treeJsonStr = ReadFile(jsonFilePath);
				
				//更新树节点的treeJson
				newNodeStr = oldNodeStr + "," + newNodeStr;
				treeJsonStr = treeJsonStr.replace(oldNodeStr,  oldNodeStr + "," + newNodeStr);

				//将更新后的treeJson写入指定文件
				WriteFile(jsonFilePath, treeJsonStr);
				
				long endTime = System.currentTimeMillis();    //获取结束时间
	        	System.out.println("从数据库获取分类数据：" + (endTime - startTime) + "ms");    //输出程序运行时间
			} 
			else {// 修改
				furnitureClassifyService.updateFurnitureClassifySensitive(nationalClassifyDTO);
				
				//提取新创建的节点信息构建json
				String newNodeStr = "{\"id\":\"" + nationalClassifyDTO.getId() 
									+ "\",\"itemNum\":\"" + nationalClassifyDTO.getItemNum()
									+"\",\"name\":\"" + nationalClassifyDTO.getName()
									+"\",\"pId\":\"" + nationalClassifyDTO.getParentid()
									+ "\",\"treePath\":\"" + nationalClassifyDTO.getTreePath()
									+ "\"}";

				//创建需要被替换的json
				FurnitureClassifyDTO oldDto = furnitureClassifyService.queryFurnitureClassifyByPrimaryKey(nationalClassifyDTO.getId());
				String oldNodeStr = "{\"id\":\"" + oldDto.getId() 
									+ "\",\"itemNum\":\"" + oldDto.getItemNum()
									+"\",\"name\":\"" + oldDto.getName()
									+"\",\"pId\":\"" + oldDto.getParentid()
									+ "\",\"treePath\":\"" + oldDto.getTreePath()
									+ "\"}";
				
				//获取当前用户对应的树json数据
				UserTreeJsonDTO treeJson = userTreeJsonService.getTreeJson("1", "管理员", "NationalClassify");
				String treeJsonStr = treeJson.getTreeJson();
				
				treeJsonStr = treeJsonStr.replace(oldNodeStr, newNodeStr);
				treeJson.setTreeJson(treeJsonStr);
				
				//更新相应的treeJson
				userTreeJsonService.updateUserTreeJson(treeJson);
			}
			mav.addObject("flag", OpResult.success);
		} 
		catch (Exception ex) {
			LOGGER.info(ex.getMessage());
			mav.addObject("error", ex.getMessage());
			mav.addObject("flag", OpResult.failure);
			return mav;
		}
		return mav;
	}
	
	/**
	 * 保存数据
	 * @param request  请求
	 * @return ModelAndView
	 */
	@RequestMapping(value = "/operation/paste", method = RequestMethod.POST)
	public ModelAndView toPasteNationalClassifyDTO(@RequestBody String[] ids, HttpServletRequest request) {
		ModelAndView mav = new ModelAndView();
		try {
			String sourceId = ids[0];
			String targetId = ids[1];
			
			//获取当前父节点的最后一个直系子节点
			FurnitureClassifyDTO lastChildDto = furnitureClassifyService.getLastChildNodeByPID(targetId);
			FurnitureClassifyDTO targetDto = furnitureClassifyService.queryFurnitureClassifyByPrimaryKey(targetId);
			
			//获取待复制包节点及其下属所有节点
			List<FurnitureClassifyDTO> pasteList = furnitureClassifyService.getNodesByPackageNodeId(sourceId);
			
			if((pasteList != null) && (pasteList.size()>0)){
				//提取新创建的节点信息构建json
				StringBuffer newNodeStr = new StringBuffer();
				
				//定义treePath的头部
				String oldTreePathHead = "";
				String newTreePathHead = targetDto.getTreePath() + ",";
				
				List<String> oldFatherIdList = new ArrayList<String>();
				List<String> newFatherIdList = new ArrayList<String>();
				
				for(int i=0; i<pasteList.size(); i++){
					FurnitureClassifyDTO dto = pasteList.get(i);
					
					if(i == 0){
						//更新父节点id
						dto.setParentid(targetDto.getId());
						
						//获取原treePath的头部
						oldTreePathHead = dto.getTreePath();
						oldTreePathHead = oldTreePathHead.replace(dto.getId(), "");
						
						//在原父节点id列表中添加当前节点id
						oldFatherIdList.add(dto.getId());
						
						//更新当前节点的id
						dto.setId(furnitureClassifyService.GetRandomString(10));
						
						//在新父节点id列表中添加当前节点更新后的id
						newFatherIdList.add(dto.getId());
						
						//更新当前节点treePath
						dto.setTreePath(newTreePathHead + dto.getId());
						pasteList.set(i, dto);
					}
					else{
						//更新当前节点treePath的头部
						dto.setTreePath(dto.getTreePath().replace(oldTreePathHead, newTreePathHead));
						
						for(int j=0; j<oldFatherIdList.size(); j++){
							//更新当前节点treePath的头部
							dto.setTreePath(dto.getTreePath().replace(oldFatherIdList.get(j), newFatherIdList.get(j)));
							
							//若当前节点在原父节点id列表中找到自己的父节点，则更新它的父节点id信息并截断后续数据
							if(oldFatherIdList.get(j).equals(dto.getParentid())){
								oldFatherIdList = oldFatherIdList.subList(0, (j+1));
								newFatherIdList = newFatherIdList.subList(0, (j+1));
								
								dto.setParentid(newFatherIdList.get(j));
							}
						}
						
						//在原父节点id列表中添加当前节点id
						String oldId = dto.getId();
						oldFatherIdList.add(oldId);
						
						//更新当前节点的id
						dto.setId(furnitureClassifyService.GetRandomString(10));
						
						//更新当前节点treePath的自身id
						dto.setTreePath(dto.getTreePath().replace(oldId, dto.getId()));
						
						//在新父节点id列表中添加当前节点更新后的id
						newFatherIdList.add(dto.getId());
						pasteList.set(i, dto);
					}
					
					newNodeStr.append(",{\"id\":\"" + dto.getId() 
										+ "\",\"itemNum\":\"" + dto.getItemNum()
										+"\",\"name\":\"" + dto.getName()
										+"\",\"pId\":\"" + dto.getParentid()
										+ "\",\"treePath\":\"" + dto.getTreePath()
										+ "\"}");
				}
				
				String newNodesJson = newNodeStr.toString();
				newNodesJson = newNodesJson.substring(1);
				newNodesJson = "[" + newNodesJson + "]";
				mav.addObject("newNodesJson", newNodesJson);
				
				//创建需要被替换的json
				String oldNodeStr = "{\"id\":\"" + lastChildDto.getId() 
									+ "\",\"itemNum\":\"" + lastChildDto.getItemNum()
									+"\",\"name\":\"" + lastChildDto.getName()
									+"\",\"pId\":\"" + lastChildDto.getParentid()
									+ "\",\"treePath\":\"" + lastChildDto.getTreePath()
									+ "\"}";
				
				//获取当前用户对应的树json数据
				String treeJsonStr = ReadFile(jsonFilePath);
				
				//更新树节点的treeJson
				treeJsonStr = treeJsonStr.replace(oldNodeStr,  oldNodeStr + newNodeStr.toString());

				//将更新后的treeJson写入指定文件
				WriteFile(jsonFilePath, treeJsonStr);
				
				mav.addObject("flag", OpResult.success);
			}
			else{
				mav.addObject("error", "未获取到待复制的节点信息！");
				mav.addObject("flag", OpResult.failure);
			}
		} 
		catch (Exception ex) {
			LOGGER.info(ex.getMessage());
			mav.addObject("error", ex.getMessage());
			mav.addObject("flag", OpResult.failure);
			return mav;
		}
		return mav;
	}

	/**
	 * 按照id批量删除数据
	 * @param ids id数组
	 * @param request 请求
	 * @return ModelAndView
	 */
	@RequestMapping(value = "/operation/delete", method = RequestMethod.POST)
	public ModelAndView toDeleteNationalClassifyDTO(@RequestBody String[] ids, HttpServletRequest request) {
		ModelAndView mav = new ModelAndView();
		try {
			//获取当前用户对应的树json数据
			String treeJsonStr = ReadFile(jsonFilePath);
			
			for(String id : ids){
				//LOGGER.info(id);
				FurnitureClassifyDTO oldDto = furnitureClassifyService.queryFurnitureClassifyByPrimaryKey(id);
				String oldNodeStr = "{\"id\":\"" + oldDto.getId() 
									+ "\",\"itemNum\":\"" + oldDto.getItemNum()
									+"\",\"name\":\"" + oldDto.getName()
									+"\",\"pId\":\"" + oldDto.getParentid()
									+ "\",\"treePath\":\"" + oldDto.getTreePath()
									+ "\"},";
				
				if(treeJsonStr.indexOf(oldNodeStr) > -1){
					LOGGER.info(treeJsonStr.indexOf(oldNodeStr)+"");
					
					//更新树节点的treeJson
					treeJsonStr = treeJsonStr.replace(oldNodeStr,  "");
				}
				else{
					oldNodeStr = oldNodeStr.replace("\"},", "\"}");
					
					//更新树节点的treeJson
					treeJsonStr = treeJsonStr.replace(oldNodeStr,  "");
				}
			}
			
			//将更新后的treeJson写入指定文件
			WriteFile(jsonFilePath, treeJsonStr);
			
			mav.addObject("flag", OpResult.success);
		} catch (Exception ex) {
			LOGGER.info(ex.getMessage());
			mav.addObject("error", ex.getMessage());
			mav.addObject("flag", OpResult.failure);
			return mav;
		}
		return mav;
	}
}
