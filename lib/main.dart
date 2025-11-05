import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quizly/providers/quiz_provider.dart';
import 'package:quizly/screens/quiz_screen.dart';
import 'package:quizly/screens/result_screen.dart';
import 'package:quizly/screens/welcome_screen.dart';
import 'package:quizly/core/app_theme.dart';

void main() {
  runApp(
    // (Kriteria 7) Menggunakan Provider sebagai state management
    ChangeNotifierProvider(
      create: (context) => QuizProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Quizly',
      debugShowCheckedModeBanner: false,

      // (Kriteria 5 & Bonus 1) Menerapkan Font Kustom dan Dual Theme
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.system, // Otomatis Ganti

      // (Kriteria 2) Navigasi antar halaman
      initialRoute: WelcomeScreen.routeName,
      routes: {
        WelcomeScreen.routeName: (context) => const WelcomeScreen(),
        QuizScreen.routeName: (context) => const QuizScreen(),
        ResultScreen.routeName: (context) => const ResultScreen(),
      },
    );
  }
}