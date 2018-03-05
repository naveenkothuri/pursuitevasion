function RTW_Sid2UrlHash() {
	this.urlHashMap = new Array();
	/* <Root>/Display */
	this.urlHashMap["lego_move_optitrack3:17"] = "msg=rtwMsg_CodeGenerationReducedBlock&block=lego_move_optitrack3:17";
	/* <Root>/Display1 */
	this.urlHashMap["lego_move_optitrack3:19"] = "msg=rtwMsg_CodeGenerationReducedBlock&block=lego_move_optitrack3:19";
	/* <Root>/Display2 */
	this.urlHashMap["lego_move_optitrack3:21"] = "msg=rtwMsg_CodeGenerationReducedBlock&block=lego_move_optitrack3:21";
	/* <Root>/Divide */
	this.urlHashMap["lego_move_optitrack3:20"] = "lego_move_optitrack3.c:41&lego_move_optitrack3.h:81";
	/* <Root>/Ultrasonic Sensor */
	this.urlHashMap["lego_move_optitrack3:16"] = "lego_move_optitrack3.c:35,128,138&lego_move_optitrack3.h:82";
	/* <Root>/Ultrasonic Sensor1 */
	this.urlHashMap["lego_move_optitrack3:18"] = "lego_move_optitrack3.c:38,131,141&lego_move_optitrack3.h:83";
	this.getUrlHash = function(sid) { return this.urlHashMap[sid];}
}
RTW_Sid2UrlHash.instance = new RTW_Sid2UrlHash();
function RTW_rtwnameSIDMap() {
	this.rtwnameHashMap = new Array();
	this.sidHashMap = new Array();
	this.rtwnameHashMap["<Root>"] = {sid: "lego_move_optitrack3"};
	this.sidHashMap["lego_move_optitrack3"] = {rtwname: "<Root>"};
	this.rtwnameHashMap["<Root>/Display"] = {sid: "lego_move_optitrack3:17"};
	this.sidHashMap["lego_move_optitrack3:17"] = {rtwname: "<Root>/Display"};
	this.rtwnameHashMap["<Root>/Display1"] = {sid: "lego_move_optitrack3:19"};
	this.sidHashMap["lego_move_optitrack3:19"] = {rtwname: "<Root>/Display1"};
	this.rtwnameHashMap["<Root>/Display2"] = {sid: "lego_move_optitrack3:21"};
	this.sidHashMap["lego_move_optitrack3:21"] = {rtwname: "<Root>/Display2"};
	this.rtwnameHashMap["<Root>/Divide"] = {sid: "lego_move_optitrack3:20"};
	this.sidHashMap["lego_move_optitrack3:20"] = {rtwname: "<Root>/Divide"};
	this.rtwnameHashMap["<Root>/Ultrasonic Sensor"] = {sid: "lego_move_optitrack3:16"};
	this.sidHashMap["lego_move_optitrack3:16"] = {rtwname: "<Root>/Ultrasonic Sensor"};
	this.rtwnameHashMap["<Root>/Ultrasonic Sensor1"] = {sid: "lego_move_optitrack3:18"};
	this.sidHashMap["lego_move_optitrack3:18"] = {rtwname: "<Root>/Ultrasonic Sensor1"};
	this.getSID = function(rtwname) { return this.rtwnameHashMap[rtwname];}
	this.getRtwname = function(sid) { return this.sidHashMap[sid];}
}
RTW_rtwnameSIDMap.instance = new RTW_rtwnameSIDMap();
