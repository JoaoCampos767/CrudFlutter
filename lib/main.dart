// @dart=2.9
import 'package:crudFlutter/routeGenerator.dart';
import 'package:crudFlutter/telas/login.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(
    const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Login(),
      initialRoute: "/",
      onGenerateRoute: RouteGeneretor.generateRoute,
    ),
  );
}
