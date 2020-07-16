import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:imdb/searchpage.dart';
import 'bloc/search_bloc.dart';
import 'data/repositories/search_repository.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'imdb',
      theme: ThemeData(
        brightness: Brightness.dark,
        primaryColorDark: Colors.black,
      ),
      home: BlocProvider(
        create: (context) => SearchBloc(repository: SearchRepositoryImpl()),
        child: SearchPage(),
      ),
    );
  }
}
