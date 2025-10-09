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
        id: 'bibleReadingPreference',
        title: 'When you read the Bible, what\'s most helpful for you?',
        description: 'Find a Church',
        type: 'single-select',
        options: [
          const QuestionOptionModel(
            value: 'More Scripture',
            label: 'More Scripture',
            subtitle: 'Focused on reading large sections of the text',
          ),
          const QuestionOptionModel(
            value: 'Life Application',
            label: 'Life Application',
            subtitle: 'Practical guidance for everyday life',
          ),
          const QuestionOptionModel(
            value: 'Balanced',
            label: 'Balanced',
            subtitle: 'A mix of both Scripture and life application',
          ),
        ],
      ),
    ];
  }
}
