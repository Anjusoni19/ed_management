import 'dart:async';

import 'package:ed_management/Colors.dart';
import 'package:ed_management/services/ApisProvider.dart';
import 'package:ed_management/services/custom%20loader.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toastification/toastification.dart';


class AddStudentScreen extends StatefulWidget {
  const AddStudentScreen({Key? key}) : super(key: key);

  @override
  _AddStudentScreenState createState() =>
      _AddStudentScreenState();
}

class _AddStudentScreenState extends State<AddStudentScreen> {

  //step 1 ------------------------------
  TextEditingController sr = TextEditingController();
  TextEditingController studentName = TextEditingController();
  TextEditingController fatherName = TextEditingController();
  TextEditingController motherName = TextEditingController();
  TextEditingController dob = TextEditingController();

  //step 2 ------------------------------
  TextEditingController mobileNumber = TextEditingController();
  TextEditingController guardianNumber = TextEditingController();

  //step 3 ------------------------------
  TextEditingController houseNumber = TextEditingController();
  TextEditingController street = TextEditingController();
  TextEditingController landmark = TextEditingController();
  TextEditingController area = TextEditingController();
  TextEditingController district = TextEditingController();
  TextEditingController city = TextEditingController();
  TextEditingController pincode = TextEditingController();

  //step 4-------------------------------
  TextEditingController doa = TextEditingController();
  TextEditingController aadhar = TextEditingController();
  TextEditingController lastSchoolName = TextEditingController();
  TextEditingController lastExamYear = TextEditingController();
  TextEditingController lastClass = TextEditingController();
  TextEditingController lastMarks = TextEditingController();
  TextEditingController lastBoard = TextEditingController();

  int _currentstep = 0;

  String _genderRadioBtnVal = '';

  var gender = 'Male';

  var _intervalValue = 'Select Standard';
  var _intervalValue2 = 'Select Section';

  List filterList = [];
  List sectionList = [];

  var religionValue = 'Select Religion';
  var castValue = 'Select Caste';

  var deptValue = 'Select Department';
  bool isRetired = false;
  var isGov = 0;
  var isRet = 'No';

  var isNew = 'Yes';

@override
  void initState() {
    // TODO: implement initState
    fetchDatas();
  }

