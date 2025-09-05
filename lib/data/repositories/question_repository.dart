import '../models/question_model.dart';
import '../services/database_service.dart';

class QuestionRepository {
  Future<List<Category>> getCategories() {
    return DatabaseService.instance.getCategories();
  }

  Future<List<Question>> getQuestions(List<int> categoriesIds) {
    return DatabaseService.instance.getQuestions(categoriesIds);
  }
}