import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Cadastrocliente extends StatefulWidget {
  const Cadastrocliente({super.key});

  @override
  State<Cadastrocliente> createState() => _CadastroclienteState();
}

class _CadastroclienteState extends State<Cadastrocliente> {
  TextEditingController userController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  String? cadastroError;

  Future<void> _cadastrarCliente() async {
    String url = "http://10.109.83.10:3000/usuarios";
    var newUser = {
      "login": userController.text,
      "senha": passwordController.text,
    };

    http.Response resposta = await http.post(
      Uri.parse(url),
      headers: {"Content-Type": "application/json"},
      body: json.encode(newUser),
    );

    if (resposta.statusCode == 201 || resposta.statusCode == 200) {  // Verifique se a resposta é 201 ou 200 para sucesso
      setState(() {
        cadastroError = null;
      });
      print("Usuário cadastrado com sucesso");
      Navigator.pop(context);  // Volta para a tela de login após cadastro
    } else {
      setState(() {
        cadastroError = "Erro ao cadastrar usuário";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Cadastrar Cliente"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 300,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      controller: userController,
                      keyboardType: TextInputType.name,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        icon: Icon(Icons.people_alt_outlined),
                        hintText: "Digite seu nome",
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      controller: passwordController,
                      keyboardType: TextInputType.visiblePassword,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        icon: Icon(Icons.key),
                        hintText: "Digite sua senha",
                      ),
                      obscureText: true,
                      obscuringCharacter: "*",
                    ),
                  ),
                  if (cadastroError != null)
                    Padding(
                                            padding: const EdgeInsets.all(8.0),
                      child: Text(
                        cadastroError!,
                        style: TextStyle(color: Colors.red),
                      ),
                    ),
                ],
              ),
            ),
            ElevatedButton(
              onPressed: _cadastrarCliente,
              child: Text("Cadastrar"),
            ),
          ],
        ),
      ),
    );
  }
}
