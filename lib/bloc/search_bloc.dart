import 'package:bloc/bloc.dart';
import 'package:imdb/bloc/search_event.dart';
import 'package:imdb/bloc/search_state.dart';
import 'package:imdb/data/models/api_result_model.dart';
import 'package:imdb/data/repositories/search_repository.dart';
import 'package:meta/meta.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  SearchRepository repository;
  SearchBloc({@required this.repository});
  @override
  SearchState get initialState => SearchInitialState();

  @override
  Stream<SearchState> mapEventToState(SearchEvent event) async* {
    if (event is SearchMovieEvent) {
      yield SearchLoadingState();
      try {
        List<Search> search = await repository.getMovie(event.title);
        yield SearchLoadedState(search: search);
      } catch (e) {
        SearchErrorState(message: e.toString());
      }
    } else if (event is ResetSearchEvent) {
      yield SearchInitialState();
    }
  }
}
