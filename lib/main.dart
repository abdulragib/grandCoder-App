import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'dart:io';
import 'dart:async';
double progress = 0;
void main() {
  runApp(
     MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyApp(),
    ),
  );
}


class MyApp extends StatefulWidget {
  @override
  _runAppState createState() => _runAppState();
}

class _runAppState extends State<MyApp> {
  late WebViewController controller;
  @override
  void initState() {
    super.initState();
    // Enable hybrid composition.
    if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();

  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {
          if (await controller.canGoBack()) {
            controller.goBack();
            return false;
          }
          else {
            return true;
          }
        },

        child: Scaffold(
            floatingActionButton:Align(
              alignment: Alignment(1.0,0.8),
              child: FloatingActionButton(
                onPressed: () {
                  controller.reload();
                },
                child: const Icon(Icons.refresh),
                backgroundColor: Colors.green,
              ),

            ),
          //floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
            body: SafeArea(
              child: Column(
                children: <Widget>[
                  LinearProgressIndicator(
                    value: progress,
                    color: Colors.green,
                    backgroundColor: Colors.grey,
                  ),

                  Expanded(
                    child: WebView(
                      javascriptMode: JavascriptMode.unrestricted,
                      initialUrl: "https://www.grandcoder.in",
                      onWebViewCreated: (controller) {
                        this.controller = controller;
                      },
                      onProgress: (progressone) =>
                          setState(() =>
                          progress = progressone / 100,
                          ),
                    ),
                  ),
                ],
              ),

            )
        )
    );
  }
}