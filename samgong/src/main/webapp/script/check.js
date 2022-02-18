
function fn_checkAll() {
    var f = document.frm;
    if(f.u_id.value == "") {
        alert("아이디가 입력되지 않았습니다.");
		f.u_id.focus();
		return false;
	}
    if(f.u_pw.value == "") {
        alert("비밀번호가 입력되지 않았습니다.");
		f.u_pw.focus();
		return false;
	}
	if(f.u_mail.value == "") {
        alert("메일이 입력되지 않았습니다.");
		f.u_mail.focus();
		return false;
	}
	if(f.u_name.value == "") {
        alert("이름이 입력되지 않았습니다.");
		f.u_name.focus();
		return false;
	}
	if(f.u_phone2.value == "") {
        alert("번호가 입력되지 않았습니다.");
		f.u_phone2.focus();
		return false;
	}
	if(f.u_phone3.value == "") {
        alert("번호가 입력되지 않았습니다.");
		f.u_phone3.focus();
		return false;
	}
	if(f.idDuplication.value < 1) {
	    alert("아이디를 중복체크 해주세요");
		return false;
	}
	document.frm.submit();
}

function fn_dbCheckId(){ // id 중복체크
	var u_id = document.frm.u_id.value;
	var idDuplication = document.frm.idDuplication.value;
	var replaced_id = u_id.replace(/ /g,'');
	
	if(idDuplication == "1"){
		document.frm.idDuplication.value = "0";
		document.frm.userid.readOnly=false;
		document.frm.dbCheckId.value = "check ID";
		return false;
	}
	if(u_id == null || u_id == ""){
	
		alert("아이디를 입력해주세요!");
		return false;
	}
	if(replaced_id.length != u_id.length){

		alert("공백은 포함할수없습니다.");
		return false;
		
	}
	var idReg = /^[a-zA-Z]+[a-z0-9A-Z]{3,11}$/g;
	
	if(!idReg.test(u_id)){
		alert("4~12자 영문자 또는 숫자 이어야합니다.");
		return false;
	}
	var w  = window.screen.width/2 -150;
	var h = window.screen.height/2 - 100;
	
	var url = "userCheckDuplication.jsp?u_id="+u_id+"&idDuplication="+idDuplication;
	window.open(url,"page","width=400,height=200,left="+w+",top="+h ); //left and top 으로 창의 위치를 설정할수있습니다.
	//팝업이름을 똑같이 하면 새창으로 열리지않고 그이름을 가진곳에 열린다. 없으면 새창으로 열린다. 
}