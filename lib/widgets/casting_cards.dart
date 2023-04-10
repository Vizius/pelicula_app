import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pelicula_app/models/models.dart';
import 'package:pelicula_app/provider/movies_provider.dart';
import 'package:provider/provider.dart';

class CastingCards extends StatelessWidget {

  final int moviId;

  const CastingCards( this.moviId);

  
  @override
  Widget build(BuildContext context) {

    final moviesprovider = Provider.of<MoviesProvider>(context,listen: true);

    return FutureBuilder(
      future:  moviesprovider.getCastmovies(moviId),
      builder: (context, AsyncSnapshot<List<Cast>> snapshot){

      if (!snapshot.hasData){
        return Container(
          constraints: BoxConstraints(minWidth: 500),
          height: 180,
          child: CupertinoActivityIndicator(),
        );
      }
      final List<Cast> cast = snapshot.data!;

      return Container(
        margin: EdgeInsets.only(bottom: 30),
        width: double.infinity,
        height: 180,
        child: ListView.builder(
          itemCount: cast.length,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) => _CastCards(cast[index]),

        ),

      );
      
    });

  }
}

class _CastCards extends StatelessWidget {
  
  final Cast movId;

  const _CastCards(this.movId);
  
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10),
      width: 110,
      height: 100,

      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: FadeInImage(
              placeholder: AssetImage("assets/no-image.jpg"),
              image: NetworkImage(movId.fullprofilepath),
              height: 140,
              width: 100,
              fit: BoxFit.cover,
              
            ),
          ),
          SizedBox(height: 5,),
          Text(movId.name, maxLines: 2,
          overflow: TextOverflow.ellipsis,
          textAlign: TextAlign.center,)
        ],
      ),

    );
  }
}