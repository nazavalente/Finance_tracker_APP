class Validators {
  static String? requiredField(String? value, String fieldName) {
    if (value == null || value.trim().isEmpty) {
      return '$fieldName wajib diisi';
    }
    return null;
  }

  static String? amount(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Nominal wajib diisi';
    }

    final parsed = double.tryParse(value.trim());
    if (parsed == null || parsed <= 0) {
      return 'Nominal tidak valid';
    }

    return null;
  }
}
