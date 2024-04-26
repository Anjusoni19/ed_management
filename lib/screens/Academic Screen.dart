import 'dart:convert';

import 'package:ed_management/Colors.dart';
import 'package:ed_management/services/ApisProvider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Teacher Feactures Screen.dart';

class AcademicScreen extends StatefulWidget {
  @override
  _AcademicScreenState createState() => _AcademicScreenState();
}

class _AcademicScreenState extends State<AcademicScreen> {
  bool onSearch = true;
  List<String> allStandard = ['RBSE - Hindi', 'First', 'Second', 'Third', 'Fourth', 'Fifth', 'Sixth', 'Seventh', 'Eight', 'Ninth', 'Tenth'];
  TextEditingController search = TextEditingController();
  var isLoading = true;
  List dataList = [];
  var selectStandard;
  List stardardList = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchDataList();
  }

  fetchDataList() async{
    final prefs = await SharedPreferences.getInstance();
    var standard = prefs.getString('standard') ?? '';
    print('standardList =====${standard}');
    var newTest = standard.replaceAll('[', '').replaceAll(']', '');
    stardardList = newTest.split(',');
    print('standardList =====${stardardList}');

    var data = await ApiService().academicData(onSearch ? search.text.toString() : selectStandard, onSearch ? 'search' : 'standard');
    if(data['status'] == true) {
        dataList = data['data'];
    }
    print('academicList');
    print(dataList.length);

    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     body: isLoading
     ? Center(child: CircularProgressIndicator(color: appPrimary,),)
     : SafeArea(
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
                               onSearch = true;
                               search.clear();
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
                           ),child: Text('By Search', style: GoogleFonts.inter(color: onSearch ? Colors.white : Colors.black, fontSize: 12),),
                           ),
                         ),
                         // SizedBox(width: 5,),
                         InkWell(
                           onTap: () {
                             setState(() {
                               onSearch = false;
                               search.clear();
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
                             ),child: Text('By Standard', style: GoogleFonts.inter(color: !onSearch ? Colors.white : Colors.black, fontSize: 12),),
                           ),
                         ),
                       ],
                     ),
                   ),
                   Padding(
                     padding: const EdgeInsets.all(10.0),
                     child: SizedBox(
                       height: 40,
                       // decoration:const  BoxDecoration(
                       //     border: Border(bottom: BorderSide(color: Colors.white))
                       // ),
                       // alignment: Alignment.center,
                       child:TextFormField(
                         readOnly: !onSearch ? true : false,
                         controller: search,
                         cursorColor: appPrimary,
                         style:  TextStyle(color: Colors.black, fontSize: 14),
                         onTap: () {
                           // if(!onSearch) {
                           // showDialog(
                           //     context: context,
                           //     builder: (context) {
                           //       return AlertDialog(
                           //         backgroundColor: Colors.white,
                           //         insetPadding: EdgeInsets.only(top: 0,left: 0, right: 0, bottom: 70),
                           //         shape: RoundedRectangleBorder(
                           //             borderRadius: BorderRadius.circular(4)
                           //         ),
                           //         contentPadding: EdgeInsets.zero,
                           //         content: SizedBox(
                           //           width: MediaQuery.of(context).size.width,
                           //           child: Column(
                           //             children: <Widget>[
                           //               Column(
                           //                 children: [
                           //                   SizedBox(height: 10,),
                           //                   Row(
                           //                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                           //                     children: <Widget>[
                           //                       Container(
                           //                         decoration: BoxDecoration(
                           //                             color: appPrimary,
                           //                             borderRadius: BorderRadius.only(topRight: Radius.circular(4), bottomRight: Radius.circular(4))
                           //                         ),
                           //                         child: Padding(
                           //                           padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                           //                           child:
                           //                           InkWell(
                           //                               onTap: () {
                           //                                 Navigator.pop(context);
                           //                               },
                           //                             child: Row(
                           //                               children: [
                           //                                 Icon(Icons.arrow_back, color: Colors.white,),
                           //                                 SizedBox(width: 15,),
                           //                                 Text('Standard', style: GoogleFonts.merriweather(color: Colors.white, fontSize: 13, fontWeight: FontWeight.w300),),
                           //                               ],
                           //                             ),
                           //                           ),
                           //                         ),
                           //                       ),
                           //                     ],
                           //                   ),
                           //                   SizedBox(height: 10,),
                           //                 ],
                           //               ),
                           //               Expanded(
                           //                 child: ListView.builder(
                           //                     itemCount: stardardList.length,
                           //                     itemBuilder: (BuildContext context, int index) {
                           //                       final standardName = stardardList[index];
                           //                       return GestureDetector(
                           //                         onTap: () {
                           //                           setState(() {
                           //                             isLoading = true;
                           //                           });
                           //                           selectStandard = standardName;
                           //                           Navigator.pop(context);
                           //                           fetchDataList();
                           //
                           //                         },
                           //                         child: Column(
                           //                           // mainAxisSize: MainAxisSize.min,
                           //                           children: [
                           //                             Padding(
                           //                               padding: const EdgeInsets.only(left: 8.0),
                           //                               child: Container(
                           //                                 height: 25,
                           //                                 child: Row(
                           //                                   children: [
                           //                                     Text(standardName, style: TextStyle(color: Colors.grey.shade700, fontSize:  12, fontWeight: FontWeight.normal ),),
                           //                                   ],
                           //                                 ),
                           //                               ),
                           //                             ),
                           //                             SizedBox(height: 5,),
                           //                             Divider(color: Colors.grey.shade500, thickness: 0.5,)
                           //                           ],
                           //                         ),
                           //                       );
                           //                     }),
                           //               ),
                           //             ],
                           //           ),
                           //         ),
                           //       );
                           //     });
                           // }
                         },
                         decoration:  InputDecoration(
                           // suffix: InkWell(
                           //     onTap: () async{
                           //       var dataList = await ApiService().academicDataList(search.text.toString(), 'search' );
                           //       if(dataList['status'] == true) {
                           //         dataList = dataList['dataList'];
                           //       }
                           //       print('reportList');
                           //       print(dataList.length);
                           //       setState(() {
                           //       });
                           //     },
                           //     child: Text('search')),
                           prefixIcon: Icon(Icons.search, size: 17, color: Colors.grey,),
                           suffixIcon: InkWell(
                               onTap: () {
                                 search.clear();
                               },
                               child: Icon(Icons.clear, size: 17, color: Colors.grey,)),
                           hintText: onSearch ? 'Type here...' : 'Select Standard',
                           //   labelText: 'Username',
                             hintStyle: TextStyle(fontSize: 8, color: Colors.grey.shade500),
                             fillColor: Colors.white,
                             // border: OutlineInputBorder(),
                             border: OutlineInputBorder(borderSide: BorderSide(color: Colors.grey.shade400, width: 1.5)),
                             focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.grey.shade400, width: 1.5)),
                             disabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.grey.shade400, width: 1.5))
                         ),
                         onFieldSubmitted: (val) async{
                           print(val);
                           setState(() {
                             isLoading = true;
                           });
                           await fetchDataList();
                         },
                       ),
                     ),
                   ),
                 ],
               ),
             ),
           ),
           SizedBox(height: 10,),
           !onSearch
               ? Container()
               : Text('${dataList.length} rows', style: GoogleFonts.poppins(color: Colors.grey, fontSize: 14),),
           SizedBox(height: 10,),
           dataList.isNotEmpty
           ? Expanded(
             child: ListView.builder(
                 itemCount: dataList.length,
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
                         height: 100,
                         child: Row(
                           children: [
                             Padding(
                               padding: const EdgeInsets.all(8.0),
                               child: Container(color: appPrimary, width: 5,),
                             ),
                             SizedBox(width: 10,),
                             Column(
                               mainAxisAlignment: MainAxisAlignment.center,
                               children: [
                                 Container(
                                   width: MediaQuery.of(context).size.width/2,
                                   child: Row(
                                     children: [
                                       Text('Name:', style: GoogleFonts.poppins(color: Colors.black, fontSize: 14),),
                                       SizedBox(width: 8,),
                                       Text('${dataList[index]['name']}', style: GoogleFonts.poppins(color: appPrimary, fontSize: 14),),
                                     ],
                                   ),
                                 ),
                                 SizedBox(height: 2,),
                                 Container(
                                   width: MediaQuery.of(context).size.width/2,
                                   child: Row(
                                     children: [
                                       Text("Fs Name:", style: GoogleFonts.poppins(color: Colors.black, fontSize: 14),),
                                       SizedBox(width: 8,),
                                       Text('${dataList[index]['fname']}', style: GoogleFonts.poppins(color: appPrimary, fontSize: 14),),
                                     ],
                                   ),
                                 ),
                                 SizedBox(height: 2,),
                                 Container(
                                   width: MediaQuery.of(context).size.width/2,
                                   child: Row(
                                     children: [
                                       Text('Standard:', style: GoogleFonts.poppins(color: Colors.black, fontSize: 14),),
                                       SizedBox(width: 8,),
                                       Text('${dataList[index]['standard']}', style: GoogleFonts.poppins(color: appPrimary, fontSize: 14),),
                                     ],
                                   ),
                                 ),
                                 SizedBox(height: 2,),
                                 Container(
                                   width: MediaQuery.of(context).size.width/2,
                                   child: Row(
                                     children: [
                                       Text('Stream:', style: GoogleFonts.poppins(color: Colors.black, fontSize: 14),),
                                       SizedBox(width: 8,),
                                       Text('${dataList[index]['stream']}', style: GoogleFonts.poppins(color: appPrimary, fontSize: 14),),
                                     ],
                                   ),
                                 ),
                               ],
                             ),
                             Spacer(),
                             Container(
                               width: MediaQuery.of(context).size.width/6.5,
                               child: Padding(
                                 padding: const EdgeInsets.only(top: 10.0, bottom: 5.0),
                                 child: Column(
                                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                   children: [
                                     Row(
                                       children: [
                                         Row(
                                           crossAxisAlignment: CrossAxisAlignment.end,
                                           children: [
                                             Text('${dataList[index]['rank']}', style: GoogleFonts.poppins(color: Colors.green, fontSize: 22),),
                                             SizedBox(height: 8,),
                                             Column(
                                               children: [
                                                 Text('Rank', style: GoogleFonts.poppins(color: Colors.grey, fontSize: 10),),
                                                 SizedBox(height: 3,)
                                               ],
                                             ),
                                           ],
                                         ),
                                         Column(
                                           children: [
                                             Image.asset('assets/icons4.png',color: Colors.grey,height: 25,),
                                             SizedBox(height: 8,)
                                           ],
                                         )
                                       ],
                                     ),
                                     // Spacer(),
                                     Column(
                                       children: [
                                         Row(
                                           crossAxisAlignment: CrossAxisAlignment.end,
                                           children: [
                                             Text('${dataList[index]['score']}', style: GoogleFonts.poppins(color: Colors.black, fontSize: 16, fontWeight: FontWeight.w500),),
                                             SizedBox(height: 5,),
                                             Column(
                                               children: [
                                                 Text('/ 150', style: GoogleFonts.poppins(color: Colors.grey, fontSize: 10),),
                                                 // SizedBox(height: 3,)
                                               ],
                                             ),
                                           ],
                                         ),
                                         Row(
                                           // crossAxisAlignment: CrossAxisAlignment.end,
                                           children: [
                                             Column(
                                               children: [
                                                 Text('Score Point', style: GoogleFonts.poppins(color: Colors.black, fontSize: 10),),
                                                 SizedBox(height: 3,)
                                               ],
                                             ),
                                           ],
                                         ),
                                       ],
                                     ),
                                   ],
                                 ),
                               ),
                             ),
                             SizedBox(width: 15,)
                           ],
                         ),
                       ),
                     ),
                   );
                 }),
           )
           : Container(),
           !onSearch
           ? Expanded(
             child: ListView.builder(
                 itemCount: stardardList.length,
                 itemBuilder: (BuildContext context, int index) {
                   final standardName = stardardList[index];
                   return GestureDetector(
                     onTap: () {
                       setState(() {
                         isLoading = true;
                       });
                       selectStandard = standardName;
                       // Navigator.pop(context);
                       fetchDataList();

                     },
                     child: Column(
                       // mainAxisSize: MainAxisSize.min,
                       children: [
                         Padding(
                           padding: const EdgeInsets.only(left: 8.0),
                           child: Container(
                             height: 25,
                             child: Row(
                               children: [
                                 Text(standardName, style: TextStyle(color: Colors.grey.shade700, fontSize:  12, fontWeight: FontWeight.normal ),),
                               ],
                             ),
                           ),
                         ),
                         SizedBox(height: 5,),
                         Divider(color: Colors.grey.shade500, thickness: 0.5,)
                       ],
                     ),
                   );
                 }),
           )
           : Container()
         ],
       ),
     ),
    );
  }
}