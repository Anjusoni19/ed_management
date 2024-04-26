import 'dart:convert';

import 'package:ed_management/Colors.dart';
import 'package:ed_management/screens/Login%20Screen.dart';
import 'package:ed_management/services/ApisProvider.dart';
import 'package:ed_management/services/Models/user.dart';
import 'package:ed_management/services/custom%20loader.dart';
import 'package:ed_management/utill/textUtill.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toastification/toastification.dart';

import 'FeacturesSubItem/Add Reminder Screen.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {

  var profileList;

  bool isLoading = true;

  List dataList = [];

  var toDate;
  var fromDate;

  String _intervalValue = 'Select Reason';

  TextEditingController remark = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchProfileData();
  }

  fetchProfileData() async{
    final prefs = await SharedPreferences.getInstance();
    var data = prefs.getStringList('data');
    print('profileList=====${data}');

    profileList = data;
    print(profileList);

    // var attendance = await ApiService().attendanceData();
    // if(attendance['status'] == true) {
    //   dataList = attendance['data'];
    // }
    // print('academicList');
    // print(dataList.length);

    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isLoading
          ? Center(child: CircularProgressIndicator(color: appPrimary,),)
      : SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              SizedBox(height: 20,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ClipOval(child: Container(
                      color: appPrimary.withOpacity(0.1),
                      child: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Image.asset('assets/EdPlus-AI-Logoss.png', color: appPrimary, height: 40,),
                      ))),
                  // SizedBox(width: 5,),
                  Spacer(),
                  Text('Name',style: GoogleFonts.merriweather()),
                  Spacer(),

                ],
              ),
              SizedBox(height: 3,),
              Text('Address',style: GoogleFonts.merriweather()),
              // TextUtil(text: 'Shipra Path, Mansarovar, Jaipur', size: 16,),
              SizedBox(height: 4,),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextUtil(text: 'Contact: ', size: 13, color: Colors.red,),
                ],
              ),
              SizedBox(height: 10,),
              Divider(),
              SizedBox(height: 10,),
              Row(
                children: [
                  Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey.shade400)
                      ),
                      alignment: Alignment.center,
                      padding: EdgeInsets.symmetric(horizontal: 3, vertical: 10),
                      child: Icon(Icons.perm_contact_cal_outlined, color: appPrimary, size: 70,)),
                  SizedBox(width: 15,),
                  Column(
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width/1.8,
                        child: Row(
                          children: [
                            Text('Name:', style: GoogleFonts.merriweather(color: Colors.black, fontSize: 13, fontWeight: FontWeight.w500),),
                            SizedBox(width: 8,),
                            Text('${profileList[0]}', style: GoogleFonts.merriweather(color: Colors.black, fontSize: 12),),
                          ],
                        ),
                      ),
                      SizedBox(height: 5,),
                      Container(
                        width: MediaQuery.of(context).size.width/1.8,
                        child: Row(
                          children: [
                            Text('Father\'s Name:', style: GoogleFonts.merriweather(color: Colors.black, fontSize: 13, fontWeight: FontWeight.bold),),
                            SizedBox(width: 8,),
                            Text('${profileList[2]}', style: GoogleFonts.merriweather(color: Colors.black, fontSize: 12),),
                          ],
                        ),
                      ),
                      SizedBox(height: 5,),
                      Container(
                        width: MediaQuery.of(context).size.width/1.8,
                        child: Row(
                          children: [
                            Text('Email:', style: GoogleFonts.merriweather(color: Colors.black, fontSize: 13, fontWeight: FontWeight.bold),),
                            SizedBox(width: 8,),
                            Text('${profileList[1]}', style: GoogleFonts.merriweather(color: Colors.black, fontSize: 12),),
                          ],
                        ),
                      ),
                      SizedBox(height: 5,),
                      Container(
                        width: MediaQuery.of(context).size.width/1.8,
                        child: Row(
                          children: [
                            Text('Post:', style: GoogleFonts.merriweather(color: Colors.black, fontSize: 13, fontWeight: FontWeight.bold),),
                            SizedBox(width: 8,),
                            Text('${profileList[4]}', style: GoogleFonts.merriweather(color: Colors.black, fontSize: 12),),
                          ],
                        ),
                      ),
                      SizedBox(height: 5,),
                      Container(
                        width: MediaQuery.of(context).size.width/1.8,
                        child: Row(
                          children: [
                            Text('Phone:', style: GoogleFonts.merriweather(color: Colors.black, fontSize: 13, fontWeight: FontWeight.bold),),
                            SizedBox(width: 8,),
                            Text('${profileList[3]}', style: GoogleFonts.merriweather(color: Colors.black, fontSize: 12),),
                          ],
                        ),
                      ),
                    ],
                  )
                ],
              ),
              SizedBox(height: 20,),
              Spacer(),
              // Row(
              //   children: [
              //     Text("Attendance History", style: GoogleFonts.merriweather(color: appPrimary,)),
              //     Spacer(),
              //     InkWell(
              //       onTap: () {
              //         showDialog(
              //             context: context,
              //             builder: (context) {
              //               return StatefulBuilder(
              //                   builder: (context, newSetState) {
              //                     return AlertDialog(
              //                     backgroundColor: Colors.white,
              //                     insetPadding: EdgeInsets.only(top: 0,left: 0, right: 0, bottom: 70),
              //                     shape: RoundedRectangleBorder(
              //                         borderRadius: BorderRadius.circular(4)
              //                     ),
              //                     contentPadding: EdgeInsets.zero,
              //                     content: SizedBox(
              //                       width: MediaQuery.of(context).size.width/1.2,
              //                       height: MediaQuery.of(context).size.height/1.7,
              //                       child: Column(
              //                         children: <Widget>[
              //                           Column(
              //                             children: [
              //                               SizedBox(height: 10,),
              //                               Container(
              //                                 decoration: BoxDecoration(
              //                                     // color: appPrimary,
              //                                     borderRadius: BorderRadius.only(topRight: Radius.circular(4), bottomRight: Radius.circular(4))
              //                                 ),
              //                                 child: Padding(
              //                                   padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
              //                                   child:
              //                                   InkWell(
              //                                     onTap: () {
              //                                       Navigator.pop(context);
              //                                     },
              //                                     child: Text('Leave Form', style: GoogleFonts.merriweather(color : appPrimary, fontSize: 15, fontWeight: FontWeight.w500),),
              //                                   ),
              //                                 ),
              //                               ),
              //                               SizedBox(height: 10,),
              //                             ],
              //                           ),
              //                           Padding(
              //                             padding: const EdgeInsets.all(20.0),
              //                             child: Column(
              //                               children: [
              //                                 Container(
              //                                   width: MediaQuery.of(context).size.width/1,
              //                                   height: 45,
              //                                   padding: EdgeInsets.symmetric(horizontal: 8),
              //                                   decoration: BoxDecoration(
              //                                       border: Border.all(color: Colors.grey.shade400),
              //                                       borderRadius: BorderRadius.circular(4)
              //                                   ),
              //                                   child: DropdownButtonHideUnderline(
              //                                     child: DropdownButton<String>(
              //                                       hint: const Text('Select Reason'),
              //                                       value: _intervalValue,
              //                                       // isExpanded: true,
              //                                       items: ['Select Reason', 'Medical', 'Personal', 'Family', 'Other'].map(
              //                                             (String? value) {
              //                                           return DropdownMenuItem<String>(
              //                                             value: value,
              //                                             child: Text(value.toString()),
              //                                           );
              //                                         },
              //                                       ).toList(),
              //                                       onChanged: (value) {
              //                                         newSetState(() {
              //                                           _intervalValue = value!;
              //                                         });
              //                                       },
              //                                     ),
              //                                   ),
              //                                 ),
              //                                 SizedBox(height: 5,),
              //                                 GestureDetector(
              //                                   onTap: () async{
              //                                     final DateTime? picked = await showDatePicker(
              //                                         context: context,
              //                                         initialDate: DateTime.now(),
              //                                         firstDate: DateTime(2000),
              //                                         //DateTime.now() - not to allow to choose before today.
              //                                         lastDate: DateTime(3000)
              //                                     );
              //                                     print('pickedTimeT');
              //                                     // print(picked.asStream());
              //                                     // if (picked != null && picked != selectedDate) {
              //                                     var format = DateFormat('yyyy-MM-dd').format(picked!);
              //                                     newSetState(() {
              //                                       fromDate = format;
              //                                       // dateController = TextEditingController(text: endDate);
              //                                     });
              //                                   },
              //                                   child: Container(
              //                                       height: 50,
              //                                       decoration: BoxDecoration(
              //                                           border: Border.all(color: Colors.grey),
              //                                           borderRadius: BorderRadius.circular(4)
              //                                       ),
              //                                       alignment: Alignment.centerLeft,
              //                                       padding: EdgeInsets.only(left: 10),
              //                                       child: Text(fromDate == null ? 'From Date' : fromDate, style: GoogleFonts.inter(color: Colors.grey.shade700, fontSize: 14),)),
              //                                 ),
              //                                 SizedBox(height: 5,),
              //                                 GestureDetector(
              //                                   onTap: () async{
              //                                     final DateTime? picked = await showDatePicker(
              //                                         context: context,
              //                                         initialDate: DateTime.now(),
              //                                         firstDate: DateTime(2000),
              //                                         //DateTime.now() - not to allow to choose before today.
              //                                         lastDate: DateTime(3000)
              //                                     );
              //                                     print('pickedTimeT');
              //                                     // print(picked.asStream());
              //                                     // if (picked != null && picked != selectedDate) {
              //                                     var format = DateFormat('yyyy-MM-dd').format(picked!);
              //                                     newSetState(() {
              //                                       toDate = format;
              //                                       // dateController = TextEditingController(text: endDate);
              //                                     });
              //                                   },
              //                                   child: Container(
              //                                       height: 50,
              //                                       decoration: BoxDecoration(
              //                                           border: Border.all(color: Colors.grey),
              //                                           borderRadius: BorderRadius.circular(4)
              //                                       ),
              //                                       alignment: Alignment.centerLeft,
              //                                       padding: EdgeInsets.only(left: 10),
              //                                       child: Text(toDate == null ? 'To Date' : toDate, style: GoogleFonts.inter(color: Colors.grey.shade700, fontSize: 14),)),
              //                                 ),
              //                                 SizedBox(height: 5,),
              //                                 Container(
              //                                   height: 50,
              //                                   // decoration:const  BoxDecoration(
              //                                   //     border: Border(bottom: BorderSide(color: Colors.white))
              //                                   // ),
              //                                   alignment: Alignment.center,
              //                                   child:TextFormField(
              //                                     // readOnly: hintT == 'Time' ? true : false,
              //                                     controller: remark,
              //                                     cursorColor: appPrimary,
              //                                     style: const TextStyle(color: appPrimary, fontSize: 14),
              //                                     decoration:  InputDecoration(
              //                                       hintText: 'Remark',
              //                                         // labelText:  hintT,
              //                                         // labelStyle: TextStyle(color: appPrimary),
              //                                         fillColor: Colors.white,
              //                                         border: OutlineInputBorder(),
              //                                         focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: appPrimary, width: 1.5))
              //                                     ),
              //                                   ),
              //                                 )
              //                               ],
              //                             ),
              //                           ),
              //                           Spacer(),
              //                           // SizedBox(height: 30,),
              //                           Row(
              //                             mainAxisAlignment: MainAxisAlignment.center,
              //                             children: [
              //                               Container(
              //                                 width: MediaQuery.of(context).size.width/3,
              //                                 child: ElevatedButton(
              //                                   style: ElevatedButton.styleFrom(primary: appPrimary),
              //                                     onPressed: () async{
              //                                     fetchData(context);
              //                                     if(_intervalValue == 'Select Reason') {
              //                                       Navigator.pop(context);
              //                                       toastification.show(
              //                                         type: ToastificationType.warning,
              //                                         context: context,
              //                                         title: Text('Please Select Reason'),
              //                                         autoCloseDuration: const Duration(seconds: 3),
              //                                       );
              //                                     } else if(fromDate == null) {
              //                                       Navigator.pop(context);
              //                                       toastification.show(
              //                                         type: ToastificationType.warning,
              //                                         context: context,
              //                                         title: Text('Please Select From Date'),
              //                                         autoCloseDuration: const Duration(seconds: 3),
              //                                       );
              //                                     } else if(toDate == null) {
              //                                       Navigator.pop(context);
              //                                       toastification.show(
              //                                         type: ToastificationType.warning,
              //                                         context: context,
              //                                         title: Text('Please Select To Date'),
              //                                         autoCloseDuration: const Duration(seconds: 3),
              //                                       );
              //                                     } else if(remark.text == '') {
              //                                       Navigator.pop(context);
              //                                       toastification.show(
              //                                         type: ToastificationType.warning,
              //                                         context: context,
              //                                         title: Text('Please enter remark'),
              //                                         autoCloseDuration: const Duration(seconds: 3),
              //                                       );
              //                                     } else {
              //                                       print(fromDate);
              //                                       print(toDate);
              //                                       print(_intervalValue);
              //                                       print(remark.text);
              //                                       var result = await ApiService().addLeaveByStaff(fromDate, toDate, _intervalValue, remark.text.toString());
              //                                       if(result['status'] == true) {
              //                                         Navigator.pop(context);
              //                                         toastification.show(
              //                                           type: ToastificationType.success,
              //                                           context: context,
              //                                           title: Text('Success'),
              //                                           autoCloseDuration: const Duration(seconds: 3),
              //                                         );
              //                                         _intervalValue = 'Select Reason';
              //                                         fromDate = null;
              //                                         toDate = null;
              //                                         remark.clear();
              //                                         Navigator.pop(context);
              //                                       }else {
              //                                         toastification.show(
              //                                           type: ToastificationType.error,
              //                                           context: context,
              //                                           title: Text('Something went wrong!'),
              //                                           autoCloseDuration: const Duration(seconds: 3),
              //                                         );
              //
              //                                         Navigator.pop(context);
              //                                       }
              //                                     }
              //                                     },
              //                                     child: Text('Submit')
              //                                 ),
              //                               ),
              //                               SizedBox(width: 15,),
              //                               Container(
              //                                 width: MediaQuery.of(context).size.width/3,
              //                                 child: OutlinedButton(
              //                                     style: OutlinedButton.styleFrom(primary: appPrimary),
              //                                     onPressed: () {
              //                                       Navigator.pop(context);
              //                                       _intervalValue = 'Select Reason';
              //                                       fromDate = null;
              //                                       toDate = null;
              //                                       remark.clear();
              //                                     },
              //                                     child: Text('Close')
              //                                 ),
              //                               )
              //                             ],
              //                           ),
              //                           SizedBox(height: 30,),
              //                         ],
              //                       ),
              //                     ),
              //                   );
              //                 }
              //               );
              //             });
              //       },
              //       child: Container(
              //         height: 25,
              //          decoration: BoxDecoration(
              //            color: Colors.orange,
              //            borderRadius: BorderRadius.circular(8)
              //          ),
              //          alignment: Alignment.center,
              //          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              //          child: Text('Take Leave', style: GoogleFonts.merriweather(color: Colors.white,)
              //          ),),
              //     )
              //   ],
              // ),
              // SizedBox(height: 20,),
              // Expanded(
              //  child: ListView.builder(
              //   itemCount: dataList.length,
              //   itemBuilder: (BuildContext context, int index) {
              //     List timeData = dataList[index]['data'];
              //     return Card(
              //       elevation: 8.0,
              //       child: Padding(
              //         padding: const EdgeInsets.all(10.0),
              //         child: Column(
              //           children: [
              //             Row(
              //               children: [
              //                 Image.asset('assets/eventdate.png', height: 20,),
              //                 SizedBox(width: 8,),
              //                 Text('${dataList[index]['date']}', style: GoogleFonts.merriweather(color: appPrimary),),
              //               ],
              //             ),
              //             SizedBox(height: 20,),
              //             Container(
              //               height: timeData.isNotEmpty ?  timeData.length * 35 : 35,
              //               child: GridView.builder(
              //                 shrinkWrap: true,
              //                   physics: NeverScrollableScrollPhysics(),
              //                   itemCount: timeData.length,
              //                   gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
              //                     maxCrossAxisExtent: 120.0,
              //                     mainAxisSpacing: 5.0,
              //                     crossAxisSpacing: 80.0,
              //                     childAspectRatio: 2.0,
              //                   ),
              //                   itemBuilder: (BuildContext context, int i) {
              //                   return i%2 == 0
              //                     ?  Column(
              //                     children: [
              //                       Text('${dataList[index]['data'][i]['time']}', style: GoogleFonts.merriweather(color: Colors.green),),
              //                       Text('Check In', style: GoogleFonts.merriweather(color: Colors.black),),
              //                     ],
              //                   )
              //                     : Column(
              //                     children: [
              //                       Text('${dataList[index]['data'][i]['time']}', style: GoogleFonts.merriweather(color: Colors.red),),
              //                       Text('Check Out', style: GoogleFonts.merriweather(color: Colors.black),),
              //                     ],
              //                   );
              //                 }
              //               ),
              //             ),
              //             // SizedBox(width: 20,),
              //             // Column(
              //             //   children: [
              //             //     Text('${dataList[index]['data'][1]['time']}', style: GoogleFonts.merriweather(color: Colors.red),),
              //             //     Text('Check Out', style: GoogleFonts.merriweather(color: Colors.black),),
              //             //   ],
              //             // )
              //           ],
              //         ),
              //       ),
              //     );
              //   }
              // )),
              // Spacer(),
              SizedBox(height: 10,),
              InkWell(
                onTap: () async{
                  final prefs = await SharedPreferences.getInstance();
                  await prefs.setBool('isLogin', false);
                  Navigator.push(context, MaterialPageRoute(builder: (context) => LoginScreen()));
                },
                child: Container(
                  height: 40,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    border: Border.all(color: appPrimary),
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8)
                  ),
                  alignment: Alignment.center,
                  child:
                  Text("Log Out ?", style: GoogleFonts.merriweather(color: appPrimary,)
                  ),
                ),
              ),
              SizedBox(height: 20,)
            ],
          ),
        ),
      ),
    );
  }
}