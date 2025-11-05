import 'package:flutter/material.dart';
import 'package:quizly/data/dummy_question.dart';
import 'package:quizly/models/question.dart';

class QuizProvider with ChangeNotifier {
  String _username = '';
  final List<Question> _questions = DUMMY_QUESTIONS;
  int _currentQuestionIndex = 0;
  final Map<int, String> _selectedAnswers = {};
  int _score = 0;

  // Getters
  String get username => _username;
  List<Question> get questions => _questions;
  int get currentQuestionIndex => _currentQuestionIndex;
  Question get currentQuestion => _questions[_currentQuestionIndex];
  int get score => _score;
  int get totalQuestions => _questions.length;
  String? get currentAnswer => _selectedAnswers[_currentQuestionIndex];

  void setUsername(String name) {
    _username = name;
    notifyListeners();
  }

  void selectAnswer(String answer) {
    _selectedAnswers[_currentQuestionIndex] = answer;
    notifyListeners();
  }

  void nextQuestion(BuildContext context) {
    if (_currentQuestionIndex < _questions.length - 1) {
      _currentQuestionIndex++;
      notifyListeners();
    } else {
      // Selesai kuis, hitung skor dan navigasi
      _calculateScore();
      Navigator.pushReplacementNamed(context, '/result');
    }
  }

  void _calculateScore() {
    _score = 0;
    _selectedAnswers.forEach((index, answer) {
      if (_questions[index].correctAnswer == answer) {
        _score++;
      }
    });
    // Tidak perlu notifyListeners() jika langsung navigasi,
    // tapi aman jika ada listener lain di ResultScreen
    notifyListeners();
  }

  void resetQuiz() {
    _username = '';
    _currentQuestionIndex = 0;
    _selectedAnswers.clear();
    _score = 0;
    // Kita tidak notifikasi agar nama di WelcomeScreen bisa di-reset
  }
}