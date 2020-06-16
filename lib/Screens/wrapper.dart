import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_gen_rd/Screens/homescreen/home_screen.dart';
import 'package:qr_gen_rd/Screens/authenticate/authenticate.dart';
import 'package:qr_gen_rd/services/database.dart';



/*Used to switch betwwen Authentication page and home screen
  condition:- if user is signed in the goto home screen
  implemented using a Provider package.. Provider looks for User obj stream.
  If user obj return non-null value(sign in success) it redirects home-screen */

class  Wrapper extends StatelessWidget{
  @override
  Widget build(BuildContext context) {

    final user = Provider.of<User>(context);  //accessing user data from the stream

    if(user != null){
      return HomeScreen(user);
    }else{
    return Authenticate();
  }
  }
} 