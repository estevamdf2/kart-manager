import 'package:flutter/material.dart';
import 'package:kart_manager/database/app_database.dart';
import 'package:kart_manager/models/piloto.dart';
import 'screens/lista.dart';

void main() {
  runApp(KartManager());
  save(Piloto(0, 'Marcos', 'M.Estevam')).then(
      (id) => {findAll().then((pilotos) => debugPrint(pilotos.toString()))});
}

class KartManager extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(
            colorScheme: ColorScheme.fromSwatch(
              primarySwatch: Colors.grey,
            ).copyWith(
              secondary: Colors.lightBlue[700],
            ),
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
