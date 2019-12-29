import 'package:flutter/material.dart';
import 'package:slwe2/dataType.dart';
import 'package:intl/intl.dart';

class PokemonInfo extends StatefulWidget {
  final int id;
  PokemonInfo(this.id);

  @override
  _PokemonInfoState createState() => _PokemonInfoState(id);
}

class _PokemonInfoState extends State<PokemonInfo> {
  final int id;
  _PokemonInfoState(this.id){
    data = new Pokemon(id);
  }
  Pokemon data;
  TypeTheme get theme {
    return data.types != null ? TypeTheme(data.types.firstWhere((x) => x.slot == 1).type.name) : TypeTheme('normal') ;
  }

  final formatter = new NumberFormat("000");

  @override
  void initState() {
    data.init(id).then((val){
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Pokemon Info"),
        ),
        body: Container(
          color: theme.color,
          child: Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  Container(
                      width: (MediaQuery.of(context).size.width - 40) * 0.75,
                      height: 50,
                      padding: EdgeInsets.all(10),
                      child: Container(
                          child: Text(
                            data.name,
                            textAlign: TextAlign.center,
                          ),
                          color: Colors.white)),
                  Container(
                    width: 40,
                    height: 50,
                    child: Image.asset(theme.typePic),
                  ),
                  Container(
                      width: (MediaQuery.of(context).size.width - 40) * 0.25,
                      height: 50,
                      padding: EdgeInsets.all(10),
                      child: Container(
                          child: Text("#" + formatter.format(data.id),
                              textAlign: TextAlign.center),
                          color: Colors.white)),
                ],
              ),
              Container(
                  color: Colors.white,
                  margin: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                  height: 300,
                  width: MediaQuery.of(context).size.width,
                  child: Image.asset('content/image/pokemon/${data.id}.png'))
            ],
          ),
        ));
  }
}
