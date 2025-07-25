import 'package:authentication_flutter/app/services/auth_services.dart';
import 'package:authentication_flutter/firebase_options.dart';
import 'package:authentication_flutter/my_application.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(
    MultiProvider(
      providers: [ChangeNotifierProvider(create: (context) => AuthService())],
      child: MyApplication(),
    ),
  );
}
