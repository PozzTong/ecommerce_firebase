import 'package:flutter/material.dart';

class FavoriteShoe extends StatefulWidget {
  const FavoriteShoe({super.key});
  @override
  State<FavoriteShoe> createState() => _FavoriteShoeState();
}

class _FavoriteShoeState extends State<FavoriteShoe> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: AppBar(
         title:Text('FavoriteShoe'),
        ),
       );
     }
}