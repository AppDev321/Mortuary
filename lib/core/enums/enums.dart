

enum LoginType { email, phone }

enum LoadingState { loading, loaded, error }


enum UserTypes {
  authorized("Authorized Person"),
  transport("Transportation"),
  processingUnit("Processing Center"),
  admin("Admin"),
  superAdmin("Super Admin");




  const UserTypes(this.displayName);
  final String displayName;

  @override
  String toString() => displayName;
}
