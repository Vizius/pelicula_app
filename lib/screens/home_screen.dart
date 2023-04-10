import 'package:flutter/material.dart';
import 'package:pelicula_app/provider/movies_provider.dart';
import 'package:pelicula_app/search/search_delegate.dart';
import 'package:pelicula_app/widgets/widgets.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {

    final moviesprovider = Provider.of<MoviesProvider>(context, listen: true);

    


    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Peliculas en cines"),
        elevation: 0,
        actions: [
          IconButton(icon: Icon( Icons.search_outlined),
            onPressed:() => showSearch(context: context, delegate: MovieSearchDelegate()), ), 
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
        children: [
          //tarjetas principales
          CardSwiper(movies: moviesprovider.onDisplayMovies,),

          //slider de peliculas
          MovieSlider(movies2: moviesprovider.popularMovies, nextpage:()=>moviesprovider.getPopularmovies(),)
        ],
    ),)
    );
  }
}