import 'package:ed_management/Colors.dart';
import 'package:ed_management/screens/FeacturesSubItem/AddStudentScreen.dart';
import 'package:ed_management/screens/FeacturesSubItem/Attendance%20Screen.dart';
import 'package:ed_management/services/ApisProvider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:group_button/group_button.dart';
import 'package:toastification/toastification.dart';

class UploadMarksScreen extends StatefulWidget {
  UploadMarksScreen({super.key, required this.standard, required this.date, required this.id, required this.subject});

  final String standard, date, id, subject;
  @override
  _UploadMarksScreenState createState() => _UploadMarksScreenState();
}

class _UploadMarksScreenState extends State<UploadMarksScreen> {
  int SelectValue = 0;

  bool isSelect = true;

  List dataList = [];

  bool isLoading = true;

  String _intervalValue = 'Select Standard';

  List newDataList = [];
  List valueList = [];

  List<TextEditingController> _controllers = [];

  TextEditingController outOff = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchDatas();
  }

  fetchDatas() async{
    var data = await ApiService().uploadMarksStudent(widget.standard, widget.date, widget.id);
    if(data['status'] == true) {
      dataList = data['data'];
    }
    print('reportList');
    print(dataList);
    setState(() {
      isLoading = false;
    });
  }

  punchData() async{
    setState(() {
      isLoading = true;
    });
    var data = await ApiService().studentMarksSubmitData(newDataList, widget.date, outOff.text, widget.id, widget.subject);
    if(data['status'] == true) {
      toastification.show(
        // type: ToastificationType.warning,
        context: context,
        title: Text(data['message']),
        autoCloseDuration: const Duration(seconds: 3),
      );
      Navigator.pop(context);
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
        body: isLoading
            ? Center(child: CircularProgressIndicator(color: appPrimary,),)
            : dataList.isEmpty
            ? Container()
            : SafeArea(
              child: Column(
          children: [
              SizedBox(height: 10,),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  children: [
                    Image.asset('assets/title.png', height: 22,),
                    SizedBox(width: 10,),
                    Container(
                        width: MediaQuery.of(context).size.width/1.75,
                        child:
                        Text('${widget.standard} (${dataList.length})', style: GoogleFonts.merriweather(fontSize: 12, fontWeight: FontWeight.bold),)),
                    Spacer(),
                    Text('Out Of', style: GoogleFonts.merriweather(fontSize: 13, fontWeight: FontWeight.w500),),
                        SizedBox(width: 8,),
                        Container(
                          height: 40,
                          width: MediaQuery.of(context).size.width/6.5,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey, width: 1),
                            // borderRadius: BorderRadius.circular(4)
                          ),
                          alignment: Alignment.center,
                          child: TextField(
                            // readOnly: isSectionalVal[index] == '0' ? false : true,
                            keyboardType: TextInputType.number,
                            textAlign: TextAlign.center,
                            cursorColor: appPrimary,
                            // keyboardType: TextInputType.number,
                            // inputFormatters:[                        //only numeric keyboard.
                            //   LengthLimitingTextInputFormatter(int.parse(widget.data['sectional'])),      //only 6 digit
                            //   LimitRange(0, int.parse(widget.data['sectional']))
                            // ],
                            // style: GoogleFonts.poppins(fontSize: 13),
                            decoration: InputDecoration(
                                // hintText: 'Marks',
                                hintStyle: GoogleFonts.poppins(fontSize: 13),
                                focusedBorder: InputBorder.none
                            ),
                            controller: outOff,
                          ),
                          // Text('0', style: GoogleFonts.inter(color: appPrimary, fontSize: 12),),
                        ),
                    SizedBox(width: 5,),
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
                      _controllers.add(TextEditingController());
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
                                                    child: Text('Name: ${dataList[index]['name']}',
                                                      style: GoogleFonts.inter(color: Colors.black, fontSize: 14),)),
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
                                        Container(
                                          height: 40,
                                          width: MediaQuery.of(context).size.width/6.5,
                                          decoration: BoxDecoration(
                                              border: Border.all(color: Colors.grey, width: 1),
                                              // borderRadius: BorderRadius.circular(4)
                                          ),
                                          alignment: Alignment.center,
                                          child: TextField(
                                            // readOnly: isSectionalVal[index] == '0' ? false : true,
                                            keyboardType: TextInputType.number,
                                            textAlign: TextAlign.center,
                                            cursorColor: appPrimary,
                                            // keyboardType: TextInputType.number,
                                            // inputFormatters:[                        //only numeric keyboard.
                                            //   LengthLimitingTextInputFormatter(int.parse(widget.data['sectional'])),      //only 6 digit
                                            //   LimitRange(0, int.parse(widget.data['sectional']))
                                            // ],
                                            decoration: InputDecoration(
                                              hintText: 'Marks',
                                              hintStyle: GoogleFonts.poppins(fontSize: 13),
                                              focusedBorder: InputBorder.none
                                            ),
                                            controller: _controllers[index],
                                            onChanged: (val) {
                                              if(val != '') {
                                                newDataList.add({
                                                  "sid":dataList[index]['sid'],
                                                  "marks":_controllers[index].text});
                                              }
                                            },
                                          ),
                                          // Text('0', style: GoogleFonts.inter(color: appPrimary, fontSize: 12),),
                                        )
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
        ),
            )
    );
  }
}