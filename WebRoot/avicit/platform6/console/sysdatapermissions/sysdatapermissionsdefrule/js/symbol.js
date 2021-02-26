function symbolSql(){
	var columnType = $("#columnType").val();
	var dialogId = $('#columnType').val();
	var dialogName = $("#columnType option:checked").text();
	var columnNameVal = $("#columnName").val();
	if("text" == columnType){
		$("#filterConditionSql").val("#"+"{t}"+"."+$('#columnName').val() + "  " + $('#columnSymbol').val() + "  " + $('#columnValue').val());
		$("#filterCondition").val($("#columnName option:checked").text() + "  " + $("#columnSymbol option:checked").text() + "  " + $('#columnValue').val());
	} else {
		if("" == columnType){
			if("" == columnNameVal){
				$("#filterConditionSql").val(" ."+columnNameVal + "  " + $('#columnSymbol').val());
			} else {
				$("#filterConditionSql").val("#"+"{t}"+"."+columnNameVal + "  " + $('#columnSymbol').val());
			}
		} else {
			if("" == columnNameVal){
				$("#filterConditionSql").val(" ."+columnNameVal + "  " + $('#columnSymbol').val() +  "  " + "#" + "{" + dialogId + "}");
			} else {
				$("#filterConditionSql").val("#"+"{t}"+"."+columnNameVal + "  " + $('#columnSymbol').val() +  "  " + "#" + "{" + dialogId + "}");
			}
		}
		$("#filterCondition").val($("#columnName option:checked").text() + "  " + $("#columnSymbol option:checked").text() +  "  " + dialogName);
	}
}