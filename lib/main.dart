import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:gasto_wallet/pages/add_page.dart';
import 'package:gasto_wallet/pages/home_page.dart';
import 'month_widget.dart';
import 'login.dart';


void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp().then((value) {
    runApp( const MyApp());  }
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'GastoWallet',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),

      routes: {
        '/': (BuildContext contex) => HomePage(),
        '/add': (BuildContext contex) => AddPage(),
      },
    );
  }
}

