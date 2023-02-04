import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class Cadastro extends StatefulWidget {
  const Cadastro({super.key});

  @override
  State<Cadastro> createState() => _CadastroState();
}

class _CadastroState extends State<Cadastro> {
  final maskCpf = MaskTextInputFormatter(
      mask: "###.###.###-##", filter: {"#": RegExp(r'[0-9]')});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Cadastro"),
        backgroundColor: const Color.fromARGB(255, 167, 92, 180),
      ),
      body: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
        ),
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Padding(
              padding: EdgeInsets.only(bottom: 40),
            ),
            const Padding(
              padding: EdgeInsets.only(
                bottom: 35,
                left: 30,
                right: 30,
              ),
              child: TextField(
                style: TextStyle(fontSize: 17),
                decoration: InputDecoration(
                  hintText: "Nome",
                  filled: true,
                  fillColor: Colors.white,
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(
                bottom: 35,
                left: 30,
                right: 30,
              ),
              child: TextField(
                keyboardType: TextInputType.text,
                style: TextStyle(fontSize: 17),
                decoration: InputDecoration(
                  hintText: "Sobrenome",
                  filled: true,
                  fillColor: Colors.white,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                bottom: 35,
                left: 30,
                right: 30,
              ),
              child: TextField(
                keyboardType: TextInputType.number,
                inputFormatters: [maskCpf],
                style: const TextStyle(fontSize: 17),
                decoration: const InputDecoration(
                  hintText: "CPF",
                  filled: true,
                  fillColor: Colors.white,
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(
                bottom: 35,
                left: 30,
                right: 30,
              ),
              child: TextField(
                keyboardType: TextInputType.emailAddress,
                style: TextStyle(fontSize: 17),
                decoration: InputDecoration(
                  hintText: "E-mail",
                  filled: true,
                  fillColor: Colors.white,
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(
                bottom: 20,
                left: 30,
                right: 30,
              ),
              child: TextField(
                obscureText: true,
                keyboardType: TextInputType.emailAddress,
                style: TextStyle(fontSize: 17),
                decoration: InputDecoration(
                  hintText: "Senha",
                  filled: true,
                  fillColor: Colors.white,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                top: 16,
                bottom: 10,
                left: 100,
                right: 100,
              ),
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 167, 92, 180),
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
    );
  }
}
