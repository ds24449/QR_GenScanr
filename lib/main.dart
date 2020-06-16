import 'package:flutter/material.dart';
import 'package:qr_gen_rd/services/auth.dart';
import 'package:qr_gen_rd/Screens/wrapper.dart';
import 'package:provider/provider.dart';
import 'package:qr_gen_rd/services/database.dart';

/*
UnderStand The FLow:
  main.dart ===(starting point of app)==> wrapper.dart --(if registeration selected)--> register.dart --> Homescreen.dart
                                                  --(else)-->homescreen.dart---(scan)-->scan.dart
                                                                          ---(generate) --> gen.dart
*/

/*Understand the files and folders
main.dart =  Contains app entry point
Screens ->
        1.authenticate -> Contains files required to Present to you SignIn and SignUp form(User Login And Register)
          1.1 -> authenticate.dart == Wrapper to switch between signIn and Register options
          1.2 -> register.dart == Registration Screen
          1.3 -> sign_in.dart == Sign In Screen
        2.homescreen -> Contains original options to generate a QR code and also to scan a qr code
          2.1 -> home_screen.dart == User HomeScreen provides options to scna qr code or generate qr code
          2.2 -> gen.dart == Creates Adn Displays A QR based on a String object
          2.3 -> scan.dart == Provides Features essential for scanning 
        3.loading.dart == conatins widget to show while loading 
        4.Wrapper.dart == wrapper to switch between authenticate and HomeScreen


services -> contains functions to Authenticate User with FireBase 
        1.auth.dart == all the authentication functions
        2.database.dart == all the database related functions
        :)
 */

void main()=>runApp(MyApp());
//To track users sign in and sign out.. i am gonna use a provider package.
//provider is google recommended way for statechange managment.
//https://pub.dev/packages/provider#-readme-tab-
//we wrap a widget tree in a provider.
//we supply an auth change stream to provider
//because stream is a continous flow of data
class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return StreamProvider<User>.value(  //it is listening to stream... keeping an eye if the USer obj changes its state
        value: AuthService().user,  //we are ccessing user stream from AuthService's instance(line 4 at auth.dart)
        child: MaterialApp(
          title: 'QR Genration-Scanner',
          theme: ThemeData(
            primarySwatch: Colors.blueAccent[110],
          ),
          home: Wrapper(),
      ),
    );
  }
}