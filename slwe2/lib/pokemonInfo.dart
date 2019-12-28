import 'package:flutter/material.dart';
import 'package:slwe2/dataType.dart';
import 'package:intl/intl.dart';

class PokemonInfoPage extends StatelessWidget {
  final pokemon data;
  final formatter = new NumberFormat("000");
  PokemonInfoPage(this.data);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Pokemon Info"),
        ),
        body: Container(
          color: Colors.green,
          child: Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  Container(
                      width: (MediaQuery.of(context).size.width - 40) * 0.75,
                      height: 50,
                      padding: EdgeInsets.all(10),
                      child: Container(
                          child: Text(data.name, 
                          textAlign: TextAlign.center,
                          ),
                          color: Colors.white)),
                  Container(
                    width: 40,
                    height: 50,
                    child: Image.asset('content/image/grass.png'),
                  ),
                  Container(
                      width: (MediaQuery.of(context).size.width - 40) * 0.25,
                      height: 50,
                      padding: EdgeInsets.all(10),
                      child: Container(
                          child: Text("#" + formatter.format(data.id),
                              textAlign: TextAlign.center
                              ),
                          color: Colors.white)),
                ],
              ),
              Container(
                color: Colors.white,
                child: Image.network(
                    "https://media.52poke.com/wiki/2/21/001Bulbasaur.png"),
              )
            ],
          ),
        ));
  }
}
