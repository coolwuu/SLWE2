import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:splashscreen/splashscreen.dart';
import 'package:http/http.dart' as http;

var responseString = "DONE";
List<pokemonBase> pokemonBaseList;
void main() {
  runApp(new MaterialApp(
    home: new MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => new _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: new SplashScreen(
        seconds: 3,
        navigateAfterSeconds: new AfterSplash(),
        image: Image(
          image: AssetImage('content/image/logo.jpeg'),
          height: 168,
        ),
        backgroundColor: Colors.white,
        photoSize: 140.0,
      ),
      height: 338,
      
    );
  }

  @override
  void initState() {
    GetInitData().then((value) {
      pokemonBaseList = value;
      //print(pokemonBaseList.length);
    });
    super.initState();
  }
}

class AfterSplash extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Welcome In SplashScreen Package"),
        automaticallyImplyLeading: false,
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.search),
              onPressed: () {
                showSearch(context: context, delegate: SearchBarViewDelegate());
              })
        ],
      ),
      body: new Center(
        child: new Text(
          responseString,
          style: new TextStyle(fontWeight: FontWeight.bold, fontSize: 30.0),
        ),
      ),
    );
  }
}

class SearchBarViewDelegate extends SearchDelegate<String> {
  String searchHint = "GOGO Name";
  var sourceList = [
    "皮卡丘",
    "皮卡丘1",
    "皮卡丘2",
    "皮卡丘3",
    "皮卡丘4",
  ];

  var suggestList = [
    "皮卡丘1",
    "皮卡丘2",
  ];

  @override
  String get searchFieldLabel => searchHint;

  @override
  List<Widget> buildActions(BuildContext context) {
    ///显示在最右边的控件列表
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = "";

          ///搜索建议的内容
          showSuggestions(context);
        },
      ),
      IconButton(
        icon: Icon(Icons.search),
        onPressed: () => query = "",
      )
    ];
  }

  ///左侧带动画的控件，一般都是返回
  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: AnimatedIcon(
          icon: AnimatedIcons.menu_arrow, progress: transitionAnimation),

      ///调用 close 关闭 search 界面
      onPressed: () => close(context, null),
    );
  }

  ///展示搜索结果
  @override
  Widget buildResults(BuildContext context) {
    List<String> result = List();

    ///模拟搜索过程
    for (var str in sourceList) {
      ///query 就是输入框的 TextEditingController
      if (query.isNotEmpty && str.contains(query)) {
        result.add(str);
      }
    }

    ///展示搜索结果
    return ListView.builder(
      itemCount: result.length,
      itemBuilder: (BuildContext context, int index) => ListTile(
        title: Text(result[index]),
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<String> suggest = query.isEmpty
        ? suggestList
        : sourceList.where((input) => input.startsWith(query)).toList();
    return ListView.builder(
      itemCount: suggest.length,
      itemBuilder: (BuildContext context, int index) => InkWell(
        child: ListTile(
          title: RichText(
            text: TextSpan(
              text: suggest[index].substring(0, query.length),
              style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
              children: [
                TextSpan(
                  text: suggest[index].substring(query.length),
                  style: TextStyle(color: Colors.grey),
                ),
              ],
            ),
          ),
        ),
        onTap: () {
          //  query.replaceAll("", suggest[index].toString());
          searchHint = "";
          query = suggest[index].toString();
          showResults(context);
        },
      ),
    );
  }
}

Future<List<pokemonBase>> GetInitData() async {
  print('Api Call');
  var url = "https://pokeapi.co/api/v2/pokemon-species";
  var pokemonList = new List<pokemonBase>();
  while (url != null) {
    print('GG');
    print(url);
    var response = await http
        .get(Uri.encodeFull(url), headers: {"Accept": "application/json"});
    var data = json.decode(response.body);
    url = data['next'];
    var result = data['results'];
    for (var i = 0; i < result.length; i++)
    {
      var temp = result[i];
      pokemonList.add(new pokemonBase(temp['name'], temp['url']));
    }
  }
  return pokemonList;
}

class pokemonBase {
  final String name;
  final String url;
  pokemonBase(this.name, this.url);
}
