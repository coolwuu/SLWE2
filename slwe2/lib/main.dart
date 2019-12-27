import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:splashscreen/splashscreen.dart';
import 'package:http/http.dart' as http;
import 'package:sprintf/sprintf.dart';

var responseString = "DONE";
List<PokemonBase> pokemonBaseList;
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
          image: AssetImage('content/image/question.jpeg'),
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
    getInitData().then((value) {
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
        title: new Text("Search Pokemon"),
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
          child: Container(
        decoration: new BoxDecoration(
            image: DecorationImage(
          image: AssetImage('content/image/answer.jpeg'),
          //fit: BoxFit.fill,
        )),
      )),
    );
  }
}

class SearchBarViewDelegate extends SearchDelegate<String> {
  String searchHint = "GOGO Name";
  /*var sourceList = [
    "皮卡丘",
    "皮卡丘1",
    "皮卡丘2",
    "皮卡丘3",
    "皮卡丘4",
  ];
  */

  var suggestList = pokemonBaseList.sublist(0, 3);
  /* = [
    "皮卡丘1",
    "皮卡丘2",
  ];
  */
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
    List<PokemonBase> result = List();

    ///模拟搜索过程
    for (var pokemonBase in pokemonBaseList) {
      var pokemon = pokemonBase;

      ///query 就是输入框的 TextEditingController
      if (query.isNotEmpty && pokemon.name.contains(query)) {
        result.add(pokemon);
      }
    }

    ///展示搜索结果
    return ListView.builder(
      itemCount: result.length,
      itemBuilder: (BuildContext context, int index) => ListTile(
        title: Text(result[index].name),
        leading: Image.network("https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/"+ result[index].id.toString() + ".png"),
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<PokemonBase> suggest = query.isEmpty
        ? suggestList
        //: sourceList.where((input) => input.startsWith(query)).toList();
        : pokemonBaseList
            .where((input) => input.name.startsWith(query)).toList();
    return ListView.builder(
      itemCount: suggest.length,
      itemBuilder: (BuildContext context, int index) => InkWell(
        child: ListTile(
          title: RichText(
            text: TextSpan(
              text: suggest[index].name.substring(0, query.length),
              style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
              children: [
                TextSpan(
                  text: suggest[index].name.substring(query.length),
                  style: TextStyle(color: Colors.grey),
                ),
              ],
            ),
          ),
          leading: Image.network("https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/"+ suggest[index].id.toString() + ".png"),
        ),
        onTap: () {
          //  query.replaceAll("", suggest[index].toString());
          searchHint = "";
          query = suggest[index].name.toString();
          showResults(context);
        },
      ),
    );
  }
}

Future<List<PokemonBase>> getInitData() async {
  var url = "https://pokeapi.co/api/v2/pokemon";
  var pokemonList = new List<PokemonBase>();
  //while (url != null) {
  var response = await http
      .get(Uri.encodeFull(url), headers: {"Accept": "application/json"});
  var data = json.decode(response.body);
  url = data['next'];
  var result = data['results'];
  for (var i = 0; i < result.length; i++) {
    var temp = result[i];
    RegExp regExp = new RegExp(
      r"\/(\d+)",
      caseSensitive: false,
      multiLine: false,
    );
    var id = int.parse(regExp.stringMatch(temp['url']).substring(1) );
    pokemonList.add(new PokemonBase(temp['name'], temp['url'] , id));
  }
  //}
  return pokemonList;
}

class PokemonBase {
  final int id ;
  final String name;
  final String url;
  PokemonBase(this.name, this.url ,this.id);
}

class pokemon {
  final int id = 25;
  final String name = "pikachu";
  final int base_experience = 112;
  final int height = 4;
  final bool is_default = true;
  final int order = 35;
  final int weight = 60;
  final String location_area_encounters =
      "https://pokeapi.co/api/v2/pokemon/25/encounters";
  /*
abilities	
A list of abilities this Pokémon could potentially have.

list PokemonAbility
forms	
A list of forms this Pokémon can take on.

list NamedAPIResource (PokemonForm)
game_indices	
A list of game indices relevent to Pokémon item by generation.

list VersionGameIndex
held_items	
A list of items this Pokémon may be holding when encountered.

list PokemonHeldItem

moves	
A list of moves along with learn methods and level details pertaining to specific version groups.

list PokemonMove
sprites	
A set of sprites used to depict this Pokémon in the game.

PokemonSprites
species	
The species this Pokémon belongs to.

NamedAPIResource (PokemonSpecies)
stats	
A list of base stat values for this Pokémon.

list PokemonStat
types	
A list of details showing types this Pokémon has.

list PokemonType
*/
}
