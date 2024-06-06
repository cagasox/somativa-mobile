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

  final String url = 'http://10.109.83.15:3000/usuarios';

  void cadastrarUsuario() async {
    String nome = nomeController.text;
    String senha = senhaController.text;

    Map<String, String> novoUsuario = {
      'nome': nome,
      'password': senha,
    };

    http.Response response = await http.post(
      Uri.parse(url),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(novoUsuario),
    );

    if (response.statusCode == 201) {
      print('Usuário cadastrado');
      Navigator.pop(context); 
    } else {
      
      print('Erro ao cadastrar usuário. Código de status: ${response.statusCode}');
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
              onPressed: cadastrarUsuario,
              child: Text('Cadastrar'),
            ),
          ],
        ),
      ),
    );
  }
}
