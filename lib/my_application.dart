import 'package:authentication_flutter/app/widgets/auth_check.dart';
import 'package:flutter/material.dart';

class MyApplication extends StatelessWidget {
  const MyApplication({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primaryColor: Colors.blueAccent),
      home: AuthCheck(),
    );
  }
}
