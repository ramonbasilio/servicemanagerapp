import 'package:flutter/material.dart';
import 'package:servicemangerapp/src/data/repository/firebase_auth.dart';

class PageResetPassword extends StatefulWidget {
  const PageResetPassword({super.key});

  @override
  State<PageResetPassword> createState() => _PageResetPasswordState();
}

class _PageResetPasswordState extends State<PageResetPassword> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Reset Senha'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(labelText: 'Email'),
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira seu email';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    await FireAuth.resetPassword(
                        email: _emailController.text, context: context);
                  }
                },
                child: const Text('Enviar reset da senha'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
