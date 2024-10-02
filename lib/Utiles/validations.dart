class Validations {
  static bool emailValidator(String email) {
    bool emailValid = RegExp(
            r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$" // Regex for email validation
            )
        .hasMatch(email);
    return emailValid;
  }
}
