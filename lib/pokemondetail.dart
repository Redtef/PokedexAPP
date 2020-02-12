import 'package:flutter/material.dart';
import 'package:pokeapp/pokemon.dart';

class PokemonDetail extends StatelessWidget {
  final Pokemon pokemon;

  PokemonDetail({this.pokemon});
  Widget displayNextEvolutions(nextEvolution) {
    if(nextEvolution == null){
        return Text("This pokemon has no evolutions");
    }else{
      return Column(
        children: <Widget>[
          Text(
                        "Next evolution",
                        style: TextStyle(
                            fontSize: 18.0, fontWeight: FontWeight.bold),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: pokemon.nextEvolution
                            .map((nextEvo) => FilterChip(
                                  label: Text(nextEvo.name),
                                  onSelected: (b) {},
                                ))
                            .toList(),
                      )
        ],
      );
    }
  }
  bodyWidget(BuildContext context) => Stack(
        children: <Widget>[
          Positioned(
              height: MediaQuery.of(context).size.height / 1.5,
              width: MediaQuery.of(context).size.width - 20,
              left: 10.0,
              top: MediaQuery.of(context).size.height * 0.1,
              child: Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      SizedBox(height: 70.0),
                      Text(
                        pokemon.name,
                        style: TextStyle(
                            fontSize: 25.0, fontWeight: FontWeight.bold),
                      ),
                      Text("Height ${pokemon.height}"),
                      Text("Weight ${pokemon.weight}"),
                      Text("Type"),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: pokemon.type
                            .map((type) => FilterChip(
                                  label: Text(type),
                                  backgroundColor: typeColor(type),
                                  onSelected: (b) {},
                                ))
                            .toList(),
                      ),
                      Text(
                        "Weaknesses",
                        style: TextStyle(
                            fontSize: 18.0, fontWeight: FontWeight.bold),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: pokemon.weaknesses
                            .map((weakness) => FilterChip(
                                  label: Text(weakness),
                                  backgroundColor: typeColor(weakness),
                                  onSelected: (b) {},
                                ))
                            .toList(),
                      ),
                      displayNextEvolutions(pokemon.nextEvolution),
                    ],
                  ))),
          Align(
            alignment: Alignment.topCenter,
            child: Hero(
              tag: pokemon.img,
              child: Container(
                height: 200,
                width: 200,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        fit: BoxFit.cover, image: NetworkImage(pokemon.img))),
              ),
            ),
          )
        ],
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.purple,
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.purple,
        title: Text(pokemon.name),
      ),
      body: bodyWidget(context),
    );
  }

  Color typeColor(String type) {
    Color color;
    switch (type) {
      case "Normal":
        color = Color(0xffa8a77a);
        break;
      case "Grass":
        color = Color(0xff7AC74C);
        break;
      case "Poison":
        color = Color(0xffA33EA1);
        break;
      case "Fire":
        color = Color(0xffEE8130);
        break;
      case "Ice":
        color = Color(0xff96D9D6);
        break;
      case "Fighting ":
        color = Color(0xffC22E28);
        break;
      case "Flying":
        color = Color(0xffA98FF3);
        break;
      case "Psychic":
        color = Color(0xffF95587);
        break;
      case "Ground":
        color = Color(0xffE2BF65);
        break;
      case "Water":
        color = Color(0xff6390F0);
        break;
      case "Rock":
        color = Color(0xffB6A136);
        break;
      case "Electric":
        color = Color(0xffF7D02C);
        break;
      case "Bug":
        color = Color(0xffA6B91A);
        break;
      case "Steel":
        color = Color(0xffB7B7CE);
        break;
      case "Dragon":
        color = Color(0xff6F35FC);
        break;
      case "Fairy":
        color = Color(0xffD685AD);
        break;
      case "Ghost":
        color = Color(0xff735797);
        break;
      case "Dark":
        color = Color(0xff705746);
        break;
      default:
    }
    return color;
  }
}
