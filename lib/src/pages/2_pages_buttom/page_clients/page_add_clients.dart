import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:servicemangerapp/src/data/model/client_model.dart';
import 'package:servicemangerapp/src/data/provider/firebase_provider.dart';

class ClienteCadastroPage extends StatefulWidget {
  const ClienteCadastroPage({super.key});

  @override
  State<ClienteCadastroPage> createState() => _ClienteCadastroPageState();
}

class _ClienteCadastroPageState extends State<ClienteCadastroPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();
  final _notesController = TextEditingController();
  ClientsProvider clientController = Get.find();

  final phoneMask = MaskTextInputFormatter(
    initialText: '(##) #####-####',
    mask: '(##) #####-####');


  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  void _salvarCliente() {
    if (_formKey.currentState!.validate()) {
      ClientModel myClient = ClientModel.crate(
          name: _nameController.text,
          phone: _phoneController.text,
          email: _emailController.text,
          notes: _notesController.text);
      clientController.registerClientProvider(client: myClient);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Dados do cliente salvos!')),
      );
      Get.back();
    }
  }

  void _cancelarCadastro() {
    // Limpar os campos e resetar o formulário
    _formKey.currentState!.reset();
    _nameController.clear();
    _phoneController.clear();
    _emailController.clear();
    _notesController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cadastro de Cliente'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: <Widget>[
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: 'Nome'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira o nome';
                  }
                  return null;
                },
              ),
              TextFormField(
                inputFormatters: [phoneMask],
                controller: _phoneController,
                decoration: const InputDecoration(labelText: 'Telefone'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira o telefone';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(labelText: 'Email'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira o email';
                  } else if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                    return 'Por favor, insira um email válido';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _notesController,
                decoration: const InputDecoration(labelText: 'Notas'),
                maxLines: 4,
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: _salvarCliente,
                    child: const Text('Salvar'),
                  ),
                  ElevatedButton(
                    onPressed: _cancelarCadastro,
                    child: const Text('Cancelar'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
