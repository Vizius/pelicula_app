
import 'package:flutter/material.dart';
import 'package:pelicula_app/models/models.dart';
import 'package:pelicula_app/provider/movies_provider.dart';
import 'package:provider/provider.dart';

class MovieSearchDelegate extends SearchDelegate{

  @override
  String get searchFieldLabel => "Buscar";
  
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [IconButton(onPressed: () => query ="", icon: Icon(Icons.clear))];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(onPressed: () => close(context, null), icon: Icon(Icons.arrow_back));
  }

  @override
  Widget buildResults(BuildContext context) {
    return Text("build result");
  }

  Widget _empycontainer(){

      return Container(
        child: Center(
          child: Icon(Icons.movie_creation,color: Colors.black38,size: 130,)
        ),
      );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    if (query.isEmpty)
    {
      return _empycontainer();
    }

    final moviesProvider = Provider.of<MoviesProvider>(context, listen: false);
    moviesProvider.getSuggestionQuery(query);

    return StreamBuilder(
      stream: moviesProvider.suggestionStream,
      builder: (context, AsyncSnapshot<List<Movie>> snapshot) {

        if(!snapshot.hasData) return _empycontainer();
      
        final movie = snapshot.data!;

        return ListView.builder(
          itemCount: movie.length,
          itemBuilder: (context, index) => _MovieItem( movie[index]),);
        
      },);
    
  }



}

class _MovieItem extends StatelessWidget {
  
  final Movie movie;
  const _MovieItem(this.movie);

  @override
  Widget build(BuildContext context) {

    movie.heroId = "search-${movie.id}"; 

    return ListTile(
      leading: Hero(
        tag: movie.heroId!,
        child: FadeInImage(
          placeholder: AssetImage("assets/no-image.jpg"), 
          image:NetworkImage(movie.fullpostimg) ,
          width: 70,fit: BoxFit.contain,),
      ),
        title: Text(movie.title),
        subtitle: Text(movie.originalTitle),
        onTap: () => Navigator.pushNamed(context,"detail",arguments: movie),

    );
  }
}