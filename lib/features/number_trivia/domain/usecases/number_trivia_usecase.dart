

import '../repositories/number_trivia_repository.dart';

abstract class NumberTriviaUseCase {
  final NumberTriviaRepository numberTriviaRepository;
  NumberTriviaUseCase(this.numberTriviaRepository);
}