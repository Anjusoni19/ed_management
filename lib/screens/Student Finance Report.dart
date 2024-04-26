import 'package:ed_management/Colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'Teacher Feactures Screen.dart';

class StudentFinanceScreen extends StatefulWidget {
  @override
  _StudentFinanceScreenState createState() => _StudentFinanceScreenState();
}

class _StudentFinanceScreenState extends State<StudentFinanceScreen> {
  var onSearch = 1;
  // List<String> allStandard = ['RBSE - Hindi', 'First', 'Second', 'Third', 'Fourth', 'Fifth', 'Sixth', 'Seventh', 'Eight', 'Ninth', 'Tenth'];
  // TextEditingController search = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: false,
        title: Text('Student Finance Report', style: TextStyle(color: appPrimary, fontSize: 17),),
        automaticallyImplyLeading: false,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 5.0, right: 5, bottom: 5, top: 5),
              child: Container(
                // elevation: 8.0,
                decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Colors.grey.shade300, width: 1.0),
                    borderRadius: BorderRadius.circular(8.0)
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          InkWell(
                            onTap: () {
                              setState(() {
                                onSearch = 1;
                              });
                            },
                            child: Container(
                              width: MediaQuery.of(context).size.width/3.1,
                              height: 30,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                  color: onSearch == 1 ? appPrimary : Colors.grey.shade300,
                                  // border: Border.all(color: Colors.grey.shade300, width: 1.0),
                                  borderRadius: BorderRadius.only(topRight: Radius.circular(8), topLeft: Radius.circular(8))
                              ),child: Text('Ledger', style: GoogleFonts.inter(color: onSearch == 1 ? Colors.white : Colors.black, fontSize: 12),),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              setState(() {
                                onSearch = 2;
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
                              ),child: Text('Extend', style: GoogleFonts.inter(color: onSearch == 2 ? Colors.white : Colors.black, fontSize: 12),),
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
                              ),child: Text('Remark', style: GoogleFonts.inter(color: onSearch == 3 ? Colors.white : Colors.black, fontSize: 12),),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 5,),
            Expanded(
              child: ListView.builder(
                  itemCount: 10,
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding: const EdgeInsets.only(left: 10.0, right: 10.0, bottom: 5),
                      child: Card(
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(color: Colors.grey.shade300),
                              borderRadius: BorderRadius.circular(4.0)
                          ),
                          // height: 100,
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Row(
                                  children: [
                                   Image.asset('assets/title.png', height: 18,),
                                    SizedBox(width: 10,),
                                    Text('Tuition Fees', style: GoogleFonts.merriweather(fontSize: 15),),
                                    Spacer(),
                                    Image.asset('assets/calendar.png', height: 15,),
                                    SizedBox(width: 7,),
                                    Text('17 May 2023', style: GoogleFonts.inter(fontSize: 12),),
                                  ],
                                ),
                              ),
                              // SizedBox(height: 5,),
                              Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Row(
                                  children: [
                                    Text('₹ 5000', style: GoogleFonts.poppins(fontSize: 16, color: Colors.green),),
                                    Spacer(),
                                    Container(
                                      height: 23,
                                      decoration: BoxDecoration(
                                          color: Colors.green.shade400,
                                          borderRadius: BorderRadius.circular(4)
                                      ),
                                      alignment: Alignment.center,
                                      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                                      child: Text('Cash', style: GoogleFonts.inter(color: Colors.white, fontSize: 10)
                                      ),),
                                    SizedBox(width: 10,),
                                    Container(
                                      height: 23,
                                      decoration: BoxDecoration(
                                          color: Colors.orange.shade400,
                                          borderRadius: BorderRadius.circular(4)
                                      ),
                                      alignment: Alignment.center,
                                      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                                      child: Text('Installment 1', style: GoogleFonts.inter(color: Colors.white, fontSize: 10)
                                      ),),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    );
                  }),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5),
        child: Container(
          height: 90,
          decoration: BoxDecoration(
             borderRadius: BorderRadius.circular(4)
          ),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  children: [
                    Text('₹ 54000', style: GoogleFonts.inter(fontSize: 15, color: Colors.red, fontWeight: FontWeight.bold),),
                    Spacer(),
                    Text('₹ 54000', style: GoogleFonts.inter(fontSize: 15, color: Colors.green, fontWeight: FontWeight.bold),),
                  ],
                ),
              ),
              Container(
                decoration: BoxDecoration(
                    color: appPrimary,
                    borderRadius: BorderRadius.only(bottomRight: Radius.circular(4), bottomLeft: Radius.circular(4))
                ),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    children: [
                      Text('Balance Amount: ', style: GoogleFonts.merriweather(fontSize: 15, color: Colors.white),),
                      SizedBox(width: 10,),
                      // Spacer(),
                      Text('₹ 0', style: GoogleFonts.poppins(fontSize: 15, color: Colors.white),),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 5,),
            ],
          ),
        ),
      ),
    );
  }
}