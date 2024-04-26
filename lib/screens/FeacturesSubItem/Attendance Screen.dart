import 'package:ed_management/Colors.dart';
import 'package:ed_management/screens/FeacturesSubItem/AddStudentScreen.dart';
import 'package:ed_management/services/ApisProvider.dart';
import 'package:ed_management/services/custom%20loader.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:toastification/toastification.dart';
import 'package:url_launcher/url_launcher.dart';

import 'Attendance Fill Screen.dart';

class AttendanceReportScreen extends StatefulWidget {
  @override
  _AttendanceReportScreenState createState() => _AttendanceReportScreenState();
}

class _AttendanceReportScreenState extends State<AttendanceReportScreen> {
  int SelectValue = 0;

  bool isSelect = true;

  var _intervalValue = 'Select Standard';
  var reasonValue = 'Select Reason';
  var present = '0';
  var absent = '0';
  var leave = '0';
  var total;
  var attendance;
  List dataList = [];

  bool isLoading = true;

  List filterList = [];

  var endDate;

  TextEditingController dateController = TextEditingController();
  TextEditingController remark = TextEditingController();

  var toDate;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchDatas();
  }

  fetchDatas() async{
    var filterData = await ApiService().attendanceFilterData();
    if(filterData['status'] == true) {
      List filterListData = filterData['data'];
      filterList.add('Select Standard');
      filterListData.forEach((element) {
        filterList.add(element['class']);
      });
    }

    var data = await ApiService().attendanceViewData();
    if(data['status'] == true) {
      dataList = data['data'];
      present = data['present'] == null ? '0' : data['present'];
      absent = data['absent'] == null ? '0' : data['absent'];
      leave = data['leave'] == null ? '0' : data['leave'];
      total = data['total'];
      attendance = data['attendance'];

      _intervalValue = filterList.first;
    }
    print('reportList');
    print(dataList.length);
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
          title: Text('Attendance Report', style: GoogleFonts.inter(color: appPrimary, fontSize: 18),),
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
                                          // Spacer(),
                                          SizedBox(width: 20,),
                                          Text('Filter Attendance', style: GoogleFonts.inter(fontSize: 16,color: appPrimary, fontWeight: FontWeight.bold),),
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
                                    //   padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
                                    //   child: Row(
                                    //     children: [
                                    //       Text('Select Document *', style: TextStyle(color: appPrimary, fontSize: 17),),
                                    //     ],
                                    //   ),
                                    // ),
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
                                          child: DropdownButton<String>(
                                            hint: const Text('Select Standard'),
                                            value: _intervalValue,
                                            // isExpanded: true,
                                            items: filterList.map(
                                                  (value) {
                                                return DropdownMenuItem<String>(
                                                  value: value,
                                                  child: Text(value == 'Select Standard' ? value.toString() : '${value.toString()} - Punched'),
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
                                        alignment: Alignment.center,
                                        child:TextFormField(
                                          enableInteractiveSelection: false,
                                          controller: dateController,
                                          onTap: () async{
                                            final DateTime? picked = await showDatePicker(
                                                context: context,
                                                initialDate: DateTime.now(),
                                                firstDate: DateTime(2000),
                                                //DateTime.now() - not to allow to choose before today.
                                                lastDate: DateTime.now()
                                            );
                                            print('pickedTimeT');
                                            // print(picked.asStream());
                                            // if (picked != null && picked != selectedDate) {
                                            var format = DateFormat('yyyy-MM-dd').format(picked!);
                                              newSetState(() {
                                                endDate = format;
                                                dateController = TextEditingController(text: endDate);
                                              });
                                            // }
                                          },
                                          showCursor: false,
                                          // cursorHeight: 0,
                                          // cursorWidth: 0,
                                          // cursorColor: appPrimary,
                                          style: const TextStyle(color: appPrimary, fontSize: 14),
                                          decoration:  InputDecoration(
                                              // hintText: '$endDate',
                                              // hintTextDirection: TextDirection.ltr,
                                              hintStyle: GoogleFonts.poppins(fontSize: 10),
                                              labelText: 'Date',
                                              fillColor: Colors.white,
                                              border: OutlineInputBorder(),
                                              focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: appPrimary, width: 1.5))
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 10,),
                                    Spacer(),
                                    Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Container(
                                            width: MediaQuery.of(context).size.width/1.2,
                                            height: 35,
                                            child: OutlinedButton(
                                                style: OutlinedButton.styleFrom(primary: appPrimary),
                                                onPressed: (){
                                                  if(_intervalValue == 'Select Standard') {
                                                    toastification.show(
                                                      type: ToastificationType.warning,
                                                      context: context,
                                                      title: Text('Please Select Standard'),
                                                      autoCloseDuration: const Duration(seconds: 3),
                                                    );
                                                  } else if(endDate == null) {
                                                    toastification.show(
                                                      type: ToastificationType.warning,
                                                      context: context,
                                                      title: Text('Please Select Date'),
                                                      autoCloseDuration: const Duration(seconds: 3),
                                                    );
                                                  }
                                                  else  {
                                                    Navigator.pop(context);
                                                    Navigator.push(context,
                                                        MaterialPageRoute(
                                                            builder: (
                                                                context) =>
                                                                AttendanceFillScreen(
                                                                  data: _intervalValue, date: '${dateController.text}',)));
                                                    // endDate= '';
                                                    // _intervalValue = 'Select Standard';
                                                    // filterList.clear();

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
            ? Center(child: CircularProgressIndicator(color: appPrimary,),)
            :
        Column(
          children: [
            SizedBox(height: 10,),
            Row(
              children: [
                Card(
                  elevation: 8.0,
                  child: Container(
                    width: MediaQuery.of(context).size.width/3.3,
                    // height: 100,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8)
                    ),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text('Total Standard', style: GoogleFonts.inter(color: Colors.deepPurple.shade900, fontSize: 8),)

                            ],
                          ),
                        ),
                        // SizedBox(height: 10,),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Icon(Icons.bar_chart_outlined, color: Colors.deepPurple.shade900,),
                              Spacer(),
                              Text('$total', style: GoogleFonts.inter(color: Colors.deepPurple.shade900, fontSize: 14, fontWeight: FontWeight.bold),),
                              SizedBox(width: 5,),
                            ],
                          ),
                        ),
                        SizedBox(height: 5,),
                        Container(
                          height: 5,
                          decoration: BoxDecoration(
                              color: Colors.deepPurple.shade900,
                              borderRadius: BorderRadius.only(bottomLeft: Radius.circular(8), bottomRight: Radius.circular(8))
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                SizedBox(width: 5,),
                Card(
                  elevation: 8.0,
                  child: Container(
                    width: MediaQuery.of(context).size.width/3.3,
                    // height: 100,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8)
                    ),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text('Attendance Punch', style: GoogleFonts.inter(color: Colors.green.shade600, fontSize: 8),)

                            ],
                          ),
                        ),
                        // SizedBox(height: 10,),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Icon(Icons.star, color: Colors.green.shade600,),
                              Spacer(),
                              Text('$attendance', style: GoogleFonts.inter(color: Colors.green.shade600, fontSize: 14, fontWeight: FontWeight.bold),),
                              SizedBox(width: 5,),
                            ],
                          ),
                        ),
                        SizedBox(height: 5,),
                        Container(
                          height: 5,
                          decoration: BoxDecoration(
                              color: Colors.green.shade600,
                              borderRadius: BorderRadius.only(bottomLeft: Radius.circular(8), bottomRight: Radius.circular(8))
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                SizedBox(width: 5,),
                Card(
                  elevation: 8.0,
                  child: Container(
                    width: MediaQuery.of(context).size.width/3.3,
                    // height: 100,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8)
                    ),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text('Not Punch', style: GoogleFonts.inter(color: Colors.red.shade900, fontSize: 8),)

                            ],
                          ),
                        ),
                        // SizedBox(height: 10,),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Icon(Icons.info_rounded, color: Colors.red.shade900,),
                              Spacer(),
                              Text('0', style: GoogleFonts.inter(color: Colors.red.shade900, fontSize: 14, fontWeight: FontWeight.bold),),
                              SizedBox(width: 5,),
                            ],
                          ),
                        ),
                        SizedBox(height: 5,),
                        Container(
                          height: 5,
                          decoration: BoxDecoration(
                              color: Colors.red.shade900,
                              borderRadius: BorderRadius.only(bottomLeft: Radius.circular(8), bottomRight: Radius.circular(8))
                          ),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
            SizedBox(height: 15,),
            Row(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width/3.3,
                  // height: 100,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8)
                  ),
                  child: Column(
                    children: [
                      Container(
                          height: 30,
                          width: 30,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            border: Border.all(color: appPrimary, width: 0.5),
                            borderRadius: BorderRadius.circular(60)
                          ),
                          // padding: EdgeInsets.all(7),
                          child: Text('$present', style: GoogleFonts.inter(color: appPrimary, fontSize: 12),)),
                      SizedBox(height: 10,),
                      Text('Total Present', style: GoogleFonts.merriweather(color: appPrimary, fontSize: 10),),
                    ],
                  ),
                ),
                SizedBox(width: 5,),
                Container(
                  width: MediaQuery.of(context).size.width/3.3,
                  // height: 100,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8)
                  ),
                  child: Column(
                    children: [
                      Container(
                          height: 30,
                          width: 30,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              border: Border.all(color: appPrimary, width: 0.5),
                              borderRadius: BorderRadius.circular(60)
                          ),
                          // padding: EdgeInsets.all(7),
                          child: Text('$absent', style: GoogleFonts.inter(color: appPrimary, fontSize: 12),)),
                      SizedBox(height: 10,),
                      Text('Total Absent', style: GoogleFonts.merriweather(color: appPrimary, fontSize: 10),),
                    ],
                  ),
                ),
                SizedBox(width: 5,),
                Container(
                  width: MediaQuery.of(context).size.width/3.3,
                  // height: 100,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8)
                  ),
                  child: Column(
                    children: [
                      Container(
                        height: 30,
                        width: 30,
                          decoration: BoxDecoration(
                              border: Border.all(color: appPrimary, width: 0.5),
                              borderRadius: BorderRadius.circular(60)
                          ),
                          alignment: Alignment.center,
                          // padding: EdgeInsets.all(7),
                          child: Text('$leave', style: GoogleFonts.inter(color: appPrimary, fontSize: 12),)),
                      SizedBox(height: 10,),
                      Text('Total Leave', style: GoogleFonts.merriweather(color: appPrimary, fontSize: 10),),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 15,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: () {
                      setState(() {
                        isSelect = true;
                        // search.clear();
                      });
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width/2.1,
                      height: 30,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          color: isSelect ? appPrimary : Colors.grey.shade300,
                          // border: Border.all(color: Colors.grey.shade300, width: 1.0),
                          borderRadius: BorderRadius.only(topRight: Radius.circular(8), topLeft: Radius.circular(8))
                      ),child: Text('Absent Student', style: GoogleFonts.inter(color: isSelect ? Colors.white : Colors.black, fontSize: 12),),
                    ),
                  ),
                  // SizedBox(width: 5,),
                  InkWell(
                    onTap: () {
                      setState(() {
                        isSelect = false;
                        // search.clear();
                      });
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width/2.1,
                      height: 30,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          color: !isSelect ? appPrimary : Colors.grey.shade300,
                          // border: Border.all(color: Colors.grey.shade300, width: 1.0),
                          borderRadius: BorderRadius.only(topRight: Radius.circular(8), topLeft: Radius.circular(8))
                      ),child: Text('Leave Student', style: GoogleFonts.inter(color: !isSelect ? Colors.white : Colors.black, fontSize: 12),),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 10,),
            dataList.isEmpty && isSelect
                ? Container()
                : Expanded(
              child: ListView.builder(
                  padding: EdgeInsets.zero,
                  itemCount: dataList.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: Card(
                        elevation: 4.0,
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Container(
                                // height: 35,
                                child: Container(
                                    child: Row(
                                      children: [
                                        Container(
                                            width: 40,
                                            height: 40,
                                            decoration: BoxDecoration(
                                              image: DecorationImage(
                                                image: NetworkImage(dataList[index]['photo']),
                                                fit: BoxFit.cover
                                              ),
                                              border: Border.all(color: Colors.black),
                                                // color: Colors.grey.shade300,
                                                borderRadius: BorderRadius.circular(60.0)
                                            ),
                                            alignment: Alignment.center,
                                            // padding: EdgeInsets.all(6),
                                            // child: Image.network(dataList[index]['photo'], height: 30, fit: BoxFit.fill,)
                                      ),
                                        SizedBox(width: 10,),
                                        Column(
                                          children: [
                                            Row(
                                              children: [
                                                Container(
                                                    width: MediaQuery.of(context).size.width/ 2.2,
                                                    child: Text('${dataList[index]['name']}', style: GoogleFonts.inter(color: Colors.black, fontSize: 14, fontWeight: FontWeight.w600),)),
                                              ],
                                            ),
                                            SizedBox(height: 3,),
                                            Row(
                                              children: [
                                                Container(
                                                    width: MediaQuery.of(context).size.width/ 2.2,
                                                    child: Text('${dataList[index]['standard']}', style: GoogleFonts.inter(color:  Colors.black, fontSize: 13),)),
                                              ],
                                            ),
                                          ],
                                        ),
                                        Spacer(),
                                        InkWell(
                                          onTap: () {
                                            print(dataList[index]['mobile']);
                                            var phoneNumber = '+91 ${dataList[index]['mobile']}';
                                            makePhoneCall(phoneNumber);
                                            // String url = 'tel:' + '+91 ${dataList[index]['mobile']}';
                                            // if (await canLaunch(url)) {
                                            // await launch(url);
                                            // } else {
                                            // throw 'Could not launch $url';
                                            // }
                                          },
                                          child: Container(
                                              decoration: BoxDecoration(
                                                  border: Border.all(color: appPrimary),
                                                  borderRadius: BorderRadius.circular(60)
                                              ),
                                              padding: EdgeInsets.all(5),
                                              alignment: Alignment.center,
                                              child: Icon(Icons.call, color: appPrimary, size: 14,)),
                                        ),
                                        SizedBox(width: 8,),
                                        Container(
                                          height: 25,
                                          child: ElevatedButton(
                                              style: ElevatedButton.styleFrom(primary: Colors.green),
                                              onPressed: () {
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
                                                                width: MediaQuery.of(context).size.width/1.2,
                                                                height: MediaQuery.of(context).size.height/1.7,
                                                                child: Column(
                                                                  children: <Widget>[
                                                                    Column(
                                                                      children: [
                                                                        SizedBox(height: 10,),
                                                                        Container(
                                                                          decoration: BoxDecoration(
                                                                            // color: appPrimary,
                                                                              borderRadius: BorderRadius.only(topRight: Radius.circular(4), bottomRight: Radius.circular(4))
                                                                          ),
                                                                          child: Padding(
                                                                            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                                                                            child:
                                                                            InkWell(
                                                                              onTap: () {
                                                                                Navigator.pop(context);
                                                                              },
                                                                              child: Text('Upload Remark', style: GoogleFonts.merriweather(color : appPrimary, fontSize: 15, fontWeight: FontWeight.w500),),
                                                                            ),
                                                                          ),
                                                                        ),
                                                                        SizedBox(height: 10,),
                                                                      ],
                                                                    ),
                                                                    Padding(
                                                                      padding: const EdgeInsets.all(20.0),
                                                                      child: Column(
                                                                        children: [
                                                                          GestureDetector(
                                                                            onTap: () async{
                                                                              final DateTime? picked = await showDatePicker(
                                                                                  context: context,
                                                                                  initialDate: DateTime.now(),
                                                                                  firstDate: DateTime.now(),
                                                                                  // firstDate: DateTime(2000),
                                                                                  //DateTime.now() - not to allow to choose before today.
                                                                                  lastDate: DateTime(3000)
                                                                              );
                                                                              print('pickedTimeT');
                                                                              // print(picked.asStream());
                                                                              // if (picked != null && picked != selectedDate) {
                                                                              var format = DateFormat('yyyy-MM-dd').format(picked!);
                                                                              newSetState(() {
                                                                                toDate = format;
                                                                                // dateController = TextEditingController(text: endDate);
                                                                              });
                                                                            },
                                                                            child: Container(
                                                                                height: 50,
                                                                                decoration: BoxDecoration(
                                                                                    border: Border.all(color: Colors.grey),
                                                                                    borderRadius: BorderRadius.circular(4)
                                                                                ),
                                                                                alignment: Alignment.centerLeft,
                                                                                padding: EdgeInsets.only(left: 10),
                                                                                child: Text(toDate == null ? 'To Date ' : toDate, style: GoogleFonts.inter(color: Colors.grey.shade700, fontSize: 14),)),
                                                                          ),
                                                                          SizedBox(height: 5,),
                                                                          Container(
                                                                            width: MediaQuery.of(context).size.width/1,
                                                                            height: 45,
                                                                            padding: EdgeInsets.symmetric(horizontal: 8),
                                                                            decoration: BoxDecoration(
                                                                                border: Border.all(color: Colors.grey.shade400),
                                                                                borderRadius: BorderRadius.circular(4)
                                                                            ),
                                                                            child: DropdownButtonHideUnderline(
                                                                              child: DropdownButton<String>(
                                                                                hint: const Text('Select Reason'),
                                                                                value: reasonValue,
                                                                                // isExpanded: true,
                                                                                items: ['Select Reason', 'Family Issue', 'Illness', 'Out of station', 'Long Absent','Other'].map(
                                                                                      (String? value) {
                                                                                    return DropdownMenuItem<String>(
                                                                                      value: value,
                                                                                      child: Text(value.toString()),
                                                                                    );
                                                                                  },
                                                                                ).toList(),
                                                                                onChanged: (value) {
                                                                                  newSetState(() {
                                                                                    reasonValue = value!;
                                                                                  });
                                                                                },
                                                                              ),
                                                                            ),
                                                                          ),
                                                                          SizedBox(height: 5,),
                                                                          Container(
                                                                            height: 50,
                                                                            // decoration:const  BoxDecoration(
                                                                            //     border: Border(bottom: BorderSide(color: Colors.white))
                                                                            // ),
                                                                            alignment: Alignment.center,
                                                                            child:TextFormField(
                                                                              // readOnly: hintT == 'Time' ? true : false,
                                                                              controller: remark,
                                                                              cursorColor: appPrimary,
                                                                              style: const TextStyle(color: appPrimary, fontSize: 14),
                                                                              decoration:  InputDecoration(
                                                                                  hintText: 'Remark',
                                                                                  // labelText:  hintT,
                                                                                  // labelStyle: TextStyle(color: appPrimary),
                                                                                  fillColor: Colors.white,
                                                                                  border: OutlineInputBorder(),
                                                                                  focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: appPrimary, width: 1.5))
                                                                              ),
                                                                            ),
                                                                          )
                                                                        ],
                                                                      ),
                                                                    ),
                                                                    Spacer(),
                                                                    // SizedBox(height: 30,),
                                                                    Row(
                                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                                      children: [
                                                                        Container(
                                                                          width: MediaQuery.of(context).size.width/3,
                                                                          child: ElevatedButton(
                                                                              style: ElevatedButton.styleFrom(primary: appPrimary),
                                                                              onPressed: () async{
                                                                                fetchData(context);
                                                                                if(reasonValue == 'Select Reason') {
                                                                                  Navigator.pop(context);
                                                                                  toastification.show(
                                                                                    type: ToastificationType.warning,
                                                                                    context: context,
                                                                                    title: Text('Please Select Reason'),
                                                                                    autoCloseDuration: const Duration(seconds: 3),
                                                                                  );
                                                                                }  else if(toDate == null) {
                                                                                  Navigator.pop(context);
                                                                                  toastification.show(
                                                                                    type: ToastificationType.warning,
                                                                                    context: context,
                                                                                    title: Text('Please Select To Date'),
                                                                                    autoCloseDuration: const Duration(seconds: 3),
                                                                                  );
                                                                                } else if(remark.text == '') {
                                                                                  Navigator.pop(context);
                                                                                  toastification.show(
                                                                                    type: ToastificationType.warning,
                                                                                    context: context,
                                                                                    title: Text('Please enter remark'),
                                                                                    autoCloseDuration: const Duration(seconds: 3),
                                                                                  );
                                                                                } else {
                                                                                  // print(fromDate);
                                                                                  print(dataList[index]['sid']);
                                                                                  print(reasonValue);
                                                                                  print(remark.text);
                                                                                  var result = await ApiService().updateAttendanceData(toDate, _intervalValue, remark.text.toString(), dataList[index]['sid']);
                                                                                  print('result');
                                                                                  print(result);
                                                                                  if(result['status'] == true) {
                                                                                    toastification.show(
                                                                                      type: ToastificationType.success,
                                                                                      context: context,
                                                                                      title: Text('Success'),
                                                                                      autoCloseDuration: const Duration(seconds: 3),
                                                                                    );
                                                                                    reasonValue = 'Select Reason';
                                                                                    // fromDate = null;
                                                                                    toDate = null;
                                                                                    remark.clear();
                                                                                    Navigator.pop(context);
                                                                                    Navigator.pop(context);
                                                                                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => AttendanceReportScreen()));
                                                                                    // await fetchDatas();
                                                                                    // Navigator.pop(context);
                                                                                    // Navigator.pop(context);
                                                                                  }else {
                                                                                    toastification.show(
                                                                                      type: ToastificationType.error,
                                                                                      context: context,
                                                                                      title: Text('Something went wrong!'),
                                                                                      autoCloseDuration: const Duration(seconds: 3),
                                                                                    );

                                                                                    Navigator.pop(context);
                                                                                  }
                                                                                }
                                                                              },
                                                                              child: Text('Submit')
                                                                          ),
                                                                        ),
                                                                        SizedBox(width: 15,),
                                                                        Container(
                                                                          width: MediaQuery.of(context).size.width/3,
                                                                          child: OutlinedButton(
                                                                              style: OutlinedButton.styleFrom(primary: appPrimary),
                                                                              onPressed: () {
                                                                                Navigator.pop(context);
                                                                                reasonValue = 'Select Reason';
                                                                                // fromDate = null;
                                                                                toDate = null;
                                                                                remark.clear();
                                                                              },
                                                                              child: Text('Close')
                                                                          ),
                                                                        )
                                                                      ],
                                                                    ),
                                                                    SizedBox(height: 30,),
                                                                  ],
                                                                ),
                                                              ),
                                                            );
                                                          }
                                                      );
                                                    });
                                              },
                                              child: Text('Update', style: GoogleFonts.inter(color: Colors.white, fontSize: 12),)),
                                        ),
                                      ],
                                    ),
                              ),),
                            ],
                          ),
                        ),
                      ),
                    );
                  }),
            ),
          ],
        )
    );
  }
}
Future<void> makePhoneCall(String phoneNumber) async {
  final Uri launchUri = Uri(
    scheme: 'tel',
    path: phoneNumber,
  );
  await launchUrl(launchUri);
}