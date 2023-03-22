import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class BrowserProvider extends ChangeNotifier
{
   double progressWeb=0;
   InAppWebViewController? inAppWebViewController;


   void changeProgress(double ps)
   {
     progressWeb=ps;
     notifyListeners();
   }
}