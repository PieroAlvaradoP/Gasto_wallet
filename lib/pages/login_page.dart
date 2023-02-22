import 'package:flutter/material.dart';
import 'package:gasto_wallet/login_state.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Iniciar Sesión'),
      ),
      body: Center(
        child: Consumer<LoginState>(
          builder: (BuildContext context, LoginState value, Widget? child) {
            if (value.isLoading()) {
              return const CircularProgressIndicator();
            } else {
              return child ?? Container();
            }
          },
          child: FloatingActionButton.extended(
            onPressed: () {
              Provider.of<LoginState>(context, listen: false).login();
            },
            label: const Text('Iniciar Sesión'),
            backgroundColor: Colors.blue,
          ),
        ),
      ),
    );
  }
}
