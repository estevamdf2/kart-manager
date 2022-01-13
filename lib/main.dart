import 'package:flutter/material.dart';
import 'screens/lista.dart';

void main() {
  runApp(KartManager());
}

class KartManager extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: Scaffold(body: ListaPilotos()));
  }
}
