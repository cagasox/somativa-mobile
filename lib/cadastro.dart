import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class TelaCadastro extends StatefulWidget {
  const TelaCadastro({Key? key}) : super(key: key);

  @override
  _TelaCadastroState createState() => _TelaCadastroState();
}

class _TelaCadastroState extends State<TelaCadastro> {
  TextEditingController nomeController = TextEditingController();
  TextEditingController senhaController = TextEditingController();

  final String url = 'http://10.109.83.8:3000/usuarios';

  final String baseUrl = 'http://10.109.83.8:3000';

  Future<void> createUser(String username, String password, BuildContext context) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/usuarios'),
        headers: {'Content-Type': 'application/json; charset=UTF-8'},
        body: jsonEncode({'nome': username, 'senha': password}),
      );
      if (response.statusCode == 201) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Usuário criado com sucesso!'),
        ));
        Navigator.pushReplacementNamed(context, '/');
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Falha ao criar usuário'),
        ));
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Erro ao criar usuário: $e'),
      ));
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cadastro de Usuário'),
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: nomeController,
              decoration: InputDecoration(
                labelText: 'Nome de Usuário',
              ),
            ),
            SizedBox(height: 20),
            TextField(
              controller: senhaController,
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Senha',
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                createUser(nomeController.text, senhaController.text, context);
              },
              child: Text('Cadastrar', style: TextStyle(color: Color.fromARGB(255, 255, 0, 0))),
            ),
          ],
        ),
      ),
    );
  }
}
