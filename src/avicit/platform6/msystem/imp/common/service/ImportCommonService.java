package avicit.platform6.msystem.imp.common.service;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.Serializable;
import java.text.ParseException;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import avicit.platform6.commons.utils.JsonUtil;
import avicit.platform6.msystem.imp.common.service.ImportHandler;
import org.apache.commons.io.FileUtils;
import org.apache.commons.lang3.StringUtils;
import org.apache.commons.lang3.math.NumberUtils;
import org.apache.commons.lang3.time.DateUtils;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.ss.usermodel.WorkbookFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import avicit.platform6.commons.utils.ComUtil;
import avicit.platform6.core.exception.DaoException;
import avicit.platform6.core.filter.session.RedisSessionService;
import avicit.platform6.core.properties.PlatformConstant;
import avicit.platform6.core.shiroSecurity.contextThread.ContextCommonHolder;
import avicit.platform6.core.spring.SpringFactory;
import avicit.platform6.msystem.imp.common.dao.ImportCommonDao;
import avicit.platform6.msystem.imp.sysimpcolumnfiledres.dto.SysImpColumnFiledResDTO;
import avicit.platform6.msystem.imp.sysimpsheettableres.dto.SysImpSheetTableResDTO;
import avicit.platform6.msystem.imp.sysimpsheettableres.service.SysImpSheetTableResService;
import avicit.platform6.msystem.imp.sysimptemplate.dto.SysImpTemplateDTO;
import avicit.platform6.msystem.imp.sysimptemplate.service.SysImpTemplateService;

/**
 * @科技有限责任公司
 * @作者：请填写
 * @邮箱：avicitdev@avicit.com @创建时间： 2018-06-14 10:07
 * @类说明：请填写 @修改记录：
 */
@Service
public class ImportCommonService implements Serializable {

	private static final long serialVersionUID = 1L;
	@Autowired
	private ImportCommonDao importCommonDao;
	@Autowired
	private SysImpSheetTableResService sysImpSheetTableResService;
	@Autowired
	private SysImpTemplateService sysImpTemplateService;

	/**
	 * 通过templateCode查询模板信息
	 * 
	 * @param templateCode
	 * @return
	 */
	public Map<String, String> findExcelByExcelPInfoCode(String templateCode) {
		Map<String, String> map = importCommonDao.searchExcelinfoByTemplateCode(templateCode);
		return map;
	}

	/**
	 * 查询数据是否已经存在
	 *
	 * @param tableName
	 * @param whereParam
	 * @return
	 * @throws Exception
	 */
	public int searchDataExists(String tableName, Map<String, String> whereParam) throws Exception {
		try {
			return importCommonDao.searchDataExists(tableName, whereParam);
		} catch (Exception e) {
			e.printStackTrace();
			throw new DaoException(e.getMessage(), e);
		}
	}

	/**
	 * 插入数据
	 *
	 * @param tableName
	 * @param data
	 * @return
	 * @throws Exception
	 */
	@Transactional
	public String insertData(String tableName, Map<String, Object> data) throws Exception {
		try {
			String id = ComUtil.getId();
			data.put("id", id);
			try {
				importCommonDao.selectOrgIdentity(tableName);
				this.setSysDyncProperties(data, PlatformConstant.OpType.insert, true);
			} catch (Exception e) {
				this.setSysDyncProperties(data, PlatformConstant.OpType.insert, false);
			}

			importCommonDao.insertData(tableName, data);
			return id;
		} catch (Exception e) {
			e.printStackTrace();
			throw new DaoException(e.getMessage(), e);
		}
	}

	/**
	 * 插入数据
	 *
	 * @param tableName
	 * @param data
	 * @return
	 * @throws Exception
	 */
	public String insertData2(String tableName, Map<String, Object> data) throws Exception {
		try {
			String id = ComUtil.getId();
			data.put("id", id);
			try {
				importCommonDao.selectOrgIdentity(tableName);
				this.setSysDyncProperties(data, PlatformConstant.OpType.insert, true);
			} catch (Exception e) {
				this.setSysDyncProperties(data, PlatformConstant.OpType.insert, false);
			}

			importCommonDao.insertData(tableName, data);
			return id;
		} catch (Exception e) {
			e.printStackTrace();
			throw new DaoException(e.getMessage(), e);
		}
	}

	/**
	 * 设定公共字段
	 *
	 * @param dyncMap
	 * @param type
	 */
	@SuppressWarnings({ "rawtypes", "incomplete-switch", "unchecked" })
	private void setSysDyncProperties(Map dyncMap, PlatformConstant.OpType type, boolean hasOrgIdentity) {
		String sessionId = ContextCommonHolder.getCookeMid();
		Map session = new HashMap();
		if (org.springframework.util.StringUtils.hasText(sessionId)) {
			session = RedisSessionService.getInstance().getSessionById(sessionId);
		}

		String userId = "";
		String userIp = "";
		if (((Map) session).get("userId") == null) {
			userId = "1";
		} else {
			userId = ((Map) session).get("userId").toString();
		}

		if (((Map) session).get("CURRENT_IP") == null) {
			userIp = "127.0.0.1";
		} else {
			userIp = ((Map) session).get("CURRENT_IP").toString();
		}

		if (hasOrgIdentity) {
			String ORG_IDENTITY = ((Map) session).get("CURRENT_ORG_IDENTITY").toString();
			dyncMap.put("ORG_IDENTITY", ORG_IDENTITY);
		}
		switch (type) {
		case insert:
			dyncMap.put("CREATED_BY", userId);
			dyncMap.put("CREATION_DATE", new Date());
			dyncMap.put("LAST_UPDATE_DATE", new Date());
			dyncMap.put("LAST_UPDATED_BY", userId);
			dyncMap.put("LAST_UPDATE_IP", userIp);
			dyncMap.put("VERSION", 0L);
			break;
		case update:
			dyncMap.put("LAST_UPDATE_DATE", new Date());
			dyncMap.put("LAST_UPDATED_BY", userId);
			dyncMap.put("LAST_UPDATE_IP", userIp);
		}

	}

