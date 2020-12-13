import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_pokedex/model/pokedex.dart';

import 'model/pokedex.dart';

class PokemonList extends StatefulWidget {
  @override
  _PokemonListState createState() => _PokemonListState();
}

class _PokemonListState extends State<PokemonList> {
  String url = "https://raw.githubusercontent.com/Biuni/PokemonGO-Pokedex/master/pokedex.json";
  Pokedex pokedex;

  Future<Pokedex> pokemonlariGetir() async {
    http.Response response = await http.get(url);
    var decodedResponseBody = jsonDecode(response.body);
    pokedex = Pokedex.fromJson(decodedResponseBody);
    return pokedex;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Pokedex"),
        ),
        body: FutureBuilder(
          future: pokemonlariGetir(),
          builder: (BuildContext context, AsyncSnapshot<Pokedex> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.connectionState == ConnectionState.done) {
              return GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
                itemBuilder: (BuildContext context, int index) {
                  return Text(snapshot.data.pokemon[index].name);
                },
              );
            } else {
              return Text("Error ${snapshot.error.hashCode} : Bilgi bulunamadı!..");
            }
          },
        ),
      ),
    );
  }
}
