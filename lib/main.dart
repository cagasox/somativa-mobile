import 'package:flutter/material.dart';
import 'package:formativa/login.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(MaterialApp(
    home: Login(),
  ));
}

class MoviesScreen extends StatefulWidget {
  @override
  _MoviesScreenState createState() => _MoviesScreenState();
}

class _MoviesScreenState extends State<MoviesScreen> {
  List<dynamic> filmes = [];

  @override
  void initState() {
    super.initState();
    loadFilmes();
  }

  void loadFilmes() {
    http.get(Uri.parse('https://raw.githubusercontent.com/danielvieira95/DESM-2/master/filmes.json'))
        .then((response) {
      if (response.statusCode == 200) {
        setState(() {
          filmes = jsonDecode(response.body);
        });
      } else {
        setState(() {
          filmes = [];
        });
      }
    }).catchError((error) {
      setState(() {
        filmes = [];
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration(seconds: 2));

    return Scaffold(
      appBar: AppBar(
        title: Text('Movies'),
      ),
      body: ListView.builder(
        itemCount: filmes.length,
        itemBuilder: (context, index) {
          var filme = filmes[index];
          return ListTile(
            leading: Image.network(filme['imagem']),
            title: Text(filme['nome']),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Duração: ${filme['duração']}'),
                Text('Ano de Lançamento: ${filme['ano de lançamento']}'),
                Text('Nota: ${filme['nota']}'),
              ],
            ),
          );
        },
      ),
    );
  }
}

