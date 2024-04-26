import 'package:ed_management/Colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'InteractionReportViewScreen.dart';

class LeadDashboardViewScreen extends StatefulWidget {
  @override
  _LeadDashboardViewScreenState createState() => _LeadDashboardViewScreenState();
}

class _LeadDashboardViewScreenState extends State<LeadDashboardViewScreen> {
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
                        Text('Admission 2024-25', style: GoogleFonts.merriweather(color: Colors.white, fontSize: 14, fontWeight: FontWeight.w300),),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 10,),
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
                      width: MediaQuery.of(context).size.width/2.1,
                      height: 30,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          color: onSearch == 1 ? appPrimary : Colors.grey.shade300,
                          // border: Border.all(color: Colors.grey.shade300, width: 1.0),
                          borderRadius: BorderRadius.only(topRight: Radius.circular(8), topLeft: Radius.circular(8))
                      ),child: Text('Lead Allotted', style: GoogleFonts.inter(color: onSearch == 1 ? Colors.white : Colors.black, fontSize: 12),),
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
                      width: MediaQuery.of(context).size.width/2.1,
                      height: 30,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          color: onSearch == 2 ? appPrimary : Colors.grey.shade300,
                          // border: Border.all(color: Colors.grey.shade300, width: 1.0),
                          borderRadius: BorderRadius.only(topRight: Radius.circular(8), topLeft: Radius.circular(8))
                      ),child: Text('Lead Pending', style: GoogleFonts.inter(color: onSearch == 2 ? Colors.white : Colors.black, fontSize: 12),),
                    ),
                  ),
                ],
              ),
            ),
            // SizedBox(height: 10,),
            // Padding(
            //   padding: const EdgeInsets.all(10.0),
            //   child: Container(
            //     // height: 80,
            //     width: MediaQuery.of(context).size.width,
            //     decoration: BoxDecoration(
            //         border: Border.all(color: appPrimary.withOpacity(0.1))
            //     ),
            //     child: Column(
            //       children: [
            //         Row(
            //           children: [
            //             Container(
            //               // height: 20,
            //               decoration: BoxDecoration(
            //                   color: Colors.deepOrange.shade700,
            //                   borderRadius: BorderRadius.only(bottomRight: Radius.circular(60))
            //               ),
            //               alignment: Alignment.center,
            //               padding: EdgeInsets.symmetric(horizontal: 28, vertical: 4),
            //               child: Text('Not Allotted : 0', style: GoogleFonts.inter(color: Colors.white),),
            //             ),
            //           ],
            //         ),
            //         SizedBox(height: 5,),
            //         Padding(
            //           padding: const EdgeInsets.only(left: 8.0),
            //           child: Row(
            //             children: [
            //               Column(
            //                 children: [
            //                   Container(
            //                       width: MediaQuery.of(context).size.width/1.12,
            //                       child: Row(
            //                         children: [
            //                           Text('Admission 2024-25', style: GoogleFonts.poppins(fontSize: 16),),
            //                           Spacer(),
            //                           Text('Total Lead: 0', style: GoogleFonts.poppins(fontSize: 13),),
            //                         ],
            //                       )),
            //                 ],
            //               ),
            //             ],
            //           ),
            //         ),
            //         Row(
            //           children: [
            //             SizedBox(width: 8,),
            //             Container(
            //               // width: MediaQuery.of(context).size.width/4.4,
            //               // height: 23,
            //                 decoration: BoxDecoration(
            //                     color: Colors.indigo.shade900,
            //                     // border: Border.all(color: Colors.blue),
            //                     borderRadius: BorderRadius.circular(4)
            //                 ),
            //                 padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
            //                 alignment: Alignment.center,
            //                 child: Text('Manager', style: GoogleFonts.merriweather(color: Colors.white, fontSize: 11),)),
            //           ],
            //         ),
            //         // SizedBox(height: 10,),
            //         Padding(
            //           padding: const EdgeInsets.all(10.0),
            //           child: LinearProgressIndicator(
            //             backgroundColor: appPrimary.withOpacity(0.3),
            //             valueColor: new AlwaysStoppedAnimation<Color>(appPrimary),
            //             value: 0.2,
            //           ),
            //         ),
            //         // SizedBox(height: 10,),
            //         Padding(
            //           padding: const EdgeInsets.all(5.0),
            //           child: Row(
            //             // mainAxisAlignment: MainAxisAlignment.end,
            //             children: [
            //               SizedBox(width: 5,),
            //               Container(
            //                   width: MediaQuery.of(context).size.width/4.4,
            //                   height: 23,
            //                   decoration: BoxDecoration(
            //                       color: Colors.red,
            //                       // border: Border.all(color: Colors.blue),
            //                       borderRadius: BorderRadius.circular(4)
            //                   ),
            //                   // padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
            //                   alignment: Alignment.center,
            //                   child: Text('Closed: 0', style: GoogleFonts.merriweather(color: Colors.white, fontSize: 11),)),
            //               SizedBox(width: 5,),
            //               Container(
            //                   width: MediaQuery.of(context).size.width/4.4,
            //                   height: 23,
            //                   decoration: BoxDecoration(
            //                       color: Colors.green,
            //                       // border: Border.all(color: Colors.green),
            //                       borderRadius: BorderRadius.circular(4)
            //                   ),
            //                   // padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
            //                   alignment: Alignment.center,
            //                   child: Text('Converted: 0', style: GoogleFonts.merriweather(color: Colors.white, fontSize: 11),)),
            //               SizedBox(width: 5,),
            //               Spacer(),
            //               Container(
            //                   width: MediaQuery.of(context).size.width/5,
            //                   height: 23,
            //                   decoration: BoxDecoration(
            //                     // color: Colors.green,
            //                       border: Border.all(color: Colors.blue),
            //                       borderRadius: BorderRadius.circular(4)
            //                   ),
            //                   // padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
            //                   alignment: Alignment.center,
            //                   child: Text('See More', style: GoogleFonts.merriweather(color: Colors.blue, fontSize: 11),)),
            //               SizedBox(width: 5,),
            //             ],
            //           ),
            //         ),
            //         SizedBox(height: 10,),
            //       ],
            //     ),
            //   ),
            // )
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