import 'dart:convert';

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
  _PokemonInfoState(this.id) {
    data = new Pokemon(id);
  }
  Pokemon data;
  TypeTheme get theme {
    return data.types.length > 0
        ? TypeTheme(data.types.firstWhere((x) => x.slot == 1).type.name)
        : TypeTheme('normal');
  }

  final formatter = new NumberFormat("000");

  @override
  void initState() {
    data.init(id).then((val) {
      data.types.sort((x, y) => x.slot > y.slot ? 1 : 0);
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
              SubColorContainer(
                  subColor:theme.subColor,
                  childWedget: Column(children: <Widget>[
                  Row(
                    children: <Widget>[
                      Container(
                          width:
                              (MediaQuery.of(context).size.width - 50) * 0.75,
                          height: 50,
                          padding: EdgeInsets.all(10),
                          child: Container(
                            child: Text(
                              data.name,
                              textAlign: TextAlign.center,
                            ),
                            decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(const Radius.circular(30)),
                                color: Colors.white),
                          )),
                      Container(
                        width: 30,
                        height: 50,
                        child: Image.asset(theme.typePic),
                      ),
                      Container(
                          width:
                              (MediaQuery.of(context).size.width - 50) * 0.25,
                          height: 50,
                          padding: EdgeInsets.all(10),
                          child: Container(
                            child: Text("#" + formatter.format(data.id),
                                textAlign: TextAlign.center),
                            decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(const Radius.circular(30)),
                                color: Colors.white),
                          )),
                    ],
                  ),
                  Container(
                      decoration: BoxDecoration(
                          borderRadius:
                              BorderRadius.all(const Radius.circular(30)),
                          color: Colors.white),
                      margin: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                      height: 300,
                      width: MediaQuery.of(context).size.width,
                      child:
                          Image.asset('content/image/pokemon/${data.id}.png'))
                ]),
              ),
              SubColorContainer(
                  subColor:theme.subColor,
                  childWedget : Column(
                    children: <Widget>[
                      Text("Types",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          )),
                      Container(
                          height: 30,
                          margin: EdgeInsets.only(top: 10, left: 10, right: 10),
                          decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(const Radius.circular(30)),
                              color: Colors.white),
                          child: getTypesWidget(
                              data.types.map((x) => x.type.name).toList()))
                    ],
                  ))
            ],
          ),
        ));
  }
}

class TypeInfo extends StatefulWidget {
  final String name;
  TypeTheme get theme {
    return new TypeTheme(name);
  }

  TypeInfo(this.name);
  @override
  _TypeInfoState createState() => _TypeInfoState();
}

class _TypeInfoState extends State<TypeInfo> {
  @override
  Widget build(BuildContext context) {
    return Container(
        height: 20,
        margin: EdgeInsets.symmetric(horizontal: 5),
        width: 50,
        color: widget.theme.color,
        child: Text(widget.name,
            style: TextStyle(color: Colors.white),
            textAlign: TextAlign.center));
  }
}

Widget getTypesWidget(List<String> types) {
  return new Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: types.map((type) => new TypeInfo(type)).toList());
}

class SubColorContainer extends StatefulWidget {
  final Widget childWedget;
  final Color subColor;
  SubColorContainer({this.childWedget,this.subColor});
  @override
  _SubColorContainerState createState() => _SubColorContainerState();
}

class _SubColorContainerState extends State<SubColorContainer> {
  @override
  Widget build(BuildContext context) {
    return Container(
       margin: EdgeInsets.symmetric(horizontal: 10,vertical:5),
                  //height: 60,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(const Radius.circular(30)),
                      color: widget.subColor),
                  child: widget.childWedget
    );
  }
}
