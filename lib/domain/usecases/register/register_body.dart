part of 'register.dart';

class RegisterBody {
  final String name;
  final String email;
  final String password;
  final String? photoUrl;

  RegisterBody({
    required this.name,
    required this.email,
    required this.password,
    this.photoUrl,
  });
}
