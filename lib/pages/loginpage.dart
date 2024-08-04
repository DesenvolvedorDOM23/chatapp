import 'package:chatapp/services/auth/auth_services.dart';
import 'package:chatapp/components/button_widget.dart';
import 'package:chatapp/components/textfield_widget.dart';
import 'package:flutter/material.dart';

class Loginpage extends StatelessWidget {
  final void Function()? onTap;
  final TextEditingController emailcontroller = TextEditingController();
  final TextEditingController passwordcontroller = TextEditingController();
  Loginpage({
    required this.onTap,
    super.key,
  });
  void login(BuildContext context) async {
    final authService = AuthServices();
    try {
      await authService.singInwithEmailandPassword(
        emailcontroller.text,
        passwordcontroller.text,
      );
    } catch (e) {
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
                title: Text(
                  e.toString(),
                ),
              ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Icon(
            Icons.message,
            size: 60,
            color: Theme.of(context).colorScheme.primary,
          ),
          const SizedBox(height: 50),
          const Text('Bem vindo de volta, que bom que você'),
          const SizedBox(
            height: 25,
          ),
          TextfieldWidget(
            controller: emailcontroller,
            hinttex: 'Email',
          ),
          const SizedBox(height: 10),
          TextfieldWidget(
            controller: passwordcontroller,
            obscureText: true,
            hinttex: 'Senha',
          ),
          const SizedBox(height: 25),
          ButtonWidget(
            onTap: () => login(context),
            text: 'Login',
          ),
          const SizedBox(
            height: 25,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Text('Não tem uma conta?'),
              const SizedBox(
                width: 8,
              ),
              GestureDetector(
                onTap: onTap,
                child: const Text('Registre-se'),
              )
            ],
          ),
        ],
      ),
    );
  }
}
