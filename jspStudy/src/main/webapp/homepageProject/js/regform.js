/*회원가입폼 아이디체크*/
function idCheck(id) {
	let value = document.regForm.id.value;
	if (value === "") {
		alert("아이디를 입력해 주세요.");
		document.regForm.id.focus();
	} else {
		url = "idCheck.jsp?id=" + value;
		window.open(url, "post", "width=500,height=300");
	}
}

/*회원가입폼 주소체크*/
function zipCheck() {
	url = "zipCheck.jsp?check=y";
	window.open(url, "post", "toolbar=no ,width=600 ,height=300 , directories=no,status=yes,scrollbars=yes,menubar=no");
}

/*회원가입폼 동체크*/
function dongCheck() {
	let value = document.zipForm.dong.value;
	if (value === "") {
		alert("동이름을 입력해 주세요.");
		document.zipForm.dong.focus();
		return;
	}
	document.zipForm.submit()
}

/*주소내용을 불러주는 윈도우창 각 요소저장*/
function sendAddress(zipcode, sido, gugun, dong, bunji) {
	var address = sido + " " + gugun + " " + dong + " " + bunji;
	opener.document.regForm.zipcode.value = zipcode;
	opener.document.regForm.address1.value = address;
	self.close();
}

/*회원가입창 패턴검색*/
function inputCheck(){
    //패턴검색
    const idPattern = /^[\w]{3,}$/; //[\w]는 영문자, 숫자, _만 입력 가능 {3,} 3글자이상가능
    const pwdPattern =/^[\w]{6,10}$/; //영문자와 숫자, _ 6~10  
    const namePattern =/^[가-힣]{2,4}|[A-Z]{1}[a-zA-Z\x20]{1,19}$/; //한글 2~4글자,영문자 2-20 첫글자는대문자 공백가능   
    const telPattern =/^[\d]{2,3}-[\d]{3,4}-[\d]{4}$/; //\d 숫자만가능
    const emailPattern =/^[a-z0-9_+.-]+@([a-z0-9-]+\.)+[a-z0-9]{2,4}$/;
    //객체찾기
    const inputID = document.querySelector("#input-id"); 
    const inputPW1 = document.querySelector("#input-pw1"); 
    const inputPW2 = document.querySelector("#input-pw2"); 
    const inputName = document.querySelector("#input-name"); 
    const inputTel= document.querySelector("#input-tel"); 
    const inputEmail= document.querySelector("#input-email"); 
    //주소객체찾기
    const zipcode= document.querySelector("#zipcode");
    const addr1= document.querySelector("#addr1");
    const addr2= document.querySelector("#addr2");
    const btnSearchAddr= document.querySelector("#btn-searchAddr");
    //폼객체찾기
    const myform= document.querySelector(".myform");
		//아이디 중복여부 확인


		
    //이벤트리스너등록및 핸들러처리
    inputID.addEventListener("blur",()=>validate(inputID, idPattern, "영문자, 숫자, _만 입력 가능" ));
    inputPW1.addEventListener("blur",()=>validate(inputPW1,pwdPattern, "영문자와 숫자, _ 6~10" ));
    inputPW2.addEventListener("blur",()=>{
        validate(inputPW2,pwdPattern, "영문자와 숫자, _ 6~10" );
        if(inputPW1.value !== inputPW2.value){
            inputPW2.nextSibling.textContent ="패스워드가 일치하지 않음";
            inputPW2.nextSibling.style.color ="red";
            inputPW1.value="";
            inputPW2.value="";
            inputPW1.focus(); 
            return; 
        }
    });
    inputName.addEventListener("blur",()=>validate(inputName,namePattern, "한글 2~4글자,영문자 2-10 첫글자는대문자 공백가능" ));
    inputTel.addEventListener("blur",()=>validate(inputTel,telPattern, "전화번호형식이 안맞음" ));
    inputEmail.addEventListener("blur",()=>validate(inputEmail,emailPattern, "이메일형식 안맞음" ));
   
    //폼 이벤트등록및 핸들러처리
    myform.addEventListener("submit",(e)=>{
        e.preventDefault();  //서버에 전송하는 기본기능막는다.
        validate(inputID, idPattern, "영문자, 숫자, _만 입력 가능" );
        validate(inputPW1,pwdPattern, "영문자와 숫자, _ 6~10" );
        validate(inputPW2,pwdPattern, "영문자와 숫자, _ 6~10" );
        if(inputPW1.value !== inputPW2.value){
            inputPW2.nextSibling.textContent ="패스워드가 일치하지 않음";
            inputPW2.nextSibling.style.color ="red";
            inputPW1.value="";
            inputPW2.value="";
            inputPW1.focus(); 
            return; 
        }
        validate(inputName,namePattern, "한글 2~4글자,영문자 2-10 첫글자는대문자 공백가능" );
        validate(inputTel,telPattern, "전화번호형식이 안맞음" );
        validate(inputEmail,emailPattern, "이메일형식 안맞음" );
        if(zipcode.value === "" ||  addr1.value  === ""){
            zipcode.nextSibling.textContent ="주소선택해주세요";
            zipcode.focus();
            return;  
        }
        myform.submit();  
    });
    //핸들러처리기능    
    function validate(userInput, pattern, message ){
        if(userInput.value.match(pattern)){
            userInput.nextSibling.innerHTML = "성공";
            userInput.nextSibling.style.color ="blue";
           }else{
            userInput.nextSibling.innerHTML = message;
            userInput.nextSibling.style.color ="red";
            userInput.value = "";
            userInput.focus();
            return; 
           }
    }
		

}

