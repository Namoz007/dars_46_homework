import 'package:dars_46/controllers/tests_controller.dart';
import 'package:dars_46/firebase_options.dart';
import 'package:dars_46/views/screens/home_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options:DefaultFirebaseOptions.currentPlatform
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (ctx){
              return TestsController();
            },
          )
        ],
        builder: (ctx,child){
          return MaterialApp(
              debugShowCheckedModeBanner: false,
              home: HomeScreen()
          );
        }
    );
  }
}
