

import 'package:flutter/material.dart';
import 'package:pelicula_app/models/models.dart';
import 'package:pelicula_app/widgets/widgets.dart';

class DetailsScreen extends StatelessWidget {
  

  @override
  Widget build(BuildContext context) {

    final Movie movie = ModalRoute.of(context)!.settings.arguments as Movie;

    print(movie.title);

    return Scaffold(
      
      body: CustomScrollView(
        slivers: [

          _CustomAppbar(movie),
          SliverList(
            delegate: SliverChildListDelegate([

              _PosterAndTittle(movie),
              SizedBox(height: 15),
              _Overview(movie),
              SizedBox(height: 30),
              CastingCards(movie.id)

            ])
            
          )

        ],
      )
    );
    
  }
}

class _CustomAppbar extends StatelessWidget { 

  final Movie mov;

  const _CustomAppbar(this.mov);

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(

      backgroundColor: Colors.amber,
      expandedHeight: 200,
      floating: false,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        titlePadding: EdgeInsets.symmetric(horizontal: 10),
        centerTitle: true,
        title: Text(mov.title),
        background: FadeInImage(
         placeholder: AssetImage("assets/loading.gif"),
         image: NetworkImage(mov.fullbackpath),
         fit: BoxFit.cover,
        
        ),
      ),

    );
  }
}


class _PosterAndTittle extends StatelessWidget {
  
   final Movie mov2;

    const _PosterAndTittle(this.mov2);
 
   @override
   Widget build(BuildContext context) {

     final textTheme = Theme.of(context).textTheme;
     return Container(

      margin: EdgeInsets.only(top: 20),
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: 
      Row(
        
        children: [
          

        Hero(
          tag: mov2.heroId!,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: FadeInImage(
              placeholder: AssetImage("assets/no-image.jpg"),
              image: NetworkImage(mov2.fullpostimg),
              height: 150,
              ),
          ),
        ),

        SizedBox(width:20),

        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              
              Text(mov2.title, 
              style: textTheme.headline6,overflow: 
              TextOverflow.ellipsis, maxLines: 2,),
              Text(mov2.originalTitle, style: textTheme.subtitle1,overflow: TextOverflow.ellipsis,maxLines: 2,),
        
              Row(
                children: [
                  Icon(Icons.star_border,size: 15,color: Colors.amber[300],),
                  Text(mov2.voteAverage.toString() ,style: textTheme.caption,)
                ],
              )
        
            ],
          ),
        )
      ]),

     );


   }
 }

class _Overview extends StatelessWidget {
  final Movie mov3;

  const _Overview(this.mov3);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Container(
      padding: EdgeInsets.symmetric(horizontal:20, vertical: 10),
      child: Text(mov3.overview,
      textAlign: TextAlign.justify,
      style: textTheme.subtitle1,
      ),
      
    );
  }
}