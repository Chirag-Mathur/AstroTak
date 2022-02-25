import 'package:astrotak/bloc/question_bloc/questions_bloc.dart';
import 'package:astrotak/bloc/relative_bloc/relatives_bloc.dart';
import 'package:astrotak/repository/api_repository.dart';
import 'package:astrotak/screens/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  ApiRepository apiRepository = ApiRepository();

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      
      providers: [
        BlocProvider(
          create: (context) => QuestionsBloc(apiRepository),
        ),
        BlocProvider(
          create: (context) => RelativesBloc(apiRepository),
        ),
      ],

      child: MaterialApp(
        home: Scaffold(
          body: Home(),
        ),
      ),
    );
  }
}
