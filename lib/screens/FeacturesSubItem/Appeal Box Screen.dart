import 'dart:io';

import 'package:ed_management/Colors.dart';
import 'package:ed_management/screens/FeacturesSubItem/AddStudentScreen.dart';
import 'package:ed_management/screens/HomePage.dart';
import 'package:ed_management/services/ApisProvider.dart';
import 'package:ed_management/services/custom%20loader.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:toastification/toastification.dart';

class AppealScreen extends StatefulWidget {
  @override
  _AppealScreenState createState() => _AppealScreenState();
}

class _AppealScreenState extends State<AppealScreen> {

  TextEditingController subject = TextEditingController();
  TextEditingController description = TextEditingController();
  TextEditingController name = TextEditingController();
  TextEditingController mobile = TextEditingController();
  TextEditingController amobile = TextEditingController();

  int SelectValue = 0;

  bool isSelect = false;

  var _intervalValue = 'Select Department';

  bool isLevel = true;
  bool isAppealForm = true;
  bool isLoading = true;

  var isValue = 1;
  List dataList = [];

  String  isMode = 'Query';

  List departmentList = [];

  String _imagepath = '';
  final ImagePicker imgpicker = ImagePicker();
  Future getImage() async {
    try {
      var pickedFile = await imgpicker.pickImage(source: ImageSource.camera);
      if (pickedFile != null) {
        setState(() {
          _imagepath = pickedFile.path;
        });
      } else {
        print("No image is selected.");
      }
    } catch (e) {
      print("error while picking image.");
    }
  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchDatas();
  }

