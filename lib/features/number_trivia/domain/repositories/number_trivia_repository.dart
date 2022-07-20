import '../../../../core/data/model/api_response.dart';
import '../../data/models/NumberTrivia.dart';

abstract class NumberTriviaRepository{
  Future<Response<NumberTrivia>?> getCustomNumberTrivia(int number);
  Future<Response<NumberTrivia>?> getRandomNumberTrivia();
}