	/**
	 * 导入数据
	 *
	 * @param code
	 * @param path
	 * @param param
	 * @return
	 */
	public Map<String, Object> importToDatabaseFromExcel(String code, String path, String param) throws Exception {

		ImportHandler importHandler = null;
		boolean validateAllResult = true;
		// 记录数据条数
		Map<String, Object> resultMap = new HashMap<String, Object>();
		Workbook book = WorkbookFactory.create(new FileInputStream(path));
		try {
			resultMap.put("msg", "读取模板信息...");
			SysImpTemplateDTO impTemplateDTO = sysImpTemplateService.searchSysImpTemplateByCode(code);
			resultMap.put("msg", "读取模板与数据表关系信息失败，请检查配置信息...");
			List<SysImpSheetTableResDTO> impSheetTableResDTOList = sysImpSheetTableResService
					.searchSysImpSheetTableResByTemplateId(impTemplateDTO.getId());
			if (impSheetTableResDTOList.size() == 0) {
				resultMap.put("msg", "未能取得模板与数据表关系信息,配置记录数量为0...");
				throw new Exception("");
			}

			resultMap.put("msg", "读取模板列与数据表字段信息...");
			Map<String, List<SysImpColumnFiledResDTO>> tableToColumnFiledResDTOMapping = sysImpTemplateService
					.getSysImpColumnFiledResDTO(impSheetTableResDTOList);
			//lql 2020/05/08 添加 Start
			/*List<SysImpColumnFiledResDTO> filedRes = tableToColumnFiledResDTOMapping.get(null);
			for(SysImpColumnFiledResDTO filedResDTO : filedRes){
			if(filedResDTO.getFieldtype()=="DATE"){
				SysImpColumnFiledResDTO filedResDTO1 = new SysImpColumnFiledResDTO();

			}
			}*/

			if (tableToColumnFiledResDTOMapping.size() == 0) {
				resultMap.put("msg", "未能模板列与数据表字段,配置记录数量为0...");
				throw new Exception("");
			}
			// table和sheet的mapping
			resultMap.put("msg", "配置模板与数据表映射...");
			Map<String, String> sheetToTableMapping = this.getSheetToTableMapping(impSheetTableResDTOList);
			resultMap.put("msg", "配置模板列与数据表字段映射...");
			Map<String, String> tableToSheetMapping = this.getTableToSheetMapping(impSheetTableResDTOList);

			resultMap.put("msg", "读取excel表数据...");
			// 从excel取得数据
			Map<String, List<Map<String, String>>> data = this.getDataFromExcel(code, book, sheetToTableMapping,
					resultMap, tableToColumnFiledResDTOMapping);

			if (data != null) {
				if (Integer
						.parseInt(resultMap.get("totalNum") != null ? resultMap.get("totalNum").toString() : "0") > 0) {

					// 事物为全部成功的校验
					importHandler = newInstanceImportHandler(impTemplateDTO.getUserClass());
					if ("3".equals(impTemplateDTO.getSwfl())) {
						resultMap.put("msg", "执行数据校验...");
						validateAllResult = validateAll(code, importHandler, param, tableToSheetMapping, data, book,
								sheetToTableMapping, tableToColumnFiledResDTOMapping);
					}

					int insertNum = 0;
					if (validateAllResult) {
						resultMap.put("msg", "执行数据导入...");
						//允许单条成功
						if("1".equals(impTemplateDTO.getSwfl())){
							insertNum = doImportData(code, importHandler, param, impTemplateDTO.getSwfl(),
									tableToSheetMapping, data, book, sheetToTableMapping, tableToColumnFiledResDTOMapping);
						}
						//允许单sheet成功
						else if("2".equals(impTemplateDTO.getSwfl())){
							insertNum = doImportData2(code, importHandler, param, impTemplateDTO.getSwfl(),
								tableToSheetMapping, data, book, sheetToTableMapping, tableToColumnFiledResDTOMapping);
						}
						//允许全部成功
						else{
							try{
							insertNum = SpringFactory.getBean(this.getClass()).doImportData3(code, importHandler, param, impTemplateDTO.getSwfl(),
									tableToSheetMapping, data, book, sheetToTableMapping, tableToColumnFiledResDTOMapping);
							}catch(Exception e){}
						}
						
					}
					resultMap.put("insertNum", insertNum);

					if (insertNum != Integer
							.parseInt(resultMap.get("totalNum") != null ? resultMap.get("totalNum").toString() : "0")) {
						writeFile(path, book);
						resultMap.put("errorFile", new File(path).getName());
					}
				}
			} else {
				writeFile(path, book);
				resultMap.put("errorFile", new File(path).getName());
				resultMap.put("insertNum", 0);
				resultMap.put("totalNum", 0);
			}
			resultMap.put("code", "0");
		} catch (Exception e) {
			e.printStackTrace();
			resultMap.put("msg", resultMap.get("msg") + e.getMessage());
			resultMap.put("code", "-1");
		}

		return resultMap;

	}

