import 'dart:async';

import 'package:ed_management/Colors.dart';
import 'package:ed_management/screens/HomePage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Login Screen.dart';

class AppSplashScreen extends StatefulWidget {

  @override
  _AppSplashScreenState createState() => _AppSplashScreenState();
}

class _AppSplashScreenState extends State<AppSplashScreen> with SingleTickerProviderStateMixin {
  AnimationController? scaleController;
  Animation<double>? scaleAnimation;

  bool _a = false;
  bool _c = false;
  bool _d = false;
  bool _e = false;
  bool secondAnim = false;

  Color boxColor = Colors.transparent;

  late Future<String> permissionStatusFuture;

  var permGranted = "granted";
  var permDenied = "denied";
  var permUnknown = "unknown";
  var permProvisional = "provisional";

  @override
  void initState() {
    super.initState();
    // permissionStatusFuture = getCheckNotificationPermStatus();
    // With this, we will be able to check if the permission is granted or not
    // when returning to the application
    // WidgetsBinding.instance.addObserver(this);
    init();

  }

  // @override
  // void didChangeAppLifecycleState(AppLifecycleState state) {
  //   if (state == AppLifecycleState.resumed) {
  //     setState(() {
  //       permissionStatusFuture = getCheckNotificationPermStatus();
  //     });
  //   }
  // }
  //
  // /// Checks the notification permission status
  // Future<String> getCheckNotificationPermStatus() {
  //   return NotificationPermissions.getNotificationPermissionStatus()
  //       .then((status) {
  //     switch (status) {
  //       case PermissionStatus.denied:
  //         return permDenied;
  //       case PermissionStatus.granted:
  //         return permGranted;
  //       case PermissionStatus.unknown:
  //         return permUnknown;
  //       case PermissionStatus.provisional:
  //         return permProvisional;
  //       default:
  //         return '';
  //     }
  //   });
  // }

  void init() async {
    Timer(Duration(milliseconds: 600), () {
      setState(() {
        boxColor = Colors.black;
        _a = true;
      });
    });
    Timer(Duration(milliseconds: 1500), () {
      setState(() {
        boxColor = Colors.white;
        _c = true;
      });
    });
    Timer(Duration(milliseconds: 1700), () {
      setState(() {
        _e = true;
      });
    });
    Timer(Duration(milliseconds: 3200), () {
      secondAnim = true;

      scaleController = AnimationController(
        vsync: this,
        duration: Duration(milliseconds: 1000),
      )..forward();
      scaleAnimation = Tween<double>(begin: 0.0, end: 12).animate(scaleController!);

      setState(() {
        boxColor = Colors.white;
        _d = true;
      });
    });
    Timer(Duration(milliseconds: 4000), () async{
      secondAnim = true;
      setState(() {});
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var isLogin = prefs.getBool('isLogin') ?? false;
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => isLogin ? MyHomePage(title: '',)  : LoginScreen()));
      // if (isWeb || isLinux) {
      //   ProKitWebLauncher().launch(context, isNewTask: true);
      // } else {
      //   ProKitLauncher().launch(context, isNewTask: true);
      // }
    });

    // afterBuildCreated(() async {
    //   setValue(appOpenCount, (getIntAsync(appOpenCount)) + 1);
    //   await appStore.setLanguage(getStringAsync(SELECTED_LANGUAGE_CODE, defaultValue: defaultLanguage), context: context);
    // });
  }


  @override
  void dispose() {
    scaleController!.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {
    double _h = MediaQuery.of(context).size.height;
    double _w = MediaQuery.of(context).size.width;
    // if(permissionStatusFuture == permGranted) {
    //   init();
    // }
    return Scaffold(
        backgroundColor: Colors.white,
        body:
        // FutureBuilder(
        // future: permissionStatusFuture,
        // builder: (context, snapshot) {
        //   // if we are waiting for data, show a progress indicator
        //   if (snapshot.connectionState == ConnectionState.waiting) {
        //     return CircularProgressIndicator();
        //   }
        //
        //   if (snapshot.hasError) {
        //     return Text('error while retrieving status: ${snapshot.error}');
        //   }
        //
        //   if (snapshot.hasData) {
        //     var textWidget = Text(
        //       "The permission status is ${snapshot.data}",
        //       style: TextStyle(fontSize: 20),
        //       softWrap: true,
        //       textAlign: TextAlign.center,
        //     );
        //     // The permission is granted, then just show the text
        //     if (snapshot.data == permGranted) {}
        //   }
        // })


        // permissionStatusFuture == permGranted
        // ?
        Center(
          child: Column(
            children: [
              AnimatedContainer(
                duration: Duration(milliseconds: _d ? 900 : 2500),
                curve: _d ? Curves.fastLinearToSlowEaseIn : Curves.elasticOut,
                height: _d
                    ? 0
                    : _a
                    ? _h / 2.5
                    : 20,
                width: 20,
              ),
              AnimatedContainer(
                duration: Duration(seconds: _c ? 2 : 0),
                curve: Curves.fastLinearToSlowEaseIn,
                height: _d
                    ? _h
                    : _c
                    ? 150
                    : 20,
                width: _d
                    ? _w
                    : _c
                    ? 300
                    : 20,
                decoration: BoxDecoration(
                    color: boxColor,
                    //shape: _c? BoxShape.rectangle : BoxShape.circle,
                    borderRadius: _d ? BorderRadius.only() : BorderRadius.circular(0)),
                child: secondAnim
                    ? Center(
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: 80,
                    decoration: BoxDecoration(color: Colors.white, shape: BoxShape.rectangle),
                    child: AnimatedBuilder(
                      animation: scaleAnimation!,
                      builder: (c, child) => Transform.scale(
                        scale: scaleAnimation!.value,
                        child: Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                )
                    : Center(
                  child: _e ? Column(
                    children: [
                      // SvgPicture.asset('assets/logo.svg', height: 100, fit: BoxFit.fill, color: Colors.white,),
                      // SizedBox(height: 10,),
                      Image.asset('assets/logo.png', height: 60, width: 70, fit: BoxFit.fill),
                      SizedBox(height: 10,),
                      Text('Edplus Management', style: GoogleFonts.openSans(color: appPrimary, fontSize: 25, fontWeight: FontWeight.bold),)
                    ],
                  ) : SizedBox()
                ),
              ),
            ],
          ),
        )
    );
  }
}