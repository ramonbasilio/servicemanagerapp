import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:servicemangerapp/src/alerts/alerts_dialog.dart';
import 'package:servicemangerapp/src/pages/0_pages_login/page_sign-in/page_sign-in.dart';
import 'package:servicemangerapp/src/pages/1_pages_functional/page_init/page_init.dart';

class FireAuth {
  static Future<void> registerUsignEmailPassword({
    required String name,
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user;

    print('Autenticando...'); //INSERIR UM LOADING
    try {
      UserCredential userCredential = await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      user = userCredential.user;
      await user!.reload();
      user = auth.currentUser;
      print('Finalizado!');
      Get.back();
      if (context.mounted) {
        AlertsDialog.snackBarMessageFirebaseAuth(
          context,
          messageOpcional: 'Cadastrado realizado com sucesso!',
          colorMessage: Colors.green,
        );
      }
    } on FirebaseAuthException catch (e) {
      if (context.mounted) {
        print('Erro: ${e.code}');
        AlertsDialog.snackBarMessageFirebaseAuth(context, error: e);
      }
    }
  }

  static Future<void> signInUsingEmailPassword({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    FirebaseAuth auth = FirebaseAuth.instance;

    try {
      await auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      if (context.mounted) {
        AlertsDialog.snackBarMessageFirebaseAuth(context,
            messageOpcional: 'Login realizado com sucesso!',
            colorMessage: Colors.green);
        Get.off(() => const PageInit());
      }
    } on FirebaseAuthException catch (e) {
      if (context.mounted) {
        AlertsDialog.snackBarMessageFirebaseAuth(
          context,
          error: e,
        );
      }
    }
  }

  static Future<void> signOut({required BuildContext context}) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    print('email deslogado: ${auth.currentUser!.email}');
    await auth.signOut();
    if (context.mounted) {
      AlertsDialog.snackBarMessageFirebaseAuth(
        context,
        messageOpcional: 'Usuário desconectado',
        colorMessage: Colors.blueAccent,
      );
    }
  }

  static Future<void> resetPassword({
    required String email,
    required BuildContext context,
  }) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    try {
      await auth.sendPasswordResetEmail(email: email);
      if (context.mounted) {
        AlertsDialog.snackBarMessageFirebaseAuth(
          context,
          messageOpcional: 'Email enviado com sucesso',
          colorMessage: Colors.green,
        );
        Get.off(() => const PageSignIn());
      }
    } on FirebaseAuthException catch (_) {
      if (context.mounted) {
        AlertsDialog.snackBarMessageFirebaseAuth(
          context,
          messageOpcional: 'Falha ao resetar a senha',
          colorMessage: Colors.redAccent,
        );
        Get.off(() => const PageSignIn());
      }
    }
  }
}