function inputCheck2(){
    //패턴검색
    const pwdPattern =/^[\w]{6,10}$/; //영문자와 숫자, _ 6~10  
    const namePattern =/^[가-힣]{2,4}|[A-Z]{1}[a-zA-Z\x20]{1,19}$/; //한글 2~4글자,영문자 2-20 첫글자는대문자 공백가능   
    const telPattern =/^[\d]{2,3}-[\d]{3,4}-[\d]{4}$/; //\d 숫자만가능
    const emailPattern =/^[a-z0-9_+.-]+@([a-z0-9-]+\.)+[a-z0-9]{2,4}$/;
    //객체찾기
    const inputPW1 = document.querySelector("#input-pw12"); 
    const inputPW2 = document.querySelector("#input-pw22"); 
    const inputName = document.querySelector("#input-name2"); 
    const inputTel= document.querySelector("#input-tel2"); 
    const inputEmail= document.querySelector("#input-email2"); 
    //주소객체찾기
    const zipcode= document.querySelector("#zipcode2");
    const addr1= document.querySelector("#addr12");
    const addr2= document.querySelector("#addr22");
    const btnSearchAddr= document.querySelector("#btn-searchAddr");
    //폼객체찾기
    const myform= document.querySelector(".myform2");
		//아이디 중복여부 확인


		
    //이벤트리스너등록및 핸들러처리
    inputPW1.addEventListener("blur",()=>validate(inputPW1,pwdPattern, "영문자와 숫자, _ 6~10" ));
    inputPW2.addEventListener("blur",()=>{
        validate(inputPW2,pwdPattern, "영문자와 숫자, _ 6~10" );
        if(inputPW1.value !== inputPW2.value){
            inputPW2.nextSibling.textContent ="패스워드가 일치하지 않음";
            inputPW2.nextSibling.style.color ="red";
            inputPW1.value="";
            inputPW2.value="";
            inputPW1.focus(); 
            return; 
        }
    });
    inputName.addEventListener("blur",()=>validate(inputName,namePattern, "한글 2~4글자,영문자 2-10 첫글자는대문자 공백가능" ));
    inputTel.addEventListener("blur",()=>validate(inputTel,telPattern, "전화번호형식이 안맞음" ));
    inputEmail.addEventListener("blur",()=>validate(inputEmail,emailPattern, "이메일형식 안맞음" ));
   
    //폼 이벤트등록및 핸들러처리
    myform.addEventListener("submit",(e)=>{
        e.preventDefault();  //서버에 전송하는 기본기능막는다.
        validate(inputPW1,pwdPattern, "영문자와 숫자, _ 6~10" );
        validate(inputPW2,pwdPattern, "영문자와 숫자, _ 6~10" );
        if(inputPW1.value !== inputPW2.value){
            inputPW2.nextSibling.textContent ="패스워드가 일치하지 않음";
            inputPW2.nextSibling.style.color ="red";
            inputPW1.value="";
            inputPW2.value="";
            inputPW1.focus(); 
            return; 
        }
        validate(inputName,namePattern, "한글 2~4글자,영문자 2-10 첫글자는대문자 공백가능" );
        validate(inputTel,telPattern, "전화번호형식이 안맞음" );
        validate(inputEmail,emailPattern, "이메일형식 안맞음" );
        if(zipcode.value === "" ||  addr1.value  === ""){
            zipcode.nextSibling.textContent ="주소선택해주세요";
            zipcode.focus();
            return;  
        }
        myform.submit();  
    });
    //핸들러처리기능    
    function validate(userInput, pattern, message ){
        if(userInput.value.match(pattern)){
            userInput.nextSibling.innerHTML = "성공";
            userInput.nextSibling.style.color ="blue";
           }else{
            userInput.nextSibling.innerHTML = message;
            userInput.nextSibling.style.color ="red";
            userInput.value = "";
            userInput.focus();
            return; 
           }
    }
		

}