  fetchDatas() async{
    final prefs = await SharedPreferences.getInstance();
    var standard = prefs.getString('standard') ?? '';
    print('standardList =====${standard}');
    // filterList.add('Select Standard');
    var newTest = standard.replaceAll('[', '').replaceAll(']', '');
    filterList = newTest.split(',');
    filterList.insert(0, 'Select Standard');
    print('standardList =====${filterList}');
    _intervalValue = filterList.first;

    var section = prefs.getString('section') ?? '';
    print('standardList =====${section}');
    // sectionList.add('Select Section');
    var newTest2 = section.replaceAll('[', '').replaceAll(']', '');
    sectionList = newTest2.split(',');
    sectionList.insert(0, 'Select Section');
    print('standardList =====${sectionList}');
    _intervalValue2 = sectionList.first;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: new AppBar(
          backgroundColor: appPrimary,
          titleSpacing: 0,
          title: new Text('Add Student', style: GoogleFonts.inter(color: Colors.white),),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: Card(
                  elevation: 4.0,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 15),
                    child: _currentstep == 0
                    ? Row(
                      children: [
                        Container(
                          child: Row(
                            children: [
                              Container(
                                height: 25,
                                width: 25,
                                decoration: BoxDecoration(
                                  color: appPrimary,
                                  borderRadius: BorderRadius.circular(40)
                                ),
                                alignment: Alignment.center,
                                child:
                                Text('1', style: GoogleFonts.inter(fontSize: 14, color: Colors.white, fontWeight: FontWeight.w500),),
                              ),
                              SizedBox(width: 8,),
                              Text('Personal Information', style: GoogleFonts.inter(fontSize: 16, color: appPrimary, fontWeight: FontWeight.w500),),
                            ],
                          ),
                        ),
                        Spacer(),
                        Row(
                          children: [
                            Container(
                              height: 25,
                              width: 25,
                              decoration: BoxDecoration(
                                border: Border.all(color: appPrimary),
                                  // color: appPrimary,
                                  borderRadius: BorderRadius.circular(40)
                              ),
                              alignment: Alignment.center,
                              child:
                              Text('2', style: GoogleFonts.inter(fontSize: 14, color: appPrimary, fontWeight: FontWeight.w500),),
                            ),
                            SizedBox(width: 10,),
                            Container(
                              height: 25,
                              width: 25,
                              decoration: BoxDecoration(
                                  border: Border.all(color: appPrimary),
                                  // color: appPrimary,
                                  borderRadius: BorderRadius.circular(40)
                              ),
                              alignment: Alignment.center,
                              child:
                              Text('3', style: GoogleFonts.inter(fontSize: 14, color: appPrimary, fontWeight: FontWeight.w500),),
                            ),
                            SizedBox(width: 10,),
                            Container(
                              height: 25,
                              width: 25,
                              decoration: BoxDecoration(
                                  border: Border.all(color: appPrimary),
                                  // color: appPrimary,
                                  borderRadius: BorderRadius.circular(40)
                              ),
                              alignment: Alignment.center,
                              child:
                              Text('4', style: GoogleFonts.inter(fontSize: 14, color: appPrimary, fontWeight: FontWeight.w500),),
                            ),
                            SizedBox(width: 10,),
                          ],
                        )
                      ],
                    )
                    : _currentstep == 1
                    ? Row(
                      children: [
                        Container(
                          height: 25,
                          width: 25,
                          decoration: BoxDecoration(
                              color: appPrimary,
                              borderRadius: BorderRadius.circular(40)
                          ),
                          alignment: Alignment.center,
                          child:                        Icon(Icons.check, color: Colors.white,size: 18,)
                      // Text('1', style: GoogleFonts.inter(fontSize: 14, color: Colors.white, fontWeight: FontWeight.w500),),
                        ),
                        SizedBox(width: 10,),
                        Row(
                          children: [
                            Container(
                              height: 25,
                              width: 25,
                              decoration: BoxDecoration(
                                  color: appPrimary,
                                  borderRadius: BorderRadius.circular(40)
                              ),
                              alignment: Alignment.center,
                              child:
                              Text('2', style: GoogleFonts.inter(fontSize: 14, color: Colors.white, fontWeight: FontWeight.w500),),
                            ),
                            SizedBox(width: 8,),
                            Text('Contact Information', style: GoogleFonts.inter(fontSize: 16, color: appPrimary, fontWeight: FontWeight.w500),),
                          ],
                        ),
                        SizedBox(width: 10,),
                        Spacer(),
                        Row(
                          children: [
                            Container(
                              height: 25,
                              width: 25,
                              decoration: BoxDecoration(
                                  border: Border.all(color: appPrimary),
                                  // color: appPrimary,
                                  borderRadius: BorderRadius.circular(40)
                              ),
                              alignment: Alignment.center,
                              child:
                              Text('3', style: GoogleFonts.inter(fontSize: 14, color: appPrimary, fontWeight: FontWeight.w500),),
                            ),
                            SizedBox(width: 10,),
                            Container(
                              height: 25,
                              width: 25,
                              decoration: BoxDecoration(
                                  // color: appPrimary,
                                 border: Border.all(color: appPrimary),
                                  borderRadius: BorderRadius.circular(40)
                              ),
                              alignment: Alignment.center,
                              child:
                              Text('4', style: GoogleFonts.inter(fontSize: 14, color: appPrimary, fontWeight: FontWeight.w500),),
                            ),
                            SizedBox(width: 10,),
                          ],
                        )
                      ],
                    )
                    : _currentstep == 2
                        ? Row(
                      children: [
                        Container(
                            height: 25,
                            width: 25,
                            decoration: BoxDecoration(
                                color: appPrimary,
                                borderRadius: BorderRadius.circular(40)
                            ),
                            alignment: Alignment.center,
                            child:
                            Icon(Icons.check, color: Colors.white,size: 18,)
                          // Text('1', style: GoogleFonts.inter(fontSize: 14, color: Colors.white, fontWeight: FontWeight.w500),),
                        ),
                        SizedBox(width: 10,),
                        Container(
                            height: 25,
                            width: 25,
                            decoration: BoxDecoration(
                                color: appPrimary,
                                borderRadius: BorderRadius.circular(40)
                            ),
                            alignment: Alignment.center,
                            child:
                            Icon(Icons.check, color: Colors.white,size: 18,)
                          // Text('2', style: GoogleFonts.inter(fontSize: 14, color: Colors.white, fontWeight: FontWeight.w500),),
                        ),
                        SizedBox(width: 10,),
                        Row(
                          children: [
                            Container(
                              height: 25,
                              width: 25,
                              decoration: BoxDecoration(
                                // border: Border.all(color: appPrimary),
                                  color: appPrimary,
                                  borderRadius: BorderRadius.circular(40)
                              ),
                              alignment: Alignment.center,
                              child:
                              Text('3', style: GoogleFonts.inter(fontSize: 14, color: Colors.white, fontWeight: FontWeight.w500),),
                            ),
                            SizedBox(width: 8,),
                            Text('Address Information', style: GoogleFonts.inter(fontSize: 16, color: appPrimary, fontWeight: FontWeight.w500),),
                          ],
                        ),
                        SizedBox(width: 10,),
                        Spacer(),
                        Row(
                          children: [
                            Container(
                              height: 25,
                              width: 25,
                              decoration: BoxDecoration(
                                // color: appPrimary,
                                  border: Border.all(color: appPrimary),
                                  borderRadius: BorderRadius.circular(40)
                              ),
                              alignment: Alignment.center,
                              child:
                              Text('4', style: GoogleFonts.inter(fontSize: 14, color: appPrimary, fontWeight: FontWeight.w500),),
                            ),
                            SizedBox(width: 10,),
                          ],
                        )
                      ],
                    )
                        : Row(
                      children: [
                        Container(
                            height: 25,
                            width: 25,
                            decoration: BoxDecoration(
                                color: appPrimary,
                                borderRadius: BorderRadius.circular(40)
                            ),
                            alignment: Alignment.center,
                            child:
                            Icon(Icons.check, color: Colors.white,size: 18,)
                          // Text('1', style: GoogleFonts.inter(fontSize: 14, color: Colors.white, fontWeight: FontWeight.w500),),
                        ),
                        SizedBox(width: 10,),
                        Container(
                            height: 25,
                            width: 25,
                            decoration: BoxDecoration(
                                color: appPrimary,
                                borderRadius: BorderRadius.circular(40)
                            ),
                            alignment: Alignment.center,
                            child:
                            Icon(Icons.check, color: Colors.white,size: 18,)
                          // Text('2', style: GoogleFonts.inter(fontSize: 14, color: Colors.white, fontWeight: FontWeight.w500),),
                        ),
                        SizedBox(width: 10,),
                        Container(
                          height: 25,
                          width: 25,
                          decoration: BoxDecoration(
                            // border: Border.all(color: appPrimary),
                              color: appPrimary,
                              borderRadius: BorderRadius.circular(40)
                          ),
                          alignment: Alignment.center,
                          child: Icon(Icons.check, size: 18, color: Colors.white,)
                          // Text('3', style: GoogleFonts.inter(fontSize: 14, color: Colors.white, fontWeight: FontWeight.w500),),
                        ),
                        SizedBox(width: 10,),
                        // Spacer(),
                        Row(
                          children: [
                            Row(
                              children: [
                                Container(
                                  height: 25,
                                  width: 25,
                                  decoration: BoxDecoration(
                                    color: appPrimary,
                                      // border: Border.all(color: appPrimary),
                                      borderRadius: BorderRadius.circular(40)
                                  ),
                                  alignment: Alignment.center,
                                  child:
                                  Text('4', style: GoogleFonts.inter(fontSize: 14, color: Colors.white, fontWeight: FontWeight.w500),),
                                ),
                                SizedBox(width: 8,),
                                Text('Other Information', style: GoogleFonts.inter(fontSize: 16, color: appPrimary, fontWeight: FontWeight.w500),),
                              ],
                            ),
                            SizedBox(width: 10,),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10),
                    child: _currentstep == 0
                    ? Column(
                            children: [
                              SizedBox(height: 10,),
                              Container(
                                height: 40,
                                // decoration:const  BoxDecoration(
                                //     border: Border(bottom: BorderSide(color: Colors.white))
                                // ),
                                child:TextFormField(
                                  controller: sr,
                                  cursorColor: appPrimary,
                                  style: const TextStyle(color: appPrimary, fontSize: 14),
                                  decoration:const  InputDecoration(
                                      labelText: 'SR No.',
                                      // hintText: 'Enter SR No.',
                                      fillColor: Colors.white,
                                      border: OutlineInputBorder(),
                                      focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: appPrimary, width: 1.5))
                                  ),
                                ),
                              ),
                              SizedBox(height: 10,),
                              Container(
                                height: 40,
                                // decoration:const  BoxDecoration(
                                //     border: Border(bottom: BorderSide(color: Colors.white))
                                // ),
                                child:TextFormField(
                                  controller: studentName,
                                  cursorColor: appPrimary,
                                  style: const TextStyle(color: appPrimary, fontSize: 14),
                                  decoration:const  InputDecoration(
                                      labelText: 'Student Name',
                                      // hintText: 'Enter Student Name',
                                      fillColor: Colors.white,
                                      border: OutlineInputBorder(),
                                      focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: appPrimary, width: 1.5))
                                  ),
                                ),
                              ),
                              SizedBox(height: 10,),
                              Container(
                                height: 40,
                                // decoration:const  BoxDecoration(
                                //     border: Border(bottom: BorderSide(color: Colors.white))
                                // ),
                                child:TextFormField(
                                  controller: fatherName,
                                  cursorColor: appPrimary,
                                  style: const TextStyle(color: appPrimary, fontSize: 14),
                                  decoration:const  InputDecoration(
                                      labelText: 'Father\'s Name',
                                      // hintText: 'Enter Father\'s Name',
                                      fillColor: Colors.white,
                                      border: OutlineInputBorder(),
                                      focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: appPrimary, width: 1.5))
                                  ),
                                ),
                              ),
                              SizedBox(height: 10,),
                              Container(
                                height: 40,
                                // decoration:const  BoxDecoration(
                                //     border: Border(bottom: BorderSide(color: Colors.white))
                                // ),
                                child:TextFormField(
                                  controller: motherName,
                                  cursorColor: appPrimary,
                                  // textAlign: TextAlign.left,
                                  style: TextStyle(color: appPrimary, fontSize: 14),
                                  decoration:const  InputDecoration(
                                      labelText: 'Mother\'s Name',
                                      // hintText: 'Enter Mother\'s Name',
                                      fillColor: Colors.white,
                                      border: OutlineInputBorder(),
                                      focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: appPrimary, width: 1.5))
                                  ),
                                ),
                              ),
                              SizedBox(height: 10,),
                              Row(
                                children: [
                                  Text('Gender', style: TextStyle(color: appPrimary),),
                                ],
                              ),
                              Row(
                                children: [
                                  Radio<String>(
                                    activeColor: appPrimary,
                                    value: "Male",
                                    groupValue: gender,
                                    onChanged: (val) {
                                      setState(() {
                                        gender = val!.toString();
                                      });
                                    },
                                  ),
                                  Text("Male"),
                                  Radio<String>(
                                    activeColor: appPrimary,
                                    value: "Female",
                                    groupValue: gender,
                                    onChanged: (val) {
                                      setState(() {
                                        gender = val!.toString();
                                      });
                                    },
                                  ),
                                  Text("Female"),
                                ],
                              ),
                              SizedBox(height: 10,),
                              Container(
                                height: 40,
                                // decoration:const  BoxDecoration(
                                //     border: Border(bottom: BorderSide(color: Colors.white))
                                // ),
                                alignment: Alignment.center,
                                child:TextFormField(
                                  controller: dob,
                                  onTap: () async{
                                    final DateTime? picked = await showDatePicker(
                                        context: context,
                                        initialDate: DateTime.now(),
                                        firstDate: DateTime(1900),
                                        //DateTime.now() - not to allow to choose before today.
                                        lastDate: DateTime.now()
                                    );
                                    print('pickedTimeT');
                                    var format = DateFormat('yyyy-MM-dd').format(picked!);
                                    setState(() {
                                      var endDate = format;
                                      dob = TextEditingController(text: endDate);
                                    });
                                  },
                                  enableInteractiveSelection: false,
                                  showCursor: false,
                                  // cursorHeight: 0,
                                  // cursorWidth: 0,
                                  // cursorColor: Colors.transparent,
                                  style: const TextStyle(color: appPrimary, fontSize: 14),
                                  decoration:  InputDecoration(
                                    // hintText: '$endDate',
                                    // hintTextDirection: TextDirection.ltr,
                                      hintStyle: GoogleFonts.poppins(fontSize: 10),
                                      labelText: 'Date of birth',
                                      fillColor: Colors.white,
                                      border: OutlineInputBorder(),
                                      focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: appPrimary, width: 1.5))
                                  ),
                                ),
                              ),
                            ],
                          )
                    : _currentstep == 1
                    ? Column(
                      children: [
                        SizedBox(height: 10,),
                        Container(
                          height: 40,
                          // decoration:const  BoxDecoration(
                          //     border: Border(bottom: BorderSide(color: Colors.white))
                          // ),
                          child:TextFormField(
                            autofocus: true,
                            controller: mobileNumber,
                            keyboardType: TextInputType.phone,
                            cursorColor: appPrimary,
                            style: const TextStyle(color: appPrimary, fontSize: 14),
                            decoration:const  InputDecoration(
                                labelText: 'Mobile Number',
                                hintText: 'Enter Mobile Number',
                                fillColor: Colors.white,
                                border: OutlineInputBorder(),
                                focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: appPrimary, width: 1.5))
                            ),
                          ),
                        ),
                        SizedBox(height: 10,),
                        Container(
                          height: 40,
                          // decoration:const  BoxDecoration(
                          //     border: Border(bottom: BorderSide(color: Colors.white))
                          // ),
                          child:TextFormField(
                            controller: guardianNumber,
                            keyboardType: TextInputType.phone,
                            cursorColor: appPrimary,
                            style: const TextStyle(color: appPrimary, fontSize: 14),
                            decoration:const  InputDecoration(
                                labelText: 'Guardian Mobile Number',
                                hintText: 'Enter Guardian Mobile Number',
                                fillColor: Colors.white,
                                border: OutlineInputBorder(),
                                focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: appPrimary, width: 1.5))
                            ),
                          ),
                        ),
                      ],
                    )
                    :   _currentstep == 2
                        ?   Column(
                      children: [
                        SizedBox(height: 10,),
                        Container(
                          height: 40,
                          // decoration:const  BoxDecoration(
                          //     border: Border(bottom: BorderSide(color: Colors.white))
                          // ),
                          child:TextFormField(
                            controller: houseNumber,
                            cursorColor: appPrimary,
                            style: const TextStyle(color: appPrimary, fontSize: 14),
                            decoration:const  InputDecoration(
                                labelText: 'House/Building No.',
                                hintText: 'Enter House/Building No.',
                                fillColor: Colors.white,
                                border: OutlineInputBorder(),
                                focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: appPrimary, width: 1.5))
                            ),
                          ),
                        ),
                        SizedBox(height: 10,),
                        Container(
                          height: 40,
                          // decoration:const  BoxDecoration(
                          //     border: Border(bottom: BorderSide(color: Colors.white))
                          // ),
                          child:TextFormField(
                            controller: street,
                            cursorColor: appPrimary,
                            style: const TextStyle(color: appPrimary, fontSize: 14),
                            decoration:const  InputDecoration(
                                labelText: 'Street/Road/Lane',
                                // hintText: 'Enter Guardian Mobile Number',
                                fillColor: Colors.white,
                                border: OutlineInputBorder(),
                                focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: appPrimary, width: 1.5))
                            ),
                          ),
                        ),
                        SizedBox(height: 10,),
                        Container(
                          height: 40,
                          // decoration:const  BoxDecoration(
                          //     border: Border(bottom: BorderSide(color: Colors.white))
                          // ),
                          child:TextFormField(
                            controller: landmark,
                            cursorColor: appPrimary,
                            style: const TextStyle(color: appPrimary, fontSize: 14),
                            decoration:const  InputDecoration(
                                labelText: 'Landmark',
                                // hintText: 'Enter Guardian Mobile Number',
                                fillColor: Colors.white,
                                border: OutlineInputBorder(),
                                focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: appPrimary, width: 1.5))
                            ),
                          ),
                        ),
                        SizedBox(height: 10,),
                        Container(
                          height: 40,
                          // decoration:const  BoxDecoration(
                          //     border: Border(bottom: BorderSide(color: Colors.white))
                          // ),
                          child:TextFormField(
                            controller: area,
                            cursorColor: appPrimary,
                            style: const TextStyle(color: appPrimary, fontSize: 14),
                            decoration:const  InputDecoration(
                                labelText: 'Area/Locality/Sector',
                                // hintText: 'Enter Guardian Mobile Number',
                                fillColor: Colors.white,
                                border: OutlineInputBorder(),
                                focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: appPrimary, width: 1.5))
                            ),
                          ),
                        ),
                        SizedBox(height: 10,),
                        Container(
                          height: 40,
                          // decoration:const  BoxDecoration(
                          //     border: Border(bottom: BorderSide(color: Colors.white))
                          // ),
                          child:TextFormField(
                            controller: district,
                            cursorColor: appPrimary,
                            style: const TextStyle(color: appPrimary, fontSize: 14),
                            decoration:const  InputDecoration(
                                labelText: 'District',
                                // hintText: 'Enter Guardian Mobile Number',
                                fillColor: Colors.white,
                                border: OutlineInputBorder(),
                                focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: appPrimary, width: 1.5))
                            ),
                          ),
                        ),
                        SizedBox(height: 10,),
                        Container(
                          height: 40,
                          // decoration:const  BoxDecoration(
                          //     border: Border(bottom: BorderSide(color: Colors.white))
                          // ),
                          child:TextFormField(
                            controller: city,
                            cursorColor: appPrimary,
                            style: const TextStyle(color: appPrimary, fontSize: 14),
                            decoration:const  InputDecoration(
                                labelText: 'City',
                                // hintText: 'Enter Guardian Mobile Number',
                                fillColor: Colors.white,
                                border: OutlineInputBorder(),
                                focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: appPrimary, width: 1.5))
                            ),
                          ),
                        ),
                        SizedBox(height: 10,),
                        Container(
                          height: 40,
                          // decoration:const  BoxDecoration(
                          //     border: Border(bottom: BorderSide(color: Colors.white))
                          // ),
                          child:TextFormField(
                            controller: pincode,
                            cursorColor: appPrimary,
                            style: const TextStyle(color: appPrimary, fontSize: 14),
                            decoration:const  InputDecoration(
                                labelText: 'Pin Code',
                                // hintText: 'Enter Guardian Mobile Number',
                                fillColor: Colors.white,
                                border: OutlineInputBorder(),
                                focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: appPrimary, width: 1.5))
                            ),
                          ),
                        ),
                      ],
                    )
                        : SingleChildScrollView(
                         child: Column(
                      children: [
                          SizedBox(height: 10,),
                          Container(
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
                                      child: Text(value == 'Select Standard' ? value.toString() : '${value.toString()}'),
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
                          SizedBox(height: 10,),
                          Container(
                            height: 40,
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey),
                                borderRadius: BorderRadius.circular(4)
                            ),
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton<String>(
                                hint: const Text('Select Section'),
                                value: _intervalValue2,
                                // isExpanded: true,
                                items: sectionList.map(
                                      (value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(value == 'Select Standard' ? value.toString() : '${value.toString()}'),
                                    );
                                  },
                                ).toList(),
                                onChanged: (value) {
                                  setState(() {
                                    _intervalValue2 = value!;
                                  });
                                },
                              ),
                            ),
                          ),
                          SizedBox(height: 10,),
                          Container(
                            height: 40,
                            // decoration:const  BoxDecoration(
                            //     border: Border(bottom: BorderSide(color: Colors.white))
                            // ),
                            alignment: Alignment.center,
                            child:TextFormField(
                              controller: doa,
                              onTap: () async{
                                final DateTime? picked = await showDatePicker(
                                    context: context,
                                    initialDate: DateTime.now(),
                                    firstDate: DateTime(1900),
                                    //DateTime.now() - not to allow to choose before today.
                                    lastDate: DateTime.now()
                                );
                                print('pickedTimeT');
                                var format = DateFormat('yyyy-MM-dd').format(picked!);
                                setState(() {
                                  var endDate = format;
                                  doa = TextEditingController(text: endDate);
                                });
                              },
                              showCursor: false,
                              enableInteractiveSelection: false,
                              // cursorHeight: 0,
                              // cursorWidth: 0,
                              // cursorColor: appPrimary,
                              style: const TextStyle(color: appPrimary, fontSize: 14),
                              decoration:  InputDecoration(
                                // hintText: '$endDate',
                                // hintTextDirection: TextDirection.ltr,
                                  hintStyle: GoogleFonts.poppins(fontSize: 10),
                                  labelText: 'Date of Admission',
                                  fillColor: Colors.white,
                                  border: OutlineInputBorder(),
                                  focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: appPrimary, width: 1.5))
                              ),
                            ),
                          ),
                          SizedBox(height: 10,),
                          Container(
                            height: 40,
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey),
                                borderRadius: BorderRadius.circular(4)
                            ),
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton<String>(
                                hint: const Text('Select Religion'),
                                value: religionValue,
                                // isExpanded: true,
                                items: ['Select Religion', 'Hinduism', 'Islam', 'Christianity', 'Sikhism', 'Buddhism', 'Jainism', 'Other'].map(
                                      (value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(value == 'Select Religion' ? value.toString() : '${value.toString()}'),
                                    );
                                  },
                                ).toList(),
                                onChanged: (value) {
                                  setState(() {
                                    religionValue = value!;
                                  });
                                },
                              ),
                            ),
                          ),
                          SizedBox(height: 10,),
                          Container(
                            height: 40,
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey),
                                borderRadius: BorderRadius.circular(4)
                            ),
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton<String>(
                                hint: const Text('Select Caste'),
                                value: castValue,
                                // isExpanded: true,
                                items: ['Select Caste', 'General', 'OBC', 'SBC', 'EBC', 'SC', 'ST', 'Other'].map(
                                      (value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(value == 'Select Cast' ? value.toString() : '${value.toString()}'),
                                    );
                                  },
                                ).toList(),
                                onChanged: (value) {
                                  setState(() {
                                    castValue = value!;
                                  });
                                },
                              ),
                            ),
                          ),
                          SizedBox(height: 10,),
                          Column(
                            children: [
                              InkWell(
                                onTap: () {
                                  if(isGov == 1) {
                                    setState(() {
                                      isGov = 0;
                                    });
                                  } else {
                                    setState(() {
                                      isGov = 1;
                                    });
                                  }
                                },
                                child: Card(
                                  elevation: 2,
                                  child: Padding(
                                    padding: const EdgeInsets.all(5.0),
                                    child: Row(
                                      children: [
                                        Icon(isGov == 1 ? Icons.check_box : Icons.check_box_outline_blank_rounded, color: appPrimary,),
                                        SizedBox(width: 5,),
                                        Text('Is your father in govt job', style: TextStyle(color: appPrimary),),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(height: 8,),
                              isGov == 1
                              ? Container()
                              : InkWell(
                                onTap: () {
                                  if(isGov == 2) {
                                    setState(() {
                                      isGov = 0;
                                    });
                                  } else {
                                    setState(() {
                                      isGov = 2;
                                    });
                                  }
                                },
                                child: Card(
                                  elevation: 2,
                                  child: Padding(
                                    padding: const EdgeInsets.all(5.0),
                                    child: Row(
                                      children: [
                                        Icon(isGov == 2 ? Icons.check_box :Icons.check_box_outline_blank_rounded, color: appPrimary,),
                                        SizedBox(width: 5,),
                                        Text('Is your mother in govt job', style: TextStyle(color: appPrimary),),
                                      ],
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                          SizedBox(height: 10,),
                          isGov == 0
                          ? Container()
                          : Container(

                            height: 40,
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey),
                                borderRadius: BorderRadius.circular(4)
                            ),
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton<String>(
                                hint: const Text('Select Department'),
                                value: deptValue,
                                // isExpanded: true,
                                items: ['Select Department', 'Defence Service', 'Medical', 'Police Force', 'Teacher', 'Other'].map(
                                      (value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(value == 'Select Department' ? value.toString() : '${value.toString()}'),
                                    );
                                  },
                                ).toList(),
                                onChanged: (value) {
                                  setState(() {
                                    deptValue = value!;
                                  });
                                },
                              ),
                            ),
                          ),
                        isGov == 0
                          ? Container()
                          :SizedBox(height: 10,),
                        isGov == 0
                          ? Container()
                          :Row(
                            children: [
                              Text('Is your ${isGov == 1 ? 'father': 'mother'} retired?', style: TextStyle(color: appPrimary),),
                            ],
                          ),
                        isGov == 0
                          ? Container()
                          :SizedBox(height: 5,),
                        isGov == 0
                          ? Container()
                          :Row(
                            children: [
                              Radio<String>(
                                activeColor: appPrimary,
                                value: "Yes",
                                groupValue: isRet,
                                onChanged: (val) {
                                  setState(() {
                                    isRet = val!.toString();
                                  });
                                },
                              ),
                              Text("Yes"),
                              SizedBox(width: 5,),
                              Radio<String>(
                                activeColor: appPrimary,
                                value: "No",
                                groupValue: isRet,
                                onChanged: (val) {
                                  setState(() {
                                    isRet = val!.toString();
                                  });
                                },
                              ),
                              Text("No"),
                            ],
                          ),
                          SizedBox(height: 10,),
                          Container(
                            height: 40,
                            // decoration:const  BoxDecoration(
                            //     border: Border(bottom: BorderSide(color: Colors.white))
                            // ),
                            child:TextFormField(
                              controller: aadhar,
                              cursorColor: appPrimary,
                              style: const TextStyle(color: appPrimary, fontSize: 14),
                              decoration:const  InputDecoration(
                                  labelText: 'Aadhar',
                                  // hintText: 'Enter Guardian Mobile Number',
                                  fillColor: Colors.white,
                                  border: OutlineInputBorder(),
                                  focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: appPrimary, width: 1.5))
                              ),
                            ),
                          ),
                          SizedBox(height: 10,),
                          Container(
                            height: 40,
                            // decoration:const  BoxDecoration(
                            //     border: Border(bottom: BorderSide(color: Colors.white))
                            // ),
                            child:TextFormField(
                              controller: lastSchoolName,
                              cursorColor: appPrimary,
                              style: const TextStyle(color: appPrimary, fontSize: 14),
                              decoration:const  InputDecoration(
                                  labelText: 'Last School Name',
                                  // hintText: 'Enter Guardian Mobile Number',
                                  fillColor: Colors.white,
                                  border: OutlineInputBorder(),
                                  focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: appPrimary, width: 1.5))
                              ),
                            ),
                          ),
                          SizedBox(height: 10,),
                          Container(
                            height: 40,
                            // decoration:const  BoxDecoration(
                            //     border: Border(bottom: BorderSide(color: Colors.white))
                            // ),
                            child:TextFormField(
                              controller: lastExamYear,
                              keyboardType: TextInputType.number,
                              cursorColor: appPrimary,
                              style: const TextStyle(color: appPrimary, fontSize: 14),
                              decoration:const  InputDecoration(
                                  labelText: 'Last Exam year',
                                  // hintText: 'Enter Guardian Mobile Number',
                                  fillColor: Colors.white,
                                  border: OutlineInputBorder(),
                                  focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: appPrimary, width: 1.5))
                              ),
                            ),
                          ),
                          SizedBox(height: 10,),
                          Container(
                          height: 40,
                          // decoration:const  BoxDecoration(
                          //     border: Border(bottom: BorderSide(color: Colors.white))
                          // ),
                          child:TextFormField(
                          controller: lastClass,
                          keyboardType: TextInputType.number,
                          cursorColor: appPrimary,
                          style: const TextStyle(color: appPrimary, fontSize: 14),
                          decoration:const  InputDecoration(
                              labelText: 'Last Class',
                              // hintText: 'Enter Guardian Mobile Number',
                              fillColor: Colors.white,
                              border: OutlineInputBorder(),
                              focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: appPrimary, width: 1.5))
                          ),
                          ),
                        ),
                        SizedBox(height: 10,),
                        Container(
                          height: 40,
                          // decoration:const  BoxDecoration(
                          //     border: Border(bottom: BorderSide(color: Colors.white))
                          // ),
                          child:TextFormField(
                          controller: lastMarks,
                          keyboardType: TextInputType.number,
                          cursorColor: appPrimary,
                          style: const TextStyle(color: appPrimary, fontSize: 14),
                          decoration:const  InputDecoration(
                              labelText: 'Last Marks (IN PER)',
                              // hintText: 'Enter Guardian Mobile Number',
                              fillColor: Colors.white,
                              border: OutlineInputBorder(),
                              focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: appPrimary, width: 1.5))
                          ),
                          ),
                        ),
                        SizedBox(height: 10,),
                        Container(
                          height: 40,
                          // decoration:const  BoxDecoration(
                          //     border: Border(bottom: BorderSide(color: Colors.white))
                          // ),
                          child:TextFormField(
                          controller: lastBoard,
                          // keyboardType: TextInputType.number,
                          cursorColor: appPrimary,
                          style: const TextStyle(color: appPrimary, fontSize: 14),
                          decoration:const  InputDecoration(
                              labelText: 'Last Board/University',
                              // hintText: 'Enter Guardian Mobile Number',
                              fillColor: Colors.white,
                              border: OutlineInputBorder(),
                              focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: appPrimary, width: 1.5))
                          ),
                          ),
                        ),
                        SizedBox(height: 10,),
                        Row(
                          children: [
                          Radio<String>(
                            activeColor: appPrimary,
                            value: "Yes",
                            groupValue: isNew,
                            onChanged: (val) {
                              setState(() {
                                isNew = val!.toString();
                              });
                            },
                          ),
                          Text("New"),
                          SizedBox(width: 5,),
                          Radio<String>(
                            activeColor: appPrimary,
                            value: "No",
                            groupValue: isNew,
                            onChanged: (val) {
                              setState(() {
                                isNew = val!.toString();
                              });
                            },
                          ),
                          Text("Old"),
                          ],
                        ),
                      ],
                    ),
                        ),

                  ),
                ),
              ),
            ],
          ),
        ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Container(
          height: 50,
          width: MediaQuery.of(context).size.width,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _currentstep == 0
                  ? Container()
                  : Container(
                  width: 120,
                  child: OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4.0),
                      ),
                      side: const BorderSide(
                        width: 1.0,
                        color: appPrimary,
                    ),),
                    onPressed: () {
                      setState(() {
                        _currentstep = _currentstep - 1;
                      });
                    },
                    child: Text('Back', style: GoogleFonts.poppins(color: appPrimary),)),
              ),
              Container(
                width: 120,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        primary: appPrimary),
                    onPressed: () async{
                      print(_currentstep);
                      if(_currentstep == 3) {
                       print('call api ===');
                       fetchData(context);
                       var result = await ApiService().
                       studentAdd(
                           sr.text,
                           doa.text,
                           fatherName.text,
                           studentName.text,
                           motherName.text,
                           dob.text,
                           castValue, religionValue, gender,
                           mobileNumber.text,
                           guardianNumber.text,
                           street.text, aadhar.text,
                           houseNumber.text, landmark.text, area.text, city.text,
                           district.text, pincode.text, isGov, deptValue, isRet, isNew);
                       print(result);
                       Navigator.pop(context);
                       if(result['message'] == 'Success') {
                         toastification.show(
                           type: ToastificationType.success,
                           context: context,
                           title: Text('Student add succesfully'),
                           autoCloseDuration: const Duration(seconds: 3),
                         );
                         Navigator.pop(context);
                       }
                      } else {
                        setState(() {
                          _currentstep = _currentstep + 1;
                        });
                      }
                    },
                    child: Text(_currentstep == 3 ? 'Submit' : 'Next', style: GoogleFonts.poppins(color: Colors.white),)),
              ),
            ],
          ),
        ),
      ),
    );
  }


}
