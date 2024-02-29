abstract class Validators {
  static String? email(String? value) {
    final regex = RegExp('^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}\$');
    if (value == null || value == '') {
      return 'Please enter an email!';
    } else if (!regex.hasMatch(value)) {
      return 'Please enter a valid email!';
    } else {
      return null;
    }
  }

  static String? text(String? value) {
    if (value == null || value == '') {
      return 'This is required!';
    }
    return null;
  }

  static String? password(String? value) {
    if (value == null || value == '') {
      return 'Please enter a password!';
    } else if (value.length < 8) {
      return 'Password must contain at least 8 characters.';
    }
    return null;
  }
}
