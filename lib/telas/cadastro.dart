import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:sla/model/usuario.dart';
import 'package:sla/telas/home.dart';

class Cadastro extends StatefulWidget {
  const Cadastro({super.key});

  @override
  State<Cadastro> createState() => _CadastroState();
}

class _CadastroState extends State<Cadastro> {
  String _mensagemErro = "";

  final TextEditingController _controllerNome = TextEditingController();
  final TextEditingController _controllerSobreNome = TextEditingController();
  final TextEditingController _controllerCPF = TextEditingController();
  final TextEditingController _controllerEmail = TextEditingController();
  final TextEditingController _controllerSenha = TextEditingController();

  final maskCpf = MaskTextInputFormatter(
      mask: "###.###.###-##", filter: {"#": RegExp(r'[0-9]')});

  _validaCampos() {
    String nome = _controllerNome.text;
    String sobrenome = _controllerSobreNome.text;
    String cpf = _controllerCPF.text;
    String email = _controllerEmail.text;
    String senha = _controllerSenha.text;

    Usuario usuario = Usuario();
    usuario.nome = nome;
    usuario.sobrenome = sobrenome;
    usuario.cpf = cpf;
    usuario.email = email;
    usuario.senha = senha;

    _cadastrarusuario(usuario);
  }

  _cadastrarusuario(Usuario usuario) async {
    await Firebase.initializeApp();
    FirebaseAuth auth = FirebaseAuth.instance;

    auth
        .createUserWithEmailAndPassword(
            email: usuario.email, password: usuario.senha)
        .then((firebaseUser) {
      FirebaseFirestore db = FirebaseFirestore.instance;

      print(firebaseUser.user?.uid);

      db
          .collection("usuarios")
          .doc(firebaseUser.user?.uid)
          .set(usuario.toMap());

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const Home(),
        ),
      );
    }).catchError((error) {
      setState(() {
        _mensagemErro =
            "Erro ao cadastrar usuário, verifique os campos e tente novamente!";
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final _formCadastro = GlobalKey<FormState>();

    return Scaffold(
        appBar: AppBar(
          title: const Text("Cadastro"),
          backgroundColor: const Color.fromARGB(255, 167, 92, 180),
        ),
        body: Form(
          key: _formCadastro,
          child: Container(
            decoration: const BoxDecoration(
              color: Colors.white,
            ),
            child: Center(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                        bottom: 35,
                        left: 30,
                        right: 30,
                      ),
                      child: TextFormField(
                        controller: _controllerNome,
                        keyboardType: TextInputType.text,
                        style: const TextStyle(fontSize: 17),
                        decoration: const InputDecoration(
                          hintText: "Nome",
                          filled: true,
                          fillColor: Colors.white,
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Campo Nome é obrigatório!";
                          }

                          return null;
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          bottom: 35, left: 30, right: 30),
                      child: TextFormField(
                        controller: _controllerSobreNome,
                        keyboardType: TextInputType.text,
                        style: const TextStyle(fontSize: 17),
                        decoration: const InputDecoration(
                          hintText: "Sobrenome",
                          filled: true,
                          fillColor: Colors.white,
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Campo Nome é obrigatório!";
                          }

                          return null;
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          bottom: 35, left: 30, right: 30),
                      child: TextFormField(
                        controller: _controllerCPF,
                        keyboardType: TextInputType.number,
                        inputFormatters: [maskCpf],
                        style: const TextStyle(fontSize: 17),
                        decoration: const InputDecoration(
                          hintText: "CPF",
                          filled: true,
                          fillColor: Colors.white,
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Campo CPF é obrigatório";
                          }

                          return null;
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          bottom: 35, left: 30, right: 30),
                      child: TextFormField(
                        controller: _controllerEmail,
                        keyboardType: TextInputType.emailAddress,
                        style: const TextStyle(fontSize: 17),
                        decoration: const InputDecoration(
                          hintText: "E-mail",
                          filled: true,
                          fillColor: Colors.white,
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Campo Email é obrigatório";
                          }

                          if (!value.contains("@")) {
                            return "Email é necessário conter @";
                          }

                          return null;
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          bottom: 20, left: 30, right: 30),
                      child: TextFormField(
                        obscureText: true,
                        controller: _controllerSenha,
                        keyboardType: TextInputType.text,
                        style: const TextStyle(fontSize: 17),
                        decoration: const InputDecoration(
                          hintText: "Senha",
                          filled: true,
                          fillColor: Colors.white,
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Campo Senha é obrigatório";
                          }

                          if (value.length <= 6) {
                            return "Senha deve conter mais de 6 caracteres";
                          }

                          return null;
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          top: 16, bottom: 10, left: 100, right: 100),
                      child: ElevatedButton(
                        onPressed: () {
                          final isValid =
                              _formCadastro.currentState!.validate();

                          if (isValid) {
                            _validaCampos();
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              const Color.fromARGB(255, 167, 92, 180),
                          padding: const EdgeInsets.fromLTRB(28, 12, 28, 12),
                        ),
                        child: const Text(
                          "Cadastrar",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}