  fetchDatas() async{
    var filterData = await ApiService().appealViewData();
    print(filterData);
    dataList = filterData['data'];
    List departmentList2 = filterData['department'];
    departmentList2.forEach((element) {
      departmentList.add(element['name']);
    });
    _intervalValue = departmentList.first;

    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          automaticallyImplyLeading: false,
          title: Text('Appeal Box', style: GoogleFonts.inter(color: appPrimary, fontSize: 18),),
          actions: [
            InkWell(
              onTap: () {
                showDialog(
                    context: context,
                    builder: (context) {
                      return StatefulBuilder(
                          builder: (context, newSetState) {
                            return AlertDialog(
                              backgroundColor: Colors.white,
                              insetPadding: EdgeInsets.zero,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8)
                              ),
                              contentPadding: EdgeInsets.zero,
                              content: SingleChildScrollView(
                                child: Container(
                                  width: MediaQuery.of(context).size.width,
                                  height: isValue == 4 ? MediaQuery.of(context).size.height + 80 :  MediaQuery.of(context).size.height ,
                                  child: Column(
                                    // crossAxisAlignment: CrossAxisAlignment.end,
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        width: MediaQuery.of(context).size.width,
                                        height: 45,
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.only(topRight: Radius.circular(8), topLeft: Radius.circular(8))
                                        ),
                                        alignment: Alignment.centerLeft,
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            SizedBox(width: 20,),
                                            Text('Register Appeal', style: GoogleFonts.inter(fontSize: 18,color: Colors.black, fontWeight: FontWeight.bold),),
                                            Spacer(),
                                            InkWell(
                                                onTap: () {
                                                  Navigator.pop(context);
                                                },
                                                child: Icon(Icons.close, color: Colors.black,)),
                                            SizedBox(width: 20,),
                                          ],
                                        ),
                                      ),
                                      Divider(color: Colors.grey,),

                                      // Padding(
                                      //   padding: const EdgeInsets.symmetric(horizontal: 20.0),
                                      //   child: Container(
                                      //     height: 40,
                                      //     width: MediaQuery.of(context).size.width,
                                      //     decoration: BoxDecoration(
                                      //         border: Border.all(color: Colors.grey),
                                      //         borderRadius: BorderRadius.circular(4)
                                      //     ),
                                      //     padding: EdgeInsets.symmetric(horizontal: 10),
                                      //     child: DropdownButtonHideUnderline(
                                      //       child: DropdownButton<String>(
                                      //         hint: const Text('Query'),
                                      //         // value: _intervalValue,
                                      //         // isExpanded: true,
                                      //         items: ['Query', 'Complain', 'Suggestion'].map(
                                      //               (String? value) {
                                      //             return DropdownMenuItem<String>(
                                      //               value: value,
                                      //               child: Text(value.toString()),
                                      //             );
                                      //           },
                                      //         ).toList(),
                                      //         onChanged: (value) {
                                      //           setState(() {
                                      //             _intervalValue = value!;
                                      //           });
                                      //         },
                                      //       ),
                                      //     ),
                                      //   ),
                                      // ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 5),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            InkWell(
                                              onTap: () {
                                                newSetState(() {
                                                  isMode = 'Query';
                                                });
                                              },
                                              child: Container(
                                                width: MediaQuery.of(context).size.width/4.5,
                                                height: 35,
                                                decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(4),
                                                  border: Border.all(color: Colors.grey.shade400)
                                                ),
                                                alignment: Alignment.center,
                                                child: Padding(
                                                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                                  child: Row(
                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                    children: [
                                                      Icon(isMode == 'Query' ? Icons.check_box : Icons.check_box_outline_blank_rounded, color: isMode == 'Query' ? appPrimary : Colors.grey, size: 18,),
                                                      // SizedBox(width: 8,),
                                                      Spacer(),
                                                      Text('Query', style: GoogleFonts.inter(fontSize: 14),)
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                            InkWell(
                                              onTap: () {
                                                newSetState(() {
                                                  isMode = 'Suggestion';
                                                });
                                              },
                                              child: Container(
                                                width: MediaQuery.of(context).size.width/3.2,
                                                height: 35,
                                                decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.circular(4),
                                                    border: Border.all(color: Colors.grey.shade400)
                                                ),
                                                alignment: Alignment.center,
                                                child: Padding(
                                                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                                  child: Row(
                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                    children: [
                                                      Icon( isMode == 'Suggestion' ? Icons.check_box : Icons.check_box_outline_blank_rounded, color:  isMode == 'Suggestion' ? appPrimary : Colors.grey, size: 18,),
                                                      // SizedBox(width: 8,),
                                                      Spacer(),
                                                      Text('Suggestion', style: GoogleFonts.inter(fontSize: 14),)
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                            InkWell(
                                              onTap: () {
                                                newSetState(() {
                                                  isMode = 'Complain';
                                                });
                                              },
                                              child: Container(
                                                width: MediaQuery.of(context).size.width/3.5,
                                                height: 35,
                                                decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.circular(4),
                                                    border: Border.all(color: Colors.grey.shade400)
                                                ),
                                                alignment: Alignment.center,
                                                child: Padding(
                                                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                                  child: Row(
                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                    children: [
                                                      Icon( isMode == 'Complain' ? Icons.check_box : Icons.check_box_outline_blank_rounded, color:  isMode == 'Complain' ? appPrimary : Colors.grey, size: 18,),
                                                      // SizedBox(width: 8,),
                                                      Spacer(),
                                                      Text('Complain', style: GoogleFonts.inter(fontSize: 14),)
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                      SizedBox(height: 10,),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                                        child: Container(
                                          height: 40,
                                          width: MediaQuery.of(context).size.width,
                                          decoration: BoxDecoration(
                                              border: Border.all(color: Colors.grey),
                                              borderRadius: BorderRadius.circular(4)
                                          ),
                                          padding: EdgeInsets.symmetric(horizontal: 10),
                                          child: DropdownButtonHideUnderline(
                                            child: DropdownButton(
                                              hint: const Text('Select Department'),
                                              value: _intervalValue,
                                              // isExpanded: true,
                                              items: departmentList.map(
                                                    (value) {
                                                  return DropdownMenuItem<String>(
                                                    value: value,
                                                    child: Text(value.toString()),
                                                  );
                                                },
                                              ).toList(),
                                              onChanged: (value) {
                                                newSetState(() {
                                                  _intervalValue = value!;
                                                });
                                              },
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(height: 10,),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                                        child: Container(
                                          height: 40,
                                          // decoration:const  BoxDecoration(
                                          //     border: Border(bottom: BorderSide(color: Colors.white))
                                          // ),
                                          child:TextFormField(
                                            controller: subject,
                                            cursorColor: appPrimary,
                                            style: const TextStyle(color: appPrimary, fontSize: 14),
                                            decoration:const  InputDecoration(
                                                labelText: 'Subject',
                                                // hintText: 'Password',
                                                fillColor: Colors.white,
                                                border: OutlineInputBorder(),
                                                focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: appPrimary, width: 1.5))
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(height: 10,),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                                        child: Container(
                                          // height: 40,
                                          // decoration:const  BoxDecoration(
                                          //     border: Border(bottom: BorderSide(color: Colors.white))
                                          // ),
                                          child:TextFormField(
                                            controller: description,
                                            cursorColor: appPrimary,
                                            minLines: 2,
                                            maxLines: 5,
                                            style: const TextStyle(color: appPrimary, fontSize: 14),
                                            decoration:const  InputDecoration(
                                                labelText: 'Description',
                                                // hintText: 'Password',
                                                fillColor: Colors.white,
                                                border: OutlineInputBorder(),
                                                focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: appPrimary, width: 1.5))
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(height: 10,),
                                      _imagepath == '' ? Container()
                                      : Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                                        child: Row(
                                          children: [
                                            Container(
                                              width: MediaQuery.of(context).size.width/2,
                                              height: 100,
                                              decoration: BoxDecoration(
                                                image: DecorationImage(
                                                  image: FileImage(File(_imagepath)),
                                                  fit: BoxFit.fill,
                                                ),
                                              borderRadius: BorderRadius.circular(8)
                                              )

                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(height: 10,),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 5),
                                        child: Row(
                                          children: [
                                            ElevatedButton(
                                              style: ElevatedButton.styleFrom(primary: appPrimary),
                                              onPressed: () async{
                                                try {
                                                  var pickedFile = await imgpicker.pickImage(source: ImageSource.camera);
                                                  if (pickedFile != null) {
                                                    newSetState(() {
                                                      _imagepath = pickedFile.path;
                                                    });
                                                  } else {
                                                    print("No image is selected.");
                                                  }
                                                } catch (e) {
                                                  print("error while picking image.");
                                                }
                                              },
                                              child: Row(
                                                mainAxisSize: MainAxisSize.min,
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                children: [
                                                  Container(
                                                    margin: EdgeInsets.only(top: 5),
                                                    child: Icon(
                                                      Icons.image,
                                                    ),
                                                  ),
                                                  Container(
                                                    padding: EdgeInsets.only(
                                                      top: 4,
                                                      left: 10,
                                                    ),
                                                    child: Text('Add Attachments'),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(height: 10,),
                                      Padding(
                                                  padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
                                                  child: Row(
                                                    children: [
                                                      Text(' Level :', style: GoogleFonts.merriweather(color: Colors.black, fontSize: 17),),
                                                    ],
                                                  ),
                                                ),
                                      SizedBox(height: 5,),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                                        child: Container(
                                          child: Row(
                                            children: [
                                              InkWell(
                                                onTap: () {
                                                  newSetState(() {
                                                    isLevel = true;
                                                  });
                                                },
                                                child: Row(
                                                  children: [
                                                    Icon(isLevel ? Icons.check_box : Icons.check_box_outline_blank_rounded, color: isLevel ? appPrimary : Colors.grey ,),
                                                    SizedBox(width: 8,),
                                                    Text('Regular', style: GoogleFonts.inter(color: Colors.black, fontSize: 13),),
                                                  ],
                                                ),
                                              ),
                                              SizedBox(width: 20,),
                                              InkWell(
                                                onTap: () {
                                                  newSetState(() {
                                                    isLevel = false;
                                                  });
                                                },
                                                child: Row(
                                                  children: [
                                                    Icon(!isLevel ? Icons.check_box : Icons.check_box_outline_blank_rounded, color: !isLevel ? appPrimary : Colors.grey ,),
                                                    SizedBox(width: 8,),
                                                    Text('Urgent', style: GoogleFonts.inter(color: Colors.black, fontSize: 13),)
                                                  ],
                                                ),
                                              ),

                                            ]
                                          ),
                                        ),
                                      ),
                                      SizedBox(height: 10,),
                                      Padding(
                                                       padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
                                                       child: Row(
                                                         children: [
                                                           Text(' Appeal From :', style: GoogleFonts.merriweather(color: Colors.black, fontSize: 17))
                                                         ],
                                                       ),
                                                     ),
                                      SizedBox(height: 5,),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                                        child: Container(
                                          child: Row(
                                              children: [
                                                InkWell(
                                                  onTap: () {
                                                    newSetState(() {
                                                      isAppealForm = true;
                                                    });
                                                  },
                                                  child: Row(
                                                    children: [
                                                      Icon(isAppealForm ? Icons.check_box : Icons.check_box_outline_blank_rounded, color: isAppealForm ? appPrimary : Colors.grey ,),
                                                      SizedBox(width: 8,),
                                                      Text('By Yourself', style: GoogleFonts.inter(color: Colors.black, fontSize: 13),),
                                                    ],
                                                  ),
                                                ),
                                                SizedBox(width: 20,),
                                                InkWell(
                                                  onTap: () {
                                                    newSetState(() {
                                                      isAppealForm = false;
                                                    });
                                                  },
                                                  child: Row(
                                                    children: [
                                                      Icon(!isAppealForm ? Icons.check_box : Icons.check_box_outline_blank_rounded, color: !isAppealForm ? appPrimary : Colors.grey ,),
                                                      SizedBox(width: 8,),
                                                      Text('Other', style: GoogleFonts.inter(color: Colors.black, fontSize: 13),)
                                                    ],
                                                  ),
                                                ),

                                              ]
                                          ),
                                        ),
                                      ),
                                      SizedBox(height: 10,),
                                      isAppealForm
                                      ? Container()
                                      : Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                                        child: Card(
                                          elevation: 2.0,
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10),
                                            child: Column(
                                              children: [
                                                Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                    children: [
                                                      InkWell(
                                                        onTap: () {
                                                          newSetState(() {
                                                            isValue = 1;
                                                          });
                                                        },
                                                        child: Row(
                                                          children: [
                                                            Icon(isValue == 1 ? Icons.check_box : Icons.check_box_outline_blank_rounded, color: isValue == 1 ? appPrimary : Colors.grey ,),
                                                            SizedBox(width: 8,),
                                                            Text('Student', style: GoogleFonts.inter(color: Colors.black, fontSize: 13),),
                                                          ],
                                                        ),
                                                      ),
                                                      // SizedBox(width: 20,),
                                                      InkWell(
                                                        onTap: () {
                                                          newSetState(() {
                                                            isValue = 2;
                                                          });
                                                        },
                                                        child: Row(
                                                          children: [
                                                            Icon(isValue == 2 ? Icons.check_box : Icons.check_box_outline_blank_rounded, color: isValue == 2 ? appPrimary : Colors.grey ,),
                                                            SizedBox(width: 8,),
                                                            Text('Staff', style: GoogleFonts.inter(color: Colors.black, fontSize: 13),)
                                                          ],
                                                        ),
                                                      ),
                                                      // SizedBox(width: 20,),
                                                      InkWell(
                                                        onTap: () {
                                                          newSetState(() {
                                                            isValue = 3;
                                                          });
                                                        },
                                                        child: Row(
                                                          children: [
                                                            Icon(isValue == 3 ? Icons.check_box : Icons.check_box_outline_blank_rounded, color: isValue == 3 ? appPrimary : Colors.grey ,),
                                                            SizedBox(width: 8,),
                                                            Text('Parent', style: GoogleFonts.inter(color: Colors.black, fontSize: 13),)
                                                          ],
                                                        ),
                                                      ),
                                                    ]
                                                ),
                                                SizedBox(height: 20,),
                                                InkWell(
                                                  onTap: () {
                                                    newSetState(() {
                                                      isValue = 4;
                                                    });
                                                  },
                                                  child: Row(
                                                    children: [
                                                      Icon(isValue == 4 ? Icons.check_box : Icons.check_box_outline_blank_rounded, color: isValue == 4 ? appPrimary : Colors.grey ,),
                                                      SizedBox(width: 8,),
                                                      Text('Other', style: GoogleFonts.inter(color: Colors.black, fontSize: 13),)
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                      isValue == 4
                                      ? Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child: Column(
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.symmetric(horizontal: 10.0),
                                              child: Container(
                                                // height: 40,
                                                // decoration:const  BoxDecoration(
                                                //     border: Border(bottom: BorderSide(color: Colors.white))
                                                // ),
                                                child:TextFormField(
                                                  controller: name,
                                                  cursorColor: appPrimary,
                                                  // minLines: 2,
                                                  // maxLines: 5,
                                                  style: const TextStyle(color: appPrimary, fontSize: 14),
                                                  decoration:const  InputDecoration(
                                                      labelText: 'Applicant Name',
                                                      // hintText: 'Password',
                                                      fillColor: Colors.white,
                                                      border: OutlineInputBorder(),
                                                      focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: appPrimary, width: 1.5))
                                                  ),
                                                ),
                                              ),
                                            ),
                                            SizedBox(height: 10,),
                                            Padding(
                                              padding: const EdgeInsets.symmetric(horizontal: 10.0),
                                              child: Container(
                                                // height: 40,
                                                // decoration:const  BoxDecoration(
                                                //     border: Border(bottom: BorderSide(color: Colors.white))
                                                // ),
                                                child:TextFormField(
                                                  controller: mobile,
                                                  cursorColor: appPrimary,
                                                  keyboardType: TextInputType.number,
                                                  // minLines: 2,
                                                  // maxLines: 5,
                                                  style: const TextStyle(color: appPrimary, fontSize: 14),
                                                  decoration:const  InputDecoration(
                                                      labelText: 'Mobile',
                                                      // hintText: 'Password',
                                                      fillColor: Colors.white,
                                                      border: OutlineInputBorder(),
                                                      focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: appPrimary, width: 1.5))
                                                  ),
                                                ),
                                              ),
                                            ),
                                            SizedBox(height: 10,),
                                            Padding(
                                              padding: const EdgeInsets.symmetric(horizontal: 10.0),
                                              child: Container(
                                                // height: 40,
                                                // decoration:const  BoxDecoration(
                                                //     border: Border(bottom: BorderSide(color: Colors.white))
                                                // ),
                                                child:TextFormField(
                                                  controller: amobile,
                                                  cursorColor: appPrimary,
                                                  keyboardType: TextInputType.number,
                                                  // minLines: 2,
                                                  // maxLines: 5,
                                                  style: const TextStyle(color: appPrimary, fontSize: 14),
                                                  decoration:const  InputDecoration(
                                                      labelText: 'Alternative Mobile',
                                                      // hintText: 'Password',
                                                      fillColor: Colors.white,
                                                      border: OutlineInputBorder(),
                                                      focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: appPrimary, width: 1.5))
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      )
                                      : Container(),
                                      Spacer(),
                                      Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Container(
                                              width: MediaQuery.of(context).size.width/1.2,
                                              height: 35,
                                              child: ElevatedButton(
                                                  style: ElevatedButton.styleFrom(primary: appPrimary),
                                                  onPressed: () async{
                                                    if(subject.text == '') {

                                                    } else {
                                                      fetchData(context);
                                                      // fetchDatas();
                                                      var result = await ApiService().
                                                      registerAppealData(
                                                          subject.text.toString(),
                                                          description.text.toString(),
                                                          isMode == 'Query' ? '1' : isMode == 'Suggestion' ? '2' : '3',
                                                          isLevel ? '1' : '0',
                                                          name.text.toString(),
                                                          mobile.text.toString(),
                                                          amobile.text.toString(),
                                                          isValue == 1 ? 'student' : isValue == 2 ? 'staff' : isValue == 3 ? 'parent' : 'other',
                                                          '',
                                                          _intervalValue, _imagepath);
                                                      toastification.show(
                                                        type: ToastificationType.warning,
                                                        context: context,
                                                        title: Text('$result'),
                                                        autoCloseDuration: const Duration(seconds: 3),
                                                      );
                                                      print(result);
                                                      Navigator.pop(context);
                                                      Navigator.pop(context);
                                                      subject.clear();
                                                      description.clear();
                                                      isMode = 'Query';
                                                      isLevel = true;
                                                      name.clear();
                                                      mobile.clear();
                                                      amobile.clear();
                                                      isValue = 1;
                                                      _imagepath = '';
                                                      _intervalValue = departmentList.first;
                                                    }
                                                  },
                                                  child: Text('Submit')),
                                            ) ,
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            );
                          }
                      );
                    });
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 9.0),
                child: Card(
                    elevation: 4.0,
                    // width: 35,
                    // height: 35,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(60),
                        side: BorderSide(color: appPrimary.withOpacity(0.6))
                    ),
                    // alignment: Alignment.center,
                    child: Container(
                        width: 30,
                        height: 30,
                        child: Icon(Icons.add, size: 18, color: appPrimary,))),
              ),
            ),
            SizedBox(width: 10,),
          ],
        ),
        body: isLoading
        ? Center(child: CircularProgressIndicator(),)
        : ListView.builder(
            padding: EdgeInsets.zero,
            itemCount: dataList.length,
            itemBuilder: (BuildContext context, int index) {
            return Padding(
                padding: const EdgeInsets.all(10.0),
                child: Card(
                  elevation: 8.0,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10.0, right: 10.0, bottom: 10, top: 10),
                    child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Row(
                              children: [
                                Container(
                                  height: 30,
                                  width: 30,
                                  decoration: BoxDecoration(
                                    color: appPrimary,
                                    borderRadius: BorderRadius.circular(60)
                                  ),
                                  alignment: Alignment.center,
                                  child: Text('${dataList[index]['cno']}', style: GoogleFonts.inter(fontSize: 13, fontWeight: FontWeight.w600, color: Colors.white),),),
                                SizedBox(width: 10,),
                                Column(
                                  children: [
                                    Container(
                                      width: MediaQuery.of(context).size.width/1.3,
                                      child: Row(
                                        children: [
                                          Text('${dataList[index]['department']}', style: GoogleFonts.inter(fontSize: 15, fontWeight: FontWeight.w600),),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      width: MediaQuery.of(context).size.width/1.3,
                                      child: Row(
                                        children: [
                                          Text('${dataList[index]['mode']}', style: GoogleFonts.inter(fontSize: 13, fontWeight: FontWeight.w400, color: Colors.black),),
                                          Spacer(),
                                          Image.asset('assets/internet.png', height: 12,),
                                          SizedBox(width: 5,),
                                          Text('${dataList[index]['date']} ${dataList[index]['time']}', style: GoogleFonts.inter(fontSize: 11, color: Colors.grey.shade600)),
                                        ],
                                      ),
                                    ),

                                  ],
                                ),
                                // SizedBox(width: 10,),
                              ]
                          ),
                          Divider(),
                          Row(
                            children: [
                              SizedBox(width: 5,),
                              Text('Subject: ', style: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w600),),
                              Text('${dataList[index]['subject']}', style: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w400),),
                            ],
                          ),
                          SizedBox(height: 5,),
                          Row(
                            children: [
                              SizedBox(width: 5,),
                              Text('Level: ', style: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w600),),
                              Text('${dataList[index]['level']}, ', style: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w400),),
                              SizedBox(width: 5,),
                              Text('Total Person: ', style: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w600),),
                              Text('1', style: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w400),),
                            ],
                          ),
                          SizedBox(height: 10,),
                          Row(
                            children: [
                              SizedBox(width: 5,),
                              Container(
                                decoration: BoxDecoration(
                                    border: Border.all(color: appPrimary),
                                    borderRadius: BorderRadius.circular(4)
                                ),
                                alignment: Alignment.center,
                                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                child: Text('View Data', style: GoogleFonts.inter(color: appPrimary, fontSize: 13),),
                              ),
                              SizedBox(width: 10,),
                              Container(
                                decoration: BoxDecoration(
                                  color: Colors.red,
                                    // border: Border.all(color: appPrimary),
                                    borderRadius: BorderRadius.circular(4)
                                ),
                                alignment: Alignment.center,
                                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                                child: Text('Pending', style: GoogleFonts.inter(color: Colors.white, fontSize: 11),),
                              )
                            ],
                          )
                        ]
                    ),
                  ),
                ));
          }
        ));
  }
}