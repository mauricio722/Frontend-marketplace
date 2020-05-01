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
    return "Se requiere el email";
  } else if (!regExp.hasMatch(value)) {
    return "Email invalido";
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
  String patttern =
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
  RegExp regExp = new RegExp(patttern);
  if (value.length == 0) {
    return "Ingrese la contraseña";
  } else if (value.length < 7) {
    return "Almenos 8 caracteres";
    
  } else if (regExp.hasMatch(value)) {
    return "La contraseña es poco segura";
  }
  return null;
}

//password field validator,password is required
String validatePasswordold(String value) {
  if (value.length == 0) {
    return "Ingrese la contraseña";
  } else {
    return null;
  }
}
