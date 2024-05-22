

enum LoginType { email, phone }

enum LoadingState { loading, loaded, error }

enum UserTypes { authorized, transport, processingUnit }


enum Gender {
  male("Male"),
  female("Female"),
  other("Other");

  const Gender(this.displayName);

  final String displayName;

  @override
  String toString() => displayName;
}
