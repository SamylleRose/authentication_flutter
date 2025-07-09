import 'package:authentication_flutter/app/pages/home_page.dart';
import 'package:authentication_flutter/app/pages/login_page.dart';
import 'package:authentication_flutter/app/services/auth_services.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AuthCheck extends StatefulWidget {
  const AuthCheck({super.key});

  @override
  State<AuthCheck> createState() => _AuthCheckState();
}

class _AuthCheckState extends State<AuthCheck> {
  @override
  Widget build(BuildContext context) {
    AuthService auth = Provider.of<AuthService>(context);

    if (auth.isLoading) {
      return _loading(); //Se auth.isLoading for true, ele exibe um indicador de carregamento (retornado pelo método loading()).
    } else if (auth.user == null) {
      return LoginPage(); //Se auth.user for null, ele exibe a LoginPage.
    } else {
      return HomePage(); //Caso contrário, ele exibe a HomePage.
    }
  }

  //O método loading deve ser privado, pois é usado apenas dentro da classe _AuthCheckState.
  _loading() {
    return Scaffold(body: Center(child: CircularProgressIndicator()));
  }
}
