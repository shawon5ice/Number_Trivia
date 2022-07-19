import 'package:ca_number_trivia/features/number_trivia/domain/entities/number_trivia.dart';
import '../../../../core/data/model/api_response.dart';

abstract class NumberTriviaRepository{
  Future<Response<NumberTrivia>?> getCustomNumberTrivia(int number);
  Future<Response<NumberTrivia>?> getRandomNumberTrivia();
}