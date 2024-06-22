import 'package:flutter/material.dart';
import 'package:servicemangerapp/src/data/repository/firebase_auth.dart';

class PageSignUp extends StatefulWidget {
  const PageSignUp({super.key});

  @override
  State<PageSignUp> createState() => _PageSignUpState();
}

class _PageSignUpState extends State<PageSignUp> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _companyNameController = TextEditingController();
  final TextEditingController _adminNameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  bool _passwordVisible = false;
  bool _confirmPasswordVisible = false;

  @override
  void initState() {
    super.initState();
    _passwordVisible = false;
    _confirmPasswordVisible = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Cadastro Usuário'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: <Widget>[
              TextFormField(
                controller: _companyNameController,
                decoration: const InputDecoration(labelText: 'Nome da Empresa'),
                // validator: (value) {
                //   if (value == null || value.isEmpty) {
                //     return 'Por favor, insira o nome da empresa';
                //   }
                //   return null;
                // },
              ),
              TextFormField(
                controller: _adminNameController,
                decoration: const InputDecoration(
                    labelText: 'Nome e Sobrenome do Administrador'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira o nome e sobrenome do administrador';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _phoneController,
                decoration: const InputDecoration(labelText: 'Telefone'),
                keyboardType: TextInputType.phone,
                // validator: (value) {
                //   if (value == null || value.isEmpty) {
                //     return 'Por favor, insira o telefone';
                //   }
                //   return null;
                // },
              ),
              TextFormField(
                controller: _addressController,
                decoration: const InputDecoration(labelText: 'Endereço'),
                // validator: (value) {
                //   if (value == null || value.isEmpty) {
                //     return 'Por favor, insira o endereço';
                //   }
                //   return null;
                // },
              ),
              TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(labelText: 'Email'),
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira o email';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _passwordController,
                decoration: InputDecoration(
                  labelText: 'Senha',
                  suffixIcon: IconButton(
                    icon: Icon(
                      _passwordVisible
                          ? Icons.visibility
                          : Icons.visibility_off,
                    ),
                    onPressed: () {
                      setState(() {
                        _passwordVisible = !_passwordVisible;
                      });
                    },
                  ),
                ),
                obscureText: !_passwordVisible,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira a senha';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _confirmPasswordController,
                decoration: InputDecoration(
                  labelText: 'Confirmação da Senha',
                  suffixIcon: IconButton(
                    icon: Icon(
                      _confirmPasswordVisible
                          ? Icons.visibility
                          : Icons.visibility_off,
                    ),
                    onPressed: () {
                      setState(() {
                        _confirmPasswordVisible = !_confirmPasswordVisible;
                      });
                    },
                  ),
                ),
                obscureText: _confirmPasswordVisible,
                // validator: (value) {
                //   if (value == null || value.isEmpty) {
                //     return 'Por favor, confirme sua senha';
                //   }
                //   if (value != _passwordController.text) {
                //     return 'As senhas não coincidem';
                //   }
                //   return null;
                // },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    await FireAuth.registerUsignEmailPassword(
                      name: _adminNameController.text,
                      email: _emailController.text,
                      password: _passwordController.text,
                      context: context,
                    );
                  }
                },
                child: const Text('Cadastrar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
