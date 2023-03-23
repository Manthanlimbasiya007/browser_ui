import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:provider/provider.dart';
import '../provider/browser_provider.dart';

class browserscreen extends StatefulWidget {
  const browserscreen({Key? key}) : super(key: key);

  @override
  State<browserscreen> createState() => _browserscreenState();
}

class _browserscreenState extends State<browserscreen> {
  TextEditingController txtsearch = TextEditingController();
  BrowserProvider? browserProviderTrue;
  BrowserProvider? browserProviderFalse;
  PullToRefreshController? pullToRefreshController;
  @override
  void initState() {
    super.initState();
    pullToRefreshController =PullToRefreshController(onRefresh: () {
      browserProviderTrue!.inAppWebViewController?.reload();
    },);
  }

  @override
  Widget build(BuildContext context) {
    browserProviderTrue = Provider.of<BrowserProvider>(context, listen: true);
    browserProviderFalse = Provider.of<BrowserProvider>(context, listen: false);
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            Column(
              children: [
                Container(
                  child: TextField(
                    controller: txtsearch,
                    decoration: InputDecoration(
                      prefixIcon: IconButton(
                        onPressed: () {
                          var newlink = txtsearch.text;
                          browserProviderTrue!.inAppWebViewController!.loadUrl(
                              urlRequest: URLRequest(
                                  url: Uri.parse(
                                      "https://www.google.com/search?q=$newlink")));
                        },
                        icon: Icon(Icons.search),
                      ),
                      border: InputBorder.none,
                    ),
                  ),
                ),
                LinearProgressIndicator(
                  value: browserProviderTrue!.progressWeb,
                ),
                Expanded(
                  child: InAppWebView(
                    initialUrlRequest:
                        URLRequest(url: Uri.parse("https://www.google.com/")),
                    pullToRefreshController: pullToRefreshController!,
                    onWebViewCreated: (controller) {
                      browserProviderTrue!.inAppWebViewController = controller;
                    },
                    onLoadError: (controller, url, code, message) {
                      pullToRefreshController!.endRefreshing();
                      browserProviderTrue!.inAppWebViewController = controller;
                    },
                    onLoadStart: (controller, url) {
                      browserProviderTrue!.inAppWebViewController = controller;
                    },
                    onLoadStop: (controller, url) {
                      pullToRefreshController!.endRefreshing();
                      browserProviderTrue!.inAppWebViewController = controller;
                    },
                    onProgressChanged: (controller, progress) {
                      pullToRefreshController!.endRefreshing();
                      browserProviderFalse!.changeProgress(progress / 100);
                    },
                  ),
                ),
              ],
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                color: Colors.white,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    IconButton(onPressed: (){
                      browserProviderTrue!.inAppWebViewController!.goBack();
                    }, icon: Icon(Icons.arrow_back)),
                    IconButton(onPressed: (){
                      browserProviderTrue!.inAppWebViewController!.reload();

                    }, icon: Icon(Icons.refresh)),
                    IconButton(onPressed: (){
                      browserProviderTrue!.inAppWebViewController!.goForward();

                    }, icon: Icon(Icons.arrow_forward)),
                  ],
                ),
              ) ,
            ),
          ],
        ),
      ),
    );
  }
}
