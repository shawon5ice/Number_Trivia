import 'package:ca_number_trivia/core/theme/theme_constant.dart';
import 'package:ca_number_trivia/core/theme/theme_manager.dart';
import 'package:ca_number_trivia/features/number_trivia/presentation/bloc/number_trivia_bloc.dart';
import 'package:ca_number_trivia/features/number_trivia/presentation/pages/number_trivia.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'core/di/app_component.dart';

void main() async {
  runApp(const MyApp());

  await AppComponent().init();
}

ThemeManager _themeManager = ThemeManager();


class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: _themeManager.themeMode,
      home: BlocProvider(
        create: (context) => NumberTriviaBloc(),
        child: const NumberTriviaPage(),
      ),
    );
  }
}
