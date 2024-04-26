import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void fetchData(BuildContext context, [bool mounted = true]) async {
  // show the loading dialog
  showDialog(
    // The user CANNOT close this dialog  by pressing outsite it
      barrierDismissible: false,
      context: context,
      builder: (_) {
        return Dialog(
          // The background color
          backgroundColor: Colors.transparent,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: const [
                // The loading indicator
                CircularProgressIndicator(color: Colors.white,),
              ],
            ),
          ),
        );
      });

  // Your asynchronous computation here (fetching data from an API, processing files, inserting something to the database, etc)
  // await Future.delayed(const Duration(seconds: 3));

  // Close the dialog programmatically
  // We use "mounted" variable to get rid of the "Do not use BuildContexts across async gaps" warning
  // if (!mounted) return;
  // Navigator.of(context).pop();
}

void showData(BuildContext context, String msg) async {
  // show the loading dialog
  showDialog(
    // The user CANNOT close this dialog  by pressing outsite it
    //   barrierDismissible: false,
      context: context,
      builder: (_) {
        return Dialog(
          // The background color
          backgroundColor: Colors.transparent,
          child: Container(
            // height: 60,
            decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(40)
            ),
            // alignment: Alignment.center,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
              child: Text('$msg',textAlign: TextAlign.center, style: GoogleFonts.inter(color: Colors.white,  fontSize: 15, fontWeight: FontWeight.bold),),
            ),
          ),
        );
      });

  // Your asynchronous computation here (fetching data from an API, processing files, inserting something to the database, etc)
  // await Future.delayed(const Duration(seconds: 3));

  // Close the dialog programmatically
  // We use "mounted" variable to get rid of the "Do not use BuildContexts across async gaps" warning
  // if (!mounted) return;
  // Navigator.of(context).pop();
}