import 'package:flutter/material.dart';
import 'package:gasto_wallet/login_state.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Consumer<LoginState>(
          builder: (BuildContext context, LoginState value, Widget? child){
            if(value.isLoading()){
              return const CircularProgressIndicator();
            }else{
              return child ?? Container();;
            }
          },
          child: ElevatedButton(
            child: const Text('Iniciar Sesión'),
            onPressed: () {
              Provider.of<LoginState>(context, listen: false).login();
            },
          ),
        ),
      ),
    );
  }
}
