import 'package:ed_management/Colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'InteractionReportViewScreen.dart';

class InteractionReportScreen extends StatefulWidget {
  @override
  _InteractionReportScreenState createState() => _InteractionReportScreenState();
}

class _InteractionReportScreenState extends State<InteractionReportScreen> {
  var _intervalValue = 'Select Staff';

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
                        Text('Interaction Report', style: GoogleFonts.merriweather(color: Colors.white, fontSize: 14, fontWeight: FontWeight.w300),),
                      ],
                    ),
                  ),
                ),
                Spacer(),
                InkWell(
                  onTap: () {

                  },
                  child: Container(
                    decoration: BoxDecoration(
                      // color: appPrimary,
                      // border: Border.all(color: Colors.grey, width: 0.5),
                      // borderRadius: BorderRadius.only(topRight: Radius.circular(0), bottomRight: Radius.circular(4))
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                      child:
                      Row(
                        children: [
                          Text('Select All', style: GoogleFonts.merriweather(color: appPrimary, fontSize: 15, fontWeight: FontWeight.w500),),
                          // Image.asset('assets/heart.png', height: 17,),
                          SizedBox(width: 10,),
                          Icon(Icons.check_box_outline_blank_sharp, color: appPrimary, size: 20,),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 10,),
              ],
            ),
            SizedBox(height: 10,),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      Text('0', style: GoogleFonts.poppins(color: appPrimary, fontSize: 15, fontWeight: FontWeight.w500),),
                      SizedBox(height: 5,),
                      Text('Total Interaction', style: GoogleFonts.merriweather(color: appPrimary, fontSize: 12, fontWeight: FontWeight.w500),),

                    ],
                  ),
                  Column(
                    children: [
                      Text('0', style: GoogleFonts.poppins(color: appPrimary, fontSize: 15, fontWeight: FontWeight.w500),),
                      SizedBox(height: 5,),
                      Text('Complete', style: GoogleFonts.merriweather(color: appPrimary, fontSize: 12, fontWeight: FontWeight.w500),),

                    ],
                  ),
                  Column(
                    children: [
                      Text('0', style: GoogleFonts.poppins(color: appPrimary, fontSize: 15, fontWeight: FontWeight.w500),),
                      SizedBox(height: 5,),
                      Text('Not Answered', style: GoogleFonts.merriweather(color: appPrimary, fontSize: 12, fontWeight: FontWeight.w500),),

                    ],
                  ),
                  Column(
                    children: [
                      Text('0', style: GoogleFonts.poppins(color: appPrimary, fontSize: 15, fontWeight: FontWeight.w500),),
                      SizedBox(height: 5,),
                      Text('Untouched', style: GoogleFonts.merriweather(color: appPrimary, fontSize: 12, fontWeight: FontWeight.w500),),

                    ],
                  )
                ],
              ),
            ),
            SizedBox(height: 10,),
            InkWell(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => InteractionReportViewScreen()));
              },
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey.shade300),
                    borderRadius: BorderRadius.circular(4)
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width/1.3,
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Image.asset('assets/medal.png', height: 16,),
                                  SizedBox(width: 5,),
                                  Text('Name : Fourth', style: GoogleFonts.merriweather(color: appPrimary, fontSize: 13),)
                                ],
                              ),
                              SizedBox(height: 5,),
                              Row(
                                children: [
                                  Image.asset('assets/images.png', height: 11,),
                                  SizedBox(width: 5,),
                                  Text('Total Student: 49', style: GoogleFonts.merriweather(color: Colors.black, fontSize: 12),),
                                  SizedBox(width: 15,),
                                  Image.asset('assets/images.png', height: 11,),
                                  SizedBox(width: 5,),
                                  Text('Total Interaction: 0', style: GoogleFonts.merriweather(color: Colors.black, fontSize: 12),)
                                ],
                              )
                            ],
                          ),
                        ),
                        Spacer(),
                        Icon(Icons.check_box_outline_blank_sharp)
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Spacer(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Container(
                height: 50,
                child: Row(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width/1.7,
                      height: 35,
                      padding: EdgeInsets.symmetric(horizontal: 5),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black),
                        borderRadius: BorderRadius.circular(4)
                      ),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          hint: const Text('Select Staff'),
                          value: _intervalValue,
                          // isExpanded: true,
                          items: ['Select Staff', 'David Manwani', 'Hitesh Joshi'].map(
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
                    Spacer(),
                    Container(
                      width: MediaQuery.of(context).size.width/3.2,
                      height: 33,
                      // padding: EdgeInsets.symmetric(horizontal: 10),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(primary: Colors.green),
                          onPressed: (){},
                          child: Text('Student Allot')),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}