import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quizly/providers/quiz_provider.dart';
import 'package:quizly/screens/welcome_screen.dart';
import 'package:quizly/widgets/custom_button.dart';

class ResultScreen extends StatelessWidget {
  static const routeName = '/result';
  const ResultScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Menggunakan 'read' karena hanya menampilkan data sekali
    final quizProvider = context.read<QuizProvider>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Hasil Kuis'),
        automaticallyImplyLeading: false, // Sembunyikan tombol back
      ),
      body: Center(
        // (Kriteria 6) Menggunakan ukuran dinamis
        child: Container(
          width: double.infinity,
          margin: const EdgeInsets.all(24.0),
          padding: const EdgeInsets.all(24.0),
          decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 10,
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Selamat, ${quizProvider.username}!',
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              Text(
                'Skor Akhir Anda:',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 10),
              Text(
                '${quizProvider.score} / ${quizProvider.totalQuestions}',
                style: Theme.of(context).textTheme.displayLarge?.copyWith(
                  color: Theme.of(context).primaryColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 30),
              // (Kriteria 3) Reusable widget
              CustomButton(
                text: 'Ulangi Kuis',
                onPressed: () {
                  // Provider tidak di-reset di sini, tapi di WelcomeScreen
                  Navigator.of(context).pushReplacementNamed(WelcomeScreen.routeName);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}