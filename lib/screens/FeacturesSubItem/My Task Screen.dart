import 'package:ed_management/Colors.dart';
import 'package:ed_management/screens/FeacturesSubItem/Add%20Task%20Screen.dart';
import 'package:ed_management/screens/FeacturesSubItem/Chat%20Screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyTaskScreen extends StatefulWidget {
  @override
  _MyTaskScreenState createState() => _MyTaskScreenState();
}

class _MyTaskScreenState extends State<MyTaskScreen> {
  int selectedVal = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: appPrimary,
        automaticallyImplyLeading: false,
        title: Text('My Tasks', style: GoogleFonts.inter(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        elevation: 0.0,
      ),
      body: Column(
        children: [
          Container(
            // height: 80,
            width: MediaQuery.of(context).size.width,
            color: appPrimary,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Column(
                children: [
                  Row(
                    children: [
                      Container(
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(60)
                        ),
                      ),
                      SizedBox(width: 10,),
                      Column(
                        children: [
                          Container(
                              width: MediaQuery.of(context).size.width/2,
                              child: Text('Anju Soni', style: GoogleFonts.merriweather(color: Colors.white),)),
                          SizedBox(height: 3,),
                          Container(
                              width: MediaQuery.of(context).size.width/2,
                              child: Text('Cambridge School', style: GoogleFonts.inter(color: Colors.white,fontSize: 12),)),
                        ],
                      ),
                      Spacer(),
                      InkWell(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => AddTaskScreen()));
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.white),
                            borderRadius: BorderRadius.circular(4)
                          ),
                           padding: EdgeInsets.symmetric(horizontal: 8, vertical: 5),
                           child: Text('Add Task', style: GoogleFonts.inter(color: Colors.white),)),
                      ),

                    ],
                  ),
                  SizedBox(height: 10,),
                ],
              ),
            ),
          ),
          SizedBox(height: 5,),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              InkWell(
                onTap: () {
                  setState(() {
                    selectedVal = 1;
                  });
                },
                child: Container(
                  width: MediaQuery.of(context).size.width/2,
                  height: 40,
                  decoration: BoxDecoration(
                      color: selectedVal == 1 ? appPrimary : Colors.white,
                      // borderRadius: BorderRadius.only(topLeft: Radius.circular(4), bottomLeft: Radius.circular(4)),
                      border: Border.all(color: selectedVal == 1 ? appPrimary : Colors.grey.shade300)
                  ),
                  alignment: Alignment.center,
                  child: Text('To Do List', style: GoogleFonts.inter(color: selectedVal == 1 ? Colors.white : appPrimary),),
                ),
              ),
              InkWell(
                onTap: () {
                  setState(() {
                    selectedVal = 2;
                  });
                },
                child: Container(
                  width: MediaQuery.of(context).size.width/2,
                  height: 40,
                  decoration: BoxDecoration(
                      color: selectedVal == 2 ? appPrimary : Colors.white,
                      border: Border.all(color: selectedVal == 2 ? appPrimary : Colors.grey.shade300)
                  ),
                  alignment: Alignment.center,
                  child: Text('Management', style: GoogleFonts.inter(color: selectedVal == 2 ? Colors.white : appPrimary),),
                ),
              ),

            ],
          ),
          SizedBox(height: 5,),
          selectedVal == 1
              ? Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
            children: [
                Row(
                  children: [
                    Text('Today Statics', style: GoogleFonts.merriweather(fontSize: 18, fontWeight: FontWeight.w500),),
                    Spacer(),
                    Container(
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.black),
                            borderRadius: BorderRadius.circular(4)
                        ),
                        padding: EdgeInsets.symmetric(horizontal: 30, vertical: 6),
                        child: Text('All Category', style: GoogleFonts.inter(color: Colors.black),)),
                  ],
                ),
                SizedBox(height: 10,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width/4.4,
                        height: 25,
                        decoration: BoxDecoration(
                          color: Colors.blue,
                            // border: Border.all(color: Colors.white),
                            borderRadius: BorderRadius.circular(4)
                        ),
                        // padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                        alignment: Alignment.center,
                        child: Text('Active : 0', style: GoogleFonts.inter(color: Colors.white, fontSize: 11),)),
                    Container(
                        width: MediaQuery.of(context).size.width/4.4,
                        height: 25,
                        decoration: BoxDecoration(
                            color: Colors.green,
                            // border: Border.all(color: Colors.white),
                            borderRadius: BorderRadius.circular(4)
                        ),
                        // padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                        alignment: Alignment.center,
                        child: Text('Complete : 0', style: GoogleFonts.inter(color: Colors.white, fontSize: 11),)),
                    Container(
                        width: MediaQuery.of(context).size.width/4.4,
                        height: 25,
                        decoration: BoxDecoration(
                            color: Colors.red,
                            // border: Border.all(color: Colors.white),
                            borderRadius: BorderRadius.circular(4)
                        ),
                        // padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                        alignment: Alignment.center,
                        child: Text('Incomplete : 0', style: GoogleFonts.inter(color: Colors.white, fontSize: 11),)),
                    Container(
                        width: MediaQuery.of(context).size.width/4.4,
                        height: 25,
                        decoration: BoxDecoration(
                            color: Colors.orange,
                            // border: Border.all(color: Colors.white),
                            borderRadius: BorderRadius.circular(4)
                        ),
                        // padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                        alignment: Alignment.center,
                        child: Text('Upcoming : 0', style: GoogleFonts.inter(color: Colors.white, fontSize: 11),)),
                  ],
                ),
              SizedBox(height: 5,),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  children: [
                    Container(
                        width: MediaQuery.of(context).size.width/4.2,
                        height: 28,
                        decoration: BoxDecoration(
                          // color: Colors.deepPurple.shade300,
                            border: Border.all(color: Colors.deepPurple),
                            borderRadius: BorderRadius.circular(4)
                        ),
                        // padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                        alignment: Alignment.center,
                        child: Text('Active : 1', style: GoogleFonts.inter(color: Colors.deepPurple, fontSize: 14, fontWeight: FontWeight.bold),)),
                  ],
                ),
              ),
              SizedBox(height: 10,),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Container(
                  // height: 80,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      border: Border.all(color: appPrimary.withOpacity(0.1))
                  ),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Container(
                            // height: 20,
                            decoration: BoxDecoration(
                                color: appPrimary,
                                borderRadius: BorderRadius.only(bottomRight: Radius.circular(60))
                            ),
                            alignment: Alignment.center,
                            padding: EdgeInsets.symmetric(horizontal: 28, vertical: 4),
                            child: Text('6 days remaining', style: GoogleFonts.inter(color: Colors.white),),
                          ),
                        ],
                      ),
                      // SizedBox(height: 5,),
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Row(
                          children: [
                            Column(
                              children: [
                                Container(
                                    width: MediaQuery.of(context).size.width/1.6,
                                    child: Text('New Test', style: GoogleFonts.merriweather(fontSize: 13),)),
                                SizedBox(height: 5,),
                                Container(
                                    width: MediaQuery.of(context).size.width/1.6,
                                    child: Text('testing', style: GoogleFonts.merriweather(fontSize: 11, color: Colors.grey),)),
                              ],
                            ),
                            Spacer(),
                            PopupMenuButton<int>(
                                itemBuilder: (BuildContext context) => <PopupMenuItem<int>>[
                                  new PopupMenuItem<int>(
                                      value: 3, child: new Text('Edit')),
                                ],
                                onSelected: (int value) {
                                })
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Row(
                          children: [
                            Text('Date: 2024-02-17 To 2024-03-06', style: GoogleFonts.merriweather(fontSize: 11, color: Colors.grey),),
                            Spacer(),
                            Text('Priority: medium', style: GoogleFonts.merriweather(fontSize: 11, color: Colors.grey),),


                          ],
                        ),
                      ),
                      SizedBox(height: 10,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Container(
                              width: MediaQuery.of(context).size.width/4.4,
                              height: 23,
                              decoration: BoxDecoration(
                                  // color: Colors.green,
                                  border: Border.all(color: Colors.blue),
                                  borderRadius: BorderRadius.circular(2)
                              ),
                              // padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                              alignment: Alignment.center,
                              child: Text('Add Subtask', style: GoogleFonts.merriweather(color: Colors.blue, fontSize: 11),)),
                          SizedBox(width: 5,),
                          Container(
                              width: MediaQuery.of(context).size.width/4.4,
                              height: 23,
                              decoration: BoxDecoration(
                                // color: Colors.green,
                                  border: Border.all(color: Colors.green),
                                  borderRadius: BorderRadius.circular(2)
                              ),
                              // padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                              alignment: Alignment.center,
                              child: Text('Complete Task', style: GoogleFonts.merriweather(color: Colors.green, fontSize: 11),)),
                          SizedBox(width: 5,),
                          Container(
                              width: MediaQuery.of(context).size.width/4.4,
                              height: 23,
                              decoration: BoxDecoration(
                                // color: Colors.green,
                                  border: Border.all(color: Colors.red),
                                  borderRadius: BorderRadius.circular(2)
                              ),
                              // padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                              alignment: Alignment.center,
                              child: Text('Incomplete Task', style: GoogleFonts.merriweather(color: Colors.red, fontSize: 11),)),
                          SizedBox(width: 5,),
                        ],
                      ),
                      SizedBox(height: 10,),
                    ],
                  ),
                ),
              )
            ],
          ),
              )
              : Column(
            children: [
              SizedBox(height: 5,),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  children: [
                    Container(
                        width: MediaQuery.of(context).size.width/4.2,
                        height: 28,
                        decoration: BoxDecoration(
                            // color: Colors.deepPurple.shade300,
                            border: Border.all(color: Colors.deepPurple),
                            borderRadius: BorderRadius.circular(4)
                        ),
                        // padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                        alignment: Alignment.center,
                        child: Text('Active : 1', style: GoogleFonts.inter(color: Colors.deepPurple, fontSize: 14, fontWeight: FontWeight.bold),)),
                  ],
                ),
              ),
              SizedBox(height: 10,),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Container(
                  // height: 80,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    border: Border.all(color: appPrimary.withOpacity(0.1))
                  ),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Container(
                            // height: 20,
                            decoration: BoxDecoration(
                              color: appPrimary,
                              borderRadius: BorderRadius.only(bottomRight: Radius.circular(60))
                            ),
                            alignment: Alignment.center,
                            padding: EdgeInsets.symmetric(horizontal: 28, vertical: 4),
                            child: Text('2024-02-17', style: GoogleFonts.inter(color: Colors.white),),
                          ),
                        ],
                      ),
                      // SizedBox(height: 5,),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Row(
                          children: [
                            Column(
                              children: [
                                Container(
                                    width: MediaQuery.of(context).size.width/1.6,
                                    child: Text('Mobile Design', style: GoogleFonts.merriweather(fontSize: 13),)),
                                SizedBox(height: 5,),
                                Container(
                                    width: MediaQuery.of(context).size.width/1.6,
                                    child: Text('Please Design Given Task', style: GoogleFonts.merriweather(fontSize: 11, color: Colors.grey),)),
                              ],
                            ),
                            Spacer(),
                            PopupMenuButton<int>(
                                itemBuilder: (BuildContext context) => <PopupMenuItem<int>>[
                                  new PopupMenuItem<int>(
                                      value: 3, child: new Text('View')),
                                ],
                                onSelected: (int value) {
                                })
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Row(
                          children: [
                            Text('Created on 2024-02-17', style: GoogleFonts.merriweather(fontSize: 11, color: Colors.grey),),
                            Spacer(),
                            InkWell(
                              onTap: () {
                                Navigator.push(context, MaterialPageRoute(builder: (context) => ChatPage()));
                              },
                              child: Container(
                                  width: MediaQuery.of(context).size.width/4.4,
                                  height: 23,
                                  decoration: BoxDecoration(
                                      color: Colors.green,
                                      // border: Border.all(color: Colors.white),
                                      borderRadius: BorderRadius.circular(4)
                                  ),
                                  // padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                                  alignment: Alignment.center,
                                  child: Text('Responsible', style: GoogleFonts.merriweather(color: Colors.white, fontSize: 11),)),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 10,)
                    ],
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}