import 'package:ed_management/Colors.dart';
import 'package:ed_management/screens/HomePage.dart';
import 'package:ed_management/utill/textUtill.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toastification/toastification.dart';

import 'FeacturesSubItem/Student Manage Screen.dart';
import 'fWebView.dart';

class TeacherFeactureScreen extends StatefulWidget {
  @override
  _TeacherFeactureScreenState createState() => _TeacherFeactureScreenState();
}

class _TeacherFeactureScreenState extends State<TeacherFeactureScreen> {
  bool checkboxValueCity = false;
  List allCities = ['Attendance', 'Appeal Box', 'Calling List', 'Expensive Ledger', 'Notes', 'Notification', 'Overdue Fees', 'Reminder', 'Task', 'Upload Result'];
  List<String> selectedCities = [];
  List feacturesValue = [];


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    allCities = access;
    fetch();
    fetchValue();
  }

  fetch() async{
    final prefs = await SharedPreferences.getInstance();
    var list = prefs.getStringList('quickAccess');
    print(list);
    selectedCities = list!;

  }
  fetchValue() {
      List datas = [];
      feacturesValue.clear();
      feacturesList.forEach((ele) {
        print(feacturesList);
        print(ele['group']);
        print('groupVal');
          feacturesValue.add(
              {
                'icon': ele['icon'],
                'name': ele['name'],
                'link': ele['link']
              }
          );
      print(datas);
      // feacturesValue.add({
      //   'grp_val': element,
      //   'data' : datas
      // });
      // datas.clear();
    });
    print('feactures value ===========');
    print('feactures value ===========${feacturesValue}');
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 20,),
              Row(
                children: [
                  Container(
                    decoration: BoxDecoration(
                        color: appPrimary,
                        borderRadius: BorderRadius.only(topRight: Radius.circular(4), bottomRight: Radius.circular(4))
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                      child:
                      Text('Feature', style: GoogleFonts.merriweather(color: Colors.white, fontSize: 13, fontWeight: FontWeight.w300),),
                    ),
                  ),
                  // Spacer(),
                  // InkWell(
                  //   onTap: () {
                  //     showDialog(
                  //         context: context,
                  //         builder: (context) {
                  //           return MyDialog(
                  //               cities: allCities,
                  //               selectedCities: selectedCities,
                  //               onSelectedCitiesListChanged: (cities) {
                  //                 selectedCities = cities;
                  //                 print(selectedCities);
                  //               });
                  //         });
                  //   },
                  //   child: Container(
                  //     decoration: BoxDecoration(
                  //       // color: appPrimary,
                  //       border: Border.all(color: Colors.grey, width: 0.5),
                  //       // borderRadius: BorderRadius.only(topRight: Radius.circular(0), bottomRight: Radius.circular(4))
                  //     ),
                  //     child: Padding(
                  //       padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                  //       child:
                  //       Row(
                  //         children: [
                  //           Image.asset('assets/heart.png', height: 17,),
                  //           // Icon(Icons.heart_broken, color: Colors.red,),
                  //           SizedBox(width: 10,),
                  //           Text('Quick Access', style: GoogleFonts.poppins(color: Colors.black, fontSize: 13, fontWeight: FontWeight.w300),),
                  //         ],
                  //       ),
                  //     ),
                  //   ),
                  // ),
                  SizedBox(width: 10,),
                ],
              ),
              SizedBox(height: 5,),
              Divider(),
              // SizedBox(height: 10,),
              Container(
                height: MediaQuery.of(context).size.height/1.4,
                width: MediaQuery.of(context).size.width,
                child: ListView.builder(
                    itemCount: feacturesValue.length,
                    itemBuilder: (BuildContext context, int i) {
                      return
                        InkWell(
                          onTap: () {
                            webViewUrl = feacturesList[i]['link'];
                            Navigator.push(context, MaterialPageRoute(builder: (context) => PageScreen()));
                          },
                          child: Container(
                            height: 70,
                            // width: 70,
                            child: Row(
                              children: [
                                Container(
                                    width: 50,
                                    height: 50,
                                    child: Image.network('${feacturesList[i]['icon']}',height: 17,)),
                                SizedBox(width: 5,),
                                TextUtil(text: '${feacturesList[i]['name']}', size: 10,),
                              ],
                            ),
                          ),
                        );
                    }
                ),
              ),
              // Padding(
              //   padding: const EdgeInsets.only(left: 10.0, right: 10, bottom: 5, top: 5),
              //   child: Container(
              //     // elevation: 8.0,
              //     decoration: BoxDecoration(
              //         color: Colors.white,
              //         border: Border.all(color: Colors.grey.shade300, width: 1.0),
              //         borderRadius: BorderRadius.circular(8.0)
              //     ),
              //     child: Padding(
              //       padding: const EdgeInsets.all(13.0),
              //       child: Column(
              //         children: [
              //           Row(
              //             children: [
              //               Text('Student Manage',style: GoogleFonts.merriweather(fontSize: 12)),
              //             ],
              //           ),
              //           SizedBox(height: 15,),
              //           Row(
              //             children: [
              //               SizedBox(width: 5,),
              //               Column(
              //                 children: [
              //                   Image.asset('assets/expensiveledger.png',height: 17,),
              //                   SizedBox(height: 5,),
              //                   TextUtil(text: 'Student Ledger', size: 10,),
              //                 ],
              //               ),
              //               SizedBox(width: 40,),
              //               InkWell(
              //                 onTap: () {
              //                   Navigator.push(context, MaterialPageRoute(builder: (context) => StudentMessageScreen()));
              //                 },
              //                 child: Column(
              //                   children: [
              //                     Image.asset('assets/fees_structure.png',height: 17,),
              //                     SizedBox(height: 5,),
              //                     TextUtil(text: 'Student Message', size: 10,),
              //                   ],
              //                 ),
              //               ),
              //             ],
              //           )
              //         ],
              //       ),
              //     ),
              //   ),
              // ),
              // Padding(
              //   padding: const EdgeInsets.only(left: 10.0, right: 10, bottom: 5, top: 5),
              //   child: Container(
              //     // elevation: 8.0,
              //     decoration: BoxDecoration(
              //         color: Colors.white,
              //         border: Border.all(color: Colors.grey.shade300, width: 1.0),
              //         borderRadius: BorderRadius.circular(8.0)
              //     ),
              //     child: Padding(
              //       padding: const EdgeInsets.all(13.0),
              //       child: Column(
              //         children: [
              //           Row(
              //             children: [
              //               Text('Finance',style: GoogleFonts.merriweather(fontSize: 12)),
              //             ],
              //           ),
              //           SizedBox(height: 15,),
              //           Row(
              //             children: [
              //               SizedBox(width: 5,),
              //               InkWell(
              //                 onTap: () {
              //                   Navigator.push(context, MaterialPageRoute(builder: (context) => OverdueFeesScreen()));
              //                 },
              //                 child: Column(
              //                   children: [
              //                     Image.asset('assets/uploadresult.png',height: 17,),
              //                     SizedBox(height: 5,),
              //                     TextUtil(text: 'Overdue Fees', size: 10,),
              //                   ],
              //                 ),
              //               ),
              //               SizedBox(width: 40,),
              //               InkWell(
              //                 onTap: () {
              //                   Navigator.push(context, MaterialPageRoute(builder: (context) => FeesExtendScreen()));
              //                 },
              //                 child: Column(
              //                   children: [
              //                     Image.asset('assets/uploadresult.png',height: 17,),
              //                     SizedBox(height: 5,),
              //                     TextUtil(text: 'Fees Extend', size: 10,),
              //                   ],
              //                 ),
              //               ),
              //               SizedBox(width: 40,),
              //               InkWell(
              //                 onTap: () {
              //                   Navigator.push(context, MaterialPageRoute(builder: (context) => FeesDepositScreen()));
              //                 },
              //                 child: Column(
              //                   children: [
              //                     Image.asset('assets/uploadresult.png',height: 17,),
              //                     SizedBox(height: 5,),
              //                     TextUtil(text: 'Fees Deposit', size: 10,),
              //                   ],
              //                 ),
              //               ),
              //               SizedBox(width: 40,),
              //               InkWell(
              //                 onTap: () {
              //                   Navigator.push(context, MaterialPageRoute(builder: (context) => ExpressPaymentScreen()));
              //                 },
              //                 child: Column(
              //                   children: [
              //                     Image.asset('assets/uploadresult.png',height: 17,),
              //                     SizedBox(height: 5,),
              //                     TextUtil(text: 'Express\nPayment', size: 10,),
              //                   ],
              //                 ),
              //               ),
              //             ],
              //           ),
              //           SizedBox(height: 15,),
              //           Row(
              //             children: [
              //               SizedBox(width: 5,),
              //               InkWell(
              //                 onTap: () {
              //                   notes = 8;
              //                   Navigator.push(context, MaterialPageRoute(builder: (context) => StudentMessageScreen()));
              //                 },
              //                 child: Column(
              //                   children: [
              //                     Image.asset('assets/uploadresult.png',height: 17,),
              //                     SizedBox(height: 5,),
              //                     TextUtil(text: 'Fees Reminder', size: 10,),
              //                   ],
              //                 ),
              //               ),
              //             ],
              //           ),
              //         ],
              //       ),
              //     ),
              //   ),
              // ),
              // Padding(
              //   padding: const EdgeInsets.only(left: 10.0, right: 10, bottom: 5, top: 5),
              //   child: Container(
              //     // elevation: 8.0,
              //     decoration: BoxDecoration(
              //         color: Colors.white,
              //         border: Border.all(color: Colors.grey.shade300, width: 1.0),
              //         borderRadius: BorderRadius.circular(8.0)
              //     ),
              //     child: Padding(
              //       padding: const EdgeInsets.all(13.0),
              //       child: Column(
              //         children: [
              //           Row(
              //             children: [
              //               Text('Edplus Special',style: GoogleFonts.merriweather(fontSize: 12)),
              //             ],
              //           ),
              //           SizedBox(height: 15,),
              //           Row(
              //             children: [
              //               SizedBox(width: 5,),
              //               InkWell(
              //                 onTap: (){
              //                   Navigator.push(context, MaterialPageRoute(builder: (context) => LeaveScreen()));
              //                 },
              //                 child: Column(
              //                   children: [
              //                     Icon(Icons.calendar_today_outlined, color: appPrimary, size: 15,),
              //                     // Image.asset('assets/noti.png',height: 17,),
              //                     SizedBox(height: 5,),
              //                     TextUtil(text: 'Leave Application', size: 10,),
              //                   ],
              //                 ),
              //               ),
              //               SizedBox(width: 40,),
              //               InkWell(
              //                 onTap: () {
              //                   notesValue = 'notes';
              //                   Navigator.push(context, MaterialPageRoute(builder: (context) => NotificationScreen()));
              //                 },
              //                 child: Column(
              //                   children: [
              //                     Image.asset('assets/notes.png',height: 17,),
              //                     SizedBox(height: 5,),
              //                     TextUtil(text: 'Notification', size: 10,),
              //                   ],
              //                 ),
              //               ),
              //               SizedBox(width: 40,),
              //               InkWell(
              //                 onTap: () {
              //                   // notesValue = 'notes';
              //                   Navigator.push(context, MaterialPageRoute(builder: (context) => LeadDashboardScreen()));
              //                 },
              //                 child: Column(
              //                   children: [
              //                     Image.asset('assets/notes.png',height: 17,),
              //                     SizedBox(height: 5,),
              //                     TextUtil(text: 'Library\nManage', size: 10,),
              //                   ],
              //                 ),
              //               ),
              //               SizedBox(width: 40,),
              //               InkWell(
              //                 onTap: () {
              //                   // notesValue = 'notes';
              //                   Navigator.push(context, MaterialPageRoute(builder: (context) => TaskScreen()));
              //                 },
              //                 child: Column(
              //                   children: [
              //                     Image.asset('assets/notes.png',height: 17,),
              //                     SizedBox(height: 5,),
              //                     TextUtil(text: 'Task\nManage', size: 10,),
              //                   ],
              //                 ),
              //               ),
              //             ],
              //           ),
              //           SizedBox(height: 20,),
              //           Row(
              //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //             children: [
              //               SizedBox(width: 5,),
              //               InkWell(
              //                 onTap: () {
              //                   Navigator.push(context, MaterialPageRoute(builder: (context) => AppealScreen()));
              //                 },
              //                 child: Column(
              //                   children: [
              //                     Icon(Icons.person_pin_outlined, color: appPrimary, size: 15,),
              //                     // Image.asset('assets/noti.png',height: 17,),
              //                     SizedBox(height: 5,),
              //                     TextUtil(text: 'Appeal Box', size: 10,),
              //                   ],
              //                 ),
              //               ),
              //               SizedBox(width: 20,),
              //               InkWell(
              //                 onTap: () {
              //                   Navigator.push(context, MaterialPageRoute(builder: (context) => CallingListScreen()));
              //                 },
              //                 child: Column(
              //                   children: [
              //                     Icon(Icons.contact_phone_outlined, color: appPrimary, size: 15,),
              //                     // Image.asset('assets/noti.png',height: 17,),
              //                     SizedBox(height: 5,),
              //                     TextUtil(text: 'Calling List', size: 10,),
              //                   ],
              //                 ),
              //               ),
              //               SizedBox(width: 20,),
              //               InkWell(
              //                 onTap: () {
              //                   Navigator.push(context, MaterialPageRoute(builder: (context) => LeadReportScreen()));
              //                 },
              //                 child: Column(
              //                   children: [
              //                     // Icon(Icons.contact_phone_outlined, color: appPrimary, size: 15,),
              //                     Image.asset('assets/lead.png',height: 17,),
              //                     SizedBox(height: 5,),
              //                     TextUtil(text: 'Lead\nReport', size: 10,),
              //                   ],
              //                 ),
              //               ),
              //               SizedBox(width: 20,),
              //               InkWell(
              //                 onTap: () {
              //                   Navigator.push(context, MaterialPageRoute(builder: (context) => GatePassScreen()));
              //                 },
              //                 child: Column(
              //                   children: [
              //                     // Icon(Icons.contact_phone_outlined, color: appPrimary, size: 15,),
              //                     Image.asset('assets/notes.png',height: 17,),
              //                     SizedBox(height: 5,),
              //                     TextUtil(text: 'Gatepass\nReport', size: 10,),
              //                   ],
              //                 ),
              //               ),
              //               SizedBox(width: 5,),
              //             ],
              //           ),
              //           SizedBox(height: 20,),
              //           Row(
              //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //             children: [
              //               SizedBox(width: 5,),
              //               InkWell(
              //                 onTap: () {
              //                   Navigator.push(context, MaterialPageRoute(builder: (context) => TransportDetailScreen()));
              //                 },
              //                 child: Column(
              //                   children: [
              //                     Icon(Icons.person_pin_outlined, color: appPrimary, size: 15,),
              //                     // Image.asset('assets/noti.png',height: 17,),
              //                     SizedBox(height: 5,),
              //                     TextUtil(text: 'Transport Detail', size: 10,),
              //                   ],
              //                 ),
              //               ),
              //               SizedBox(width: 20,),
              //               InkWell(
              //                 onTap: () {
              //                   Navigator.push(context, MaterialPageRoute(builder: (context) => TransportDriverDetailScreen()));
              //                 },
              //                 child: Column(
              //                   children: [
              //                     Icon(Icons.contact_phone_outlined, color: appPrimary, size: 15,),
              //                     // Image.asset('assets/noti.png',height: 17,),
              //                     SizedBox(height: 5,),
              //                     TextUtil(text: 'Transport Driver\nReport', size: 10,),
              //                   ],
              //                 ),
              //               ),
              //               SizedBox(width: 20,),
              //               InkWell(
              //                 onTap: () {
              //                   Navigator.push(context, MaterialPageRoute(builder: (context) => TransportRouteScreen()));
              //                 },
              //                 child: Column(
              //                   children: [
              //                     // Icon(Icons.contact_phone_outlined, color: appPrimary, size: 15,),
              //                     Image.asset('assets/lead.png',height: 17,),
              //                     SizedBox(height: 5,),
              //                     TextUtil(text: 'Transport Route\nReport', size: 10,),
              //                   ],
              //                 ),
              //               ),
              //               SizedBox(width: 20,),
              //               Column(
              //                 children: [
              //                   // Icon(Icons.contact_phone_outlined, color: appPrimary, size: 15,),
              //                   Image.asset('assets/notes.png',height: 17,),
              //                   SizedBox(height: 5,),
              //                   TextUtil(text: 'Lesson Plan', size: 10,),
              //                 ],
              //               ),
              //               SizedBox(width: 5,),
              //             ],
              //           ),
              //         ],
              //       ),
              //     ),
              //   ),
              // ),


            ],
          ),
        ),
      ),
    );
  }
}

