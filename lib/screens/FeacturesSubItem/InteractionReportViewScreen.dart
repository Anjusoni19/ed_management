import 'package:ed_management/Colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class InteractionReportViewScreen extends StatefulWidget {
  @override
  _InteractionReportViewScreenState createState() => _InteractionReportViewScreenState();
}

class _InteractionReportViewScreenState extends State<InteractionReportViewScreen> {
  var _intervalValue = 'Select Staff';

  bool onSearch = true;

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
                        Icon(Icons.arrow_back, color: Colors.white, size: 18,),
                        // SizedBox(width: 10,),
                        // Text('Interaction Report', style: GoogleFonts.merriweather(color: Colors.white, fontSize: 14, fontWeight: FontWeight.w300),),
                      ],
                    ),
                  ),
                ),
                Spacer(),
                Container(
                  width: MediaQuery.of(context).size.width/2.8,
                  height: 30,
                  padding: EdgeInsets.symmetric(horizontal: 8),
                  decoration: BoxDecoration(
                      border: Border.all(color: appPrimary),
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
                      Text('Total Student', style: GoogleFonts.merriweather(color: appPrimary, fontSize: 12, fontWeight: FontWeight.w500),),

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
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
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
                      width: MediaQuery.of(context).size.width/2.1,
                      height: 30,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          color: onSearch ? appPrimary : Colors.grey.shade300,
                          // border: Border.all(color: Colors.grey.shade300, width: 1.0),
                          borderRadius: BorderRadius.only(topRight: Radius.circular(8), topLeft: Radius.circular(8))
                      ),child: Text('Student Alloted', style: GoogleFonts.inter(color: onSearch ? Colors.white : Colors.black, fontSize: 12),),
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
                      width: MediaQuery.of(context).size.width/2.1,
                      height: 30,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          color: !onSearch ? appPrimary : Colors.grey.shade300,
                          // border: Border.all(color: Colors.grey.shade300, width: 1.0),
                          borderRadius: BorderRadius.only(topRight: Radius.circular(8), topLeft: Radius.circular(8))
                      ),child: Text('Student Pending', style: GoogleFonts.inter(color: !onSearch ? Colors.white : Colors.black, fontSize: 12),),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 5,),
            Container(
              height: 45,
              color: Colors.grey.shade300,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: Row(
                  children: [
                    Text('Total Rows: 49', style: GoogleFonts.poppins(color: Colors.black, fontSize: 14),),
                    Spacer(),
                    Icon(Icons.check_box_outline_blank_rounded, color: appPrimary,)
                  ],
                ),
              ),
            ),
            SizedBox(height: 10,),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey.shade300),
                    borderRadius: BorderRadius.circular(4)
                ),
                child: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Column(
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width/1.12,
                        child: Row(
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                    decoration: BoxDecoration(
                                      border: Border.all(color: Colors.grey),
                                      borderRadius: BorderRadius.circular(60)
                                    ),
                                    padding: EdgeInsets.all(5),
                                    alignment: Alignment.center,
                                    child: Image.asset('assets/images.png', height: 45,)),
                                SizedBox(height: 20,)
                                // Spacer()
                              ],
                            ),
                            SizedBox(width: 8,),
                            Column(
                              children: [
                                Container(
                                    width: MediaQuery.of(context).size.width/1.4,
                                    child: Row(
                                      children: [
                                        Text('Name : Akhtar Raza', style: GoogleFonts.merriweather(color: appPrimary, fontSize: 13),),
                                        Spacer(),
                                        Container(
                                            decoration: BoxDecoration(
                                                border: Border.all(color: appPrimary),
                                                borderRadius: BorderRadius.circular(60)
                                            ),
                                            padding: EdgeInsets.all(5),
                                            alignment: Alignment.center,
                                            child: Icon(Icons.call, color: appPrimary, size: 14,)),
                                      ],
                                    )),
                                // SizedBox(height: 5,),
                                Container(
                                    width: MediaQuery.of(context).size.width/1.4,
                                    child: Text('F\' Name : Vakil Mohammad', style: GoogleFonts.merriweather(color: appPrimary, fontSize: 13),)),
                                SizedBox(height: 5,),
                                Container(
                                    width: MediaQuery.of(context).size.width/1.4,
                                    child: Text('Standard : Fourth', style: GoogleFonts.merriweather(color: appPrimary, fontSize: 13),)),
                                SizedBox(height: 5,),
                                Container(
                                    width: MediaQuery.of(context).size.width/1.4,
                                    child: Row(
                                      children: [
                                        Text('Stream : English', style: GoogleFonts.merriweather(color: appPrimary, fontSize: 13),),
                                        Spacer(),
                                        Icon(Icons.check_box_outline_blank_rounded, color: Colors.black, size: 23,),
                                        SizedBox(width: 3,)
                                      ],
                                    )),
                                SizedBox(height: 5,),
                              ],
                            ),
                          ],
                        ),
                      ),
                      // SizedBox(height: 5,),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: LinearProgressIndicator(
                          backgroundColor: appPrimary.withOpacity(0.3),
                          valueColor: new AlwaysStoppedAnimation<Color>(appPrimary),
                          value: 0.4,
                        ),
                      ),
                      // SizedBox(height: 5,),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5),
                        child: Row(
                          children: [
                            Container(
                              height: 25,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(primary: Colors.green),
                                  onPressed: () {},
                                  child: Text('David manwani', style: GoogleFonts.poppins(fontSize: 11),)),
                            ),
                          ],
                        ),
                      )
                    ],
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