	/**
	 * 错误信息写入excel
	 *
	 * @param path
	 * @param book
	 * @throws Exception
	 */
	private void writeFile(String path, Workbook book) throws Exception {
		FileUtils.forceMkdir(new File(path.substring(0, path.lastIndexOf("/"))));
		try {
			FileOutputStream out = new FileOutputStream(new File(path));
			book.write(out);
			out.close();
			// book.dispose();
		} catch (Exception e) {
			throw e;
		}
	}

	/**
	 * 事物为全部成功的校验
	 *
	 * @param code
	 * @param importHandler
	 * @param tableToSheetMapping
	 * @param data
	 * @param book
	 * @param sheetToTableMapping
	 * @return
	 * @throws Exception
	 */
	private boolean validateAll(String code, ImportHandler importHandler, String param,
			Map<String, String> tableToSheetMapping, Map<String, List<Map<String, String>>> data, Workbook book,
			Map<String, String> sheetToTableMapping,
			Map<String, List<SysImpColumnFiledResDTO>> tableToColumnFiledResDTOMapping) throws Exception {
		boolean result = true;
		for (Map.Entry<String, List<Map<String, String>>> table : data.entrySet()) {
			int rowNum = 1;
			String sheetName = tableToSheetMapping.get(table.getKey());
			List<SysImpColumnFiledResDTO> columnFiledResDTOList = tableToColumnFiledResDTOMapping.get(table.getKey());

			for (Map<String, String> row : table.getValue()) {
				boolean rowResult = doValidateRow(code, importHandler, param, table.getKey(), sheetName, row,
						columnFiledResDTOList, book, sheetToTableMapping, rowNum, table.getValue(), data);
				if (!rowResult) {
					result = false;
				}
				rowNum += 1;
			}
		}
		return result;
	}

	/**
	 * 初始化自定义handler
	 *
	 * @param userClass
	 * @return
	 * @throws Exception
	 */
	private ImportHandler newInstanceImportHandler(String userClass) throws Exception {
		ImportHandler importHandler = null;
		if (StringUtils.isNotBlank(userClass)) {
			importHandler = (ImportHandler) Class.forName(userClass).newInstance();
		}
		return importHandler;
	}

	/**
	 * table和sheet的mapping
	 *
	 * @param impSheetTableResDTOList
	 * @return
	 */
	private Map<String, String> getTableToSheetMapping(List<SysImpSheetTableResDTO> impSheetTableResDTOList) {
		Map<String, String> mapping = new HashMap<String, String>();
		for (SysImpSheetTableResDTO dto : impSheetTableResDTOList) {
			mapping.put(dto.getTableName(), dto.getSheetName());
		}
		return mapping;
	}

	/**
	 * sheet和table的mapping
	 *
	 * @param impSheetTableResDTOList
	 * @return
	 * @throws Exception
	 */
	private Map<String, String> getSheetToTableMapping(List<SysImpSheetTableResDTO> impSheetTableResDTOList)
			throws Exception {
		Map<String, String> mapping = new HashMap<String, String>();
		Set<String> set = new HashSet<String>();
		int setNum = set.size();
		for (SysImpSheetTableResDTO dto : impSheetTableResDTOList) {
			mapping.put(dto.getSheetName(), dto.getTableName());
			set.add(dto.getTableName());
			if (++setNum != set.size()) {
				throw new Exception("配置出现错误，多个sheet页关联同一张数据表！");
			}
		}
		return mapping;
	}