class MyDialog extends StatefulWidget {
  MyDialog({
    required this.cities,
    required this.selectedCities,
    required this.onSelectedCitiesListChanged,
  });

  final List cities;
  final List<String> selectedCities;
  final ValueChanged<List<String>> onSelectedCitiesListChanged;

  @override
  _MyDialogState createState() => _MyDialogState();
}

class _MyDialogState extends State<MyDialog> {
  List<String> _tempSelectedCities = [];
  @override
  void initState() {
    _tempSelectedCities = widget.selectedCities;
    super.initState();
    // fetchValue();
  }


  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.white,
      insetPadding: EdgeInsets.only(top: 5,left: 5, right: 5, bottom: 80),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8)
      ),
      contentPadding: EdgeInsets.zero,
      content: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: <Widget>[
            Card(
              margin: EdgeInsets.zero,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.only(topLeft: Radius.circular(8), topRight: Radius.circular(8))),
              child: Container(
                height: 50,
                child: Padding(
                  padding: const EdgeInsets.only(top: 10.0, left: 10, right: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        'Quick Access',
                        style: TextStyle(fontSize: 18.0, color: appPrimary, fontWeight: FontWeight.w600),
                        textAlign: TextAlign.center,
                      ),
                      InkWell(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Icon(Icons.close))
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                  padding: EdgeInsets.zero,
                  itemCount: widget.cities.length,
                  itemBuilder: (BuildContext context, int index) {
                    final cityName = widget.cities[index];
                    return Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          height: 35,
                          child: CheckboxListTile(
                              dense: true,
                              contentPadding: EdgeInsets.symmetric(horizontal: 5),
                              title: Row(
                                children: [
                                  Container(
                                      width: 35,
                                      height: 35,
                                      decoration: BoxDecoration(
                                          color: Colors.grey.shade300,
                                          borderRadius: BorderRadius.circular(6.0)
                                      ),
                                      alignment: Alignment.center,
                                      padding: EdgeInsets.all(6),
                                      child: Image.asset('assets/notes.png', height: 17,)),
                                  SizedBox(width: 10,),
                                  Text(cityName, style: GoogleFonts.merriweather(color: appPrimary, fontSize: 14),),
                                ],
                              ),
                              value: _tempSelectedCities.contains(cityName),
                              activeColor: appPrimary,
                              hoverColor: appPrimary,
                              checkColor: Colors.white,
                              onChanged: (bool? value) async{
                                if (_tempSelectedCities.length > 3) {
                                  toastification.show(
                                    type: ToastificationType.success,
                                    context: context,
                                    title: Text('You can only pick 4 items'),
                                    autoCloseDuration: const Duration(seconds: 3),
                                  );
                                } else {
                                  if (value!) {
                                    if (!_tempSelectedCities.contains(cityName)) {
                                      setState(() {
                                        _tempSelectedCities.add(cityName);
                                      });
                                    }
                                  } else {
                                    if (_tempSelectedCities.contains(cityName)) {
                                      setState(() {
                                        _tempSelectedCities.removeWhere(
                                                (String city) => city == cityName);
                                      });
                                    }
                                  }
                                  // selectedCities = selectedCities;
                                  // print(selectedCities);
                                }
                                widget
                                    .onSelectedCitiesListChanged(_tempSelectedCities);

                                final prefs = await SharedPreferences.getInstance();
                                await prefs.setStringList('quickAccess', _tempSelectedCities);

                              }),
                        ),
                        SizedBox(height: 10,),
                        Divider()
                      ],
                    );
                  }),
            ),
          ],
        ),
      ),
    );
  }
}