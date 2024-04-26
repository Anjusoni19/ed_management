import 'package:ed_management/Colors.dart';
import 'package:ed_management/screens/FeacturesSubItem/Interaction%20Report%20Screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CallingListScreen extends StatefulWidget {
  @override
  _CallingListScreenState createState() => _CallingListScreenState();
}

class _CallingListScreenState extends State<CallingListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        elevation: 1.0,
        title: Text('Calling List', style: GoogleFonts.inter(color: appPrimary, fontSize: 18),),
      ),
      body:  Padding(
        padding: const EdgeInsets.all(10.0),
        child: InkWell(
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => InteractionReportScreen()));
          },
          child: Card(
            elevation: 4.0,
            child: Padding(
              padding: const EdgeInsets.all(5.0),
              child: Container(
                // height: 80,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    // border: Border.all(color: appPrimary.withOpacity(0.1))
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // SizedBox(height: 5,),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Row(
                        children: [
                          Container(
                            height: 40,
                            width: 40,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(60),
                              color: appPrimary
                            ),
                            alignment: Alignment.center,
                            child: Text('A', style: GoogleFonts.inter(fontSize: 18, color: Colors.white),),
                          ),
                          SizedBox(width: 10,),
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
                    Divider(color: Colors.grey.shade400,),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 5),
                      child: Row(
                        children: [
                          Text('Responsible:', style: GoogleFonts.merriweather(fontSize: 11, color: Colors.black, fontWeight: FontWeight.bold),),
                          SizedBox(width: 5,),
                          Text('Anju Soni', style: GoogleFonts.merriweather(fontSize: 11, color: Colors.black, fontWeight: FontWeight.w300),),


                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 5),
                      child: Row(
                        children: [
                          Text('Frequency:', style: GoogleFonts.merriweather(fontSize: 11, color: Colors.black, fontWeight: FontWeight.bold),),
                          SizedBox(width: 5,),
                          Text('01 Mar 2024', style: GoogleFonts.merriweather(fontSize: 11, color: Colors.black, fontWeight: FontWeight.w300),),


                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 5),
                      child: Row(
                        children: [
                          Text('Remark:', style: GoogleFonts.merriweather(fontSize: 11, color: Colors.black, fontWeight: FontWeight.bold),),
                          SizedBox(width: 5,),
                          Text('testing', style: GoogleFonts.merriweather(fontSize: 11, color: Colors.black, fontWeight: FontWeight.w300),),


                        ],
                      ),
                    ),
                    SizedBox(height: 10,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                            // width: MediaQuery.of(context).size.width/4.4,
                            height: 20,
                            decoration: BoxDecoration(
                              color: Colors.green,
                              //   border: Border.all(color: Colors.blue),
                                borderRadius: BorderRadius.circular(2)
                            ),
                            padding: EdgeInsets.symmetric(horizontal: 8,),
                            alignment: Alignment.center,
                            child: Text('Active', style: GoogleFonts.merriweather(color: Colors.white, fontSize: 11),)),
                        SizedBox(width: 5,),
                        Container(
                            // width: MediaQuery.of(context).size.width/4.4,
                            height: 20,
                            decoration: BoxDecoration(
                              color: Colors.blue,
                                // border: Border.all(color: Colors.green),
                                borderRadius: BorderRadius.circular(4)
                            ),
                            padding: EdgeInsets.symmetric(horizontal: 8),
                            alignment: Alignment.center,
                            child: Text('Total Standard: 1', style: GoogleFonts.merriweather(color: Colors.white, fontSize: 11),)),
                        SizedBox(width: 5,),
                        Container(
                            // width: MediaQuery.of(context).size.width/4.4,
                            height: 20,
                            decoration: BoxDecoration(
                              color: Colors.orange,
                                // border: Border.all(color: Colors.red),
                                borderRadius: BorderRadius.circular(4)
                            ),
                            padding: EdgeInsets.symmetric(horizontal: 8,),
                            alignment: Alignment.center,
                            child: Text('Total Student: 49', style: GoogleFonts.merriweather(color: Colors.white, fontSize: 11),)),
                        Spacer(),
                        Container(
                          height: 25,
                          width: 25,
                            decoration: BoxDecoration(
                              border: Border.all(color: appPrimary, width: 1.5),
                              borderRadius: BorderRadius.circular(60)
                            ),
                            alignment: Alignment.center,
                            child: Icon(Icons.arrow_forward_ios_outlined, color: appPrimary, size: 15,)),
                        SizedBox(width: 5,),
                      ],
                    ),
                    SizedBox(height: 10,),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}