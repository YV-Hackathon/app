import '../models/question_model.dart';
import '../models/question_option_model.dart';

abstract class QuestionLocalDataSource {
  Future<List<QuestionModel>> getQuestions();
}

class QuestionLocalDataSourceImpl implements QuestionLocalDataSource {
  @override
  Future<List<QuestionModel>> getQuestions() async {
    return [
      QuestionModel(
        id: '1',
        title: 'When you read the Bible, what\'s most helpful for you?',
        subtitle: 'Find a Church',
        options: [
          const QuestionOptionModel(
            id: '1',
            title: 'More Scripture',
            description: 'Focused on reading large sections of the text',
          ),
          const QuestionOptionModel(
            id: '2',
            title: 'Life Application',
            description: 'Practical guidance for everyday life',
          ),
          const QuestionOptionModel(
            id: '3',
            title: 'Balanced',
            description: 'A mix of both Scripture and life application.',
          ),
        ],
      ),
    ];
  }
}
