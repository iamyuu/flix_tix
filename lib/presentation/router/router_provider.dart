import 'package:flix_tix/presentation/pages/login_page/login_page.dart';
import 'package:flix_tix/presentation/pages/main_page/main_page.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:go_router/go_router.dart';

part 'router_provider.g.dart';

@Riverpod(keepAlive: true)
Raw<GoRouter> router(RouterRef ref) => GoRouter(
      debugLogDiagnostics: false,
      initialLocation: '/',
      routes: [
        GoRoute(
          path: '/',
          pageBuilder: (context, state) => MainPage(),
        ),
        GoRoute(
          path: '/login',
          pageBuilder: (context, state) => LoginPage(),
        ),
      ],
    );
