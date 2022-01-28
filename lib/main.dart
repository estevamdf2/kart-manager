import 'package:flutter/material.dart';
import 'screens/lista.dart';

void main() {
  runApp(KartManager());
}

class KartManager extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(
            primaryColor: Colors.grey[900],
            appBarTheme: AppBarTheme(color: Colors.grey[900]),
            elevatedButtonTheme: ElevatedButtonThemeData(
                style: ElevatedButton.styleFrom(
              primary: Colors.blueAccent[700],
            )),
            buttonTheme: ButtonThemeData(
                buttonColor: Colors.blueAccent[700],
                textTheme: ButtonTextTheme.primary)),
        home: Scaffold(body: ListaPilotos()));
  }
}
