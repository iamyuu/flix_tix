abstract interface class AuthenticationRepository {
  Future<void> signUpWithCredentials(String email, String password);

  Future<void> logInWithCredentials(String email, String password);

  Future<void> logOut();

  Future<bool> isSignedIn();

  Future<String> getUser();
}
