import 'package:ed_management/Colors.dart';
import 'package:ed_management/screens/Student%20Finance%20Report.dart';
import 'package:ed_management/utill/textUtill.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:math' as math show Random;

class StudentMessageScreen extends StatefulWidget {
  @override
  _StudentMessageScreenState createState() => _StudentMessageScreenState();
}

class _StudentMessageScreenState extends State<StudentMessageScreen> {
  bool isSelect = false;

  int selectedVal = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 10,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        title: Text('Student Message', style: GoogleFonts.inter(color: appPrimary),),
        actions: [
          InkWell(
            onTap: () {
              // Navigator.push(context, MaterialPageRoute(builder: (context) => AddStudentScreen()));
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 9.0),
              child: Icon(Icons.check_box_outline_blank, size: 22, color: appPrimary,),
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
                                borderRadius: BorderRadius.circular(2)
                            ),
                            contentPadding: EdgeInsets.zero,
                            content: SizedBox(
                              width: MediaQuery.of(context).size.width/1.1,
                              height: MediaQuery.of(context).size.height/1.8,
                              child: Column(
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Row(
                                      children: [
                                        InkWell(
                                          onTap: () {
                                            newSetState(() {
                                              selectedVal = 1;
                                            });
                                          },
                                          child: Container(
                                            width: MediaQuery.of(context).size.width/3.5,
                                            height: 40,
                                            decoration: BoxDecoration(
                                                color: selectedVal == 1 ? appPrimary : Colors.white,
                                                border: Border.all(color: selectedVal == 1 ? appPrimary : Colors.grey.shade300)
                                            ),
                                            alignment: Alignment.center,
                                            child: Text('Standard', style: GoogleFonts.inter(color: selectedVal == 1 ? Colors.white : appPrimary),),
                                          ),
                                        ),
                                        InkWell(
                                          onTap: () {
                                            newSetState(() {
                                              selectedVal = 2;
                                            });
                                          },
                                          child: Container(
                                            width: MediaQuery.of(context).size.width/3.5,
                                            height: 40,
                                            decoration: BoxDecoration(
                                                color: selectedVal == 2 ? appPrimary : Colors.white,
                                                border: Border.all(color: selectedVal == 2 ? appPrimary : Colors.grey.shade300)
                                            ),
                                            alignment: Alignment.center,
                                            child: Text('Tag', style: GoogleFonts.inter(color: selectedVal == 2 ? Colors.white : appPrimary),),
                                          ),
                                        ),
                                        InkWell(
                                          onTap: () {
                                            newSetState(() {
                                              selectedVal = 3;
                                            });
                                          },
                                          child: Container(
                                            width: MediaQuery.of(context).size.width/3.5,
                                            height: 40,
                                            decoration: BoxDecoration(
                                                color: selectedVal == 3 ? appPrimary : Colors.white,
                                                border: Border.all(color: selectedVal == 3 ? appPrimary : Colors.grey.shade300)
                                            ),
                                            alignment: Alignment.center,
                                            child: Text('Section', style: GoogleFonts.inter(color: selectedVal == 3 ? Colors.white : appPrimary),),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  selectedVal == 1
                                      ?  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 15.0),
                                    child: Row(
                                      children: [
                                        Text('Fourth', style: TextStyle(color: Colors.black),),
                                        Spacer(),
                                        InkWell(
                                            onTap: () {
                                              newSetState(() {
                                                isSelect = !isSelect;
                                              });
                                            },
                                            child: Icon(isSelect ? Icons.check_box : Icons.check_box_outline_blank, color: isSelect ? appPrimary : Colors.grey,))
                                      ],
                                    ),
                                  )
                                      : Container(),
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
                                              onPressed: (){},
                                              child: Text('Filter')),
                                        ) ,
                                        SizedBox(width: 20,),
                                        Container(
                                          width: 80,
                                          height: 30,
                                          child: ElevatedButton(
                                              style: ElevatedButton.styleFrom(primary: Colors.red),
                                              onPressed: (){},
                                              child: Text('Close')),
                                        )
                                      ],
                                    ),
                                  ),
                                  SizedBox(height: 10,),
                                ],
                              ),
                            ),
                          );
                        }
                    );
                  });
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 12.0),
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
                      width: 25,
                      height: 25,
                      child: Icon(Icons.filter_list_outlined,size: 16, color: appPrimary,))),
            ),
          ),
          SizedBox(width: 10,),
        ],
      ),
      body:  SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(top: 10.0),
          child: ListView.builder(
              itemCount: 10,
              itemBuilder: (BuildContext context, int index) {
                final color = Colors.primaries[math.Random().nextInt(Colors.primaries.length)];
                return GestureDetector(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => StudentFinanceScreen()));
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10.0, right: 10.0, bottom: 5),
                    child: Card(
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(color: Colors.grey.shade300),
                            borderRadius: BorderRadius.circular(4.0)
                        ),
                        height: 170,
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(color: appPrimary, width: 5,),
                            ),
                            SizedBox(width: 2,),
                            Padding(
                              padding: const EdgeInsets.only(top: 10.0, bottom: 10),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    width: MediaQuery.of(context).size.width/1.3,
                                    child: Row(
                                      children: [
                                        Text('Name:', style: GoogleFonts.poppins(color: Colors.black, fontSize: 14),),
                                        SizedBox(width: 8,),
                                        Text('Anju Soni:', style: GoogleFonts.poppins(color: appPrimary, fontSize: 14),),
                                      ],
                                    ),
                                  ),
                                  SizedBox(height: 2,),
                                  Container(
                                    width: MediaQuery.of(context).size.width/1.3,
                                    child: Row(
                                      children: [
                                        Text("Fs Name:", style: GoogleFonts.poppins(color: Colors.black, fontSize: 14),),
                                        SizedBox(width: 8,),
                                        Text('Praveen Kumar Soni:', style: GoogleFonts.poppins(color: appPrimary, fontSize: 14),),
                                      ],
                                    ),
                                  ),
                                  SizedBox(height: 2,),
                                  Container(
                                    width: MediaQuery.of(context).size.width/1.3,
                                    child: Row(
                                      children: [
                                        Text('Standard:', style: GoogleFonts.poppins(color: Colors.black, fontSize: 14),),
                                        SizedBox(width: 8,),
                                        Text('Fourth:', style: GoogleFonts.poppins(color: appPrimary, fontSize: 14),),
                                      ],
                                    ),
                                  ),
                                  SizedBox(height: 2,),
                                  Container(
                                    width: MediaQuery.of(context).size.width/1.3,
                                    child: Row(
                                      children: [
                                        Text('Stream:', style: GoogleFonts.poppins(color: Colors.black, fontSize: 14),),
                                        SizedBox(width: 8,),
                                        Text('RBSE - Hindi', style: GoogleFonts.poppins(color: appPrimary, fontSize: 14),),
                                      ],
                                    ),
                                  ),
                                  SizedBox(height: 10,),
                                  Container(
                                    width: MediaQuery.of(context).size.width/1.3,
                                    child: Row(
                                      children: [
                                        Icon(Icons.info, color: Colors.orange.shade400, size: 17,),
                                        SizedBox(width: 5,),
                                        Text('222 Days', style: GoogleFonts.inter(color: Colors.black, fontSize: 12)),
                                        SizedBox(width: 15,),
                                        Icon(Icons.calendar_month, color: Colors.red.shade400, size: 17,),
                                        SizedBox(width: 5,),
                                        Text('2023-07-16', style: GoogleFonts.inter(color: Colors.black, fontSize: 12)),
                                      ],
                                    ),
                                  ),
                                  SizedBox(height: 10,),
                                  Container(
                                    width: MediaQuery.of(context).size.width/1.3,
                                    child: Row(
                                      children: [
                                        Container(
                                          height: 23,
                                          decoration: BoxDecoration(
                                              // border: Border.all(color: Colors.green),
                                              color: appPrimary,
                                              borderRadius: BorderRadius.circular(2)
                                          ),
                                          alignment: Alignment.center,
                                          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                                          child:
                                          Text('3500 INR', style: GoogleFonts.inter(color: Colors.white, fontSize: 10)
                                          ),),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(width: 15,),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              }),
        ),
      ),
    );
  }
}