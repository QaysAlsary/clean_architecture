import 'package:clean_architecture/core/app_theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme:appTheme ,
    title: 'Posts App  ',
    home: Scaffold(appBar: 
    AppBar(
      title: Text('Posts App Bar'),

    ),
      body: Center(
        child: Container(
          child: Text('Hello World '),
        ),
      ),
    ),
    );
  }
}