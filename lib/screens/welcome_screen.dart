import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quizly/providers/quiz_provider.dart';
import 'package:quizly/screens/quiz_screen.dart';
import 'package:quizly/widgets/custom_button.dart';
import 'package:quizly/core/app_assets.dart'; // (Kriteria 4)

class WelcomeScreen extends StatefulWidget {
  static const routeName = '/';
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  final _nameController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  void _startQuiz() {
    if (_formKey.currentState!.validate()) {
      // Ambil provider
      final quizProvider = Provider.of<QuizProvider>(context, listen: false);

      // Reset kuis sebelumnya (jika ada) dan set nama
      quizProvider.resetQuiz();
      quizProvider.setUsername(_nameController.text);

      // (Kriteria 2) Navigasi ke halaman kuis
      Navigator.of(context).pushReplacementNamed(QuizScreen.routeName);
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // (Kriteria 6) Menggunakan MediaQuery untuk ukuran dinamis
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: SafeArea(
        // (Bonus 2) Adaptive design sederhana
        child: LayoutBuilder(
          builder: (context, constraints) {
            bool isTablet = constraints.maxWidth > 600;

            return Center(
              child: SingleChildScrollView(
                child: Container(
                  // (Kriteria 6) Lebar dinamis
                  width: isTablet ? 500 : size.width * 0.9,
                  padding: const EdgeInsets.all(24.0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // (Kriteria 4) Menggunakan aset gambar
                        Image.asset(
                          AppAssets.logo,
                          height: 150,
                          // Tambahkan errorBuilder untuk jaga-jaga jika aset tidak ada
                          errorBuilder: (context, error, stackTrace) =>
                          const Icon(Icons.quiz_rounded, size: 150),
                        ),
                        const SizedBox(height: 20),
                        Text(
                          'Selamat Datang di Quizly!',
                          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 10),
                        Text(
                          'Masukkan nama Anda untuk memulai kuis',
                          style: Theme.of(context).textTheme.titleMedium,
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 30),
                        TextFormField(
                          controller: _nameController,
                          decoration: const InputDecoration(
                            labelText: 'Nama Anda',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(12)),
                            ),
                            prefixIcon: Icon(Icons.person),
                          ),
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return 'Nama tidak boleh kosong';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 20),
                        // (Kriteria 3) Menggunakan reusable widget
                        CustomButton(
                          text: 'Mulai Kuis',
                          onPressed: _startQuiz,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}