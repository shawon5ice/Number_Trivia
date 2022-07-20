import '../../data/models/NumberTrivia.dart';

abstract class NumberTriviaRepository{
  Future<NumberTrivia?> getCustomNumberTrivia(int number);
  Future<NumberTrivia?> getRandomNumberTrivia();
}