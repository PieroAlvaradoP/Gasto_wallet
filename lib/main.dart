import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:gasto_wallet/login_state.dart';
import 'package:gasto_wallet/pages/add_page.dart';
import 'package:gasto_wallet/pages/home_page.dart';
import 'package:gasto_wallet/pages/login_page.dart';
import 'package:provider/provider.dart';
import 'package:gasto_wallet/login_state.dart';
import 'month_widget.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp().then((value) {
    runApp(
      ChangeNotifierProvider<LoginState>(
        create: (BuildContext context) => LoginState(),
        child: MyApp(),
      ),
    );
  });
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'GastoWallet',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routes: {
        '/': (BuildContext contex){
          var state = Provider.of<LoginState>(context, listen: true);
          print(state);
          if(state.isLoggedIn()){
            return const HomePage();
          }else{
            return LoginPage();
          }
        },
        '/add': (BuildContext contex) => AddPage(),
      },
    );
  }
}
