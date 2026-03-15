import 'package:go_router/go_router.dart';
import '../ui/issue/widgets/issue_list_screen.dart';
import 'routes.dart';

/// アプリのルーター設定
final GoRouter appRouter = GoRouter(
  // 初期ルートは Issue 一覧画面
  initialLocation: Routes.issues,
  routes: [
    // Issue 一覧画面
    GoRoute(
      path: Routes.issues,
      builder: (context, state) => const IssueListScreen(),
    ),
  ],
);
