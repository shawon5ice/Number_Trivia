part of 'number_trivia_bloc.dart';

@immutable
abstract class NumberTriviaState extends Equatable {
}

class NumberTriviaInitial extends NumberTriviaState {
  @override
  List<Object?> get props => [];
}


class FetchTriviaSuccess extends NumberTriviaState{
  final String text;
  final String type;

  FetchTriviaSuccess({required this.text, required this.type});

  @override
  List<Object?> get props => [text,type];
}

class OnFailure extends NumberTriviaState {
  final String message;

  OnFailure(this.message);
  @override
  List<Object?> get props => [message];
}

class OnLoading extends NumberTriviaState {
  @override
  List<Object?> get props => [];
}

class InputFormValidationState extends NumberTriviaState {
  final String? message;

  InputFormValidationState(this.message);

  @override
  List<Object?> get props => [message];
}