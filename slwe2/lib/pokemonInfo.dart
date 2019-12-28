import 'package:flutter/material.dart';
import 'package:slwe2/dataType.dart' ;


class PokemonInfoPage extends StatelessWidget {
  final pokemon data;
  PokemonInfoPage(this.data);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(data.name),
      ),
      body: Center(
        child: RaisedButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text('Go back!'),
        ),
      ),
    );
  }
}
