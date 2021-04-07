abstract class DoubleValidator {
  bool isValid(double value);
}

class NonEmptyDoubleValidator implements DoubleValidator {
  @override
  bool isValid(double value) {
    if (value == null) return false;
    return true;
  }
}

