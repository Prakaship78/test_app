import 'package:imdb/data/models/api_result_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

abstract class SearchRepository {
  Future<List<Search>> getMovie(String title);
}

class SearchRepositoryImpl extends SearchRepository {
  @override
  Future<List<Search>> getMovie(String title) async {
    var response =
        await http.get('http://www.omdbapi.com/?s=$title&apikey=30c25eab');
    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      List<Search> search = ApiResultModel.fromJson(data).search;
      print(search);
      return search;
    } else {
      throw Exception();
    }
  }
}
