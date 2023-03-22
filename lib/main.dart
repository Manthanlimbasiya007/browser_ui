import 'package:browser_ui/screen/provider/browser_provider.dart';
import 'package:browser_ui/screen/view/browser_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main()
{
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(
        create: (context) => BrowserProvider(),
      )
    ],
    child: MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        '/':(context) => browserscreen(),
      },
    ),
  ));
}