	/**
	 * 从excel中取得数据
	 *
	 * @param code
	 * @param book
	 * @param sheetToTableMapping
	 * @param resultMap
	 * @return
	 * @throws Exception
	 */
	private Map<String, List<Map<String, String>>> getDataFromExcel(String code, Workbook book,
			Map<String, String> sheetToTableMapping, Map<String, Object> resultMap,
			Map<String, List<SysImpColumnFiledResDTO>> tableToColumnFiledResDTOMapping) throws Exception {

		Map<String, List<Map<String, String>>> data = new HashMap<String, List<Map<String, String>>>();
		int totalNum = 0;
		int rowsNum = 0;
		for (Map.Entry<String, String> entry : sheetToTableMapping.entrySet()) {
			// 获取sheet
			Sheet sheet = book.getSheet(entry.getKey());
			if (sheet == null) {
				throw new Exception("取到的sheet页为空，请检查模板是否正确。（注意：请勿更改模板sheet页名称，以及表头名称）");
			}

			// 获得最大行数
			rowsNum = sheet.getPhysicalNumberOfRows();
			int rowNumtemp = 0;
			// 最末行计算
			for (int i = rowsNum; i > 0; i--) {
				Row row = sheet.getRow(i);
				if (!(row == null || isRowEmpty(row))) {
					rowNumtemp = i;
					break;
				}
			}
			rowsNum = rowNumtemp;
			// 第一行数据
			Row firstRow = sheet.getRow(0);
			int c_num = firstRow.getLastCellNum();
			boolean hasblankrow = false;

			// 从第二行数据开始循环行
			for (int i = 1; i < rowsNum; i++) {
				Row row = sheet.getRow(i);
				if (row == null || isRowEmpty(row)) {
					hasblankrow = true;
					writeMessage(book, entry.getKey(), i, "excel表格中读到空白的行，请检查数据！", c_num);
				}
			}

			if (hasblankrow) {
				return null;
			}
		}

		for (Map.Entry<String, String> entry : sheetToTableMapping.entrySet()) {
			List<Map<String, String>> sheetData = new ArrayList<Map<String, String>>();

			// 获取sheet
			Sheet sheet = book.getSheet(entry.getKey());
			// 获取选择的表
			String tableName = entry.getValue();
			// 获得最大行数
			rowsNum = sheet.getPhysicalNumberOfRows();
			int rowNumtemp = 0;
			// 最末行计算
			for (int i = rowsNum; i > 0; i--) {
				Row row = sheet.getRow(i);
				if (!(row == null || isRowEmpty(row))) {
					rowNumtemp = i;
					break;
				}
			}
			rowsNum = rowNumtemp;
			// 获取column关系表中维护的属性
			List<SysImpColumnFiledResDTO> columnDtos = tableToColumnFiledResDTOMapping.get(tableName);

			// 不允许重复的列
			Map<String, String> norepeatfiled = new HashMap<String, String>();
			Set<String> norepeatfiledValue = new HashSet<String>();
			for (SysImpColumnFiledResDTO dto : columnDtos) {
				if ("1".equals(dto.getKeyunique())) {
					norepeatfiled.put(dto.getField(), dto.getColumnTitle());
				}
			}

			// 第一行数据
			Row firstRow = sheet.getRow(0);
			// 从第二行数据开始循环行
			for (int i = 1; i <= rowsNum; i++) {
				Row row = sheet.getRow(i);
				int columnNum = columnDtos.size();
				totalNum++;

				// 获取列数 遍历列
				Map<String, String> map = new HashMap<String, String>();
				for (int j = 0; j < columnNum; j++) {
					// 获取excel表头
					String headerName = firstRow.getCell(j).toString();
					int hascol = 0;
					for (SysImpColumnFiledResDTO dto : columnDtos) {
						if (dto.getColumnTitle().equals(headerName)) {
							Cell cell = row.getCell(j);
							if (cell!=null){
								cell.setCellType(1);
							}
							map.put(dto.getField(), cell == null ? "" : cell.toString());
							break;
						}
						hascol++;
						if (hascol == columnDtos.size()) {
							throw new Exception("取到的sheet页为空，请检查模板是否正确。（注意：请勿更改模板sheet页名称，以及表头名称）");
						}
					}
				}
				if (norepeatfiled.size() > 0) {
					StringBuffer name = new StringBuffer();
					StringBuffer value = new StringBuffer();
					for (String filed : norepeatfiled.keySet()) {
						value.append(map.get(filed)).append(",");
						name.append(norepeatfiled.get(filed)).append(",");
					}

					if (!norepeatfiledValue.contains(value.toString())) {
						norepeatfiledValue.add(value.toString());
					} else {
						throw new Exception("系统检测到不允许重复的字段在表格中存在重复数据！重复列名称：" + name + "重复数据" + value);
					}
				}
				sheetData.add(map);
			}
			data.put(tableName, sheetData);
		}
		resultMap.put("totalNum", totalNum);
		return data;
	}

	private static boolean isRowEmpty(Row row) {
		for (int c = row.getFirstCellNum(); c < row.getLastCellNum(); c++) {
			Cell cell = row.getCell(c);
			if (cell != null && cell.getCellType() != Cell.CELL_TYPE_BLANK)
				return false;
		}
		return true;
	}

	/**
	 * 允许全部成功
	 *
	 * @param code
	 * @param importHandler
	 * @param param
	 * @param swfl
	 * @param tableToSheetMapping
	 * @param data
	 * @param book
	 * @param sheetToTableMapping
	 * @return
	 * @throws Exception
	 */
	@Transactional
	public int doImportData3(String code, ImportHandler importHandler, String param, String swfl,
			Map<String, String> tableToSheetMapping, Map<String, List<Map<String, String>>> data, Workbook book,
			Map<String, String> sheetToTableMapping,
			Map<String, List<SysImpColumnFiledResDTO>> tableToColumnFiledResDTOMapping) throws Exception {
		boolean validateSheetResult = true;
		boolean validateRowResult = true;
		int insertNum = 0;

		// 遍历表
		for (Map.Entry<String, List<Map<String, String>>> table : data.entrySet()) {
			String tableName = table.getKey();
			String sheetName = tableToSheetMapping.get(tableName);

			List<SysImpColumnFiledResDTO> columnFiledResDTOList = tableToColumnFiledResDTOMapping.get(tableName);

			if (validateSheetResult) {
				int rowNum = 1;
				// 遍历行
				for (Map<String, String> row : table.getValue()) {
					rowNum++;
					if (validateRowResult) {
						
						
						// 遍历列
						Map<String, Object> rowData = new HashMap<String, Object>();
						for (Map.Entry<String, String> col : row.entrySet()) {
							String colName = col.getKey();
							String colValue = col.getValue();

							SysImpColumnFiledResDTO dto = this
									.getSysImpColumnFiledResDTOByColName(columnFiledResDTOList, colName);
							if (dto != null) {
								if ("DATE".equals(dto.getFieldtype().toUpperCase())) {
									rowData.put(colName, formatDate(colValue));
								} else if (dto.getFieldtype() != null
										&& dto.getFieldtype().toUpperCase().indexOf("TIMESTAMP") != -1) {
									rowData.put(colName, formatDate(colValue));
								} else {
									rowData.put(colName, colValue);
								}
							}
						}
						// 插入前操作
						if (importHandler != null) {
							importHandler.insertRowBefore(sheetName, rowData, param);
						}
						// 如果是子表，插入补充数据
						Map<String, Object> extensionData = JsonUtil.parseJSON2Map(param);
						// FkSubColKey 与 datatable-js.vm
						// 导入按钮功能中exData属性值一致，用于识别是否为子表
						if (extensionData != null && extensionData.containsKey("FkSubColKey")) {
							String fkKey = (String) extensionData.get("FkSubColKey");
							Object fkValue = extensionData.get(fkKey);
							rowData.put(fkKey, fkValue);
						}

						try{
							insertData2(tableName, rowData);
							// 计算插入条数
							insertNum++;
						}catch(Exception e){
							writeMessage(book, sheetName, rowNum-1, e.getMessage(), row.size());
							throw new DaoException(e.getMessage(), e);
						}
						
						// 行插入后操作
						if (importHandler != null) {
							importHandler.insertRowAfter(sheetName, rowData, param);
						}
					}
				}
			}
			
			if(importHandler != null){
				importHandler.insertSheetAfter(sheetName, table.getValue(), param);
			}
		}
		
		
		return insertNum;
	}

	
	
