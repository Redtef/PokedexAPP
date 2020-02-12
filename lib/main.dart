import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'pokemondetail.dart';

import 'package:pokeapp/pokemon.dart';

void main() => runApp(MaterialApp(
      title: 'Poke APP',
      theme: ThemeData(
        accentColor: Colors.purple,
      ),
      home: Homepage(),
    ));

class Homepage extends StatefulWidget {
  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  var url =
      "https://raw.githubusercontent.com/Biuni/PokemonGO-Pokedex/master/pokedex.json";

  PokeHub pokehub;
  Icon _searchIcon = new Icon(Icons.search);
  final TextEditingController _filter = new TextEditingController();
  String _searchText = "";
  List pokemonSearched = new List();
  List pokemon = new List();
  Widget _appBarTitle = new Text('Poke APP');

  @override
  void initState() {
    super.initState();
    this.fetchData();
  }

  _HomepageState() {
    _filter.addListener(() {
      if (_filter.text.isEmpty) {
        setState(() {
          _searchText = "";
          pokemonSearched = pokemon;
        });
      } else {
        setState(() {
          _searchText = _filter.text;
        });
      }
    });
  }
  fetchData() async {
    var response = await http.get(url);
    var decodedJson = jsonDecode(response.body);
    pokehub = PokeHub.fromJson(decodedJson);

    setState(() {
      pokemon = pokehub.pokemon;
      pokemonSearched = pokemon;
    });
  }

  void _searchPressed() {
    setState(() {
      if (this._searchIcon.icon == Icons.search) {
        this._searchIcon = new Icon(Icons.close);
        this._appBarTitle = new TextField(
          controller: _filter,
          decoration: new InputDecoration(
              prefixIcon: new Icon(Icons.search), hintText: 'Search...'),
        );
      } else {
        this._searchIcon = new Icon(Icons.search);
        this._appBarTitle = new Text('PokeApp');
        setState(() {
          pokemonSearched = pokemon;
        });

        _filter.clear();
      }
    });
  }

  Widget _buildList() {
    if (pokehub == null) {
      return Center(
        child: CircularProgressIndicator(),
      );
    } else {
      //pokehub has loaded
      List tempList = new List();
      if (_searchText.isNotEmpty) {
        for (var i = 0; i < pokemon.length; i++) {
          if (pokemon[i].name.contains(_searchText.toLowerCase()))
            tempList.add(pokemon[i]);
          for (var j = 0; j < pokemon[i].type.length; j++) {
            if (pokemon[i].type[j].toString().toLowerCase() == _searchText.toLowerCase())
              tempList.add(pokemon[i]);
          }
        }
        pokemonSearched = tempList;
      }
    }

    return GridView.count(
      crossAxisCount: 2,
      children: pokemonSearched
          .map((poke) => Padding(
              padding: const EdgeInsets.all(2.0),
              child: InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => PokemonDetail(
                                  pokemon: poke,
                                )));
                  },
                  child: Hero(
                    tag: poke.img,
                    child: Card(
                      elevation: 3.0,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Container(
                            height: 100.0,
                            width: 100.0,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: NetworkImage(poke.img)),
                            ),
                          ),
                          Text(
                            poke.name,
                            style: TextStyle(
                                fontSize: 20.0, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ))))
          .toList(),
    );
  }

  Widget _buildBar(BuildContext context) {
    return new AppBar(
      centerTitle: true,
      title: _appBarTitle,
      leading: new IconButton(
        icon: _searchIcon,
        onPressed: _searchPressed,
      ),
      //backgroundColor: Colors.purple,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildBar(context),
      drawer: Drawer(),
      body: _buildList(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.refresh),
      ),
    );
  }
}
