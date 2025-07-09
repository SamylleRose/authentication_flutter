//Permite lançar exceções específicas para problemas como senha fraca, email já cadastrado, etc.
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';

class AuthException implements Exception {
  String message;
  AuthException(this.message);
}

class AuthService extends ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  User? user;
  bool isLoading = true;

  AuthService() {
    _authCheck();
  }

  //Mantém o estado de autenticação atualizado e notifica os ouvintes sobre mudanças
  _authCheck() {
    _auth.authStateChanges().listen((User? user) {
      user = (user == null) ? null : user;
      isLoading = false;
      notifyListeners();
    });
  }

  //Usado internamente para atualizar o estado do usuário após operações como login, registro ou logout.
  _getUser() {
    user = _auth.currentUser;
    notifyListeners();
  }

  register(String userName, String email, String password) async {
    try {
      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);
      await userCredential.user!.updateDisplayName(userName);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        throw AuthException('A senha é muito! Escolha uma mais forte.');
      } else if (e.code == 'email-already-in-use') {
        throw AuthException(
          'Este e-mail já está cadastrado. Tente outro.',
        ); //E-mail já cadastrado.
      } else if (e.code == 'invalid-email') {
        throw AuthException(
          'O formato do e-mail é inválido.',
        ); //Formato de e-mail inválido.
      } else {
        throw AuthException('Erro ao cadastrar. Tente novamente mais tarde.');
      }
    } catch (e) {
      throw AuthException('Erro inesperado. Verifique sua conexão.');
    }
  }

  //Permite que usuários já cadastrados façam login no aplicativo.
  login(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      ); // Faz login com e-mail e senha.
      _getUser();
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        //E-mail não cadastrado.
        throw AuthException('Email não encontrado. Cadastre-se.');
      } else {
        throw AuthException('Email ou senha incorreto, tente novamente.');
      }
    } catch (e) {
      throw AuthException('Erro inesperado. Verifique sua conexão.');
    }
  }

  //Permite que o usuário encerre a sessão.
  logout() async {
    // await _googleSignIn.signOut();
    await _auth.signOut();
    _getUser();
  }
}