	/**
	 * 允许单sheet导入数据
	 *
	 * @param code
	 * @param importHandler
	 * @param param
	 * @param swfl
	 * @param tableToSheetMapping
	 * @param data
	 * @param book
	 * @param sheetToTableMapping
	 * @return
	 * @throws Exception
	 */

	private int doImportData2(String code, ImportHandler importHandler, String param, String swfl,
			Map<String, String> tableToSheetMapping, Map<String, List<Map<String, String>>> data, Workbook book,
			Map<String, String> sheetToTableMapping,
			Map<String, List<SysImpColumnFiledResDTO>> tableToColumnFiledResDTOMapping) throws Exception {

		int insertNum = 0;

		// 遍历表
		for (Map.Entry<String, List<Map<String, String>>> table : data.entrySet()) {
			String tableName = table.getKey();
			String sheetName = tableToSheetMapping.get(tableName);
			insertNum = insertNum + SpringFactory.getBean(this.getClass()).impSheet( code,  importHandler,  param,  swfl,
					tableToSheetMapping, data,  book,
					sheetToTableMapping,
					 tableToColumnFiledResDTOMapping, table);

			if(importHandler != null){
				importHandler.insertSheetAfter(sheetName, table.getValue(), param);
			}
			
		}
		return insertNum;
	}
	
	
	@Transactional
	public int impSheet(String code, ImportHandler importHandler, String param, String swfl,
			Map<String, String> tableToSheetMapping, Map<String, List<Map<String, String>>> data, Workbook book,
			Map<String, String> sheetToTableMapping,
			Map<String, List<SysImpColumnFiledResDTO>> tableToColumnFiledResDTOMapping, Map.Entry<String, List<Map<String, String>>> table) throws Exception{
		int insertNum = 0;
		boolean validateSheetResult = true;
		boolean validateRowResult = true;
		String tableName = table.getKey();
		String sheetName = tableToSheetMapping.get(tableName);

		List<SysImpColumnFiledResDTO> columnFiledResDTOList = tableToColumnFiledResDTOMapping.get(tableName);


		validateSheetResult = validateSheet(code, importHandler, param, tableName, sheetName, table.getValue(),
					columnFiledResDTOList, book, sheetToTableMapping, data);
		if (validateSheetResult) {
			int rowNum = 1;
			// 遍历行
			for (Map<String, String> row : table.getValue()) {
				rowNum++;
				if (validateRowResult) {
					// 遍历列
					Map<String, Object> rowData = new HashMap<String, Object>();
					for (Map.Entry<String, String> col : row.entrySet()) {
						String colName = col.getKey();
						String colValue = col.getValue();

						SysImpColumnFiledResDTO dto = this
								.getSysImpColumnFiledResDTOByColName(columnFiledResDTOList, colName);
						if (dto != null) {
							if ("DATE".equals(dto.getFieldtype().toUpperCase())) {
								rowData.put(colName, formatDate(colValue));
							} else if (dto.getFieldtype() != null
									&& dto.getFieldtype().toUpperCase().indexOf("TIMESTAMP") != -1) {
								rowData.put(colName, formatDate(colValue));
							} else {
								rowData.put(colName, colValue);
							}
						}
					}
					// 插入前操作
					if (importHandler != null) {
						importHandler.insertRowBefore(sheetName, rowData, param);
					}
					// 如果是子表，插入补充数据
					Map<String, Object> extensionData = JsonUtil.parseJSON2Map(param);
					// FkSubColKey 与 datatable-js.vm
					// 导入按钮功能中exData属性值一致，用于识别是否为子表
					if (extensionData != null && extensionData.containsKey("FkSubColKey")) {
						String fkKey = (String) extensionData.get("FkSubColKey");
						Object fkValue = extensionData.get(fkKey);
						rowData.put(fkKey, fkValue);
					}

					// 事务控制方式1：允许单条成功 2：允许单sheet页成功 3：允许全部成功
					// 插入数据
					try{
						insertData2(tableName, rowData);
						// 计算插入条数
						insertNum++;
					}catch(Exception e){
						writeMessage(book, sheetName, rowNum-1, e.getMessage(), row.size());
						throw new DaoException(e.getMessage(), e);
					}
					if (importHandler != null) {
						importHandler.insertRowAfter(sheetName, rowData, param);
					}
				}
			}
		}
		return insertNum;
	}
	/**
	 * 允许单条导入数据
	 *
	 * @param code
	 * @param importHandler
	 * @param param
	 * @param swfl
	 * @param tableToSheetMapping
	 * @param data
	 * @param book
	 * @param sheetToTableMapping
	 * @return
	 * @throws Exception
	 */
	private int doImportData(String code, ImportHandler importHandler, String param, String swfl,
			Map<String, String> tableToSheetMapping, Map<String, List<Map<String, String>>> data, Workbook book,
			Map<String, String> sheetToTableMapping,
			Map<String, List<SysImpColumnFiledResDTO>> tableToColumnFiledResDTOMapping) throws Exception {
		boolean validateSheetResult = true;
		boolean validateRowResult = true;
		int insertNum = 0;

		// 遍历表
		for (Map.Entry<String, List<Map<String, String>>> table : data.entrySet()) {
			String tableName = table.getKey();
			String sheetName = tableToSheetMapping.get(tableName);

			List<SysImpColumnFiledResDTO> columnFiledResDTOList = tableToColumnFiledResDTOMapping.get(tableName);

			if (validateSheetResult) {
				int rowNum = 1;
				// 遍历行
				for (Map<String, String> row : table.getValue()) {
					// 校验
					if ("1".equals(swfl)) {
						validateRowResult = validateRow(code, importHandler, param, tableName, sheetName, row,
								columnFiledResDTOList, book, sheetToTableMapping, rowNum, table.getValue(), data);
						rowNum += 1;
					}

					if (validateRowResult) {
						// 遍历列
						Map<String, Object> rowData = new HashMap<String, Object>();
						for (Map.Entry<String, String> col : row.entrySet()) {
							String colName = col.getKey();
							String colValue = col.getValue();

							SysImpColumnFiledResDTO dto = this
									.getSysImpColumnFiledResDTOByColName(columnFiledResDTOList, colName);
							if (dto != null) {
								if ("DATE".equals(NvlAndtoUpperCase(dto.getFieldtype()))) {
									rowData.put(colName, formatDate(colValue));
								} else if (dto.getFieldtype() != null
										&& NvlAndtoUpperCase(dto.getFieldtype()).indexOf("TIMESTAMP") != -1) {
									rowData.put(colName, formatDate(colValue));
								} else {
									rowData.put(colName, colValue);
								}
							}
						}
						// 插入前操作
						if (importHandler != null) {
							importHandler.insertRowBefore(sheetName, rowData, param);
						}
						// 如果是子表，插入补充数据
						Map<String, Object> extensionData = JsonUtil.parseJSON2Map(param);
						// FkSubColKey 与 datatable-js.vm
						// 导入按钮功能中exData属性值一致，用于识别是否为子表
						if (extensionData != null && extensionData.containsKey("FkSubColKey")) {
							String fkKey = (String) extensionData.get("FkSubColKey");
							Object fkValue = extensionData.get(fkKey);
							rowData.put(fkKey, fkValue);
						}

						// 事务控制方式1：允许单条成功 2：允许单sheet页成功 3：允许全部成功
						// 插入数据
						try{
							SpringFactory.getBean(this.getClass()).insertData(tableName, rowData);
							// 计算插入条数
							insertNum++;
						}catch(Exception e){
							writeMessage(book, sheetName, rowNum-1, e.getMessage(), row.size());
						}
						
						// 插入后操作
						if (importHandler != null) {
							importHandler.insertRowAfter(sheetName, rowData, param);
						}
					}
					
					// sheet插入后操作
					if (importHandler != null) {
						importHandler.insertSheetAfter(sheetName, table.getValue(), param);
					}
				}
			}
		}
		return insertNum;
	}
	
