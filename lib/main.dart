import 'package:flutter/material.dart';
import 'config/dependencies.dart';
import 'routing/app_router.dart';

void main() {
  runApp(const MyApp());
}

/// アプリのルート Widget
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Provider による依存関係をルートに配置し、MaterialApp.router に渡す
    return buildDependencies(
      child: MaterialApp.router(
        title: 'GitHub Issues',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        ),
        routerConfig: appRouter,
      ),
    );
  }
}
