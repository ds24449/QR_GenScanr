/*Scans qr codes
Used barcode_scan package */


import 'dart:async';  //for asynchrounous(parallel) computing
import 'package:barcode_scan/barcode_scan.dart';  //required package
import 'package:flutter/material.dart';           //base package
import 'package:flutter/services.dart';           //Platform specific services

class ScanScreen extends StatefulWidget{
  @override
  _ScanState createState() => new _ScanState();
}

class _ScanState extends State<ScanScreen>{
  String barcode = "";  //to store barcode info

  //@override
  /*void initState() {
    super.initState();
  }*/   
  //After Testing remove this in final Version

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text('QR Code Scanner'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,     //center vertically
          crossAxisAlignment: CrossAxisAlignment.stretch, //stretched horizontally
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(17),
              child:RaisedButton(
                color: Colors.greenAccent,
                textColor: Colors.white,
                splashColor:Colors.blueGrey,
                onPressed:scan,
                child: const Text('START SCAN'),
              ),
            ),
            Padding(padding: EdgeInsets.all(15),
            child:Text(barcode,textAlign: TextAlign.center,), //output text....displayed after scan is done
            ),
          ],
        ),
      )
    );
  }

  Future scan() async{
    try{
      ScanResult result = await BarcodeScanner.scan();
      if(result.type == ResultType.Barcode){  //if we got desired scan result instead of error
        //print(result.rawContent);//used for debugging
        setState(()=>this.barcode = result.rawContent); //sets scanned content to var
      }
    }on PlatformException catch (e){  //Exception raised in try block on Platform interaction basis
      if(e.code == BarcodeScanner.cameraAccessDenied){  //is exception is camera Permission denial
        setState((){
          this.barcode = 'The user did not grant the camera permission!';
        });
      }else{    //unknown exception
        setState(()=> this.barcode = "[Unknown Error]: $e");
      }
    }on FormatException{    //if desired format exception raised
      setState(()=>this.barcode = 'null User Returned Using Back button');
    }catch(e){
      setState(()=>this.barcode = 'Unknown error: $e');
    }
  }
}