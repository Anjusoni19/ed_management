import 'package:ed_management/Colors.dart';
import 'package:ed_management/screens/FeacturesSubItem/AddStudentScreen.dart';
import 'package:ed_management/services/ApisProvider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class NotificationScreen extends StatefulWidget {
  @override
  _NotificationScreenState createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  int SelectValue = 0;

  bool isSelect = false;

  List dataList = [];

  bool isLoading = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchData();
  }

  fetchData() async{
    var data = await ApiService().notification();
    if(data['status'] == true) {
      dataList = data['data'];
    }
    print('reportList');
    print(dataList.length);
    setState(() {
      isLoading = false;
    });
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          automaticallyImplyLeading: false,
          title: Text('Notification', style: GoogleFonts.inter(color: appPrimary, fontSize: 18),),
        ),
        body: isLoading
            ? Center(child: CircularProgressIndicator(color: appPrimary,),)
            :  ListView.builder(
            itemCount: dataList.length,
            itemBuilder: (BuildContext context, int index) {
             var FirstTile =  dataList[index]['title'][0];
             String splitColor = dataList[index]['color'];
             var val = splitColor.replaceAll('#', '0xff');
             print(val);
            return Padding(
              padding: const EdgeInsets.only(left: 10.0, right: 10.0, bottom: 0, top: 10),
              child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                        children: [
                          Container(
                            height: 50,
                            width: 50,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(60),
                                boxShadow: kElevationToShadow[2],
                                color: Color(int.parse(val))
                            ),
                            alignment: Alignment.center,
                            child: Text('${FirstTile}', style: GoogleFonts.inter(fontSize: 25, color: Colors.white, ),),
                          ),
                          SizedBox(width: 10,),
                          Column(
                            children: [
                              Container(
                                  width: MediaQuery.of(context).size.width/1.4,
                                  child: Text('${dataList[index]['title']}', style: GoogleFonts.inter(fontSize: 15, fontWeight: FontWeight.w400),)),
                              SizedBox(height: 2,),
                              Container(
                                  width: MediaQuery.of(context).size.width/1.4,
                                  child: Text('${dataList[index]['mode']}', style: GoogleFonts.inter(fontSize: 14,color: Colors.grey),)),
                              SizedBox(height: 2,),
                              Container(
                                  width: MediaQuery.of(context).size.width/1.4,
                                  child: Row(
                                    children: [
                                      Image(image: AssetImage('assets/internet.png'), height: 12,),
                                      SizedBox(width: 5,),
                                      Text('${dataList[index]['date']}', style: GoogleFonts.inter(fontSize: 14, color: Colors.grey),),
                                    ],
                                  )),
                            ],
                          ),
                        ]
                    ),
                    Divider(thickness: 1,)
                  ]
              ),
            );
          }
        ));
  }
}