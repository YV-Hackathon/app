import 'package:go_router/go_router.dart';
import '../../features/auth/presentation/pages/login_page.dart';

final appRouter = GoRouter(
  initialLocation: '/login',
  routes: [
    GoRoute(
      path: '/login',
      name: 'login',
      builder: (context, state) => const LoginPage(),
    ),
    // Add more routes here as you create pages
  ],
);