	/**
	 * 根据列名获取SysImpColumnFiledResDTO
	 *
	 * @param columnFiledResDTOList
	 * @param colName
	 * @return
	 */
	private SysImpColumnFiledResDTO getSysImpColumnFiledResDTOByColName(
			List<SysImpColumnFiledResDTO> columnFiledResDTOList, String colName) {
		for (SysImpColumnFiledResDTO dto : columnFiledResDTOList) {
			if (colName.equals(dto.getField())) {
				return dto;
			}
		}
		return null;
	}

	/**
	 * 校验sheet
	 *
	 * @param code
	 * @param importHandler
	 * @param param
	 * @param tableName
	 * @param sheetName
	 * @param sheetData
	 * @param columnFiledResDTOList
	 * @param book
	 * @param sheetToTableMapping
	 * @return
	 * @throws Exception
	 */
	private boolean validateSheet(String code, ImportHandler importHandler, String param, String tableName,
			String sheetName, List<Map<String, String>> sheetData, List<SysImpColumnFiledResDTO> columnFiledResDTOList,
			Workbook book, Map<String, String> sheetToTableMapping, Map<String, List<Map<String, String>>> data)
			throws Exception {
		boolean result = true;
		int rowNum = 1;
		for (Map<String, String> row : sheetData) {
			boolean validateSheetResult = doValidateRow(code, importHandler, param, tableName, sheetName, row,
					columnFiledResDTOList, book, sheetToTableMapping, rowNum, sheetData, data);
			if (!validateSheetResult) {
				result = false;
			}
			rowNum += 1;
		}
		return result;
	}

	/**
	 * 校验行数据
	 *
	 * @param code
	 * @param importHandler
	 * @param param
	 * @param tableName
	 * @param sheetName
	 * @param row
	 * @param columnFiledResDTOList
	 * @param book
	 * @param sheetToTableMapping
	 * @param rowNum
	 * @return
	 * @throws Exception
	 */
	private boolean validateRow(String code, ImportHandler importHandler, String param, String tableName,
			String sheetName, Map<String, String> row, List<SysImpColumnFiledResDTO> columnFiledResDTOList,
			Workbook book, Map<String, String> sheetToTableMapping, int rowNum, List<Map<String, String>> sheetData,
			Map<String, List<Map<String, String>>> data) throws Exception {
		return doValidateRow(code, importHandler, param, tableName, sheetName, row, columnFiledResDTOList, book,
				sheetToTableMapping, rowNum, sheetData, data);
	}

