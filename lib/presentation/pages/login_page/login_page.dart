import 'package:flix_tix/presentation/pages/main_page/main_page.dart';
import 'package:flix_tix/presentation/providers/usecase/login_provider.dart';
import 'package:flix_tix/domain/usecases/login/login.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class LoginPage extends HookConsumerWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    void handleLogin() {
      Login logn = ref.watch(loginProvider);

      logn(
        LoginBody(email: 'fake@mail.dev', password: 'pw'),
      ).then((value) => {
            if (value.isSuccess)
              {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => MainPage(user: value.data!),
                  ),
                )
              }
            else
              {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(value.error!),
                  ),
                )
              }
          });
    }

    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: handleLogin,
          child: const Text('Login'),
        ),
      ),
    );
  }
}
