import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'cadastrocliente.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController userController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool exibirSenha = false;
  String? loginError;

  Future<void> _verificarLogin() async {
    String url = "http://10.109.83.10:3000/usuarios";
    http.Response resposta = await http.get(Uri.parse(url));

    if (resposta.statusCode == 200) {
      List<dynamic> usuarios = json.decode(resposta.body);

      bool usuarioEncontrado = usuarios.any((usuario) =>
          usuario['login'] == userController.text &&
          usuario['senha'] == passwordController.text);

      if (usuarioEncontrado) {
        setState(() {
          loginError = null;
        });
        print("Usuário encontrado");
        // Navegue para a próxima tela ou faça algo mais
      } else {
        setState(() {
          loginError = "Usuário ou senha inválidos";
        });
      }
    } else {
      setState(() {
        loginError = "Erro ao conectar ao servidor";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("App Mercado"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 300,
              height: 300,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      keyboardType: TextInputType.name,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        icon: Icon(Icons.people_alt_outlined),
                        iconColor: Colors.blue,
                        hintText: "Digite seu nome",
                      ),
                      controller: userController,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      keyboardType: TextInputType.visiblePassword,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        icon: Icon(Icons.key),
                        iconColor: Colors.blue,
                        hintText: "Digite sua senha",
                        suffixIcon: IconButton(
                          icon: Icon(
                            exibirSenha ? Icons.visibility : Icons.visibility_off,
                          ),
                          onPressed: () {
                            setState(() {
                              exibirSenha = !exibirSenha;
                            });
                          },
                        ),
                      ),
                      obscureText: !exibirSenha,
                      obscuringCharacter: "*",
                      controller: passwordController,
                    ),
                  ),
                  if (loginError != null)
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        loginError!,
                        style: TextStyle(color: Colors.red),
                      ),
                    ),
                ],
              ),
            ),
            ElevatedButton(onPressed: _verificarLogin, child: Text("Entrar")),
            ElevatedButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Cadastrocliente()));
              },
              child: Text("Cadastrar"),
            ),
          ],
        ),
      ),
    );
  }
}

class Usuario {
  String id;
  String login;
  String senha;
  Usuario(this.id, this.login, this.senha);

  factory Usuario.fromJson(Map<String, dynamic> json) {
    return Usuario(json["id"], json["login"], json["senha"]);
  }
}