	/**
	 * 校验数据
	 *
	 * @param code
	 * @param importHandler
	 * @param tableName
	 * @param sheetName
	 * @param row
	 * @param columnFiledResDTOList
	 * @param book
	 * @param sheetToTableMapping
	 * @param rowNum
	 * @return
	 * @throws Exception
	 */
	private boolean doValidateRow(String code, ImportHandler importHandler, String param, String tableName,
			String sheetName, Map<String, String> row, List<SysImpColumnFiledResDTO> columnFiledResDTOList,
			Workbook book, Map<String, String> sheetToTableMapping, int rowNum, List<Map<String, String>> sheetData,
			Map<String, List<Map<String, String>>> data) throws Exception {
		boolean result = false;
		StringBuffer message = new StringBuffer();

		// 唯一性check
		result = this.checkDataExists(tableName, row, columnFiledResDTOList);

		if (result) {
			// 校验excel的表头
			if (!checkFieldNum(row, columnFiledResDTOList, message)) {
				result = false;
			}
			// 校验数据
			for (Map.Entry<String, String> col : row.entrySet()) {
				String colName = col.getKey();
				String colValue = col.getValue();
				if (colName == null) {
					throw new Exception("列与数据库字段未对应，请检查配置！");
				}

				if (StringUtils.isNotBlank(colName)) {
					SysImpColumnFiledResDTO dto = this.getSysImpColumnFiledResDTOByColName(columnFiledResDTOList,
							colName);
					if (dto != null) {
						String columnName = dto.getColumnTitle();
						String required = dto.getRequired();
						String checkType = dto.getCheckType();
						Long textLength = dto.getVcharlength();
						String filedType = dto.getFieldtype();
						Long scalaLength = dto.getDatascale() == null ? 0L : dto.getDatascale();

						if ("Y".equals(required) && StringUtils.isBlank(colValue)) {
							message.append(columnName + "不能为空;");
							result = false; // 非空

						} else {
							if (textLength != null && textLength.intValue() > 0) {
								int colValueLength = this.getStringLength(colValue);
								if (!"DATE".equals(NvlAndtoUpperCase(dto.getFieldtype())) && NvlAndtoUpperCase(dto.getFieldtype()).indexOf("TIMESTAMP") == -1
										&& !"NUMBER".equals(NvlAndtoUpperCase(dto.getFieldtype()))
										&& colValueLength > textLength.intValue()) {
									message.append(columnName + "的长度超过" + textLength + "个字符;");
									result = false;
								}
							}
							if (StringUtils.isNotBlank(colValue)) {
								if (("1".equals(checkType) || "NUMBER".equals(NvlAndtoUpperCase(dto.getFieldtype())))
										&& !validateNumber(columnName, colValue,
												textLength != null ? textLength.intValue() : 0, scalaLength.intValue(),
												message)) { // 数字
									result = false;

								} else if (("2".equals(checkType) || "DATE".equals(NvlAndtoUpperCase(filedType))
										|| (NvlAndtoUpperCase(filedType)).indexOf("TIMESTAMP") != -1)
										&& !validateDate(columnName, colValue, message)) { // 日期
									result = false;

								} else if ("3".equals(checkType) && !validateEmail(columnName, colValue, message)) { // 邮箱
									result = false;

								} else if ("4".equals(checkType) && !validatePhone(columnName, colValue, message)) { // 手机号码
									result = false;
								}
							}
						}
					}
				}
			}

			// 自定义校验
			if (importHandler != null
					&& !importHandler.validateRow(sheetName, data, sheetData, row, param, message, rowNum)) {
				result = false;
			}

			if (!result) {
				writeMessage(book, sheetName, rowNum, message.toString(), row.size());
			}
		} else {
			writeMessage(book, sheetName, rowNum, "该行数据在数据库中已经存在！", row.size());
		}
		return result;
	}

	private boolean checkFieldNum(Map<String, String> row, List<SysImpColumnFiledResDTO> columnFiledResDTOList,
			StringBuffer message) {
		boolean result = true;
		if (row.size() != columnFiledResDTOList.size()) {
			for (SysImpColumnFiledResDTO dto : columnFiledResDTOList) {
				if (row.get(dto.getField()) == null) {
					message.append("列名（" + dto.getColumnTitle() + "）不存在;");
					result = false;
				}
			}
		}
		return result;
	}

	/**
	 * 校验email
	 * 
	 * @param columnName
	 * @param email
	 * @param message
	 * @return
	 */
	private boolean validateEmail(String columnName, String email, StringBuffer message) {

		String emailRegx = "^([a-z0-9A-Z]+[-|_|\\.]?)+[a-z0-9A-Z]@([a-z0-9A-Z]+(-[a-z0-9A-Z]+)?\\.)+[a-zA-Z]{2,}$";
		Pattern regex = Pattern.compile(emailRegx);
		Matcher matcher = regex.matcher(email);
		boolean result = matcher.matches();
		if (!result) {
			message.append(columnName + "的邮箱格式不正确;");
		}
		return result;

	}

