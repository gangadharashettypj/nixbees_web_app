/*
 * @Author GS
 */
class Validators {
  static bool emailValidator(String email) {
    return !RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(email);
  }

  static String validatePassword(String value) {
    Pattern pattern =
        r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{6,}$';
    RegExp regex = new RegExp(pattern);

    if (value.isEmpty) {
      return 'Please enter password';
    } else if (value.length < 6) {
      return 'Password must contain at least 6 characters';
    } else {
      if (!regex.hasMatch(value))
        return 'Password should contain at least 1 uppercase, 1 lowercase, 1 digit, 1 special character';
      else
        return null;
    }
  }
}
