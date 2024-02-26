
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String _scanbarCodeResult ="";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Billing",style: TextStyle(fontSize: 25,color: Colors.white),),
        backgroundColor: Colors.black,
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              decoration: BoxDecoration(
                  color: Colors.yellow,
                borderRadius: BorderRadius.circular(12)
              ),
              height: 40,
              width: 190,
              child: InkWell(
                onTap: (){
                  showDialog(
                      context: Get.context!,
                      builder: (context) {
                        return SimpleDialog(
                            backgroundColor: Colors.white,
                            alignment: Alignment.center,
                            titleTextStyle: TextStyle(color: Colors.black,fontSize: 18,fontWeight: FontWeight.bold,letterSpacing: 1.7,),
                            title: Text("Enter product no.",textAlign: TextAlign.center),
                            contentPadding: EdgeInsets.all(20),
                            children: [
                              TextField(
                                decoration: InputDecoration(
                                  icon: Icon(Icons.shopping_bag_outlined,color: Colors.black,shadows: [Shadow(color: Colors.white,blurRadius: 12)]),
                                  focusColor: Colors.black,

                                ),

                              ),
                              SizedBox(height: 10),
                              ElevatedButton(
                                  onPressed: (){},
                                  child: Text("Submit",textAlign: TextAlign.center,style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black),)
                              )

                              // Text("23456",textAlign: TextAlign.center,style: GoogleFonts.lato(letterSpacing: 1,fontWeight: FontWeight.w500,color: Colors.black,fontSize: 15,),)
                            ],
                        );
                      });;
                },
                  child: Center(child: Text("Enter Product No.",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),))),
            ),
            SizedBox(height: 30),
            Container(
              height: 40,
              width: 210,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: Colors.yellow
              ),
              child: InkWell(
                onTap: scanBarcode,
                  child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Scan Bar Code",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),
                          ),
                          SizedBox(width: 5,),
                          Icon(Icons.camera_alt_outlined)
                        ],
                      ))),
            ),
          ],
        ),
      ),
    );
  }

  void scanBarcode()async {
    String barcodeRes;
    try{
      barcodeRes = await FlutterBarcodeScanner.scanBarcode(
          "#ff6666",
          "cancel",
          true,
          ScanMode.BARCODE
      );
    }on PlatformException{
      barcodeRes ="failed to find version";
    }
    setState(() {
      _scanbarCodeResult = barcodeRes;
    });
  }
}
