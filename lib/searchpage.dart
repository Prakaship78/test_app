import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'bloc/search_bloc.dart';
import 'bloc/search_event.dart';
import 'bloc/search_state.dart';
import 'package:imdb/data/models/api_result_model.dart';
import 'SearchdetailPage.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  SearchBloc searchBloc;
  var titleController = TextEditingController();
  String id;

  var _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    searchBloc = BlocProvider.of<SearchBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    return Material(
        child: Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        leading: Image(image: AssetImage('assets/logo2.png')),
        backgroundColor: Colors.transparent,
        actions: [
          IconButton(
              icon: Icon(Icons.home),
              onPressed: () {
                BlocProvider.of<SearchBloc>(context).add(ResetSearchEvent());
              })
        ],
      ),
      body: Form(
        key: _formKey,
        child: Container(
          child: BlocListener<SearchBloc, SearchState>(
            listener: (context, state) {
              if (state is SearchErrorState) {
                return Scaffold.of(context).showSnackBar(SnackBar(
                  content: Text(state.message),
                ));
              }
            },
            child: BlocBuilder<SearchBloc, SearchState>(
              builder: (context, state) {
                if (state is SearchInitialState) {
                  return Container(
                      padding: EdgeInsets.only(left: 10, right: 10),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image(
                            image: AssetImage('assets/logo.png'),
                            width: 200,
                            height: 200,
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          TextFormField(
                            controller: titleController,
                            decoration: InputDecoration(
                                suffixIcon: FlatButton(
                                  onPressed: () {
                                    if (titleController.text != null) {
                                      return searchBloc.add(SearchMovieEvent(
                                          titleController.text));
                                    }
                                  },
                                  child: Icon(
                                    Icons.search,
                                    color: Colors.white60,
                                  ),
                                ),
                                enabledBorder: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(20)),
                                    borderSide: BorderSide(
                                        color: Colors.yellow,
                                        style: BorderStyle.solid)),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20)),
                                  borderSide: BorderSide(
                                      color: Colors.yellow,
                                      style: BorderStyle.solid),
                                ),
                                hintText: 'Search Movie',
                                labelText: 'Movie name',
                                hintStyle: TextStyle(color: Colors.white)),
                            style: TextStyle(color: Colors.white),
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'You cannot leave this blank';
                              }
                              value = value.toUpperCase();
                            },
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Container(
                            width: 200,
                            height: 50,
                            child: FlatButton(
                              shape: new RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20))),
                              onPressed: () {
                                if (_formKey.currentState.validate()) {
                                  return searchBloc.add(
                                      SearchMovieEvent(titleController.text));
                                }
                              },
                              color: Colors.lightBlue,
                              child: Text(
                                "Search",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 18),
                              ),
                            ),
                          )
                        ],
                      ));
                } else if (state is SearchLoadingState) {
                  return buildLoading();
                } else if (state is SearchLoadedState) {
                  return buildSearchList(state.search);
                } else if (state is SearchErrorState) {
                  return buildErrorUi(state.message);
                }
              },
            ),
          ),
        ),
      ),
    ));
  }
}

Widget buildLoading() {
  return Center(
    child: CircularProgressIndicator(),
  );
}

Widget buildErrorUi(String message) {
  return Center(
    child: Padding(
      padding: EdgeInsets.all(10),
      child: Text(
        message,
        style: TextStyle(color: Colors.red),
      ),
    ),
  );
}

Widget buildSearchList(List<Search> search) {
  if (search != null) {
    return ListView.builder(
      itemCount: search.length,
      itemBuilder: (context, pos) {
        return Padding(
          padding: EdgeInsets.all(10),
          child: InkWell(
            child: ListTile(
                leading: Image(
                  image: NetworkImage(search[pos].poster),
                ),
                title: Text(
                  '${search[pos].title} (${search[pos].year})',
                  style: TextStyle(fontSize: 18),
                ),
                subtitle: Text(search[pos].type)),
            onTap: () {
              navigateToSearchDetailPage(context, search[pos]);
            },
          ),
        );
      },
    );
  } else {
    return Container(
      child: Center(
        child: Text(
          'No result Found ',
          style: TextStyle(color: Colors.white, fontSize: 18),
        ),
      ),
    );
  }
}

void navigateToSearchDetailPage(BuildContext context, Search search) {
  Navigator.push(context, MaterialPageRoute(
    builder: (context) {
      return SearchdeatilPage(
        search: search,
      );
    },
  ));
}
