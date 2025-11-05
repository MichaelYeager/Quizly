import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quizly/providers/quiz_provider.dart';
import 'package:quizly/widgets/answer_option.dart';
import 'package:quizly/widgets/custom_button.dart';

class QuizScreen extends StatefulWidget {
  static const routeName = '/quiz';
  const QuizScreen({super.key});

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  // State lokal untuk UI (jawaban yang dipilih saat ini)
  String? _selectedOption;

  void _onOptionSelected(String option) {
    setState(() {
      _selectedOption = option;
    });
    // Langsung simpan ke provider
    Provider.of<QuizProvider>(context, listen: false).selectAnswer(option);
  }

  void _submit() {
    // Navigasi ke pertanyaan berikutnya
    Provider.of<QuizProvider>(context, listen: false).nextQuestion(context);
    // Reset pilihan lokal untuk pertanyaan baru
    setState(() {
      _selectedOption = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    // (Kriteria 7) Menggunakan 'watch' agar UI update saat state berubah
    final quizProvider = context.watch<QuizProvider>();
    final question = quizProvider.currentQuestion;

    // (Kriteria 7) Mengambil state jawaban dari provider saat build
    // Ini memastikan jawaban tetap ada saat rotasi layar
    _selectedOption = quizProvider.currentAnswer;

    return Scaffold(
      appBar: AppBar(
        title: Text('Quizly - Pertanyaan ${quizProvider.currentQuestionIndex + 1}/${quizProvider.totalQuestions}'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Box Pertanyaan
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Text(
                question.text,
                style: Theme.of(context).textTheme.headlineSmall,
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 30),

            // Pilihan Jawaban (Kriteria 3)
            ...question.options.map((option) {
              return AnswerOption(
                text: option,
                isSelected: _selectedOption == option,
                onTap: () => _onOptionSelected(option),
              );
            }).toList(),

            const SizedBox(height: 30),

            // Tombol Next (Kriteria 3)
            CustomButton(
              text: quizProvider.currentQuestionIndex == quizProvider.totalQuestions - 1
                  ? 'Lihat Skor'
                  : 'Selanjutnya',
              onPressed: _selectedOption == null ? null : _submit, // Nonaktif jika belum pilih
            ),
          ],
        ),
      ),
    );
  }
}