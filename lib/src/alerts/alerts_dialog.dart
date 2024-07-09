import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AlertsDialog {
  static void snackBarMessageFirebaseAuth(
    BuildContext context, {
    FirebaseAuthException? error,
    String? messageOpcional,
    Color? colorMessage,
  }) {
    if (messageOpcional != null && colorMessage != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: colorMessage,
          content: Text(
            messageOpcional,
            style: const TextStyle(color: Colors.black),
          ),
        ),
      );
    }
    if (error != null) {
      if (error.code == 'weak-password') {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            backgroundColor: Colors.redAccent,
            content: Text(
              'Senha fraca. Sua senha precisa ter no mínimo 6 carateres',
            ),
          ),
        );
      }
      if (error.code == 'email-already-in-use') {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            backgroundColor: Colors.redAccent,
            content: Text(
              'E-mail já utilizado',
            ),
          ),
        );
      }
      if (error.code == 'invalid-email') {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            backgroundColor: Colors.redAccent,
            content: Text(
              'Nenhum usuário encontrado com esse e-mail',
            ),
          ),
        );
      }
      if (error.code == 'invalid-credential') {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            backgroundColor: Colors.redAccent,
            content: Text(
              'Senha errada',
            ),
          ),
        );
      }

      if (error.code == 'network-request-failed') {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            backgroundColor: Colors.redAccent,
            content: Text(
              'Verifique sua conexão com a internet',
            ),
          ),
        );
      }
    }
  }
}
