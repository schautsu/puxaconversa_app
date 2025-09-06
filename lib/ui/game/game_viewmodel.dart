import 'package:flutter/material.dart';
import 'package:appinio_swiper/appinio_swiper.dart';
import 'package:puxaconversa_app/data/models/question_model.dart';
import 'package:puxaconversa_app/data/repositories/question_repository.dart';

class GameViewModel extends ChangeNotifier {
  final AppinioSwiperController swiperController = AppinioSwiperController();
  final QuestionRepository _questionRepository = QuestionRepository();

  // Variáveis de estado
  List<Question> _shuffledQuestions = [];
  bool _isFinished = false;
  int _currentCardIndex = 0;

  // Getters para a View
  List<Question> get shuffledQuestions => _shuffledQuestions;
  bool get isFinished => _isFinished;
  bool get isPreviousButtonDisabled => _currentCardIndex == 0;

  // Carrega e embaralha as perguntas
  Future<void> loadQuestions(List<int> categoryIds) async {
    _shuffledQuestions = await _questionRepository.getQuestions(categoryIds);
    _shuffledQuestions.shuffle();

    notifyListeners(); // Notifica a UI
  }

  void unswipeCard() {
    swiperController.unswipe();

    if (_currentCardIndex > 0) {
      _currentCardIndex--;
    }
    // O jogo sairá do estado da mensagem de fim das cartas
    if (_isFinished) {
      _isFinished = false;

      notifyListeners(); // Notifica a UI
    }
  }

  void onCardSwiped(
    int previousIndex,
    int targetIndex,
    SwiperActivity activity,
  ) {
    _currentCardIndex = targetIndex;

    notifyListeners(); // Notifica a UI
  }

  void onCardsEnd() {
    _isFinished = true;
    notifyListeners(); // Notifica a UI
  }
}
