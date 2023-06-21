function validateForm(form) {
  var r_id = form.r_id.value;	
  var password = form.r_pass.value;
  var name = form.r_name.value;
  var email = form.r_email.value;
  var number = form.r_number.value;

  var idError = document.getElementById("idError");
  var passwordError = document.getElementById("passwordError");
  var nameError = document.getElementById("nameError");
  var emailError = document.getElementById("emailError");
  var numberError = document.getElementById("numError");

  var isValid = true;
  var koreanchk = /[ㄱ-ㅎ|ㅏ-ㅣ|가-힣]/;
	
	// Get a reference to the error message element
	
	// Validate the ID value
	if (r_id == "") {
	  idError.innerHTML = "ID는 반드시 작성해야합니다.";
	  isValid = false;
	} else if (r_id.length < 6 || r_id.length > 12) {
	  idError.innerHTML = "ID는 6~12자 사이여야만 합니다.";
	  isValid = false;
	} else if (!/^[a-zA-Z0-9]+$/.test(r_id)) {
	  idError.innerHTML = "ID는 영어와 숫자만 포함할 수있습니다.";
	  isValid = false;
  	} else {
      idError.innerHTML = "";
  }

  // Check if password is valid
  if (password == "") {
    passwordError.innerHTML = "비밀번호는 반드시 작성해야 합니다.";
    isValid = false;
  } else if (password.length < 8 || password.length > 20) {
    passwordError.innerHTML = "비밀번호는 8글자 이상 20글자 이하로 작성해야합니다.";
    isValid = false;
  } else if (!/^(?=.*[a-z])(?=.*\d)[a-zA-Z\d]{8,}$/.test(password)) {
    passwordError.innerHTML = "비밀번호는 적어도 하나의 소문자, 하나의 숫자를 포함해야 합니다.";
    isValid = false;
  } else {
    passwordError.innerHTML = "";
  }

  // Check if name is valid
  if (name == "") {
    nameError.innerHTML = "이름(닉네임)은 반드시 작성하여야 합니다.";
    isValid = false;
  } else if (!/^[a-zA-Z]+$/.test(name) && !koreanchk.test(name)) {
    nameError.innerHTML = "이름(닉네임)은 문자만 포함할 수있습니다.";
    isValid = false;
  } else {
    nameError.innerHTML = "";
  }

  // Check if email is valid
  if (email == "") {
    emailError.innerHTML = "이메일은 반드시 작성해야 합니다.";
    isValid = false;
  } else if (!/^\S+@\S+\.\S+$/.test(email)) {
    emailError.innerHTML = "이메일이 유효한 형식이 아닙니다.";
    isValid = false;
  } else {
    emailError.innerHTML = "";
  }

  // Check if phone number is valid
  if (number == "") {
    numberError.innerHTML = "휴대폰 번호는 반드시 입력해야 합니다.";
    isValid = false;
  } else if (!/^\d{11}$/.test(number)) {
    numberError.innerHTML = "휴대폰은 유효한 형식이여야 합니다.";
    isValid = false;
  } else {
    numberError.innerHTML = "";
  }

  return isValid;
}

