function symbolDialogSql(){
	var dialogId = $("#dialogId").val();
	var dialogName = $("#dialogName").val();
	if(dialogId == ""){
		symbolSql();
	} else {
		$("#filterConditionSql").val("#"+"{t}"+"."+$('#columnName').val() + "  " + $('#columnSymbol').val() +  "  '" + dialogId + "'");
		$("#filterCondition").val($("#columnName option:checked").text() + "  " + $("#columnSymbol option:checked").text() +  "  " + dialogName);
	}
}

function symbolSql(isText){
	if(!isText){
		var dialogId = $('#columnType').val();
		var dialogName = $("#columnType option:checked").text();
		var columnNameVal = $('#columnName').val();
		var columnSymbolVal = $('#columnSymbol').val();
		if(dialogId == ""){
			if("" == columnNameVal){
				$("#filterConditionSql").val("  .  " + columnSymbolVal +  "  " + dialogId);
			} else {
				$("#filterConditionSql").val("#"+"{t}"+"."+ columnNameVal + "  " + columnSymbolVal +  "  " + dialogId);
			}
			$("#filterCondition").val($("#columnName option:checked").text() + "  " + $("#columnSymbol option:checked").text() +  "  ");
		} else {
			if("" == columnNameVal){
				$("#filterConditionSql").val("  .  "+ columnSymbolVal +  "  " + "#" + "{" + dialogId + "}");
			} else {
				$("#filterConditionSql").val("#"+"{t}"+"."+ columnNameVal + "  " + columnSymbolVal +  "  " + "#" + "{" + dialogId + "}");
			}
			$("#filterCondition").val($("#columnName option:checked").text() + "  " + $("#columnSymbol option:checked").text() +  "  " + dialogName);
		}
	} else {
		$("#filterConditionSql").val("#"+"{t}"+"."+ columnNameVal + "  " + columnSymbolVal +  "  " + columnNameVal);
		$("#filterCondition").val($("#columnName option:checked").text() + "  " + $("#columnSymbol option:checked").text() +  "  " + isText);
	}
}