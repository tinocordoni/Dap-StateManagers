import 'package:flutter/material.dart';
import 'package:gestor_de_estados/classes/class_user_info.dart';
import 'package:gestor_de_estados/data/session.dart';
import 'package:gestor_de_estados/datasources/user_datasource.dart';
import 'package:go_router/go_router.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String appTitle = 'Library';
  bool obscurePassword = true;
  String informar = 'Ingrese su usuario y contraseña';

  TextEditingController mailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 244, 223, 163),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                appTitle,
                style: const TextStyle(
                  fontSize: 50,
                  color: Color.fromARGB(255, 227, 171, 0),
                ),
              ),
              const SizedBox(height: 100),
              SizedBox(
                width: 500,
                child: TextField(
                  controller: mailController,
                  decoration: const InputDecoration(
                    labelText: 'Mail',
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: 500,
                child: TextField(
                  controller: passwordController,
                  obscureText: obscurePassword,
                  decoration: const InputDecoration(
                    labelText: 'Contraseña',
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 227, 171, 0),
                ),
                onPressed: () {
                  final mail = mailController.text;
                  final password = passwordController.text;

                  if (mail.isEmpty || password.isEmpty) {
                    informar = 'Llene ambos campos';
                  } else if (usuarios.any((usuario) => usuario.mail == mail)) {
                    UserInfo persona = usuarios.firstWhere(
                      (usuario) => usuario.mail == mail,
                    );

                    if (password == persona.password) {
                      currentUser = persona;
                      informar = 'Puede ingresar';
                      context.go('/books');
                    } else {
                      informar = 'Contraseña incorrecta';
                    }
                  } else {
                    informar = 'El usuario no existe';
                  }

                  passwordController.clear();
                  ScaffoldMessenger.of(
                    context,
                  ).showSnackBar(SnackBar(content: Text(informar)));
                  setState(() {});
                },
                child: const Text(
                  'Ingresar',
                  style: TextStyle(color: Color.fromARGB(255, 244, 223, 163)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
