import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'dart:convert';

RegExp regExp = new RegExp(
  r"\/(\d+)",
  caseSensitive: false,
  multiLine: false,
);

class PokemonBase {
  int get id {
    return int.parse(regExp.stringMatch(this.url).substring(1));
  }

  final String name;
  final String url;
  PokemonBase(this.name, this.url);
}

class TypeTheme {
  Color color;
  String typePic;
  TypeTheme(String type) {
    switch (type.toLowerCase()) {
      case "grass":
        {
          typePic = 'content/image/type/grass.png';
          color = Colors.green;
        }
        break;
      case "fire":
        {
          typePic = 'content/image/type/fire.png';
          color = Colors.red;
        }
        break;
      case "water":
        {
          typePic = 'content/image/type/water.png';
          color = Colors.blue;
        }
        break;
      case "fight":
        {
          typePic = 'content/image/type/fight.png';
          color = Colors.brown;
        }
        break;
      case "dark":
        {
          typePic = 'content/image/type/dark.png';
          color = Colors.grey;
        }
        break;
      case "normal":
        {
          typePic = 'content/image/type/normal.png';
          color = Colors.grey;
        }
        break;
      case "flying":
        {
          typePic = 'content/image/type/flying.png';
          color = Colors.lightBlue;
        }
        break;
      case "fire":
        {
          typePic = 'content/image/type/fire.png';
          color = Colors.pink;
        }
        break;
      case "psychic":
        {
          typePic = 'content/image/type/psychic.png';
          color = Colors.purple;
        }
        break;
      case "ground":
        {
          typePic = 'content/image/type/ground.png';
          color = Colors.brown;
        }
        break;
      case "poison":
        {
          typePic = 'content/image/type/poison.png';
          color = Colors.purple;
        }
        break;
      case "steel":
        {
          typePic = 'content/image/type/poison.png';
          color = Colors.grey;
        }
        break;
      case "rock":
        {
          typePic = 'content/image/type/rock.png';
          color = Colors.grey;
        }
        break;
      case "bug":
        {
          typePic = 'content/image/type/bug.png';
          color = Colors.green;
        }
        break;
      case "dragon":
        {
          typePic = 'content/image/type/dragon.png';
          color = Colors.brown;
        }
        break;
      case "electric":
        {
          typePic = 'content/image/type/electric.png';
          color = Colors.yellow;
        }
        break;
      case "ghost":
        {
          typePic = 'content/image/type/ghost.png';
          color = Colors.purple;
        }
        break;
      default:
        {
          color = Colors.grey;
          typePic = 'content/image/type/normal.png';
        }
    }
  }
}

class Type {
  final int slot;
  final PokemonBase type;
  Type(this.slot, this.type);
}

class Pokemon {
  int id = 25;
  String name = "pikachu";
  int base_experience = 112;
  int height = 4;
  bool is_default = true;
  int order = 35;
  int weight = 60;
  String location_area_encounters =
      "https://pokeapi.co/api/v2/pokemon/25/encounters";
  List<Type> types;
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
  Pokemon(this.id) {
    init(id);
  }

  init(id) async {
    var url = "https://pokeapi.co/api/v2/pokemon/" + id.toString();
    print(url);
    var response = await http
        .get(Uri.encodeFull(url), headers: {"Accept": "application/json"});
    var data = json.decode(response.body);
    print(data["name"]);
    id = data["id"];
    name = data["name"];
    base_experience = data["experience"];
    height = data["height"];
    is_default = data["is_default"];
    order = data["order"];
    weight = data["weight"];
    location_area_encounters = data["location_area_encounters"];
    var types = List<Type>();
    for (var data in data['types']) {
      types.add(Type(data["slot"],
          PokemonBase(data['type']['name'], data['type']['url'])));
    }
    this.types = types;
  }
}
