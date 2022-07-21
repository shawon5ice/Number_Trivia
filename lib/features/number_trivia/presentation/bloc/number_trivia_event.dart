part of 'number_trivia_bloc.dart';

@immutable
abstract class NumberTriviaEvent extends Equatable {}


class FetchRandomTriviaEvent extends NumberTriviaEvent {

  @override
  List<Object?> get props => [];
}


class FetchCustomTriviaEvent extends NumberTriviaEvent {
  final int number;

  FetchCustomTriviaEvent(this.number);

  @override
  List<Object?> get props => [number];
}

class InputFormValidation extends NumberTriviaEvent {
  final String? number;

  InputFormValidation(this.number);

  @override
  List<Object?> get props => [number];
}