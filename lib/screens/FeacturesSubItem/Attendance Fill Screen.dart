import 'package:ed_management/Colors.dart';
import 'package:ed_management/screens/FeacturesSubItem/AddStudentScreen.dart';
import 'package:ed_management/screens/FeacturesSubItem/Attendance%20Screen.dart';
import 'package:ed_management/services/ApisProvider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:group_button/group_button.dart';

class AttendanceFillScreen extends StatefulWidget {
  AttendanceFillScreen({super.key, required this.data, required this.date});

  final String data, date;
  @override
  _AttendanceFillScreenState createState() => _AttendanceFillScreenState();
}

class _AttendanceFillScreenState extends State<AttendanceFillScreen> {
  int SelectValue = 0;

  bool isSelect = true;

  List dataList = [];

  bool isLoading = true;

  String _intervalValue = 'Select Standard';

   List newDataList = [];
   List valueList = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchData();
  }

  fetchData() async{
    print(widget.data);
    print(widget.date);
    var data = await ApiService().attendanceFillData(widget.data, widget.date);
    if(data['status'] == true) {
      dataList = data['data'];
      dataList.forEach((element) {
        print(element['status']);
        valueList.add(element['status']);
      });
    }
    print('reportList');
    print(valueList);
    setState(() {
      isLoading = false;
    });
  }

  punchData() async{
    setState(() {
      isLoading = true;
    });
    print(widget.date);
    var data = await ApiService().attendanceSubmitData(newDataList, widget.date);
    if(data['status'] == true) {
      Navigator.pop(context);
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => AttendanceReportScreen()));
      // setState(() {
      //   isLoading = true;
        // dataList.clear();
      // });
      // Navigator.pop(context);
    }
    print('reportList');
    print(dataList.length);
    setState(() {
      isLoading = false;
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          automaticallyImplyLeading: false,
          title: Text('Attendance', style: GoogleFonts.inter(color: appPrimary, fontSize: 18),),
          // actions: [
          //   InkWell(
          //     onTap: () {
          //       showDialog(
          //           context: context,
          //           builder: (context) {
          //             return StatefulBuilder(
          //                 builder: (context, newSetState) {
          //                   return AlertDialog(
          //                     backgroundColor: Colors.white,
          //                     insetPadding: EdgeInsets.only(top: 0,left: 0, right: 0, bottom: 70),
          //                     shape: RoundedRectangleBorder(
          //                         borderRadius: BorderRadius.circular(8)
          //                     ),
          //                     contentPadding: EdgeInsets.zero,
          //                     content: SizedBox(
          //                       width: MediaQuery.of(context).size.width/1.1,
          //                       height: MediaQuery.of(context).size.height/1.2,
          //                       child: Column(
          //                         // crossAxisAlignment: CrossAxisAlignment.end,
          //                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //                         children: [
          //                           Container(
          //                             width: MediaQuery.of(context).size.width,
          //                             height: 45,
          //                             decoration: BoxDecoration(
          //                                 color: Colors.white,
          //                                 borderRadius: BorderRadius.only(topRight: Radius.circular(8), topLeft: Radius.circular(8))
          //                             ),
          //                             alignment: Alignment.centerLeft,
          //                             child: Row(
          //                               mainAxisAlignment: MainAxisAlignment.center,
          //                               children: [
          //                                 // Spacer(),
          //                                 SizedBox(width: 20,),
          //                                 Text('Filter Attendance', style: GoogleFonts.inter(fontSize: 16,color: appPrimary, fontWeight: FontWeight.bold),),
          //                                 Spacer(),
          //                                 InkWell(
          //                                     onTap: () {
          //                                       Navigator.pop(context);
          //                                     },
          //                                     child: Icon(Icons.close, color: Colors.black,)),
          //                                 SizedBox(width: 20,),
          //                               ],
          //                             ),
          //                           ),
          //                           Divider(color: Colors.grey,),
          //                           // Padding(
          //                           //   padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
          //                           //   child: Row(
          //                           //     children: [
          //                           //       Text('Select Document *', style: TextStyle(color: appPrimary, fontSize: 17),),
          //                           //     ],
          //                           //   ),
          //                           // ),
          //                           Padding(
          //                             padding: const EdgeInsets.symmetric(horizontal: 20.0),
          //                             child: Container(
          //                               height: 40,
          //                               width: MediaQuery.of(context).size.width,
          //                               decoration: BoxDecoration(
          //                                   border: Border.all(color: Colors.grey),
          //                                   borderRadius: BorderRadius.circular(4)
          //                               ),
          //                               padding: EdgeInsets.symmetric(horizontal: 10),
          //                               child: DropdownButtonHideUnderline(
          //                                 child: DropdownButton<String>(
          //                                   hint: const Text('Select Standard'),
          //                                   // value: _intervalValue,
          //                                   // isExpanded: true,
          //                                   items: ['Select Standard', 'Sign', 'Aadhar Card'].map(
          //                                         (String? value) {
          //                                       return DropdownMenuItem<String>(
          //                                         value: value,
          //                                         child: Text(value.toString()),
          //                                       );
          //                                     },
          //                                   ).toList(),
          //                                   onChanged: (value) {
          //                                     setState(() {
          //                                       _intervalValue = value!;
          //                                     });
          //                                   },
          //                                 ),
          //                               ),
          //                             ),
          //                           ),
          //                           SizedBox(height: 10,),
          //                           Padding(
          //                             padding: const EdgeInsets.symmetric(horizontal: 20.0),
          //                             child: Container(
          //                               height: 40,
          //                               // decoration:const  BoxDecoration(
          //                               //     border: Border(bottom: BorderSide(color: Colors.white))
          //                               // ),
          //                               child:TextFormField(
          //                                 cursorColor: appPrimary,
          //                                 style: const TextStyle(color: appPrimary, fontSize: 14),
          //                                 decoration:const  InputDecoration(
          //                                     labelText: 'Date',
          //                                     // hintText: 'Password',
          //                                     fillColor: Colors.white,
          //                                     border: OutlineInputBorder(),
          //                                     focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: appPrimary, width: 1.5))
          //                                 ),
          //                               ),
          //                             ),
          //                           ),
          //                           SizedBox(height: 10,),
          //                           Spacer(),
          //                           Padding(
          //                             padding: const EdgeInsets.all(10.0),
          //                             child: Row(
          //                               mainAxisAlignment: MainAxisAlignment.center,
          //                               children: [
          //                                 Container(
          //                                   width: MediaQuery.of(context).size.width/1.2,
          //                                   height: 35,
          //                                   child: OutlinedButton(
          //                                       style: OutlinedButton.styleFrom(primary: appPrimary),
          //                                       onPressed: (){
          //
          //                                       },
          //                                       child: Text('Submit')),
          //                                 ) ,
          //                               ],
          //                             ),
          //                           )
          //                         ],
          //                       ),
          //                     ),
          //                   );
          //                 }
          //             );
          //           });
          //     },
          //     child: Padding(
          //       padding: const EdgeInsets.symmetric(vertical: 9.0),
          //       child: Card(
          //           elevation: 4.0,
          //           // width: 35,
          //           // height: 35,
          //           shape: RoundedRectangleBorder(
          //               borderRadius: BorderRadius.circular(60),
          //               side: BorderSide(color: appPrimary.withOpacity(0.4))
          //           ),
          //           // alignment: Alignment.center,
          //           child: Container(
          //               width: 30,
          //               height: 30,
          //               child: Icon(Icons.filter_list_outlined, size: 18, color: appPrimary,))),
          //     ),
          //   ),
          //   SizedBox(width: 10,),
          // ],
        ),
        body: isLoading
            ? Center(child: CircularProgressIndicator(color: appPrimary,),)
            : dataList.isEmpty
      ? Container()
      : Column(
          children: [
            SizedBox(height: 10,),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                children: [
                  Image.asset('assets/title.png', height: 22,),
                  SizedBox(width: 10,),
                  Container(
                      width: MediaQuery.of(context).size.width/1.3,
                      child: Text('${widget.data} (${dataList.length})', style: GoogleFonts.merriweather(fontSize: 12, fontWeight: FontWeight.bold),)),
                ],
              ),
            ),
            // SizedBox(height: 10,),
            dataList.isEmpty
                ? Container()
                : Expanded(
              child: ListView.builder(
                  padding: EdgeInsets.zero,
                  itemCount: dataList.length,
                  itemBuilder: (BuildContext context, int index) {

                    // var status = dataList[index]['status'];
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 0.0),
                      child: Card(
                        // elevation: 4.0,
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Container(
                                // height: 35,
                                child: Container(
                                  child: Row(
                                    children: [
                                      Column(
                                        children: [
                                          Row(
                                            children: [
                                              Container(
                                                  width: MediaQuery.of(context).size.width/ 2,
                                                  child: Text('Name: ${dataList[index]['name']}', style: GoogleFonts.inter(color: Colors.black, fontSize: 14, fontWeight: FontWeight.w600),)),
                                            ],
                                          ),
                                          SizedBox(height: 3,),
                                          Row(
                                            children: [
                                              Container(
                                                  width: MediaQuery.of(context).size.width/ 2,
                                                  child:
                                                  Text('F Name: ${dataList[index]['fname']}', style: GoogleFonts.inter(color:  Colors.black, fontSize: 13),)),
                                            ],
                                          ),
                                        ],
                                      ),
                                      Spacer(),
                                      Row(
                                        children: [
                                          InkWell(
                                            onTap: (){
                                            setState(() {
                                              valueList[index] = 'P';
                                              // valueList.insert(index, 'P');
                                              newDataList.add(
                                                {
                                                  "sid": dataList[index]['sid'],
                                                  "status":"P"// mark P/A/L
                                                }
                                              );
                                            });
                                           },
                                            child: Container(
                                              height: 25,
                                              child: Row(
                                                children: [
                                                  Icon(valueList[index] == 'P' ? Icons.check_box : Icons.check_box_outline_blank, size: 20, color: valueList[index] == 'P' ? appPrimary : Colors.black
                                                    ,),
                                                SizedBox(width: 3,),
                                                Text('P', style: GoogleFonts.inter(color:  Colors.black, fontSize: 13),),
                                        ],
                                              ),
                                            ),
                                          ),
                                          SizedBox(width: 10,),
                                          InkWell(
                                            onTap: (){
                                              setState(() {
                                                // status = 'A';
                                                valueList[index] = 'A';
                                                newDataList.add(
                                                    {
                                                      "sid": dataList[index]['sid'],
                                                      "status":"A"// mark P/A/L
                                                    }
                                                );
                                              });
                                            },
                                            child: Container(
                                              height: 25,
                                              child: Row(
                                                children: [
                                                  Icon(valueList[index] == 'A' ? Icons.check_box : Icons.check_box_outline_blank, size: 20, color: valueList[index] == 'A' ? appPrimary : Colors.black,),
                                                  SizedBox(width: 3,),
                                                  Text('A', style: GoogleFonts.inter(color:  Colors.black, fontSize: 13),),
                                                ],
                                              ),
                                            ),
                                          ),
                                          SizedBox(width: 10,),
                                          InkWell(
                                            onTap: (){
                                              setState(() {
                                                valueList[index] = 'L';
                                                // valueList.insert(index, 'L');
                                                newDataList.add(
                                                    {
                                                      "sid": dataList[index]['sid'],
                                                      "status":"P"// mark P/A/L
                                                    }
                                                );
                                              });
                                            },
                                            child: Container(
                                              height: 25,
                                              child: Row(
                                                children: [
                                                  Icon(valueList[index] == 'L' ? Icons.check_box : Icons.check_box_outline_blank, size: 20, color: valueList[index] == 'L' ? appPrimary : Colors.black
                                                    ,),
                                                  SizedBox(width: 3,),
                                                  Text('L', style: GoogleFonts.inter(color:  Colors.black, fontSize: 13),),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),),
                            ],
                          ),
                        ),
                      ),
                    );
                  }),
            ),
            SizedBox(height: 10,),
            Container(
              width: MediaQuery.of(context).size.width,
              height: 35,
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(primary: appPrimary),
                  onPressed: () async{
                    await punchData();
                  },
                  child: Text('Submit')),
            ) ,
          ],
        )
    );
  }
}