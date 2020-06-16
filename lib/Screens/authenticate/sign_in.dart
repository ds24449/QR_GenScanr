import 'package:flutter/material.dart';
import 'package:qr_gen_rd/Screens/loading.dart';
import 'package:qr_gen_rd/services/auth.dart';

/* Contains SignIn function
Describes implementation on how to Authenticate with FireBase Authentication Services*/



class SignIn extends StatefulWidget {

  final Function toggleFunction;    //the function we recived as a parameter
  SignIn({this.toggleFunction});   //Constructor makes the parameter property of widget.. We passed the value to the Widget not to its state object
  //however this function can be used inside state object

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {      //this is the state object for Wiget


  final AuthService _auth = AuthService();    //custom made AuthServices
  final _formKey = GlobalKey<FormState>();  //A global key of FormState..Use it to identify our form
  bool loading = false; //whereever loading is true we will put a spinner 

  //text field state
  String email = '';
  String password = '';
  String error = '';

  @override
  Widget build(BuildContext context) {
    return loading?Loading():Scaffold(
      appBar: AppBar(
        elevation: 0.5,
        title: Text('Sign In for Bus Services'),
        actions: <Widget>[  // This Here Shows Register Option on SignIn screen
          FlatButton.icon(onPressed: (){
            widget.toggleFunction();
          },
          icon: Icon(Icons.person), 
          label:Text("Register"))
        ],
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical:20.0,horizontal: 50),
        child: Form(
          key: _formKey,
          child:Column(
            children: <Widget>[
              SizedBox(height: 20,),
              TextFormField(
                decoration: InputDecoration(
                  hintText: 'Email',
                  fillColor: Colors.white,
                  filled: true,
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color:Colors.white,width: 2.0)
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color:Colors.pink,width: 2.0)
                  )
                ),
                validator: (value)=>value.isEmpty?'Enter Email':null, //if value empty return helper text else return nothing
                //Validator takes a function and returns result to know if form is valid
                //our form is valid if there is somethin in there
                onChanged: (value){
                  setState(() {
                    email = value;
                  });
                },
              ),
              SizedBox(height:20,),
              TextFormField(
                decoration: InputDecoration(
                  hintText: 'Password',
                  fillColor: Colors.white,
                  filled: true,
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color:Colors.white,width: 2.0)
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color:Colors.pink,width: 2.0)
                  )
                ),
                validator: (value)=>value.length<6?'Enter Atleast 6 Charaters':null,
                obscureText: true,
                onChanged: (value){
                  setState(() {
                    password = value;
                  });
                },
              ),
              RaisedButton(
                color: Colors.greenAccent,
                splashColor: Colors.blueGrey,
                child: Text("Sign-In"),
                onPressed: () async {
                  if(_formKey.currentState.validate()){//condition:- is our form valid?
                  //this validate() method uses validator properties of form
                    setState(()=> loading = true);
                    dynamic result = await _auth.signinWithEmailAndPassword(email, password);
                    if(result == null){
                      setState((){ 
                        loading = false;
                        error = 'Could Not Sign In with these Credentials :(';
                      //Now understand this... IF there is Sucessful Registeration we have a Stream Setup already
                      //to send user to HomeScreen
                      });
                    }
                  }
                }
              ),
              Text(error,
              style: TextStyle(color: Colors.red),),
            ]
          )
        )

      )
    );
  }
}