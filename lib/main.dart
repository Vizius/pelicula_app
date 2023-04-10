import 'package:flutter/material.dart';
import 'package:pelicula_app/provider/movies_provider.dart';
import 'package:pelicula_app/screens/screens.dart';
import 'package:provider/provider.dart';


void main() => runApp(AppState());

class AppState extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers:[

        ChangeNotifierProvider(create: (_) => MoviesProvider(), lazy: false,)


      ],
      child: MyApp(),
    );
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Peliculas',
      initialRoute: "home",
      routes: {
        "home":( _ )=> HomeScreen(),
        "detail":( _ )=> DetailsScreen(),
      },
    );
  }
}