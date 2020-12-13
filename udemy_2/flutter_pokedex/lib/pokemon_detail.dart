import 'package:flutter/material.dart';
import 'package:flutter_pokedex/model/pokedex.dart';
import 'package:palette_generator/palette_generator.dart';

class PokemonDetail extends StatefulWidget {
  final Pokemon pokemon;
  PokemonDetail({@required this.pokemon});

  @override
  _PokemonDetailState createState() => _PokemonDetailState();
}

class _PokemonDetailState extends State<PokemonDetail> {
  PaletteGenerator paletteGenerator;
  Color baskinRenk;

  @override
  void initState() {
    super.initState();
    baskinRengiBul();
  }

  void baskinRengiBul() {
    Future<PaletteGenerator> fpaletGenerator = PaletteGenerator.fromImageProvider(NetworkImage(widget.pokemon.img));
    fpaletGenerator.then((value) {
      paletteGenerator = value;
      setState(() {
        baskinRenk = paletteGenerator.dominantColor.color;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: baskinRenk,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: baskinRenk,
        title: Text(
          widget.pokemon.name,
          textAlign: TextAlign.center,
        ),
      ),
      body: OrientationBuilder(
        builder: (BuildContext context, Orientation orientation) {
          if (orientation == Orientation.portrait) {
            return _dikeyBody(context);
          } else {
            return _yatayBody(context);
          }
        },
      ),
    );
  }

  Widget _yatayBody(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width - 30,
      height: MediaQuery.of(context).size.height * (3 / 4),
      margin: EdgeInsets.symmetric(horizontal: 15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            flex: 2,
            child: Hero(
              tag: widget.pokemon.img,
              child: Container(
                width: 200,
                child: Image.network(
                  widget.pokemon.img,
                  fit: BoxFit.fill,
                ),
              ),
            ),
          ),
          Expanded(
            flex: 4,
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(height: 50),
                  Text(
                    widget.pokemon.name,
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text("Height : " + widget.pokemon.height),
                  Text("Weight : " + widget.pokemon.weight),
                  SizedBox(height: 15),
                  Text(
                    "Types",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: widget.pokemon.type != null
                        ? widget.pokemon.type
                            .map((tip) => Chip(
                                  backgroundColor: Colors.deepOrange.shade300,
                                  label: Text(
                                    tip,
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ))
                            .toList()
                        : [
                            Text(
                              "No Types",
                              style: TextStyle(color: Colors.purple.shade700),
                            ),
                          ],
                  ),
                  SizedBox(height: 15),
                  Text(
                    "Prev Evolution",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: widget.pokemon.prevEvolution != null
                        ? widget.pokemon.prevEvolution
                            .map((evolution) => Chip(
                                  backgroundColor: Colors.deepOrange.shade300,
                                  label: Text(
                                    evolution.name,
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ))
                            .toList()
                        : [
                            Text(
                              "First Evolution",
                              style: TextStyle(color: Colors.purple.shade700),
                            ),
                          ],
                  ),
                  SizedBox(height: 15),
                  Text(
                    "Next Evolution",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: widget.pokemon.nextEvolution != null
                        ? widget.pokemon.nextEvolution
                            .map((evolution) => Chip(
                                  backgroundColor: Colors.deepOrange.shade300,
                                  label: Text(
                                    evolution.name,
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ))
                            .toList()
                        : [
                            Text(
                              "Last Evolution",
                              style: TextStyle(color: Colors.purple.shade700),
                            ),
                          ],
                  ),
                  SizedBox(height: 15),
                  Text(
                    "Weakness",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: widget.pokemon.weaknesses != null
                        ? widget.pokemon.weaknesses
                            .map((weaknesses) => Chip(
                                  backgroundColor: Colors.deepOrange.shade300,
                                  label: Text(
                                    weaknesses,
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ))
                            .toList()
                        : [
                            Text(
                              "No Weaknesses",
                              style: TextStyle(color: Colors.purple.shade700),
                            ),
                          ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _dikeyBody(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          height: MediaQuery.of(context).size.height * 0.7,
          width: MediaQuery.of(context).size.width - 20,
          left: 10,
          top: MediaQuery.of(context).size.height * 0.1,
          child: Card(
            elevation: 6,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(height: 50),
                Text(
                  widget.pokemon.name,
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text("Height : " + widget.pokemon.height),
                Text("Weight : " + widget.pokemon.weight),
                Text(
                  "Types",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: widget.pokemon.type != null
                      ? widget.pokemon.type
                          .map((tip) => Chip(
                                backgroundColor: Colors.deepOrange.shade300,
                                label: Text(
                                  tip,
                                  style: TextStyle(color: Colors.white),
                                ),
                              ))
                          .toList()
                      : [
                          Text(
                            "No Types",
                            style: TextStyle(color: Colors.purple.shade700),
                          ),
                        ],
                ),
                Text(
                  "Prev Evolution",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: widget.pokemon.prevEvolution != null
                      ? widget.pokemon.prevEvolution
                          .map((evolution) => Chip(
                                backgroundColor: Colors.deepOrange.shade300,
                                label: Text(
                                  evolution.name,
                                  style: TextStyle(color: Colors.white),
                                ),
                              ))
                          .toList()
                      : [
                          Text(
                            "First Evolution",
                            style: TextStyle(color: Colors.purple.shade700),
                          ),
                        ],
                ),
                Text(
                  "Next Evolution",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: widget.pokemon.nextEvolution != null
                      ? widget.pokemon.nextEvolution
                          .map((evolution) => Chip(
                                backgroundColor: Colors.deepOrange.shade300,
                                label: Text(
                                  evolution.name,
                                  style: TextStyle(color: Colors.white),
                                ),
                              ))
                          .toList()
                      : [
                          Text(
                            "Last Evolution",
                            style: TextStyle(color: Colors.purple.shade700),
                          ),
                        ],
                ),
                Text(
                  "Weakness",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: widget.pokemon.weaknesses != null
                      ? widget.pokemon.weaknesses
                          .map((weaknesses) => Chip(
                                backgroundColor: Colors.deepOrange.shade300,
                                label: Text(
                                  weaknesses,
                                  style: TextStyle(color: Colors.white),
                                ),
                              ))
                          .toList()
                      : [
                          Text(
                            "No Weaknesses",
                            style: TextStyle(color: Colors.purple.shade700),
                          ),
                        ],
                ),
              ],
            ),
          ),
        ),
        Align(
          alignment: Alignment.topCenter,
          child: Hero(
            tag: widget.pokemon.img,
            child: Container(
              width: 150,
              height: 150,
              child: Image.network(
                widget.pokemon.img,
                fit: BoxFit.contain,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
