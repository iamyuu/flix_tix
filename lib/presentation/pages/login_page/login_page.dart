import 'package:flix_tix/presentation/router/router_provider.dart';
import 'package:flix_tix/presentation/user_data/user_data_provider.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class LoginPage extends ConsumerWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen(userDataProvider, (previous, next) {
      if (next is AsyncData) {
        if (next.value != null) {
          ref.read(routerProvider).goNamed('main');
        }
      } else if (next is AsyncError) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              next.error.toString(),
            ),
          ),
        );
      }
    });

    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            ref
                .read(userDataProvider.notifier)
                .login(email: 'fake@mail.dev', password: 'pw');
          },
          child: const Text('Login'),
        ),
      ),
    );
  }
}
