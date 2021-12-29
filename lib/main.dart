// import 'package:flutter/material.dart';
// import 'package:in_app_purchase/in_app_purchase.dart';
// import 'homescreen.dart';
// import 'package:provider/provider.dart';
//
// import 'providermodel.dart';
//
// void main() {
//   InAppPurchaseConnection.enablePendingPurchases();
//
//   runApp(ChangeNotifierProvider(
//       create: (context) => ProviderModel(),
//       child: MaterialApp(
//         home: MyApp(),
//       )));
// }
//
// class MyApp extends StatefulWidget {
//   @override
//   _MyAppState createState() => _MyAppState();
// }
//
// class _MyAppState extends State<MyApp> {
//   @override
//   void initState() {
//     var provider = Provider.of<ProviderModel>(context, listen: false);
//     provider.initialize();
//     super.initState();
//   }
//
//   @override
//   void dispose() {
//     var provider = Provider.of<ProviderModel>(context, listen: false);
//     provider.subscription.cancel();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return HomeScreen();
//   }
// }

// Copyright 2013 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.


import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:in_app_purchase_android/in_app_purchase_android.dart';
import 'package:justadmob/ui/home_page_ui.dart';





void main() {
  WidgetsFlutterBinding.ensureInitialized();
  // MobileAds.instance.initialize();
  MobileAds.instance.initialize();
  if (defaultTargetPlatform == TargetPlatform.android) {

    InAppPurchaseAndroidPlatformAddition.enablePendingPurchases();
  }

  runApp(_MyApp());
}


class _MyApp extends StatefulWidget {
  const _MyApp({Key key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<_MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Scready',
      home: Scaffold(
        body: HomePageUI(),
      ),
    );
  }
}
