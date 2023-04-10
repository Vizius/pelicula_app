
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:pelicula_app/helper/debouncer.dart';
import 'package:pelicula_app/models/models.dart';
import 'package:pelicula_app/models/search_response.dart';

class MoviesProvider extends ChangeNotifier{

  final _apikey = "apikey";
  final _baseUrl = "api.themoviedb.org";
  final _language = "es-MX";

  List<Movie> onDisplayMovies =[];
  List<Movie> popularMovies =[];
  Map<int, List<Cast>> castMovies ={};

  final debunce = Debouncer(duration: Duration(milliseconds: 500));

  final StreamController<List<Movie>> _suggestuionStreamController = new StreamController.broadcast();
  Stream<List<Movie>> get suggestionStream => this._suggestuionStreamController.stream;

  int _popularPage=0;

  MoviesProvider()
  {
    print("movies inicializado");

    this.getOnDisplayMovies();
    this.getPopularmovies();

  }

  Future <String> _getJsonData( String endpoint, [int page =1])async
  {
    
    final url = Uri.https(_baseUrl, '$endpoint', 
    {
    "api_key":_apikey, 
    "language": _language, 
    "page":"$page"
    });


    final response = await http.get(url);
    return response.body;
  }


  getOnDisplayMovies() async
  {
    final jsonData = await this._getJsonData("/3/movie/now_playing");
    final nowplayingresponse = NowPlayingResponse.fromJson(jsonData);

    onDisplayMovies = nowplayingresponse.results;

    notifyListeners();
  }

  getPopularmovies()async{

    _popularPage++;

    final jsonData = await this._getJsonData("/3/movie/popular",_popularPage);

    final popularresponse = PopularResponse.fromJson(jsonData);

    popularMovies = [...popularMovies, ...popularresponse.results];

    notifyListeners();

  }
  Future <List<Cast>> getCastmovies(int moviId)async{

    
    if (castMovies.containsKey(moviId))return castMovies[moviId]!;

    final jsonData = await this._getJsonData("/3/movie/$moviId/credits",_popularPage);

    final castresponse = CreditsResponse.fromJson(jsonData);

    castMovies[moviId] = castresponse.cast;

    return castresponse.cast;

  }

  Future <List<Movie>>searchMovie(String query) async
  {
    final url = Uri.https(_baseUrl, '3/search/movie', 
    {
    "api_key":_apikey, 
    "language": _language, 
    "query":"$query"
    });

    final response = await http.get(url);
    final searchresponse = SearchResponse.fromJson(response.body);

    return searchresponse.results;

  }

  void getSuggestionQuery (String searchMov)
  {
    debunce.value ="";
    debunce.onValue =(value) async {

      final results = await this.searchMovie(value);
      this._suggestuionStreamController.add(results);


    };

    final timer = Timer.periodic(Duration(milliseconds: 300), (_) {debunce.value = searchMov; });

    Future.delayed(Duration(milliseconds: 301)).then((_) => timer.cancel()); 
  }




}