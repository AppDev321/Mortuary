
import '../constants/app_strings.dart';



abstract class Validator {
  static String? validator;
}

class ConfirmPasswordValidator implements Validator {
  static String? validator(String? password, String? otherPassword) {
    return (password?.isEmpty ?? true) && (otherPassword?.isEmpty ?? true)
        ? AppStrings.confirmPasswordIsRequired
        : password!.length < 6 && otherPassword!.length < 6
        ? AppStrings.passwordLengthError
        : password != otherPassword
        ? AppStrings.passwordDoesNotMatch
        : null;
  }
}



class PasswordValidator implements Validator {
  static String? validator(String? password) {
    return password!.isEmpty
        ? AppStrings.passwordIsRequired
        : password.length >= 6
        ? null
        : AppStrings.passwordLengthError;
  }
}



class UserNameValidator implements Validator {
  static String? validator(String? name) {
    return name!.isEmpty ? AppStrings.usernameIsRequired : null;
  }
}

class EmailValidator implements Validator {
  static String? validator(String? email) {
    return email!.isEmpty
        ? AppStrings.emailIsRequired
        : AppStrings.emailRegExp.hasMatch(email)
        ? null
        : AppStrings.invalidEmailAddress;
  }
}

class OTPFieldValidator implements Validator {
  static String? validator(String? otpField) {
    return otpField == null
        ? ''
        : otpField.isEmpty
        ? ''
        : otpField.length == 4
        ? null
        : '';
  }
}

class DobValidator implements Validator {
  static String? validator(String? name) {
    return name!.isEmpty ? AppStrings.dateOfBirthIsRequired : null;
  }
}

class EmptyDateFieldValidator implements Validator {
  static String? validator(String? dateTime) {
    if (dateTime == null || dateTime.isEmpty) {
      return AppStrings.emptyFieldIsRequired;
    }
    return null;
  }
}

class EmptyListValidator implements Validator {
  static String? validator(String? dateTime) {
    if (dateTime == null || dateTime.isEmpty) {
      return AppStrings.emptyFieldIsRequired;
    }
    return null;
  }
}

class GenderValidator implements Validator {
  static String? validator(name) {
    return name == null ? AppStrings.genderIsRequired : null;
  }
}

class PhoneValidator implements Validator {
  static String? validator(String? phone) {
    return phone!.isEmpty ? AppStrings.phoneNumberIsRequired : null;
  }
}

class TrueValidator implements Validator {
  static String? validator(bool? value) {
    if (value == null) {
      return AppStrings.agreeToTermsIsRequired;
    }
    return value ? null : AppStrings.agreeToTermsIsRequired;
  }
}

class DynamicFieldValidator implements Validator {
  static String? validator(dynamic file) {
    if (file == null) {
      return AppStrings.emptyFieldIsRequired;
    }
    return null;
  }
}

class EmptyFieldValidator implements Validator {
  static String? validator(dynamic string) {
    if (string == null) {
      return AppStrings.emptyFieldIsRequired;
    }
    return string.toString().isNotEmpty ? null : AppStrings.emptyFieldIsRequired;
  }
}

class LoyaltyPointsValidator implements Validator {
  static String? validator(
      double? pointsValue, double total, double? maxAllowedPoints) {
    if (pointsValue == null) {
      return AppStrings.emptyFieldIsRequired;
    }

    // Assuming pointsValue can be converted to double, you can add more validation checks here
    double enteredPoints = pointsValue ?? 0.0;

    if (maxAllowedPoints != null && enteredPoints > maxAllowedPoints) {
      return 'Redeemed points cannot be greater than $maxAllowedPoints';
    }

    if (pointsValue > total) {
      return 'Redeemed points cannot be greater than $total';
    }

    return null;
  }
}

class DoneQuantityValidator implements Validator {
  static String? validator(
      String doneQty, String demandQty, String availableQty) {
    return doneQty.isEmpty || availableQty.isEmpty
        ? ''
        : int.parse(doneQty) <= int.parse(availableQty) &&
        int.parse(doneQty) <= int.parse(demandQty)
        ? null
        : '';
  }
}

class MaxQuantityValidator implements Validator {
  static String? validator(String? maxQty, String? minQty, bool allowEmpty) {
    if (allowEmpty) {
      if (maxQty!.isEmpty || minQty!.isEmpty) {
        return null;
      } else {
        return int.parse(maxQty) >= int.parse(minQty) ? null : '';
      }
    }
    return maxQty!.isEmpty || minQty!.isEmpty
        ? ''
        : int.parse(maxQty) >= int.parse(minQty)
        ? null
        : '';
  }
}