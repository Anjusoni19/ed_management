
import 'dart:async';
import 'package:camera/camera.dart';
import 'package:flutter/services.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:ed_management/Colors.dart';
import 'package:ed_management/screens/Account%20Screen.dart';
import 'package:ed_management/screens/FeacturesSubItem/Attendance%20Screen.dart';
import 'package:ed_management/screens/FeacturesSubItem/Notes%20Screen.dart';
import 'package:ed_management/screens/Scanner%20Screen.dart';
import 'package:ed_management/services/ApisProvider.dart';
import 'package:ed_management/services/custom%20loader.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_tts/flutter_tts_web.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toastification/toastification.dart';

import 'HomePage.dart';
import 'animatedButton.dart';

class DashboardScreen extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}
List LoginData = [];
String notesValue = '';
// String notesValue = '';
var imagePath ;


class _DashboardState extends State<DashboardScreen> {
  var _toggleValue;
  bool isLoading = true;
 List quickAcess = [];

  Future<PermissionStatus> _getCameraPermission() async {
    var status = await Permission.camera.status;
    if (!status.isGranted) {
      final result = await Permission.camera.request();
      return result;
    } else {
      return status;
    }
  }

  askPermission() async{
    PermissionStatus status = await _getCameraPermission();
    if (status.isGranted) {
      Navigator.push(context, MaterialPageRoute(builder: (context) => Scanner()));
    } else {
      print('object');
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchDate();
  }
  fetchDate() async{
    final prefs = await SharedPreferences.getInstance();
    var list = prefs.getStringList('quickAccess') ?? [];
    print(list);
    quickAcess = list;
    print('quickAcess');
    print(quickAcess);

    var oneSecond = Duration(seconds: 3);

    Timer.periodic(oneSecond, (Timer timer) async{
      setState(() {
        isLoading = false;
        _toggleValue = myAttend;
        print('_toggleValue');
        print(_toggleValue);
        timer.cancel();
      });
    });
    }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        final shouldPop = await showDialog<bool>(
          context: context,
          builder: (context) {
            return AlertDialog(
              title:  Text('Do you want to go back?', style: GoogleFonts.openSans(fontWeight: FontWeight.bold),),
              actionsAlignment: MainAxisAlignment.spaceBetween,
              actions: [
                TextButton(
                  onPressed: () {
                    SystemNavigator.pop();
                    // Navigator.pop(context, true);
                  },
                  child: const Text('Yes'),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pop(context, false);
                  },
                  child: const Text('No'),
                ),
              ],
            );
          },
        );
        return shouldPop!;
      },
      child: Scaffold(
        body: SafeArea(
          child: isLoading
            ? Center(child: CircularProgressIndicator(color: appPrimary,),)
            : Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: appPrimary,
                  borderRadius: BorderRadius.only(bottomLeft: Radius.circular(16), bottomRight: Radius.circular(16))
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 10.0),
                      child: Row(
                        children: [
                          ClipRRect(
                              // decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(60),
                              // ),
                              child: Container(
                                  height: 50,
                                  width: 50,
                                  child: Image.network(photoUrl, height: 50,))),
                          SizedBox(width: 8,),
                          // InkWell(
                          //   onTap: () {
                          //     // Navigator.push(context, MaterialPageRoute(builder: (context) => AccountScreen()));
                          //   },
                          //   child: Container(
                          //     width: MediaQuery.of(context).size.width/3.5,
                          //     decoration: BoxDecoration(
                          //         border: Border.all(color: Colors.white),
                          //         borderRadius: BorderRadius.circular(4)
                          //     ),
                          //     alignment: Alignment.center,
                          //     padding: EdgeInsets.symmetric(horizontal: 2, vertical: 2),
                          //     child: Text('${branchName}',
                          //       textAlign: TextAlign.center,
                          //       style: GoogleFonts.inter(color: Colors.white, fontSize: 13),),
                          //   ),
                          // ),
                          Spacer(),
                          AnimatedToggle(
                            values: ['Duty On', 'Duty Off'],
                            onToggleCallback: (value) async{
                              setState(() {
                                print(_toggleValue);
                                _toggleValue = value;
                              });
                            },
                            buttonColor: myAttend == 0 ? Colors.green : Colors.red,
                            backgroundColor:  Colors.grey.shade200,
                            textColor: const Color(0xFFFFFFFF),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 15.0, top: 5, right: 10),
                      child: Row(
                        children: [
                          Column(
                            children: [
                              Text('$name', style: GoogleFonts.merriweather(fontSize: 17, fontWeight: FontWeight.bold, color: Colors.white),),
                              SizedBox(height: 5,),
                              Text('$day', style: GoogleFonts.merriweather(fontSize: 11, color: Colors.pinkAccent.shade100),),
                            ],
                          ),
                          // Spacer(),
                          // InkWell(
                          //   onTap: () {
                          //     askPermission();
                          //   },
                          //   child: Container(
                          //     // width: MediaQuery.of(context).size.width/2.5,
                          //     decoration: BoxDecoration(
                          //         border: Border.all(color: Colors.white),
                          //         borderRadius: BorderRadius.circular(4)
                          //     ),
                          //     alignment: Alignment.center,
                          //     padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                          //     child: Row(
                          //       children: [
                          //         Icon(Icons.qr_code_scanner, color: Colors.white, size: 18,),
                          //         SizedBox(width: 10,),
                          //         Text('Attendance Scanner', style: GoogleFonts.inter(color: Colors.white, fontSize: 12),),
                          //       ],
                          //     ),
                          //   ),
                          // ),
                        ],
                      ),
                    ),
                    SizedBox(height: 15,),
                  ],
                ),
              ),
              quickAcess.isEmpty
                  ? Container()
                  :  SizedBox(height: 15,),
              quickAcess.isEmpty
              ? Container()
              : Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: Row(
                  children: [
                    Text('Quick Access', style: GoogleFonts.poppins(fontSize: 15, fontWeight: FontWeight.w500),)
                  ],
                ),
              ),
              quickAcess.isEmpty
                  ? Container()
                  : Container(
                    height: 100,
                    width: MediaQuery.of(context).size.width,
                    alignment: Alignment.center,
                    child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      ListView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemCount: quickAcess.length,
                          itemBuilder: (context,index){
                          return Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: InkWell(
                              onTap: () {
                                // Navigator.push(context, MaterialPageRoute(builder: (context) => AttendanceReportScreen()));
                              },
                              child: Card(
                                elevation: 2,
                                child: Container(
                                  alignment: Alignment.center,
                                  width: MediaQuery.of(context).size.width/5,
                                  child: Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Column(
                                      children: [
                                        Icon(Icons.calendar_month, color: appPrimary, size: 22,),
                                        SizedBox(height: 8,),
                                        Text('${quickAcess[index]}',
                                          textAlign: TextAlign.center,
                                          style: GoogleFonts.inter(fontSize: 10, fontWeight: FontWeight.bold),)
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          );
                        }
                      ),
                    ],
                  ),
                ),
              ),
              // Padding(
              //   padding: const EdgeInsets.only(left: 10.0, right: 10),
              //   child: Padding(
              //     padding: const EdgeInsets.all(10.0),
              //     child: Row(
              //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //       children: [
              //         Container(
              //           width: MediaQuery.of(context).size.width/6.5,
              //           height: 55,
              //           decoration: BoxDecoration(
              //             color: appPrimary.withOpacity(0.05),
              //             borderRadius: BorderRadius.circular(8)
              //           ),
              //           child: Padding(
              //             padding: const EdgeInsets.all(5.0),
              //             child: Column(
              //               mainAxisAlignment: MainAxisAlignment.center,
              //               children: [
              //                 Text('Calling List',
              //                   textAlign: TextAlign.center,
              //                   style: GoogleFonts.merriweather(fontSize: 8),),
              //                 SizedBox(height: 3,),
              //                 Row(
              //                   mainAxisAlignment: MainAxisAlignment.center,
              //                   children: [
              //                     Text('46', style: GoogleFonts.poppins(fontSize: 15, fontWeight: FontWeight.bold),),
              //                     Text('/0', style: GoogleFonts.merriweather(fontSize: 10, color: appPrimary),),
              //                   ],
              //                 )
              //               ],
              //             ),
              //           ),
              //         ),
              //         InkWell(
              //           onTap: () {
              //             notesValue = 'classtest';
              //             Navigator.push(context, MaterialPageRoute(builder: (context) => NotesScreen()));
              //           },
              //           child: Container(
              //             height: 55,
              //             width: MediaQuery.of(context).size.width/6.5,
              //             decoration: BoxDecoration(
              //                 color: appPrimary.withOpacity(0.05),
              //                 borderRadius: BorderRadius.circular(8)
              //             ),
              //             alignment: Alignment.center,
              //             child: Padding(
              //               padding: const EdgeInsets.all(5.0),
              //               child: Column(
              //                 mainAxisAlignment: MainAxisAlignment.center,
              //                 children: [
              //                   Text('Class Test',
              //                     textAlign: TextAlign.center,
              //                     style: GoogleFonts.merriweather(fontSize: 8),),
              //                   SizedBox(height: 5,),
              //                   Text('${classtest == null ? 0 : classtest}',
              //                     textAlign: TextAlign.center,
              //                     style: GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.bold),)
              //                 ],
              //               ),
              //             ),
              //           ),
              //         ),
              //         Container(
              //           height: 55,
              //           width: MediaQuery.of(context).size.width/6.5,
              //           decoration: BoxDecoration(
              //               color: appPrimary.withOpacity(0.05),
              //               borderRadius: BorderRadius.circular(8)
              //           ),
              //           child: Padding(
              //             padding: const EdgeInsets.all(5.0),
              //             child: Column(
              //               mainAxisAlignment: MainAxisAlignment.center,
              //               children: [
              //                 Text('Home Work',
              //                   textAlign: TextAlign.center,
              //                   style: GoogleFonts.merriweather(fontSize: 8),),
              //                 SizedBox(height: 5,),
              //                 Text('${homework == null ? 0 : homework}',
              //                   textAlign: TextAlign.center,
              //                   style: GoogleFonts.inter(fontSize: 12, fontWeight: FontWeight.bold),)
              //               ],
              //             ),
              //           ),
              //         ),
              //         Container(
              //           width: MediaQuery.of(context).size.width/6.5,
              //           height: 55,
              //           decoration: BoxDecoration(
              //               color: appPrimary.withOpacity(0.05),
              //               borderRadius: BorderRadius.circular(8)
              //           ),
              //           child: Padding(
              //             padding: const EdgeInsets.all(8.0),
              //             child: Column(
              //               mainAxisAlignment: MainAxisAlignment.center,
              //               children: [
              //                 Text('Notes',
              //                   textAlign: TextAlign.center,
              //                   style: GoogleFonts.merriweather(fontSize: 8),),
              //                 SizedBox(height: 5,),
              //                 Text('${notes == null ? 0 : notes}',
              //                   textAlign: TextAlign.center,
              //                   style: GoogleFonts.inter(fontSize: 12, fontWeight: FontWeight.bold),)
              //               ],
              //             ),
              //           ),
              //         ),
              //         Container(
              //           height: 55,
              //           width: MediaQuery.of(context).size.width/6.5,
              //           decoration: BoxDecoration(
              //               color: appPrimary.withOpacity(0.05),
              //               borderRadius: BorderRadius.circular(8)
              //           ),
              //           child: Padding(
              //             padding: const EdgeInsets.all(8.0),
              //             child: Column(
              //               mainAxisAlignment: MainAxisAlignment.center,
              //               children: [
              //                 Text('Lead',
              //                   textAlign: TextAlign.center,
              //                   style: GoogleFonts.merriweather(fontSize: 8),),
              //                 SizedBox(height: 5,),
              //                 Text('${lead == null ? 0 : lead}',
              //                   textAlign: TextAlign.center,
              //                   style: GoogleFonts.inter(fontSize: 12, fontWeight: FontWeight.bold),)
              //               ],
              //             ),
              //           ),
              //         ),
              //       ],
              //     ),
              //   ),
              // ),
              // SizedBox(height: 5,),
              attendances.isEmpty
              ? Container()
              : Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: Row(
                  children: [
                    Text('Attendances',
                      style: GoogleFonts.poppins(fontSize: 15, fontWeight: FontWeight.w500),)
                  ],
                ),
              ),
              attendances.isEmpty
                  ? Container()
                  : Container(
                height: 115,
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    // shrinkWrap: true,
                    itemCount: attendances.length,
                    itemBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding: const EdgeInsets.only(left: 10.0, right: 10),
                      child: Card(
                        elevation: 2.0,
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Container(
                            alignment: Alignment.center,
                            // height: 150,
                            // color: Colors.orange.shade50,
                            width: MediaQuery.of(context).size.width/1.4,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Text('${attendances[index]['standard']}',
                                      style: GoogleFonts.merriweather(fontSize: 14, fontWeight: FontWeight.bold,color: appPrimary),),
                                  ],
                                ),
                                // Container(color: Colors.grey.shade400, width: 1, height: 30,),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      width: MediaQuery.of(context).size.width/6.5,
                                      decoration: BoxDecoration(
                                        color: Colors.orange.withOpacity(0.1),
                                        borderRadius: BorderRadius.circular(4)
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child: Column(
                                          children: [
                                            Text('${attendances[index]['student']}', style: GoogleFonts.poppins(fontSize: 15, ),),
                                            SizedBox(height: 2),
                                            Text('Total', style: GoogleFonts.merriweather(fontSize: 10, fontWeight: FontWeight.bold),)
                                          ],
                                        ),
                                      ),
                                    ),
                                    Container(
                                      width: MediaQuery.of(context).size.width/6.5,
                                      decoration: BoxDecoration(
                                          color: Colors.orange.withOpacity(0.1),
                                          borderRadius: BorderRadius.circular(4)
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child: Column(
                                          children: [
                                            Text('${attendances[index]['present'] == null ? 0 : attendances[index]['present']}', style: GoogleFonts.poppins(fontSize: 15, color: Colors.green.shade700),),
                                            SizedBox(height: 2,),
                                            Text('Present', style: GoogleFonts.merriweather(fontSize: 10, color: Colors.green.shade700, fontWeight: FontWeight.bold),)
                                          ],
                                        ),
                                      ),
                                    ),
                                    // Container(color: Colors.grey.shade400, width: 1, height: 30,),
                                    Container(
                                      width: MediaQuery.of(context).size.width/6.5,
                                      decoration: BoxDecoration(
                                          color: Colors.orange.withOpacity(0.1),
                                          borderRadius: BorderRadius.circular(4)
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child: Column(
                                          children: [
                                            Text('${attendances[index]['absent'] == null ? 0 : attendances[index]['absent']}',
                                              style: GoogleFonts.poppins(fontSize: 15, color: Colors.red.shade700),),
                                            SizedBox(height: 2,),
                                            Text('Absent', style: GoogleFonts.merriweather(fontSize: 10, color: Colors.red.shade700, fontWeight: FontWeight.bold),)
                                          ],
                                        ),
                                      ),
                                    ),
                                    // Container(color: Colors.grey.shade400, width: 1, height: 30,),
                                    Container(
                                      width: MediaQuery.of(context).size.width/6.5,
                                      decoration: BoxDecoration(
                                          color: Colors.orange.withOpacity(0.1),
                                          borderRadius: BorderRadius.circular(4)
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child: Column(
                                          children: [
                                            Text('${attendances[index]['leave'] == null ? 0 : attendances[index]['leave']}',
                                              style: GoogleFonts.poppins(fontSize: 15, color: Colors.blue.shade700),),
                                            SizedBox(height: 2,),
                                            Text('Leave', style: GoogleFonts.merriweather(fontSize: 10, color: Colors.blue.shade700, fontWeight: FontWeight.bold),)
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                // Container(color: Colors.grey.shade400, width: 1, height: 30,),

                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  }
                ),
              ),
              SizedBox(height: 10,),
              ExamMarks.isEmpty
                  ? Container()
                  :Padding(
                padding: const EdgeInsets.only(left: 15.0),
                child: Row(
                   children: [
                     Text('Exam Marks',
                       style: GoogleFonts.poppins(fontSize: 15, fontWeight: FontWeight.w500),)
                   ],
                ),
              ),
              SizedBox(height: 5,),
              ExamMarks.isEmpty
                  ? Container()
                  :Container(
                height: 110,
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    // shrinkWrap: true,
                    itemCount: ExamMarks.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Padding(
                        padding: const EdgeInsets.only(left: 10.0, right: 10),
                        child: Container(
                          decoration: BoxDecoration(
                            color: index == 0 ? Colors.red.withOpacity(0.05): Colors.green.withOpacity(0.05),
                            borderRadius: BorderRadius.circular(20)
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Container(
                              alignment: Alignment.center,
                              height: 100,
                              width: MediaQuery.of(context).size.width/2,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Text('${ExamMarks[index]['exam']}', style: GoogleFonts.merriweather(fontSize: 16, color: index == 0 ? Colors.red.shade900:Colors.green.shade900),),
                                    ],
                                  ),
                                  Container(color: index == 0 ? Colors.red.shade200 : Colors.green.shade200, height: 1,),
                                  SizedBox(width: 15),
                                  Column(
                                    children: [
                                      Row(
                                        children: [
                                          Text('${ExamMarks[index]['standard']}', style: GoogleFonts.merriweather(fontSize: 12,fontWeight: FontWeight.bold ),),
                                        ],
                                      ),
                                      SizedBox(height: 2),
                                      Row(
                                        children: [
                                          Text('${ExamMarks[index]['subject']}', style: GoogleFonts.merriweather(fontSize: 12),),
                                        ],
                                      )
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Text('${ExamMarks[index]['upload']}', style: GoogleFonts.merriweather(fontSize: 15, color: index == 0 ? Colors.red:Colors.green),),
                                      Text('/${ExamMarks[index]['student']}', style: GoogleFonts.merriweather(fontSize: 15, color: appPrimary),),
                                    ],
                                  ),

                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    }
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


// A screen that allows users to take a picture using a given camera.
class TakePictureScreen extends StatefulWidget {
  const TakePictureScreen({
    super.key,
    required this.camera,
  });

  final CameraDescription camera;

  @override
  TakePictureScreenState createState() => TakePictureScreenState();
}

class TakePictureScreenState extends State<TakePictureScreen> {
  late CameraController _controller;
  late Future<void> _initializeControllerFuture;


  @override
  void initState() {
    super.initState();
    // To display the current output from the Camera,
    // create a CameraController.
    _controller = CameraController(
      // Get a specific camera from the list of available cameras.
      widget.camera,
      // Define the resolution to use.
      ResolutionPreset.medium,
    );

    // Next, initialize the controller. This returns a Future.
    _initializeControllerFuture = _controller.initialize();
  }

  @override
  void dispose() {
    // Dispose of the controller when the widget is disposed.
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Take a picture')),
      // You must wait until the controller is initialized before displaying the
      // camera preview. Use a FutureBuilder to display a loading spinner until the
      // controller has finished initializing.
      body: FutureBuilder<void>(
        future: _initializeControllerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            // If the Future is complete, display the preview.
            return CameraPreview(_controller);
          } else {
            // Otherwise, display a loading indicator.
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        // Provide an onPressed callback.
        onPressed: () async {
          // Take the Picture in a try / catch block. If anything goes wrong,
          // catch the error.
          try {
            // Ensure that the camera is initialized.
            await _initializeControllerFuture;

            // Attempt to take a picture and get the file `image`
            // where it was saved.
            final image = await _controller.takePicture();

            if (!context.mounted) return;
             imagePath = image.path;
            // If the picture was taken, display it on a new screen.
            Navigator.pop(context);
          } catch (e) {
            // If an error occurs, log the error to the console.
            print(e);
          }
        },
        child: const Icon(Icons.camera_alt),
      ),
    );
  }
}
