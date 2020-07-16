import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:imdb/data/models/api_result_model.dart';
import 'package:meta/meta.dart';

abstract class SearchState extends Equatable {}

class SearchInitialState extends SearchState {
  @override
  List<Object> get props => [];
}

class SearchLoadingState extends SearchState {
  @override
  List<Object> get props => [];
}

class SearchLoadedState extends SearchState {
  List<Search> search;
  SearchLoadedState({@required this.search});
  @override
  List<Object> get props => throw UnimplementedError();
}

class SearchErrorState extends SearchState {
  String message;
  SearchErrorState({@required this.message});
  @override
  List<Object> get props => throw UnimplementedError();
}
