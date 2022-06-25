String? nameValidator(String? input) {
  if (input! == "") {
    return "Name is required";
  }
  if (input.length > 50) {
    return "Name is too long";
  }
  return null;
}

String? phoneValidator(String? input) {
  if (input == null || input == '') {
    return "Phone number is required";
  }
  if (int.tryParse(input) is! int || input.length < 10 || input.length > 12) {
    return "Invalid phone number";
  }
  return null;
}
