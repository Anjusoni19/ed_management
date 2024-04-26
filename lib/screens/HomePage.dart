import 'dart:async';

import 'package:ed_management/Colors.dart';
import 'package:ed_management/screens/Academic%20Screen.dart';
import 'package:ed_management/screens/Dashboard.dart';
import 'package:ed_management/screens/FeacturesSubItem/Notification%20Screen.dart';
import 'package:ed_management/screens/Profile%20Screen.dart';
import 'package:ed_management/screens/Report%20Screen.dart';
import 'package:ed_management/screens/Teacher%20Feactures%20Screen.dart';
import 'package:ed_management/services/ApisProvider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:motion_tab_bar/MotionBadgeWidget.dart';
import 'package:motion_tab_bar/MotionTabBar.dart';
import 'package:motion_tab_bar/MotionTabBarController.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
var webViewUrl = '';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, this.title}) : super(key: key);

  final String? title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}
var geotimeVal;

var photoUrl = '';
List ExamMarks = [];
List attendances = [];
List access = [];

bool isLoading = true;

var name;
var locationVal;

var myAttend;

var classtest;
var homework;
var notes;
var lead;
String day = '';
var feacturesList;
List groupVal = [];
var branchName;
Timer? timer;

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {
  // TabController? _tabController;
  MotionTabBarController? _motionTabBarController;
  String? _currentAddress;
  Position? _currentPosition;
  FlutterTts flutterTts = FlutterTts();

 var lat;
 var long;



  @override
  void initState() {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: appPrimary,
        systemNavigationBarColor: Colors.white
    ));
    super.initState();
    // askPermission();

    //// use "MotionTabBarController" to replace with "TabController", if you need to programmatically change the tab
    _motionTabBarController = MotionTabBarController(
      initialIndex: 0,
      length: 5,
      vsync: this,
    );
    _getCurrentPosition();
    fetchDatas();
  }

  Future<void> _getCurrentPosition() async {
    final hasPermission = await _handleLocationPermission();

    if (!hasPermission) return;
    await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
        .then((Position position) {
      setState(() => _currentPosition = position);
      _getAddressFromLatLng(_currentPosition!);
    }).catchError((e) {
      debugPrint(e);
    });
  }
  Future<bool> _handleLocationPermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Location services are disabled. Please enable the services')));
      return false;
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Location permissions are denied')));
        return false;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Location permissions are permanently denied, we cannot request permissions.')));
      return false;
    }
    return true;
  }
  Future<void> _getAddressFromLatLng(Position position) async {
    lat = _currentPosition!.latitude;
    long = _currentPosition!.longitude;

    await placemarkFromCoordinates(
        _currentPosition!.latitude, _currentPosition!.longitude)
        .then((List<Placemark> placemarks) {
      Placemark place = placemarks[0];
      setState(() {
        _currentAddress =
        '${place.street}, ${place.subLocality}, ${place.subAdministrativeArea}, ${place.postalCode}';
      });
    }).catchError((e) {
      debugPrint(e);
    });
  }

  updateLocation() async{
    print('In==');
    await _getCurrentPosition();
    int min = 5;
    var oneSecond = Duration(seconds: min);
    timer = Timer.periodic(oneSecond, (Timer timer) async{
      print('In==IN');
      var update = await ApiService().updateLocation(lat, long);
      print('update ====');
      print(update);
    });
  }


  fetchDatas() async{
    final prefs = await SharedPreferences.getInstance();
    branchName = prefs.getString('branchName');
    var data = await ApiService().dashboardData();
    if(data['status'] == true) {
      feacturesList = data['features'];

      // feacturesList.forEach((element) {
      //   if(groupVal.contains(element['group'])) {
      //
      //   } else {
      //     groupVal.add(element['group']);
      //   }
      // });
      print(groupVal);
      // ExamMarks = data['result'];
      myAttend = data['myattend'];
      // locationVal = data['location'];
      // geotimeVal = data['geotime'];
      // branchName = data['branchname'];
      // LoginData = data['login'];
      // attendances = data['attendances'];
      // photoUrl = data['photo'];
      // name = data['name'];
      // classtest = data['classtest'];
      // homework = data['homework'];
      // lead = data['lead'];
      // notes = data['notes'];
      // List quickAcess = data['access'];
      // quickAcess.forEach((element) {
      //   access.add(element['name']);
      // });
      print('myAttend========');
      print(myAttend);
      if(myAttend == 1){
        print('working==');
        await updateLocation();
      } else {
        timer!.cancel();
      }
      final DateTime now = DateTime.now();
      final DateFormat formatter = DateFormat('EEEE, dd MMM');
      final String formatted = formatter.format(now);
      day = formatted;
      // var voiceData = data['voice'] == null ? '' : data['voice'];
      // print("voice ========");
      // print(voiceData);
      // print(data['voice']);
      // await _speak(voiceData);
    }

    print('reportList');
    // print(dataList.length);
    setState(() {
      isLoading = false;
    });
  }

  Future _speak(voiceData) async{
    var voice = voiceData;
    await flutterTts.speak('$voice');
  }

  @override
  void dispose() {
    super.dispose();
    _motionTabBarController!.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text(widget.title!),
      // ),
      bottomNavigationBar: MotionTabBar(
        controller: _motionTabBarController, // Add this controller if you need to change your tab programmatically
        initialSelectedTab: "Home",
        useSafeArea: true, // default: true, apply safe area wrapper
        labels: const ["Home", "MIS", "Ed+","Notification", "Profile"],
        icons: const [Icons.home_outlined, Icons.insert_chart_outlined, Icons.add, Icons.notifications, Icons.person_pin_outlined],
        tabSize: 50,
        tabBarHeight: 55,
        textStyle:  GoogleFonts.poppins(
          fontSize: 10,
          color: appPrimary,
          fontWeight: FontWeight.bold,
        ),
        tabIconColor: appPrimary,
        tabIconSize: 28.0,
        tabIconSelectedSize: 26.0,
        tabSelectedColor: appPrimary,
        tabIconSelectedColor: Colors.white,
        tabBarColor: Colors.white,
        onTabItemSelected: (int value) {
          setState(() {
            _motionTabBarController!.index = value;
          });
        },
      ),
      body: TabBarView(
        physics: const NeverScrollableScrollPhysics(), // swipe navigation handling is not supported
        controller: _motionTabBarController,
        children: <Widget>[
          DashboardScreen(),
          ReportScreen(),
          TeacherFeactureScreen(),
          NotificationScreen(),
          Profile()
        ],
      ),
    );
  }
}
