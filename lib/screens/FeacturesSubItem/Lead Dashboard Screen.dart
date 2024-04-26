import 'package:ed_management/Colors.dart';
import 'package:ed_management/screens/FeacturesSubItem/Lead%20View%20Screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'InteractionReportViewScreen.dart';

class LeadDashboardScreen extends StatefulWidget {
  @override
  _LeadDashboardScreenState createState() => _LeadDashboardScreenState();
}

class _LeadDashboardScreenState extends State<LeadDashboardScreen> {
  var _intervalValue = 'Select Staff';

  var onSearch = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:  SafeArea(
        child: Column(
          children: [
            SizedBox(height: 10,),
            Row(
              children: [
                Container(
                  decoration: BoxDecoration(
                      color: appPrimary,
                      borderRadius: BorderRadius.only(topRight: Radius.circular(4), bottomRight: Radius.circular(4))
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                    child:
                    Row(
                      children: [
                        Icon(Icons.arrow_back, color: Colors.white,),
                        SizedBox(width: 10,),
                        Text('Lead Dashboard', style: GoogleFonts.merriweather(color: Colors.white, fontSize: 14, fontWeight: FontWeight.w300),),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 10,),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width/2.2,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.grey.shade300)
                    ),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Text('Total Lead', style: GoogleFonts.inter(color: Colors.indigo.shade900, fontSize: 15, fontWeight: FontWeight.w500),),
                                ],
                              ),
                              SizedBox(height: 5,),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Icon(Icons.bar_chart, color: Colors.indigo.shade900, size: 25,),
                                  Text('0', style: GoogleFonts.inter(color: Colors.indigo.shade900, fontSize: 20, fontWeight: FontWeight.w500),),
                                ],
                              ),

                            ],
                          ),
                        ),
                        Container(height: 25,
                          decoration: BoxDecoration(
                            color: Colors.indigo.shade900,
                            borderRadius: BorderRadius.only(bottomRight: Radius.circular(8), bottomLeft: Radius.circular(8))
                          ),
                          alignment: Alignment.center,
                          child: Text('Today Total: 0', style: GoogleFonts.poppins(color: Colors.white, fontSize: 12),),
                        )
                      ],
                    ),
                  ),
                  Spacer(),
                  Container(
                    width: MediaQuery.of(context).size.width/2.2,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: Colors.grey.shade300)
                    ),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Text('Closed Lead', style: GoogleFonts.inter(color: Colors.green.shade700, fontSize: 15, fontWeight: FontWeight.w500),),
                                ],
                              ),
                              SizedBox(height: 5,),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Icon(Icons.star, color: Colors.green.shade700, size: 25,),
                                  Text('0', style: GoogleFonts.inter(color: Colors.green.shade700, fontSize: 20, fontWeight: FontWeight.w500),),
                                ],
                              ),

                            ],
                          ),
                        ),
                        Container(height: 25,
                          decoration: BoxDecoration(
                              color: Colors.green.shade700,
                              borderRadius: BorderRadius.only(bottomRight: Radius.circular(8), bottomLeft: Radius.circular(8))
                          ),
                          alignment: Alignment.center,
                          child: Text('Today Closed: 0', style: GoogleFonts.poppins(color: Colors.white, fontSize: 12),),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width/2.2,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: Colors.grey.shade300)
                    ),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Text('Not Engagement', style: GoogleFonts.inter(color: Colors.red.shade900, fontSize: 15, fontWeight: FontWeight.w500),),
                                ],
                              ),
                              SizedBox(height: 5,),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Image.network('https://upload.wikimedia.org/wikipedia/commons/thumb/f/f6/OOjs_UI_icon_alert-destructive.svg/150px-OOjs_UI_icon_alert-destructive.svg.png', color: Colors.red.shade900, height: 25,),
                                  Text('0', style: GoogleFonts.inter(color: Colors.red.shade900, fontSize: 20, fontWeight: FontWeight.w500),),
                                ],
                              ),

                            ],
                          ),
                        ),
                        Container(height: 25,
                          decoration: BoxDecoration(
                              color: Colors.red.shade900,
                              borderRadius: BorderRadius.only(bottomRight: Radius.circular(8), bottomLeft: Radius.circular(8))
                          ),
                          alignment: Alignment.center,
                          child: Text('Today Total: 0', style: GoogleFonts.poppins(color: Colors.white, fontSize: 12),),
                        )
                      ],
                    ),
                  ),
                  Spacer(),
                  Container(
                    width: MediaQuery.of(context).size.width/2.2,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: Colors.grey.shade300)
                    ),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Text('Upcoming Appointment', style: GoogleFonts.inter(color: Colors.orange.shade700, fontSize: 15, fontWeight: FontWeight.w500),),
                                ],
                              ),
                              SizedBox(height: 5,),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Icon(Icons.watch_later_outlined, color: Colors.orange.shade700, size: 25,),
                                  Text('0', style: GoogleFonts.inter(color: Colors.orange.shade700, fontSize: 20, fontWeight: FontWeight.w500),),
                                ],
                              ),

                            ],
                          ),
                        ),
                        Container(height: 25,
                          decoration: BoxDecoration(
                              color: Colors.orange.shade700,
                              borderRadius: BorderRadius.only(bottomRight: Radius.circular(8), bottomLeft: Radius.circular(8))
                          ),
                          alignment: Alignment.center,
                          child: Text('Today Closed: 0', style: GoogleFonts.poppins(color: Colors.white, fontSize: 12),),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            // SizedBox(height: 5,),
            Container(
              height: 45,
              color: Colors.grey.shade200,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: Row(
                  children: [
                    Text('Campaign', style: GoogleFonts.poppins(color: Colors.black, fontSize: 16),),
                    // Spacer(),
                    SizedBox(width: 5,),
                    Container(
                      height: 20,
                      width: 20,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(40),
                          color: appPrimary
                        ),
                        alignment: Alignment.center,
                        child: Text('3', style: GoogleFonts.poppins(color: Colors.white, fontSize: 12),)),
                    // Icon(Icons.check_box_outline_blank_rounded, color: appPrimary,)
                  ],
                ),
              ),
            ),
            SizedBox(height: 5,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: () {
                      setState(() {
                        onSearch = 1;
                        // search.clear();
                      });
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width/3.2,
                      height: 30,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          color: onSearch == 1 ? appPrimary : Colors.grey.shade300,
                          // border: Border.all(color: Colors.grey.shade300, width: 1.0),
                          borderRadius: BorderRadius.only(topRight: Radius.circular(8), topLeft: Radius.circular(8))
                      ),child: Text('Manager', style: GoogleFonts.inter(color: onSearch == 1 ? Colors.white : Colors.black, fontSize: 12),),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      setState(() {
                        onSearch = 2;
                        // search.clear();
                      });
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width/3.2,
                      height: 30,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          color: onSearch == 2 ? appPrimary : Colors.grey.shade300,
                          // border: Border.all(color: Colors.grey.shade300, width: 1.0),
                          borderRadius: BorderRadius.only(topRight: Radius.circular(8), topLeft: Radius.circular(8))
                      ),child: Text('Counselor', style: GoogleFonts.inter(color: onSearch == 2 ? Colors.white : Colors.black, fontSize: 12),),
                    ),
                  ),
                  // SizedBox(width: 5,),
                  InkWell(
                    onTap: () {
                      setState(() {
                        onSearch = 3;
                        // search.clear();
                      });
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width/3.2,
                      height: 30,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          color: onSearch == 3 ? appPrimary : Colors.grey.shade300,
                          // border: Border.all(color: Colors.grey.shade300, width: 1.0),
                          borderRadius: BorderRadius.only(topRight: Radius.circular(8), topLeft: Radius.circular(8))
                      ),child: Text('Marketing', style: GoogleFonts.inter(color: onSearch == 3 ? Colors.white : Colors.black, fontSize: 12),),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 10,),
            InkWell(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => LeadDashboardViewScreen()));
              },
              child: Padding(
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
                                color: Colors.deepOrange.shade700,
                                borderRadius: BorderRadius.only(bottomRight: Radius.circular(60))
                            ),
                            alignment: Alignment.center,
                            padding: EdgeInsets.symmetric(horizontal: 28, vertical: 4),
                            child: Text('Not Allotted : 0', style: GoogleFonts.inter(color: Colors.white),),
                          ),
                        ],
                      ),
                      SizedBox(height: 5,),
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Row(
                          children: [
                            Column(
                              children: [
                                Container(
                                    width: MediaQuery.of(context).size.width/1.12,
                                    child: Row(
                                      children: [
                                        Text('Admission 2024-25', style: GoogleFonts.poppins(fontSize: 16),),
                                        Spacer(),
                                        Text('Total Lead: 0', style: GoogleFonts.poppins(fontSize: 13),),
                                      ],
                                    )),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Row(
                        children: [
                          SizedBox(width: 8,),
                          Container(
                              // width: MediaQuery.of(context).size.width/4.4,
                              // height: 23,
                              decoration: BoxDecoration(
                                  color: Colors.indigo.shade900,
                                  // border: Border.all(color: Colors.blue),
                                  borderRadius: BorderRadius.circular(4)
                              ),
                              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                              alignment: Alignment.center,
                              child: Text('Manager', style: GoogleFonts.merriweather(color: Colors.white, fontSize: 11),)),
                        ],
                      ),
                      // SizedBox(height: 10,),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: LinearProgressIndicator(
                          backgroundColor: appPrimary.withOpacity(0.3),
                          valueColor: new AlwaysStoppedAnimation<Color>(appPrimary),
                          value: 0.2,
                        ),
                      ),
                      // SizedBox(height: 10,),
                      Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Row(
                          // mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            SizedBox(width: 5,),
                            Container(
                                width: MediaQuery.of(context).size.width/4.4,
                                height: 23,
                                decoration: BoxDecoration(
                                  color: Colors.red,
                                    // border: Border.all(color: Colors.blue),
                                    borderRadius: BorderRadius.circular(4)
                                ),
                                // padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                                alignment: Alignment.center,
                                child: Text('Closed: 0', style: GoogleFonts.merriweather(color: Colors.white, fontSize: 11),)),
                            SizedBox(width: 5,),
                            Container(
                                width: MediaQuery.of(context).size.width/4.4,
                                height: 23,
                                decoration: BoxDecoration(
                                  color: Colors.green,
                                    // border: Border.all(color: Colors.green),
                                    borderRadius: BorderRadius.circular(4)
                                ),
                                // padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                                alignment: Alignment.center,
                                child: Text('Converted: 0', style: GoogleFonts.merriweather(color: Colors.white, fontSize: 11),)),
                            SizedBox(width: 5,),
                            Spacer(),
                            Container(
                                width: MediaQuery.of(context).size.width/5,
                                height: 23,
                                decoration: BoxDecoration(
                                  // color: Colors.green,
                                    border: Border.all(color: Colors.blue),
                                    borderRadius: BorderRadius.circular(4)
                                ),
                                // padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                                alignment: Alignment.center,
                                child: Text('See More', style: GoogleFonts.merriweather(color: Colors.blue, fontSize: 11),)),
                            SizedBox(width: 5,),
                          ],
                        ),
                      ),
                      SizedBox(height: 10,),
                    ],
                  ),
                ),
              ),
            )
            // InkWell(
            //   onTap: () {
            //     // Navigator.push(context, MaterialPageRoute(builder: (context) => InteractionReportViewScreen()));
            //   },
            //   child: Padding(
            //     padding: const EdgeInsets.all(10.0),
            //     child: Container(
            //       decoration: BoxDecoration(
            //           border: Border.all(color: Colors.grey.shade300),
            //           borderRadius: BorderRadius.circular(4)
            //       ),
            //       child: Padding(
            //         padding: const EdgeInsets.all(10.0),
            //         child: Row(
            //           children: [
            //             Container(
            //               width: MediaQuery.of(context).size.width/1.3,
            //               child: Column(
            //                 children: [
            //                   Row(
            //                     children: [
            //                       Image.asset('assets/medal.png', height: 16,),
            //                       SizedBox(width: 5,),
            //                       Text('Name : Fourth', style: GoogleFonts.merriweather(color: appPrimary, fontSize: 13),)
            //                     ],
            //                   ),
            //                   SizedBox(height: 5,),
            //                   Row(
            //                     children: [
            //                       Image.asset('assets/images.png', height: 11,),
            //                       SizedBox(width: 5,),
            //                       Text('Total Student: 49', style: GoogleFonts.merriweather(color: Colors.black, fontSize: 12),),
            //                       SizedBox(width: 15,),
            //                       Image.asset('assets/images.png', height: 11,),
            //                       SizedBox(width: 5,),
            //                       Text('Total Interaction: 0', style: GoogleFonts.merriweather(color: Colors.black, fontSize: 12),)
            //                     ],
            //                   )
            //                 ],
            //               ),
            //             ),
            //             Spacer(),
            //             Icon(Icons.check_box_outline_blank_sharp)
            //           ],
            //         ),
            //       ),
            //     ),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}