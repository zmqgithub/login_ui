String validatePassword(String value) {
  print(value);
  if (value == null) return 'Invalid password';
  if (value.length < 6)
    return 'Invalid password';
  else
    return null;
}

String validateEmail(String value) {
  print(value);
  if (value == null) return 'Enter Valid Email';
  Pattern pattern =
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
  RegExp regex = new RegExp(pattern);
  if (!regex.hasMatch(value))
    return 'Enter Valid Email';
  else
    return null;
}
