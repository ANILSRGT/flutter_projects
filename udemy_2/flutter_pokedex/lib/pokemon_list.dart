import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_pokedex/pokemon_detail.dart';
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
  Future<Pokedex> veri;

  Future<Pokedex> pokemonlariGetir() async {
    var response = await http.get(url);
    var decodedResponseBody = jsonDecode(response.body);
    pokedex = Pokedex.fromJson(decodedResponseBody);
    return pokedex;
  }

  @override
  void initState() {
    super.initState();
    veri = pokemonlariGetir();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Pokedex"),
        ),
        body: OrientationBuilder(
          builder: (BuildContext context, Orientation orientation) {
            if (orientation == Orientation.portrait) {
              return FutureBuilder(
                future: veri,
                builder: (BuildContext context, AsyncSnapshot<Pokedex> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  } else if (snapshot.connectionState == ConnectionState.done) {
                    /*return GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
                  itemCount: snapshot.data.pokemon.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Text(snapshot.data.pokemon[index].name);
                  },
                );*/

                    return GridView.count(
                      crossAxisCount: 2,
                      children: snapshot.data.pokemon.map((poke) {
                        return InkWell(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => PokemonDetail(pokemon: poke),
                            ));
                          },
                          child: Hero(
                            tag: poke.img,
                            child: Card(
                              elevation: 4,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  Expanded(
                                    child: Container(
                                      height: 120,
                                      child: FadeInImage.assetNetwork(
                                        placeholder: "assets/loading.gif",
                                        image: poke.img,
                                        fit: BoxFit.contain,
                                      ),
                                    ),
                                  ),
                                  Text(
                                    poke.name,
                                    style: TextStyle(
                                      fontSize: 22,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    );
                  } else {
                    return Text("Error ${snapshot.error.hashCode} : Bilgi bulunamadı!..");
                  }
                },
              );
            } else {
              return FutureBuilder(
                future: veri,
                builder: (BuildContext context, AsyncSnapshot<Pokedex> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  } else if (snapshot.connectionState == ConnectionState.done) {
                    /*return GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
                  itemCount: snapshot.data.pokemon.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Text(snapshot.data.pokemon[index].name);
                  },
                );*/

                    return GridView.extent(
                      maxCrossAxisExtent: 300,
                      children: snapshot.data.pokemon.map((poke) {
                        return InkWell(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => PokemonDetail(pokemon: poke),
                            ));
                          },
                          child: Hero(
                            tag: poke.img,
                            child: Card(
                              elevation: 4,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  Expanded(
                                    child: Container(
                                      height: 120,
                                      child: FadeInImage.assetNetwork(
                                        placeholder: "assets/loading.gif",
                                        image: poke.img,
                                        fit: BoxFit.contain,
                                      ),
                                    ),
                                  ),
                                  Text(
                                    poke.name,
                                    style: TextStyle(
                                      fontSize: 22,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    );
                  } else {
                    return Text("Error ${snapshot.error.hashCode} : Bilgi bulunamadı!..");
                  }
                },
              );
            }
          },
        ),
      ),
    );
  }
}
