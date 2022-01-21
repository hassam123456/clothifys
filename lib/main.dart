import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_shop/Admins/HomePage.dart';
import 'package:e_shop/Config/config.dart';
import 'package:e_shop/Counters/cartitemcounter.dart';
import 'package:e_shop/admin/condition.dart';
import 'package:e_shop/provider/categoryProvider.dart';
import 'package:e_shop/provider/productProvider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter/material.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Address/addAddress.dart';
import 'Admins/viewPurchasedItems.dart';
import 'Authentication/authenication.dart';
import 'Counters/ItemQuantity.dart';
import 'Counters/changeAddresss.dart';
import 'Counters/totalMoney.dart';
import 'GooglemAP.dart';
import 'Store/storehome.dart';






Future<void> main() async
{
  WidgetsFlutterBinding.ensureInitialized();

  EcommerceApp.auth = FirebaseAuth.instance;
  EcommerceApp.sharedPreferences = await SharedPreferences.getInstance();
  EcommerceApp.firestore = Firestore.instance;
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ListenableProvider<CategoryProvider>(create: (ctx)=> CategoryProvider(),),
        ListenableProvider<ProductProvider>(create: (ctx)=> ProductProvider(),),
        ChangeNotifierProvider(create: (c) => CartItemCounter(),),
        ChangeNotifierProvider(create: (c) => ItemQuantity(),),
        ChangeNotifierProvider(create: (c) => AddressChanger(),),
        ChangeNotifierProvider(create: (c) => TotalAmount(),)


      ],
      child: MaterialApp(
        title: 'Clothify',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: Colors.green,
        ),
        home: SplashScreen(),
      ),
    );
  }
}





class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(Duration(seconds: 5), () =>
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => AuthenticScreen
              ())));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Container(
            color: Colors.greenAccent,
            // decoration: BoxDecoration(
            //   gradient: LinearGradient(
            //     colors: [Colors.pink,
            //       Colors.greenAccent],
            //     begin: const FractionalOffset(0.0, 0.0),
            //     end: const FractionalOffset(1.0, 0.0),
            //     stops: [0.0, 1.0],
            //     tileMode: TileMode.clamp,
            //   ),
            //
            // ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Spacer(),
              Expanded(
                flex: 2,
                child: Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[

                      CircleAvatar(
                        backgroundColor: Colors.black12,
                        radius: 80.0,
                        child: Image.asset('images/logo1.png',
                          height: 120.0,
                          width: 120.0,
                        ),

                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 10.0),
                      ),

                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SpinKitRipple(
                      color: Colors.greenAccent,
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 20.0),
                    ),
                    Text(
                      'LOADING',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16.0,
                      ),

                    ),
                    SizedBox(
                      height: 10.0,
                    )
                  ],
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}