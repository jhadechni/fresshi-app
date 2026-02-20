import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fresshi/core/logging/logging.dart';
import 'package:fresshi/routes/app_router.dart';
import 'package:fresshi/shared/ui/theme/app_theme.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  initializeLogging();
  runApp(
    const ProviderScope(
      child: FresshiApp(),
    ),
  );
}

class FresshiApp extends StatelessWidget {
  const FresshiApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Fresshi',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      routerConfig: appRouter,
      
    );
  }
}
