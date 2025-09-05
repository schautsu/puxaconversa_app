import 'package:flutter/material.dart';
import 'package:puxaconversa_app/data/models/question_model.dart';
import 'package:puxaconversa_app/data/repositories/question_repository.dart';

// Enum para os modos de seleção de categorias
enum SelectionMode { all, custom }

class CategorySelectionViewModel extends ChangeNotifier {
  final QuestionRepository _questionRepository = QuestionRepository();

  // Variáveis de estado
  SelectionMode _currentSelectionMode = SelectionMode.all;
  List<Category> _allCategories = [];
  final Set<int> _selectedCategoryIds = {};

  // Getters para a View
  List<Category> get allCategories => _allCategories;
  SelectionMode get selectionMode => _currentSelectionMode;

  bool isCategorySelected(int categoryId) =>
      _selectedCategoryIds.contains(categoryId);

  bool get isStartButtonDisabled =>
      _currentSelectionMode == SelectionMode.custom &&
      _selectedCategoryIds.isEmpty;

  // Obtém as categorias do BD
  Future<void> loadAllCategories() async {
    _allCategories = await _questionRepository.getCategories();

    notifyListeners(); // Notifica a UI
  }

  // Altera o modo de seleção de categorias (Todas/Personalizada)
  void setSelectionMode(SelectionMode mode) {
    if (_currentSelectionMode == mode) {
      return;
    }
    _currentSelectionMode = mode;
    // Ao alterar a seleção de Personalizada para Todas, limpa a seleção que tinha
    if (mode == SelectionMode.all) {
      _selectedCategoryIds.clear();
    }

    notifyListeners(); // Notifica a UI
  }

  // Marca/desmarca uma categoria (Personalizada)
  void toggleCategory(int categoryId) {
    if (_selectedCategoryIds.contains(categoryId)) {
      _selectedCategoryIds.remove(categoryId);
    } else {
      _selectedCategoryIds.add(categoryId);
    }

    notifyListeners();
  }

  List<int> getCategoriesIdsForGame() {
    // Cria uma lista de Ids das categorias selecionadas para o jogo
    if (_currentSelectionMode == SelectionMode.all) {
      return _allCategories.map((category) => category.id).toList();
    } else {
      return _selectedCategoryIds.toList();
    }
  }
}