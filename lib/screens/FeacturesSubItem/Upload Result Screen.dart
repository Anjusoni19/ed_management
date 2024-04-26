import 'package:ed_management/Colors.dart';
import 'package:ed_management/screens/FeacturesSubItem/Upload%20Result%20View%20Screen.dart';
import 'package:ed_management/services/ApisProvider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class UploadResultScreen extends StatefulWidget {
  @override
  _UploadResultScreenState createState() => _UploadResultScreenState();
}

class _UploadResultScreenState extends State<UploadResultScreen> {
  var _progressValue = 0.4;
  List dataList = [];
  bool isLoading = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchData();
  }

  fetchData() async{
    var data = await ApiService().uploadResultData();
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
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        title: Text('Upload Result', style: GoogleFonts.inter(color: appPrimary, fontSize: 16),),
      ),
      body: isLoading
        ? Center(child: CircularProgressIndicator(color: appPrimary,),)
        :  ListView.builder(
          itemCount: dataList.length,
          itemBuilder: (BuildContext context, int index) {
            return Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                InkWell(
                  onTap: () {

                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) =>
                            UploadResultViewScreen(
                              data: dataList[index],
                              exam: dataList[index]['exam'],
                              section: '${dataList[index]['section']}',
                              standard: '${dataList[index]['standard']}',
                              subject: '${dataList[index]['subject']}',
                            )));
                  },
                  child: Card(
                    elevation: 8.0,
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Image.asset('assets/medal.png', height: 22,),
                                SizedBox(width: 8,),
                                Text('${dataList[index]['exam']}', style: GoogleFonts.merriweather(color: appPrimary, fontSize: 16, fontWeight: FontWeight.bold),)
                              ],
                            ),
                            SizedBox(height: 10,),
                            Row(
                              children: [
                                SizedBox(width: 5,),
                                Image.asset('assets/standardicon.png', height: 17,),
                                SizedBox(width: 10,),
                                Text('${dataList[index]['stream']} - ${dataList[index]['standard']}', style: GoogleFonts.merriweather(color: Colors.black, fontSize: 12),),
                                Spacer(),
                                Container(
                                  height: 30,
                                  child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(primary: Colors.green.shade400),
                                      onPressed: () {},
                                      child: Text('${dataList[index]['subject']}', style: GoogleFonts.merriweather(color: Colors.white, fontSize: 9),)),
                                ),
                                SizedBox(width: 5,),
                              ],
                            ),
                            SizedBox(height: 10,),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 10.0),
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Text('Overall Max Marks: ${dataList[index]['overall']}', style: GoogleFonts.merriweather(fontSize: 13, color: appPrimary),),
                                      Spacer(),
                                      Text('Upload Marks ', style: GoogleFonts.merriweather(fontSize: 12, color: Colors.grey, fontWeight: FontWeight.bold),),
                                      SizedBox(width: 10,),
                                      Text('${dataList[index]['overallupload']}/', style: GoogleFonts.poppins(fontSize: 14, color: Colors.green),),
                                      Text('${dataList[index]['students']}', style: GoogleFonts.poppins(fontSize: 14, color: appPrimary),),
                                    ],
                                  ),
                                  SizedBox(height: 5,),
                                  LinearProgressIndicator(
                                    backgroundColor: appPrimary.withOpacity(0.3),
                                    valueColor: new AlwaysStoppedAnimation<Color>(appPrimary),
                                    value: _progressValue,
                                  ),
                                ],
                              ),
                            ),
                            dataList[index]['practical'] == null
                                ? Container()
                                :SizedBox(height: 5,),
                            dataList[index]['practical'] == null
                            ? Container()
                            : Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 10.0),
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Text('Practical Marks: ${dataList[index]['practical']}', style: GoogleFonts.merriweather(fontSize: 13, color: appPrimary),),
                                      Spacer(),
                                      Text('Upload Marks ', style: GoogleFonts.merriweather(fontSize: 12, color: Colors.grey, fontWeight: FontWeight.bold),),
                                      SizedBox(width: 5,),
                                      Text('${dataList[index]['practicalupload']}/', style: GoogleFonts.poppins(fontSize: 14, color: Colors.green),),
                                      Text('${dataList[index]['students']}', style: GoogleFonts.poppins(fontSize: 14, color: appPrimary),),
                                    ],
                                  ),
                                  SizedBox(height: 10,),
                                  LinearProgressIndicator(
                                    backgroundColor: appPrimary.withOpacity(0.3),
                                    valueColor: new AlwaysStoppedAnimation<Color>(appPrimary),
                                    value: _progressValue,
                                  ),
                                ],
                              ),
                            ),
                            dataList[index]['theory'] == null
                                ? Container()
                                :SizedBox(height: 5,),
                            dataList[index]['theory'] == null
                                ? Container()
                                :Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 10.0),
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Text('Theory Marks: ${dataList[index]['theory']}', style: GoogleFonts.merriweather(fontSize: 13, color: appPrimary),),
                                      Spacer(),
                                      Text('Upload Marks ', style: GoogleFonts.merriweather(fontSize: 12, color: Colors.grey, fontWeight: FontWeight.bold),),
                                      SizedBox(width: 5,),
                                      Text('${dataList[index]['theoryupload']}/', style: GoogleFonts.poppins(fontSize: 14, color: Colors.green),),
                                      Text('${dataList[index]['students']}', style: GoogleFonts.poppins(fontSize: 14, color: appPrimary),),
                                    ],
                                  ),
                                  SizedBox(height: 10,),
                                  LinearProgressIndicator(
                                    backgroundColor: appPrimary.withOpacity(0.3),
                                    valueColor: new AlwaysStoppedAnimation<Color>(appPrimary),
                                    value: _progressValue,
                                  ),
                                ],
                              ),
                            ),
                            dataList[index]['oral'] == null
                                ? Container()
                                :SizedBox(height: 5,),
                            dataList[index]['oral'] == null
                                ? Container()
                                :Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 10.0),
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Text('Oral Marks: ${dataList[index]['oral']}', style: GoogleFonts.merriweather(fontSize: 13, color: appPrimary),),
                                      Spacer(),
                                      Text('Upload Marks ', style: GoogleFonts.merriweather(fontSize: 12, color: Colors.grey, fontWeight: FontWeight.bold),),
                                      SizedBox(width: 5,),
                                      Text('${dataList[index]['oralupload']}/', style: GoogleFonts.poppins(fontSize: 14, color: Colors.green),),
                                      Text('${dataList[index]['students']}', style: GoogleFonts.poppins(fontSize: 14, color: appPrimary),),
                                    ],
                                  ),
                                  SizedBox(height: 10,),
                                  LinearProgressIndicator(
                                    backgroundColor: appPrimary.withOpacity(0.3),
                                    valueColor: new AlwaysStoppedAnimation<Color>(appPrimary),
                                    value: _progressValue,
                                  ),
                                ],
                              ),
                            ),
                            dataList[index]['sectional'] == null
                                ? Container()
                                :SizedBox(height: 5,),
                            dataList[index]['sectional'] == null
                                ? Container()
                                : Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 10.0),
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Text('Sectional Marks: ${dataList[index]['sectional']}', style: GoogleFonts.merriweather(fontSize: 13, color: appPrimary),),
                                      Spacer(),
                                      Text('Upload Marks ', style: GoogleFonts.merriweather(fontSize: 12, color: Colors.grey, fontWeight: FontWeight.bold),),
                                      SizedBox(width: 5,),
                                      Text('${dataList[index]['sectionalupload']}/', style: GoogleFonts.poppins(fontSize: 14, color: Colors.green),),
                                      Text('${dataList[index]['students']}', style: GoogleFonts.poppins(fontSize: 14, color: appPrimary),),
                                    ],
                                  ),
                                  SizedBox(height: 10,),
                                  LinearProgressIndicator(
                                    backgroundColor: appPrimary.withOpacity(0.3),
                                    valueColor: new AlwaysStoppedAnimation<Color>(appPrimary),
                                    value: _progressValue,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      )),
                ),
              ],
            ),
      );
          }
        ),
    );
  }
}