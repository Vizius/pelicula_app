import 'package:flutter/material.dart';

import '../models/models.dart';

class MovieSlider extends StatefulWidget {

  final List<Movie> movies2;
  final Function nextpage;

  const MovieSlider({
    super.key, 
    required this.movies2, 
    required this.nextpage
  });

  @override
  State<MovieSlider> createState() => _MovieSliderState();
}

class _MovieSliderState extends State<MovieSlider> {

  final ScrollController scrollcontroler = new ScrollController();

@override
  void initState() {
    // TODO: implement initState
    super.initState();

    scrollcontroler.addListener(() {
      if(scrollcontroler.position.pixels >=scrollcontroler.position.maxScrollExtent - 500)
      {
        widget.nextpage();
      }
      
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    
    return Container(
      
      width: double.infinity,
      height: 260,

      child: Column(
        
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),

           child: Text("Populares", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),)

          
          ),
          
          SizedBox(height: 5,),

          Expanded(
            
            child: ListView.builder(
              controller: scrollcontroler,
              scrollDirection: Axis.horizontal,
              itemCount: widget.movies2.length,
              itemBuilder: (_,int index)  => _MoviePoster(widget.movies2[index], "${widget.movies2[index].title}-${index}-${widget.movies2[index].id}")
          

            )
            ),
          

        ]
        
      ),


    );
  }
}
class _MoviePoster extends StatelessWidget {

  final Movie movi;
  final String heroId;
  
  
  const _MoviePoster(
     this.movi, 
     this.heroId 
  );

  
  @override
  Widget build(BuildContext context) {

    movi.heroId = heroId;
    
    return Container(
      width: 130,
      height: 190,
      margin: EdgeInsets.symmetric(horizontal: 20),
      
      child: Column(
        
        children: [

          GestureDetector(
            onTap: () => Navigator.pushNamed(context,"detail",arguments: movi),
            child: Hero(
              tag: movi.heroId!,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: FadeInImage(
                  placeholder: AssetImage("assets/no-image.jpg"), 
                  image: NetworkImage(movi.fullpostimg),
                  height: 180,
                  width: 190,
                  fit: BoxFit.cover,
                
                ),
              ),
            ),
          ),

          SizedBox(height: 5),

          Text(
          movi.title, 
          overflow: TextOverflow.ellipsis, 
          maxLines: 2,
          textAlign: TextAlign.center,),

          

        ]
      ),
    );
  }
}
