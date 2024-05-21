import 'package:go_router/go_router.dart';
import 'package:task_manager_app/ui/screens/home/home.dart';
import 'package:task_manager_app/ui/screens/login/login.dart';
import 'package:task_manager_app/ui/screens/splash/splash.dart';

abstract class AppRouter {
  static const kHomePage = '/homeView';
  static const kLogInPage = '/kLogInPage';

  static final router = GoRouter(
    routes: [
      GoRoute(
        path: "/",
        builder: (context, state) => const SplashPage(),
      ),
      GoRoute(
        path: "/homeView",
        builder: (context, state) => const HomePage(),
      ),
      GoRoute(
        path: "/kLogInPage",
        builder: (context, state) => const LogInPage(),
      ),
    ],
  );
}
