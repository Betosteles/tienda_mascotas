import 'package:flutter/material.dart';

TextStyle getEstiloTienda() {
  return const TextStyle(
    color: Colors.white,
    fontWeight: FontWeight.bold,
  );
}

AppBar getAppBarStyle(String titulo) {
  return AppBar(
    title: Text(titulo, style: getEstiloTienda()),
    backgroundColor: Colors.green[900],
  );
}
