import 'package:flutter/material.dart';
import 'package:qr_gen_rd/Screens/authenticate/sign_in.dart';
import 'package:qr_gen_rd/Screens/authenticate/resgister.dart';


/*A Wrapper For Switching Between SignIn form and Register Form */

class Authenticate extends StatefulWidget {
  @override
  _AuthenticateState createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {

  bool showSignIn = true;  //If this is true we show signIn widget
  void toggleView(){
    setState(() => showSignIn = !showSignIn);   //Reversing the current state of showSignIn 
  }

  @override
  Widget build(BuildContext context) {
    if(showSignIn){
      return SignIn(toggleFunction: toggleView);
    }else{
      return Register(toggleFunction: toggleView);
    }
  }
}