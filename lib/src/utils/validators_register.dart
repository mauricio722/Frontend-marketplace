/*
validator of the email field, expect an 
email type text and cannot be empty
error: - email is required
- invalid email
max length 50 characteres
*/
String validateEmail(String value) {
  String pattern =
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
  RegExp regExp = new RegExp(pattern);
  if (value.length == 0) {
    return "Email required";
  } else if (value.length > 30) {
    return "email must have max 30 characters";
  } else if (!regExp.hasMatch(value)) {
    return "invalid email";
  } else {
    return null;
  }
}

/*
password field validator, expect a type of 
text and cannot be empty
error: - password is required
max length 40 characters
*/
String validatePassword(String value) {
  if (value.length == 0) {
    return "Password required";
  } else if (value.length < 6) {
    return "Password must have min 6 characters";
  } else if (value.length > 30) {
    return "Password must have max 30 characters";
  } else {
    return null;
  }
}

/*
validator of the email field, expect an 
type text and cannot be empty
error: - name is required
- invalid name
max length 40 letters
*/
String validateName(String value) {
  String pattern = r'(^[a-z A-Z\á\é\í\ó\ú\ü\ñÁ\É\Í\Ó\Ú\Ñ ]*$)';
  RegExp regExp = new RegExp(pattern);
  if (value.length == 0) {
    return "Name required";
  } else if (value.length < 3) {
    return "Name must have min 3 letters";
  } else if (value.length > 20) {
    return "Name must have max 20 letters";
  } else if (!regExp.hasMatch(value)) {
    return "required only letters";
  }
  return null;
}

/*
validator of the lastName field, expect an 
type text and cannot be empty
error: - last name is required
- invalid last name
max length 40 letters
*/
String validateLastName(String value) {
  String pattern = r'(^[a-z A-Z\á\é\í\ó\ú\ü\ñ\Á\É\Í\Ó\Ú\Ñ ]*$)';
  RegExp regExp = new RegExp(pattern);
  if (value.length == 0) {
    return "Last name required";
  } else if (value.length < 3) {
    return "Last name must have min 3 letters";
  } else if (value.length > 20) {
    return "Last name must have max 20 letters";
  } else if (!regExp.hasMatch(value)) {
    return "required only letters";
  }
  return null;
}

/*
validator of the documentNumber field, expect an 
email type number and cannot be empty
error: - document number is required
- The number must have 10 digits
- type only numbers
min length 7 numbers
max length 10 numbers
*/
String validateDocumentNumber(String value) {
  String patttern = r'(^[0-9 ]*$)';
  RegExp regExp = new RegExp(patttern);
  if (!regExp.hasMatch(value)) {
    return "required only numbers";
  } else if (value.length == 0) {
    return "Document required";
  } else if (value.length < 7) {
    return "Document must have min 7 numbers";
  } else if (value.length > 10) {
    return "Document must have max 10 numbers";
  }

  return null;
}

/*
validator of the phone field, expect an 
email type number and cannot be empty
error: - phone is required
- The number must have 10 digits
- type only numbers
min length 7 numbers
max length 10 numbers
*/
String validateMobile(String value) {
  String patttern = r'(^[0-9 ]*$)';
  RegExp regExp = new RegExp(patttern);
  if (!regExp.hasMatch(value)) {
    return "required only numbers";
  } else if (value.length == 0) {
    return "Mobile required";
  } else if (value.length < 7) {
    return "Mobile must have min 7 numbers";
  } else if (value.length > 10) {
    return "Document must have max 10 numbers";
  }

  return null;
}

/*
validator of the address field, expect an 
type text and cannot be empty
error: - address is required
- invalid address
max length 40 letters
*/
String validateAddress(String value) {
  if (value.length == 0) {
    return "Address required";
  } else if (value.length < 5) {
    return "Address must have  min 5 characters";
  } else if (value.length > 50) {
    return "Address must have max 50 characters";
  }

  return null;
}

//r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\
//.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
