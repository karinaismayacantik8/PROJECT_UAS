class Validator {
  Validator._();

  static String? validateName(String? value) {
    if (value == null || value.trim().isEmpty) {
      return "Nama tidak boleh kosong";
    }

    if (value.trim().length < 3) {
      return "Nama minimal 3 karakter";
    }

    return null;
  }

  static String? validateEmail(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Email tidak boleh kosong';
    }

    final regex = RegExp(r'^[^@]+@[^@]+\.[^@]+');

    if (!regex.hasMatch(value)) {
      return 'Format email tidak valid';
    }

    return null;
  }

  static String? validatePassword(String? value) {
    if (value == null || value.length < 6) {
      return 'Password minimal 6 karakter';
    }
    return null;
  }

  static String? validateAddress(String? value) {
    if (value == null || value.length < 10) {
      return 'Alamat minimal 10 karakter';
    }
    return null;
  }
}