import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:slwe2/dataType.dart';
import 'package:intl/intl.dart';

List<TypeInfo> typeInfos = new List<TypeInfo>();

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
              SubColorContainer(subColor: theme.subColor, child: <Widget>[
                Row(
                  children: <Widget>[
                    Container(
                        width: (MediaQuery.of(context).size.width - 50) * 0.75,
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
                        width: (MediaQuery.of(context).size.width - 50) * 0.25,
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
                    child: Image.asset('content/image/pokemon/${data.id}.png'))
              ]),
              SubColorContainer(
                subColor: theme.subColor,
                title: "type",
                child: <Widget>[
                  Container(
                      height: 30,
                      margin: EdgeInsets.only(top: 10, left: 10, right: 10),
                      decoration: BoxDecoration(
                          borderRadius:
                              BorderRadius.all(const Radius.circular(30)),
                          color: Colors.white),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: getTypesWidget(
                              data.types.map((x) => x.type.name).toList())))
                ],
              ),
            ],
          ),
        ));
  }
}

class TypeInfoPage extends StatefulWidget {
  final String name;
  TypeInfo typeInfo;

  TypeTheme get theme {
    return new TypeTheme(name);
  }

  TypeInfoPage(this.name) {
    if (typeInfos.where((x) => x.name == this.name).length > 0) {
      typeInfo = typeInfos.firstWhere((x) => x.name == name);
    } else {
      typeInfo = TypeInfo(name);
      typeInfos.add(typeInfo);
    }
  }
  @override
  _TypeInfoPageState createState() => _TypeInfoPageState();
}

class _TypeInfoPageState extends State<TypeInfoPage> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        height: 20,
        margin: EdgeInsets.symmetric(horizontal: 5),
        width: 50,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(const Radius.circular(30)),
            color: widget.theme.color),
        child: Text(widget.name,
            style: TextStyle(color: Colors.white), textAlign: TextAlign.center),
      ),
      onTap: () {
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                  contentPadding: EdgeInsets.all(5),
                  contentTextStyle: TextStyle(fontWeight: FontWeight.bold),
                  content: Container(
                      color: widget.theme.subColor,
                      width: MediaQuery.of(context).size.width,
                      child: Column(
                        mainAxisSize : MainAxisSize.min,
                        children: <Widget>[
                          Row(children: <Widget>[
                            Expanded(
                                flex: 2,
                                child: Container(
                                    color: Colors.red[400],
                                    child: Text("Damage From",
                                        textAlign: TextAlign.center))),
                            Expanded(
                                flex: 1,
                                child: Container(
                                    color: widget.theme.subColor,
                                    child: TypeInfoPage(widget.name))),
                            Expanded(
                                flex: 2,
                                child: Container(
                                    color: Colors.green[400],
                                    child: Text("Damage To",
                                        textAlign: TextAlign.center))),
                          ]),
                          Row(children: <Widget>[
                            Expanded(
                                flex: 1,
                                child: Container(
                                    color: Colors.red[400],
                                    child: Text("Power",
                                        textAlign: TextAlign.center))),
                            Expanded(
                                flex: 1,
                                child: Container(
                                    color: Colors.red[400],
                                    child: Text("Type",
                                        textAlign: TextAlign.center))),
                            Expanded(
                                flex: 1,
                                child: Container(
                                  color: widget.theme.color,
                                )),
                            Expanded(
                                flex: 1,
                                child: Container(
                                    color: Colors.green[400],
                                    child: Text("Power",
                                        textAlign: TextAlign.center))),
                            Expanded(
                                flex: 1,
                                child: Container(
                                    color: Colors.green[400],
                                    child: Text("Type",
                                        textAlign: TextAlign.center))),
                          ]),
                          Table(
                            children: <TableRow>[
                              TableRow(
                                children: <Widget>[
                                  Container(
                                    color: Colors.green,
                                    child:
                                        Text('2x', textAlign: TextAlign.center),
                                  ),
                                  Column(
                                      children: getTypesWidget(widget
                                          .typeInfo.double_damage_from
                                          .map((x) => x.name)
                                          .toList())),
                                  Text(''),
                                  Container(
                                    color: Colors.red,
                                    child: Text('0.5 x',
                                        textAlign: TextAlign.center),
                                  ),
                                  Column(
                                      children: getTypesWidget(widget
                                          .typeInfo.half_damage_to
                                          .map((x) => x.name)
                                          .toList())),
                                ],
                              ),
                              TableRow(
                                children: <Widget>[
                                  Container(
                                    color: Colors.red,
                                    child: Text('0.5x',
                                        textAlign: TextAlign.center),
                                  ),
                                  Column(
                                      children: getTypesWidget(widget
                                          .typeInfo.half_damage_from
                                          .map((x) => x.name)
                                          .toList())),
                                  Text(''),
                                  Container(
                                    color: Colors.green,
                                    child:
                                        Text('2x', textAlign: TextAlign.center),
                                  ),
                                  Column(
                                      children: getTypesWidget(widget
                                          .typeInfo.double_damage_to
                                          .map((x) => x.name)
                                          .toList())),
                                ],
                              ),
                              TableRow(
                                children: <Widget>[
                                  Container(
                                    color: Colors.black,
                                    child:
                                        Text('0x', textAlign: TextAlign.center),
                                  ),
                                  Column(
                                      children: getTypesWidget(widget
                                          .typeInfo.no_damage_from
                                          .map((x) => x.name)
                                          .toList())),
                                  Text(''),
                                  Container(
                                    color: Colors.black,
                                    child:
                                        Text('0x', textAlign: TextAlign.center),
                                  ),
                                  Column(
                                      children: getTypesWidget(widget
                                          .typeInfo.no_damage_to
                                          .map((x) => x.name)
                                          .toList())),
                                ],
                              ),
                            ],
                          )
                        ],
                      )));
            });
      },
    );
  }
}

List<Widget> getTypesWidget(List<String> types) {
  return types.map((type) => new TypeInfoPage(type)).toList();
}

class SubColorContainer extends StatefulWidget {
  final List<Widget> child;
  final Color subColor;
  final String title;
  SubColorContainer(
      {@required this.child, @required this.subColor, this.title});
  @override
  _SubColorContainerState createState() => _SubColorContainerState();
}

class _SubColorContainerState extends State<SubColorContainer> {
  @override
  Widget build(BuildContext context) {
    var widgets = widget.title != null
        ? <Widget>[
            Text(widget.title,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                )),
          ]
        : <Widget>[];
    widgets.addAll(widget.child);
    return Container(
        margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        //height: 60,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(const Radius.circular(30)),
            color: widget.subColor),
        child: Column(children: widgets));
  }
}
