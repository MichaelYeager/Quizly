import 'package:quizly/models/question.dart';

const List<Question> DUMMY_QUESTIONS = [
  Question(
    id: 'q1',
    text: 'Apa framework UI yang dikembangkan oleh Google untuk membangun aplikasi mobile, web, dan desktop dari satu basis kode?',
    options: ['React Native', 'Flutter', 'SwiftUI', 'Kotlin'],
    correctAnswer: 'Flutter',
  ),
  Question(
    id: 'q2',
    text: 'Bahasa pemrograman apa yang digunakan oleh Flutter?',
    options: ['Dart', 'JavaScript', 'Python', 'Java'],
    correctAnswer: 'Dart',
  ),
  Question(
    id: 'q3',
    text: 'Widget apa yang digunakan untuk membuat layout dengan scrolling?',
    options: ['Column', 'Row', 'ListView', 'Container'],
    correctAnswer: 'ListView',
  ),
  Question(
    id: 'q4',
    text: 'Untuk mengelola state secara sederhana di Flutter, kita bisa menggunakan...?',
    options: ['StatefulWidget', 'Provider', 'Bloc', 'Semua benar'],
    correctAnswer: 'Semua benar',
  ),
];