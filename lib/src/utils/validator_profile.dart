/*
validator of the email field, expect an 
type text and cannot be empty
error: - name is required
- invalid name
max length 40 letters
*/
String validateName(String value) {
  String pattern = r'(^[a-z, A-Z]*$)';
  RegExp regExp = new RegExp(pattern);
  if (value.length == 0) {
    return "Se requiere el nombre";
  } else if (!regExp.hasMatch(value)) {
    return "solo letras";
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
  String pattern = r'(^[a-z, A-Z]*$)';
  RegExp regExp = new RegExp(pattern);
  if (value.length == 0) {
    return "Se requiere el apellido";
  } else if (!regExp.hasMatch(value)) {
    return "solo letras";
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
  String patttern = r'(^[0-9]*$)';
  RegExp regExp = new RegExp(patttern);
  if (value.length == 0) {
    return "Se requiere el telefono";
  } else if (value.length < 7) {
    return "The number must have min 7 digits";
  } else if (!regExp.hasMatch(value)) {
    return "solo números";
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
  String patttern = r'(^[0-9]*$)';
  RegExp regExp = new RegExp(patttern);
  if (value.length == 0) {
    return "Se requiere el documento";
  } else if (value.length < 7) {
    return "The number must have min 7 digits";
  } else if (!regExp.hasMatch(value)) {
    return "solo números";
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
    return "Se requiere la dirección";
  } else {
    return null;
  }
}
