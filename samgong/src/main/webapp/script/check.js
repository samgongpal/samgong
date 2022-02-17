function checkAll() {
	var obj1 = document.frm;
	if(obj1.u_id.value == "") {
		alert("아이디가 입력되지 않았습니다.");
		obj1.u_id.focus();
		return false;
	}
	if(obj1.u_pw.value == "") {
		alert("비밀번호가 입력되지 않았습니다.");
		obj1.u_pw.focus();
		return false;
	}
}
function checkAll() {
    var obj2 = document.frm;
    if(obj2.u_id.value == "") {
        alert("아이디가 입력되지 않았습니다.");
		obj2.u_id.focus();
		return false;
	}
    if(obj2.u_pw.value == "") {
        alert("비밀번호가 입력되지 않았습니다.");
		obj2.u_pw.focus();
		return false;
	}
	if(obj2.u_mail.value == "") {
        alert("메일이 입력되지 않았습니다.");
		obj2.u_mail.focus();
		return false;
	}
	if(obj2.u_name.value == "") {
        alert("이름이 입력되지 않았습니다.");
		obj2.u_name.focus();
		return false;
	}
	if(obj2.u_phone2.value == "") {
        alert("번호가 입력되지 않았습니다.");
		obj2.u_phone2.focus();
		return false;
	}
	if(obj2.u_phone3.value == "") {
        alert("번호가 입력되지 않았습니다.");
		obj2.u_phone3.focus();
		return false;
	}
	if(obj.idDuplication.value != idUncheck) {
	    alert("아이디를 중복체크 해주세요");
		return false;
	}
}
function fn_logincheck(){

	
}