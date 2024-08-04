import 'package:chatapp/services/auth/auth_services.dart';
import 'package:chatapp/components/button_widget.dart';
import 'package:chatapp/components/textfield_widget.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatelessWidget {
  final void Function()? onTap;
  RegisterPage({
    required this.onTap,
    super.key,
  });

  final TextEditingController emailcontroller = TextEditingController();
  final TextEditingController passwordcontroller = TextEditingController();
  final TextEditingController confirmpwdcontroller = TextEditingController();
  void register(BuildContext context) async {
    final auth = AuthServices();
    if (passwordcontroller.text == confirmpwdcontroller.text) {
      try {
        await auth.singUp(
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
    } else {
      showDialog(
          context: context,
          builder: (context) => const AlertDialog(
                title: Text(
                  'As senhas não coincidem',
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
          const Text('Criar uma conta !'),
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
          const SizedBox(height: 10),
          TextfieldWidget(
            controller: confirmpwdcontroller,
            obscureText: true,
            hinttex: 'Confirme sua  Senha',
          ),
          const SizedBox(height: 25),
          ButtonWidget(
            onTap: () => register(context),
            text: 'Registre-se',
          ),
          const SizedBox(
            height: 25,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              GestureDetector(
                onTap: onTap,
                child: const Text('já tem uma conta faça Login !'),
              )
            ],
          ),
        ],
      ),
    );
  }
}
