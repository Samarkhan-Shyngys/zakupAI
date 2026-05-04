import 'package:flutter/material.dart';
import 'core/theme/app_theme.dart';
import 'presentation/screens/role_selection_screen.dart';

void main() => runApp(const ZakupAIApp());

class ZakupAIApp extends StatelessWidget {
  const ZakupAIApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ЗакупАИ',
      theme: AppTheme.light,
      home: const RoleSelectionScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
