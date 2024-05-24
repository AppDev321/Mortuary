

enum LoginType { email, phone }

enum LoadingState { loading, loaded, error }

enum UserRole {
  emergency,
  transport,
  processingUnit,
  admin,
  superAdmin,
  volunteer,
  morgue,
  none
}

extension UserRoleExtension on UserRole {
  String get displayName {
    switch (this) {
      case UserRole.emergency:
        return "Emergency";
      case UserRole.transport:
        return "Transportation";
      case UserRole.processingUnit:
        return "Processing Center";
      case UserRole.admin:
        return "Admin";
      case UserRole.superAdmin:
        return "Super Admin";
      case UserRole.volunteer:
        return "Volunteer";
      case UserRole.morgue:
        return "Morgue";
      case UserRole.none:
        return "none";
    }
  }

  static UserRole fromString(String value) {
    for (var userType in UserRole.values) {
      if (userType.displayName == value) {
        return userType;
      }
    }
    return UserRole.none;
  }
}
