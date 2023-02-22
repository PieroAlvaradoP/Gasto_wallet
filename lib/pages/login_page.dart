import 'package:flutter/material.dart';
import 'package:gasto_wallet/login_state.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Iniciar Sesión'),
        ),
        body: Align(
          alignment: Alignment.center,
          child: ListView(
            children: <Widget>[
              Container(
                  height: 200,
                  alignment: Alignment.center,
                  padding: const EdgeInsets.all(10),
              ),
              Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.all(10),
                  child: const Text(
                    'Gasto Wallet',
                    style: TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.w500,
                        fontSize: 30),
                  )
              ),
              Container(
                width: 200,
                height: 200,
                margin: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Image.network(
                  "https://play-lh.googleusercontent.com/CHUroB_c-G__crsSc57AewD-EI1R9K9EmGqGmRRbus0qV_8RtpcgHic2SSfwlwDhPSM"
                ),
              ),
              Container(
                alignment: Alignment.center,
                child: Consumer<LoginState>(
                  builder: (BuildContext context, LoginState value, Widget? child) {
                    if (value.isLoading()) {
                      return const CircularProgressIndicator();
                    } else {
                      return Container(
                        margin: const EdgeInsets.only(top: 20.0),
                        child: FloatingActionButton.extended(
                          onPressed: () {
                            Provider.of<LoginState>(context, listen: false).login();
                          },
                          label: const Text('Iniciar Sesión'),
                          backgroundColor: Colors.blue,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          elevation: 5.0,
                        ),
                      );
                    }
                  },
                  child: const SizedBox(),
                ),
              ),
            ],
          ),
        )
    );
  }
}

