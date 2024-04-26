import 'dart:convert';

import 'package:ed_management/Colors.dart';
import 'package:ed_management/screens/FeacturesSubItem/AddStudentScreen.dart';
import 'package:ed_management/services/ApisProvider.dart';
import 'package:ed_management/services/custom%20loader.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'Attendance Screen.dart';

class StudentManageScreen extends StatefulWidget {
  @override
  _StudentManageScreenState createState() => _StudentManageScreenState();
}

class _StudentManageScreenState extends State<StudentManageScreen> {
  int SelectValue = 0;

  bool isSelect = false;

  var _intervalValue = 'Photo';

  List dataList = [];
  List filterList = [];
  List newFilterList = [];
  bool isLoading = true;

  int selectIndex = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchDatas('');
  }

  fetchDatas(filter) async{
    var newFilter = '';
    if(filter != '') {
      newFilter= newFilterList.toString().replaceAll('[', '').replaceAll(']','');
    }
    print(newFilter);
    var data = await ApiService().studentManageData(newFilter);
    if(data['status'] == true) {
      dataList = data['data'] == null ?[] : data['data'] ;
      filterList = data['access'];
    }
    print('studentList');
    print(dataList.length);
    print(filterList);
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SelectValue == 3
      ? AppBar(
        backgroundColor: appPrimary,
        titleSpacing: 1,
        title: Text('Student Manage', style: GoogleFonts.inter(color: Colors.white, fontSize: 18),),
        // automaticallyImplyLeading: false,
      )
      : AppBar(
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        title: Text('Student Manage', style: GoogleFonts.inter(color: appPrimary, fontSize: 18),),
        actions: [
          InkWell(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => AddStudentScreen()));
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
          SizedBox(width: 5,),
          InkWell(
            onTap: () {
              showDialog(
                  context: context,
                  builder: (context) {
                    return StatefulBuilder(
                        builder: (context, newSetState) {
                          return AlertDialog(
                            backgroundColor: Colors.white,
                            insetPadding: EdgeInsets.only(top: 0,left: 0, right: 0, bottom: 70),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(4)
                            ),
                            contentPadding: EdgeInsets.zero,
                            content: SizedBox(
                              width: MediaQuery.of(context).size.width/1.1,
                              height: MediaQuery.of(context).size.height/1.8,
                              child: Column(
                                // crossAxisAlignment: CrossAxisAlignment.end,
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    width: MediaQuery.of(context).size.width,
                                    height: 45,
                                    decoration: BoxDecoration(
                                        color: appPrimary,
                                        borderRadius: BorderRadius.only(topRight: Radius.circular(4), topLeft: Radius.circular(4))
                                    ),
                                    alignment: Alignment.centerLeft,
                                    child: Row(
                                      children: [
                                        SizedBox(width: 20,),
                                        Text('Standard', style: GoogleFonts.inter(fontSize: 16,color: Colors.white),),
                                        Spacer(),
                                        // InkWell(
                                        //     onTap: () {
                                        //       newSetState(() {
                                        //         isSelect = !isSelect;
                                        //       });
                                        //     },
                                        //     child: Icon(isSelect ? Icons.check_box_outlined : Icons.check_box_outline_blank, color: isSelect ? Colors.white : Colors.white,)),
                                        // SizedBox(width: 20,),
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    child: ListView.builder(
                                        itemCount: filterList.length,
                                        itemBuilder: (BuildContext context, int index) {
                                        return Padding(
                                          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
                                          child: Row(
                                            children: [
                                              Text('${filterList[index]['name']}', style: TextStyle(color: Colors.black),),
                                              Spacer(),
                                              InkWell(
                                                  onTap: () {
                                                    if(newFilterList.contains(filterList[index]['name'])) {
                                                      newSetState(() {
                                                        newFilterList.remove(filterList[index]['name']);
                                                      });
                                                    } else {
                                                      newSetState(() {
                                                        newFilterList.add(filterList[index]['name']);
                                                      });
                                                    }
                                                  },
                                                  child: Icon(newFilterList.contains(filterList[index]['name']) ? Icons.check_box : Icons.check_box_outline_blank, color: newFilterList.contains(filterList[index]['name']) ? appPrimary : Colors.grey,))
                                            ],
                                          ),
                                        );
                                      }
                                    ),
                                  ),
                                  Spacer(),
                                  Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Container(
                                          width: 80,
                                          height: 30,
                                          child: ElevatedButton(
                                              style: ElevatedButton.styleFrom(primary: Colors.green),
                                              onPressed: () async{
                                                // Navigator.pop(context);
                                                print(newFilterList);
                                               newSetState(() {
                                                 isLoading = true;
                                               });
                                               await fetchDatas(newFilterList);
                                                Navigator.pop(context);
                                                // newFilterList.clear();
                                              },
                                              child: Text('Filter')),
                                        ) ,
                                        SizedBox(width: 20,),
                                        Container(
                                          width: 80,
                                          height: 30,
                                          child: ElevatedButton(
                                              style: ElevatedButton.styleFrom(primary: Colors.red),
                                              onPressed: (){
                                                // newFilterList.clear();
                                                Navigator.pop(context);
                                              },
                                              child: Text('Close')),
                                        )
                                      ],
                                    ),
                                  )
                                ],
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
                      child: Icon(Icons.filter_list_outlined,size: 18, color: appPrimary,))),
            ),
          ),
          SizedBox(width: 10,),
        ],
      ),
      body: SelectValue == 3
      ? SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              Card(
                elevation: 8.0,
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width,
                        height: 45,
                        decoration: BoxDecoration(
                          color: appPrimary,
                          borderRadius: BorderRadius.only(topRight: Radius.circular(4), topLeft: Radius.circular(4))
                        ),
                        alignment: Alignment.centerLeft,
                        child: Row(
                          children: [
                            SizedBox(width: 10,),
                            Text('Personal Information', style: GoogleFonts.inter(fontSize: 18, fontWeight: FontWeight.w600,color: Colors.white),),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Container(
                                    width: MediaQuery.of(context).size.width/1.6,
                                    child: Row(
                                      children: [
                                        Text("SR No. : ", style: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w700, color: appPrimary),),
                                        Text('${dataList[selectIndex]['sr']}', style: GoogleFonts.inter(fontSize: 15,),),
                                      ],
                                    )),
                              ],
                            ),
                            SizedBox(height: 5,),
                            Row(
                              children: [
                                Container(
                                    width: MediaQuery.of(context).size.width/1.6,
                                    child: Row(
                                      children: [
                                        Text("Student Name : ", style: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w700, color: appPrimary),),
                                        Text('${dataList[selectIndex]['name']}', style: GoogleFonts.inter(fontSize: 15,),),
                                      ],
                                    )),
                              ],
                            ),
                            SizedBox(height: 5,),
                            Row(
                              children: [
                                Container(
                                    width: MediaQuery.of(context).size.width/1.6,
                                    child: Row(
                                      children: [
                                        Text("Father Name : ", style: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w700, color: appPrimary),),
                                        Text('${dataList[selectIndex]['fname']}', style: GoogleFonts.inter(fontSize: 15,),),
                                      ],
                                    )),
                              ],
                            ),
                            SizedBox(height: 5,),
                            Row(
                              children: [
                                Container(
                                    width: MediaQuery.of(context).size.width/1.6,
                                    child: Row(
                                      children: [
                                        Text("Mother Name : ", style: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w700, color: appPrimary),),
                                        Text('${dataList[selectIndex]['mname']}', style: GoogleFonts.inter(fontSize: 15,),),
                                      ],
                                    )),
                              ],
                            ),
                            SizedBox(height: 5,),
                            Row(
                              children: [
                                Container(
                                    width: MediaQuery.of(context).size.width/1.6,
                                    child: Row(
                                      children: [
                                        Text("Gender : ", style: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w700, color: appPrimary),),
                                        Text('${dataList[selectIndex]['gender']}', style: GoogleFonts.inter(fontSize: 15,),),
                                      ],
                                    )),
                              ],
                            ),
                            SizedBox(height: 5,),
                            Row(
                              children: [
                                Container(
                                    width: MediaQuery.of(context).size.width/1.6,
                                    child: Row(
                                      children: [
                                        Text("Date Of Birth : ", style: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w700, color: appPrimary),),
                                        Text('${dataList[selectIndex]['dob']}', style: GoogleFonts.inter(fontSize: 15,),),
                                      ],
                                    )),
                              ],
                            ),
                          ],
                        ),
                      ),

                    ],
                  ),
                ),
              ),
              SizedBox(height: 10,),
              Card(
                elevation: 8.0,
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width,
                        height: 45,
                        decoration: BoxDecoration(
                            color: appPrimary,
                            borderRadius: BorderRadius.only(topRight: Radius.circular(4), topLeft: Radius.circular(4))
                        ),
                        alignment: Alignment.centerLeft,
                        child: Row(
                          children: [
                            SizedBox(width: 10,),
                            Text('Contact Information', style: GoogleFonts.inter(fontSize: 18, fontWeight: FontWeight.w600,color: Colors.white),),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Container(
                                    width: MediaQuery.of(context).size.width/1.6,
                                    child: Row(
                                      children: [
                                        Text("Mobile Number : ", style: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w700, color: appPrimary),),
                                        Text('${dataList[selectIndex]['smobile']}', style: GoogleFonts.inter(fontSize: 15,),),
                                      ],
                                    )),
                              ],
                            ),
                            SizedBox(height: 5,),
                            Row(
                              children: [
                                Container(
                                    width: MediaQuery.of(context).size.width/1.6,
                                    child: Row(
                                      children: [
                                        Text("Guardient Mobile Number : ", style: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w700, color: appPrimary),),
                                        Text('${dataList[selectIndex]['gmobile'] == ''? 'NA' : dataList[selectIndex]['gmobile']}', style: GoogleFonts.inter(fontSize: 15,),),
                                      ],
                                    )),
                              ],
                            ),
                          ],
                        ),
                      ),

                    ],
                  ),
                ),
              ),
              SizedBox(height: 10,),
              Card(
                elevation: 8.0,
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width,
                        height: 45,
                        decoration: BoxDecoration(
                            color: appPrimary,
                            borderRadius: BorderRadius.only(topRight: Radius.circular(4), topLeft: Radius.circular(4))
                        ),
                        alignment: Alignment.centerLeft,
                        child: Row(
                          children: [
                            SizedBox(width: 10,),
                            Text('Address Information', style: GoogleFonts.inter(fontSize: 18, fontWeight: FontWeight.w600,color: Colors.white),),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Container(
                                    width: MediaQuery.of(context).size.width/1.6,
                                    child: Row(
                                      children: [
                                        Text("House No. : ", style: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w700, color: appPrimary),),
                                        Text('${dataList[selectIndex]['hno'] == '' ? 'NA' : dataList[selectIndex]['hno']}', style: GoogleFonts.inter(fontSize: 15,),),
                                      ],
                                    )),
                              ],
                            ),
                            SizedBox(height: 5,),
                            Row(
                              children: [
                                Container(
                                    width: MediaQuery.of(context).size.width/1.6,
                                    child: Row(
                                      children: [
                                        Text("Road/Street : ", style: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w700, color: appPrimary),),
                                        Text('${dataList[selectIndex]['streat'] == '' ? 'NA' : dataList[selectIndex]['streat']}', style: GoogleFonts.inter(fontSize: 15,),),
                                      ],
                                    )),
                              ],
                            ),
                            SizedBox(height: 5,),
                            Row(
                              children: [
                                Container(
                                    width: MediaQuery.of(context).size.width/1.6,
                                    child: Row(
                                      children: [
                                        Text("Landmark : ", style: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w700, color: appPrimary),),
                                        Text('${dataList[selectIndex]['land'] == '' ? 'NA' : dataList[selectIndex]['land']}', style: GoogleFonts.inter(fontSize: 15,),),
                                      ],
                                    )),
                              ],
                            ),
                            SizedBox(height: 5,),
                            Row(
                              children: [
                                Container(
                                    width: MediaQuery.of(context).size.width/1.6,
                                    child: Row(
                                      children: [
                                        Text("Area/Sector : ", style: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w700, color: appPrimary),),
                                        Text('${dataList[selectIndex]['area'] == '' ? 'NA' : dataList[selectIndex]['area']}', style: GoogleFonts.inter(fontSize: 15,),),
                                      ],
                                    )),
                              ],
                            ),
                            SizedBox(height: 5,),
                            Row(
                              children: [
                                Container(
                                    width: MediaQuery.of(context).size.width/1.6,
                                    child: Row(
                                      children: [
                                        Text("City : ", style: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w700, color: appPrimary),),
                                        Text('${dataList[selectIndex]['city'] == '' ? 'NA' : dataList[selectIndex]['city']}', style: GoogleFonts.inter(fontSize: 15,),),
                                      ],
                                    )),
                              ],
                            ),
                            SizedBox(height: 5,),
                            Row(
                              children: [
                                Container(
                                    width: MediaQuery.of(context).size.width/1.6,
                                    child: Row(
                                      children: [
                                        Text("District : ", style: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w700, color: appPrimary),),
                                        Text('${dataList[selectIndex]['dict'] == '' ? 'NA' : dataList[selectIndex]['dict']}', style: GoogleFonts.inter(fontSize: 15,),),
                                      ],
                                    )),
                              ],
                            ),
                            SizedBox(height: 5,),
                            Row(
                              children: [
                                Container(
                                    width: MediaQuery.of(context).size.width/1.6,
                                    child: Row(
                                      children: [
                                        Text("Pincode : ", style: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w700, color: appPrimary),),
                                        Text('${dataList[selectIndex]['pin'] == '' ? 'NA' : dataList[selectIndex]['pin']}', style: GoogleFonts.inter(fontSize: 15,),),
                                      ],
                                    )),
                              ],
                            ),
                          ],
                        ),
                      ),

                    ],
                  ),
                ),
              ),
              SizedBox(height: 10,),
              Card(
                elevation: 8.0,
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width,
                        height: 45,
                        decoration: BoxDecoration(
                            color: appPrimary,
                            borderRadius: BorderRadius.only(topRight: Radius.circular(4), topLeft: Radius.circular(4))
                        ),
                        alignment: Alignment.centerLeft,
                        child: Row(
                          children: [
                            SizedBox(width: 10,),
                            Text('Other Information', style: GoogleFonts.inter(fontSize: 18, fontWeight: FontWeight.w600,color: Colors.white),),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Container(
                                    width: MediaQuery.of(context).size.width/1.6,
                                    child: Row(
                                      children: [
                                        Text("Standard : ", style: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w700, color: appPrimary),),
                                        Text('${dataList[selectIndex]['standard'] == '' ? 'NA' : dataList[selectIndex]['standard']}', style: GoogleFonts.inter(fontSize: 15,),),
                                      ],
                                    )),
                              ],
                            ),
                            SizedBox(height: 5,),
                            Row(
                              children: [
                                Container(
                                    width: MediaQuery.of(context).size.width/1.6,
                                    child: Row(
                                      children: [
                                        Text("Section : ", style: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w700, color: appPrimary),),
                                        Text('${dataList[selectIndex]['section'] == '' ? 'NA' : dataList[selectIndex]['section']}', style: GoogleFonts.inter(fontSize: 15,),),
                                      ],
                                    )),
                              ],
                            ),
                            SizedBox(height: 5,),
                            Row(
                              children: [
                                Container(
                                    width: MediaQuery.of(context).size.width/1.6,
                                    child: Row(
                                      children: [
                                        Text("Date Of Admission : ", style: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w700, color: appPrimary),),
                                        Text('${dataList[selectIndex]['doa'] == '' ? 'NA' : dataList[selectIndex]['doa']}', style: GoogleFonts.inter(fontSize: 15,),),
                                      ],
                                    )),
                              ],
                            ),
                            SizedBox(height: 5,),
                            Row(
                              children: [
                                Container(
                                    width: MediaQuery.of(context).size.width/1.6,
                                    child: Row(
                                      children: [
                                        Text("Religion : ", style: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w700, color: appPrimary),),
                                        Text('${dataList[selectIndex]['rel'] == '' ? 'NA' : dataList[selectIndex]['rel']}', style: GoogleFonts.inter(fontSize: 15,),),
                                      ],
                                    )),
                              ],
                            ),
                            SizedBox(height: 5,),
                            Row(
                              children: [
                                Container(
                                    width: MediaQuery.of(context).size.width/1.6,
                                    child: Row(
                                      children: [
                                        Text("Caste : ", style: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w700, color: appPrimary),),
                                        Text('${dataList[selectIndex]['caste'] == '' ? 'NA' : dataList[selectIndex]['caste']}', style: GoogleFonts.inter(fontSize: 15,),),
                                      ],
                                    )),
                              ],
                            ),
                            SizedBox(height: 5,),
                            Row(
                              children: [
                                Container(
                                    width: MediaQuery.of(context).size.width/1.6,
                                    child: Row(
                                      children: [
                                        Text("Aadhar : ", style: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w700, color: appPrimary),),
                                        Text('${dataList[selectIndex]['aadhar'] == '' || dataList[selectIndex]['aadhar'] == null ? 'NA' : dataList[selectIndex]['aadhar']}', style: GoogleFonts.inter(fontSize: 15,),),
                                      ],
                                    )),
                              ],
                            ),
                          ],
                        ),
                      ),

                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      )
      : isLoading
        ? Center(child: CircularProgressIndicator(color: appPrimary,),)
        : ListView.builder(
          itemCount: dataList.length,
          itemBuilder: (BuildContext context, int index) {
            return Padding(
            padding: const EdgeInsets.all(10.0),
            child: Card(
              elevation: 8.0,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      children: [
                        Container(
                            decoration: BoxDecoration(
                              border: Border.all(color: appPrimary.withOpacity(0.6)),
                              borderRadius: BorderRadius.circular(60)
                            ),
                            padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 8),
                            child: Image.asset('assets/logo.png', height: 20,)),
                        SizedBox(width: 10,),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Row(
                              children: [
                                Container(
                                    width: MediaQuery.of(context).size.width/1.6,
                                    child: Text('${dataList[index]['name']}', style: GoogleFonts.inter(fontSize: 15, fontWeight: FontWeight.w500),)),
                              ],
                            ),
                            // SizedBox(height: 5,),
                            Row(
                              children: [
                                Container(
                                    width: MediaQuery.of(context).size.width/1.6,
                                    child: Text('${dataList[index]['standard']}', style: GoogleFonts.inter(fontSize: 14))),
                              ],
                            ),

                          ],
                        ),
                        Spacer(),
                        PopupMenuButton<int>(
                            itemBuilder: (BuildContext context) => <PopupMenuItem<int>>[
                              new PopupMenuItem<int>(
                                  value: 1, child: new Text('Attach')),
                              new PopupMenuItem<int>(
                                  value: 2, child: new Text('Edit')),
                              new PopupMenuItem<int>(
                                  value: 3, child: new Text('View')),
                            ],
                            onSelected: (int value) {
                              setState(() {
                                selectIndex = index;
                                SelectValue = value;
                              });
                              if(SelectValue == 1) {
                                showDialog(
                                    context: context,
                                    builder: (context) {
                                      return StatefulBuilder(
                                          builder: (context, newSetState) {
                                            return AlertDialog(
                                              backgroundColor: Colors.white,
                                              insetPadding: EdgeInsets.only(top: 0,left: 0, right: 0, bottom: 70),
                                              shape: RoundedRectangleBorder(
                                                  borderRadius: BorderRadius.circular(8)
                                              ),
                                              contentPadding: EdgeInsets.zero,
                                              content: SizedBox(
                                                width: MediaQuery.of(context).size.width/1.1,
                                                height: MediaQuery.of(context).size.height/1.2,
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
                                                          Spacer(),
                                                          // SizedBox(width: 20,),
                                                          Text('Upload Documents', style: GoogleFonts.inter(fontSize: 18,color: Colors.black, fontWeight: FontWeight.bold),),
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
                                                    Divider(),
                                                    Padding(
                                                      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
                                                      child: Row(
                                                        children: [
                                                          Text('Select Document *', style: TextStyle(color: appPrimary, fontSize: 17),),
                                                        ],
                                                      ),
                                                    ),
                                                Padding(
                                                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                                                  child: Container(
                                                    height: 40,
                                                    width: MediaQuery.of(context).size.width,
                                                     decoration: BoxDecoration(
                                                       border: Border.all(color: appPrimary),
                                                       borderRadius: BorderRadius.circular(4)
                                                     ),
                                                    padding: EdgeInsets.symmetric(horizontal: 10),
                                                    child: DropdownButtonHideUnderline(
                                                      child: DropdownButton<String>(
                                                        hint: const Text('Photo'),
                                                        value: _intervalValue,
                                                        // isExpanded: true,
                                                        items: ['Photo', 'Sign', 'Aadhar Card'].map(
                                                              (String? value) {
                                                            return DropdownMenuItem<String>(
                                                              value: value,
                                                              child: Text(value.toString()),
                                                            );
                                                          },
                                                        ).toList(),
                                                        onChanged: (value) {
                                                          setState(() {
                                                            _intervalValue = value!;
                                                          });
                                                        },
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                    SizedBox(height: 5,),
                                                    Divider(),
                                                    Padding(
                                                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                                                      child: Container(
                                                        width: MediaQuery.of(context).size.width/1.2,
                                                        height: 100,
                                                        decoration: BoxDecoration(
                                                          border: Border.all(color: Colors.grey),
                                                          borderRadius: BorderRadius.circular(4)
                                                        ),
                                                        alignment: Alignment.center,
                                                        child: Icon(Icons.camera_enhance_rounded, color: Colors.grey,),
                                                      ),
                                                    ),
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
                                                                onPressed: (){},
                                                                child: Text('Submit')),
                                                          ) ,
                                                        ],
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ),
                                            );
                                          }
                                      );
                                    });
                              }
                            })
                      ],
                    ),
                    Divider(color: Colors.grey.shade400,),
                    Padding(
                      padding: const EdgeInsets.only(left: 10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Row(
                                children: [
                                  Container(
                                      width: MediaQuery.of(context).size.width/1.6,
                                      child: Row(
                                        children: [
                                          Text("Father's Name: ", style: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w700),),
                                          Text('${dataList[index]['fname']}', style: GoogleFonts.inter(fontSize: 14,),),
                                        ],
                                      )),
                                ],
                              ),
                              // SizedBox(height: 5,),
                              Row(
                                children: [
                                  Container(
                                      width: MediaQuery.of(context).size.width/1.6,
                                      child: Text('Zone: ', style: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w700))),
                                ],
                              ),

                            ],
                          ),
                          Spacer(),
                          InkWell(
                            onTap: () {
                              print(dataList[index]['mobile']);
                              var phoneNumber = '+91 ${dataList[index]['smobile']}';
                              makePhoneCall(phoneNumber);
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
                                      child: Icon(Icons.call,size: 18, color: appPrimary,))),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
      );
          }
        ),
    );
  }
}