	/**
	 * 校验手机号码
	 *
	 * @param columnName
	 * @param phone
	 * @param message
	 * @return
	 */
	private boolean validatePhone(String columnName, String phone, StringBuffer message) {

		String regex = "^((13[0-9])|(14[5,7,9])|(15([0-3]|[5-9]))|(17[0,1,3,5,6,7,8])|(18[0-9])|(19[8|9]))\\d{8}$";
		if (phone.length() != 11) {
			message.append(columnName + "的长度不等于11;");
			return false;
		} else {
			Pattern p = Pattern.compile(regex);
			Matcher m = p.matcher(phone);
			boolean result = m.matches();
			if (!result) {
				message.append(columnName + "的手机号码格式不正确;");
			}
			return result;
		}
	}

	/**
	 * 校验日期
	 *
	 * @param columnName
	 * @param date
	 * @param message
	 * @return
	 */
	private boolean validateDate(String columnName, String date, StringBuffer message) {
		/*
		 * String[] parsePatterns = {"yyyy-MM-dd HH:mm:ss", "yyyy-MM-dd",
		 * "yyyy-MMdd HH:mm:ss","yyyyMM-dd HH:mm:ss","yyyyMMdd HH:mm:ss",
		 * "yyyy-MM-dd HH:mmss", "yyyy-MM-dd HHmm:ss", "yyyy-MM-dd HHmmss",
		 * "yyyy-MMdd HH:mmss", "yyyy-MMdd HHmm:ss", "yyyy-MMdd HHmmss",
		 * "yyyyMM-dd HH:mmss", "yyyyMM-dd HHmm:ss", "yyyyMM-dd HHmmss",
		 * "yyyyMMdd HH:mmss", "yyyyMMdd HHmm:ss", "yyyyMMdd HHmmss",
		 * "yyyy-MMdd", "yyyyMM-dd" ,"yyyyMMdd"};
		 */
		String[] parsePatterns = { "yyyy-MM-dd HH:mm:ss", "yyyy-MM-dd" };
		for (String pattern : parsePatterns) {
			try {
				DateUtils.parseDateStrictly(date, pattern);
				return true;
			} catch (ParseException e) {
			}
		}
		message.append(columnName + "的日期格式(yyyy-MM-dd HH:mm:ss或者yyyy-MM-dd)不正确;");
		return false;
	}

	/**
	 * 校验数字
	 *
	 * @param columnName
	 * @param number
	 * @param message
	 * @return
	 */
	private boolean validateNumber(String columnName, String number, int textLength, int scalaLength,
			StringBuffer message) {
		boolean result = NumberUtils.isNumber(number);
		if (!result) {
			message.append(columnName + "不是数值类型;");
		} else {
			int colValueLength = number.replace(".", "").replace("-", "").replace("+", "").length();
			int colValueScalaLength = (number.indexOf(".") != -1)
					? number.substring(number.indexOf("."), number.length()).replace(".", "").length() : 0;
			if (scalaLength > 0) {
				if (colValueScalaLength == 0) {
					if (colValueLength > textLength - scalaLength) {
						message.append(columnName + "的长度超过" + textLength + "(" + scalaLength + "位小数);");
						result = false;
					}
				} else {
					if (colValueLength > textLength || colValueScalaLength > scalaLength) {
						message.append(columnName + "的长度超过" + textLength + "(" + scalaLength + "位小数);");
						result = false;
					}
				}
			} else {
				if (textLength != 0) {
					if (colValueScalaLength > 0) {
						message.append(columnName + "不能有小数位;");
						result = false;
					}
				}
			}
		}
		return result;
	}

	/**
	 * 格式化日期
	 *
	 * @param date
	 * @return
	 */
	private Date formatDate(String date) {

		String[] parsePatterns = { "yyyy-MM-dd HH:mm:ss", "yyyy-MM-dd" };
		for (String pattern : parsePatterns) {
			try {
				return DateUtils.parseDateStrictly(date, pattern);
			} catch (ParseException e) {
			}
		}
		return null;
	}

	private boolean checkDataExists(String tableName, Map<String, String> row,
			List<SysImpColumnFiledResDTO> columnFiledResDTOList) throws Exception {
		Map<String, String> param = new HashMap<String, String>();
		for (SysImpColumnFiledResDTO dto : columnFiledResDTOList) {
			if ("1".equals(dto.getKeyunique())) {
				param.put(dto.getField(), row.get(dto.getField()));
			}
		}
		if (param.size() > 0) {
			int count = this.searchDataExists(tableName, param);
			return count == 0 ? true : false;
		} else {
			return true;
		}
	}

	/**
	 * 写错误信息
	 *
	 * @param book
	 * @param sheetName
	 * @param rowNum
	 * @param message
	 */
	private void writeMessage(Workbook book, String sheetName, Integer rowNum, String message, int colNum) {
		try{
		Row header = book.getSheet(sheetName).getRow(0);
		Row row = book.getSheet(sheetName).getRow(rowNum.intValue());
		// int colNum = row.getPhysicalNumberOfCells();
		if (header.getCell(colNum) == null) {
			header.createCell(colNum).setCellValue("错误信息");
		}
		row.createCell(colNum).setCellValue(message);
		}catch(Exception e){}

	}

	/**
	 * 基本原理是将字符串中所有的非标准字符（双字节字符）替换成两个标准字符（**，或其他的也可以）。
	 * 这样就可以直接例用length方法获得字符串的字节长度了
	 */
	private int getStringLength(String s) {
		s = s.replaceAll("[^\\x00-\\xff]", "**");
		int length = s.length();
		return length;
	}
	
	private String NvlAndtoUpperCase(String s){
		if(s!=null){
			return s.toUpperCase();
		}else{
			return "";
		}
	}
}
