import 'package:ed_management/Colors.dart';
import 'package:ed_management/screens/Student%20Finance%20Report.dart';
import 'package:ed_management/utill/textUtill.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:math' as math show Random;

class OverdueFeesScreen extends StatefulWidget {
  @override
  _OverdueFeesScreenState createState() => _OverdueFeesScreenState();
}

class _OverdueFeesScreenState extends State<OverdueFeesScreen> {
  var selectedVal = 1;

  bool isSelect = false;

  bool onSearch = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 10,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        title: Text('Finance Report', style: GoogleFonts.inter(color: appPrimary, fontSize: 14),),
      ),
      body:  SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Card(
                child: SizedBox(
                  height: 40,
                  // decoration:const  BoxDecoration(
                  //     border: Border(bottom: BorderSide(color: Colors.white))
                  // ),
                  // alignment: Alignment.center,
                  child:TextFormField(
                    // readOnly: !onSearch ? true : false,
                    // controller: search,
                    cursorColor: appPrimary,
                    style:  TextStyle(color: Colors.black, fontSize: 15),
                    decoration:  InputDecoration(
                        prefixIcon: Icon(Icons.search, size: 20, color: Colors.grey,),
                        // hintText: onSearch ? '' : 'Select Standard',
                        //   labelText: 'Username',
                        hintStyle: TextStyle(fontSize: 14, color: Colors.grey.shade500),
                        fillColor: Colors.white,
                        // border: InputBorder.none,
                        border: OutlineInputBorder(borderSide: BorderSide(color: Colors.grey.shade200, width: 1.5)),
                        focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.grey.shade200, width: 1.5)),
                        disabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.grey.shade200, width: 1.5))
                    ),
                  ),
                ),
              ),
              SizedBox(height: 5,),
              Padding(
                padding: const EdgeInsets.all(2.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap: () {
                        setState(() {
                          onSearch = true;
                          // search.clear();
                        });
                      },
                      child: Container(
                        width: MediaQuery.of(context).size.width/2.12,
                        height: 30,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            color: onSearch ? appPrimary : Colors.grey.shade300,
                            // border: Border.all(color: Colors.grey.shade300, width: 1.0),
                            borderRadius: BorderRadius.only(topRight: Radius.circular(8), topLeft: Radius.circular(8))
                        ),child: Text('Overdue', style: GoogleFonts.inter(color: onSearch ? Colors.white : Colors.black, fontSize: 12),),
                      ),
                    ),
                    // SizedBox(width: 5,),
                    InkWell(
                      onTap: () {
                        setState(() {
                          onSearch = false;
                          // search.clear();
                        });
                      },
                      child: Container(
                        width: MediaQuery.of(context).size.width/2.12,
                        height: 30,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            color: !onSearch ? appPrimary : Colors.grey.shade300,
                            // border: Border.all(color: Colors.grey.shade300, width: 1.0),
                            borderRadius: BorderRadius.only(topRight: Radius.circular(8), topLeft: Radius.circular(8))
                        ),child: Text('Remaining', style: GoogleFonts.inter(color: !onSearch ? Colors.white : Colors.black, fontSize: 12),),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: ListView.builder(
                    itemCount: 10,
                    itemBuilder: (BuildContext context, int index) {
                      final color = Colors.primaries[math.Random().nextInt(Colors.primaries.length)];
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => StudentFinanceScreen()));
                        },
                        child: Padding(
                          padding: const EdgeInsets.only( bottom: 5, top: 5),
                          child: Card(
                            child: Container(
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  border: Border.all(color: Colors.grey.shade300),
                                  borderRadius: BorderRadius.circular(4.0)
                              ),
                              height: 200,
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
                                          width: MediaQuery.of(context).size.width/1.16,
                                          child: Row(
                                            children: [
                                              Text('Name:', style: GoogleFonts.poppins(color: Colors.black, fontSize: 12),),
                                              SizedBox(width: 8,),
                                              Text('Anju Soni:', style: GoogleFonts.poppins(color: appPrimary, fontSize: 12),),
                                            ],
                                          ),
                                        ),
                                        SizedBox(height: 2,),
                                        Container(
                                          width: MediaQuery.of(context).size.width/1.16,
                                          child: Row(
                                            children: [
                                              Text("Fs Name:", style: GoogleFonts.poppins(color: Colors.black, fontSize: 12),),
                                              SizedBox(width: 8,),
                                              Text('Praveen Soni:', style: GoogleFonts.poppins(color: appPrimary, fontSize: 12),),
                                              Spacer(),
                                              Text('Total:',
                                                textAlign: TextAlign.end,
                                                style: GoogleFonts.poppins(color: Colors.black, fontSize: 9),),
                                              SizedBox(width: 8,),
                                              Text('30000',
                                                textAlign: TextAlign.end,
                                                style: GoogleFonts.poppins(color: Colors.black, fontSize: 9),),
                                            ],
                                          ),
                                        ),
                                        SizedBox(height: 2,),
                                        Container(
                                          width: MediaQuery.of(context).size.width/1.16,
                                          child: Row(
                                            children: [
                                              Text('Standard:', style: GoogleFonts.poppins(color: Colors.black, fontSize: 12),),
                                              SizedBox(width: 8,),
                                              Text('Fourth:', style: GoogleFonts.poppins(color: appPrimary, fontSize: 12),),
                                              Spacer(),
                                              Text('Received:',
                                                textAlign: TextAlign.end,
                                                style: GoogleFonts.poppins(color: Colors.green, fontSize: 9),),
                                              SizedBox(width: 8,),
                                              Text('13572',
                                                textAlign: TextAlign.end,
                                                style: GoogleFonts.poppins(color: Colors.green, fontSize: 9),),
                                            ],
                                          ),
                                        ),
                                        SizedBox(height: 2,),
                                        Container(
                                          width: MediaQuery.of(context).size.width/1.16,
                                          child: Row(
                                            children: [
                                              Text('Stream:', style: GoogleFonts.poppins(color: Colors.black, fontSize: 12),),
                                              SizedBox(width: 8,),
                                              Text('RBSE - Hindi', style: GoogleFonts.poppins(color: appPrimary, fontSize: 12),),
                                              Spacer(),
                                              Text('Balance Fees:',
                                                textAlign: TextAlign.end,
                                                style: GoogleFonts.poppins(color: appPrimary, fontSize: 9),),
                                              SizedBox(width: 8,),
                                              Text('16428',
                                                textAlign: TextAlign.end,
                                                style: GoogleFonts.poppins(color: appPrimary, fontSize: 9),),
                                            ],
                                          ),
                                        ),
                                        SizedBox(height: 10,),
                                        Container(
                                          width: MediaQuery.of(context).size.width/1.16,
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
                                          width: MediaQuery.of(context).size.width/1.16,
                                          child: Row(
                                            children: [
                                              Container(
                                                height: 23,
                                                decoration: BoxDecoration(
                                                  // border: Border.all(color: Colors.green),
                                                    color: Colors.orange.shade700,
                                                    borderRadius: BorderRadius.circular(2)
                                                ),
                                                alignment: Alignment.center,
                                                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                                                child:
                                                Text('16428', style: GoogleFonts.inter(color: Colors.white, fontSize: 10)
                                                ),),
                                              SizedBox(width: 10,),
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
                                                Text('View Remark', style: GoogleFonts.inter(color: Colors.white, fontSize: 10)
                                                ),),
                                              Spacer(),
                                              Row(
                                                children: [
                                                  InkWell(
                                                    onTap: () {

                                                    },
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
                                                            child: Icon(Icons.add,size: 18, color: appPrimary,))),
                                                  ),
                                                  // SizedBox(width: 5,),
                                                  InkWell(
                                                    onTap: () {

                                                    },
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
                                                  // SizedBox(width: 5,),
                                                  InkWell(
                                                    onTap: () {

                                                    },
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
                                                            padding: EdgeInsets.all(5),
                                                            child: Image.asset('assets/update.png',height: 15, color: appPrimary,))),
                                                  ),
                                                ],
                                              )
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  // SizedBox(width: 15,),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    }),
              )
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        mini: true,
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
                                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                                child: InkWell(
                                  onTap: () {
                                    Navigator.pop(context);
                                    // Navigator.push(context, MaterialPageRoute(builder: (context) => ForgotPasswordScreen()));
                                  },
                                  child: Container(
                                    height: 35,
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                        border: Border.all(color: appPrimary),
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(4)
                                    ),
                                    alignment: Alignment.center,
                                    child: Text("APPLY", style: GoogleFonts.merriweather(color: appPrimary, fontSize: 13)),
                                  ),
                                ),
                              ),
                              SizedBox(height: 10,),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                                child: InkWell(
                                  onTap: () {
                                    Navigator.pop(context);
                                    // Navigator.push(context, MaterialPageRoute(builder: (context) => ForgotPasswordScreen()));
                                  },
                                  child: Container(
                                    height: 35,
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                        border: Border.all(color: Colors.black),
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(4)
                                    ),
                                    alignment: Alignment.center,
                                    child: Text("CLOSE", style: GoogleFonts.merriweather(color: Colors.black, fontSize: 13)),
                                  ),
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
        child: Icon(Icons.filter_list_outlined, color: appPrimary,size: 18,),
        backgroundColor: Colors.white,
        hoverColor: appPrimary,
        foregroundColor: appPrimary,
      ),
    );
  }
}