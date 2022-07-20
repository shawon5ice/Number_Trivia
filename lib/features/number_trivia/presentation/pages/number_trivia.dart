import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/number_trivia_bloc.dart';

class NumberTriviaPage extends StatefulWidget {
  const NumberTriviaPage({Key? key}) : super(key: key);

  @override
  State<NumberTriviaPage> createState() => _NumberTriviaPageState();
}

class _NumberTriviaPageState extends State<NumberTriviaPage> {
  late NumberTriviaBloc _numberTriviaBloc;

  @override
  void initState() {
    super.initState();
    _numberTriviaBloc = BlocProvider.of<NumberTriviaBloc>(context);
    _numberTriviaBloc.stream.listen((state) {});
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NumberTriviaBloc, NumberTriviaState>(
      builder: (context, state) {
        return Column(
          children: [
            Card(
              child: Text(
               'Hello'
              ),
            )
          ],
        );
      },
    );
  }
}
