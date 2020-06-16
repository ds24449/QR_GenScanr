import 'package:flutter/material.dart';
import 'package:qr_gen_rd/Screens/loading.dart';
import 'package:qr_gen_rd/services/database.dart';
import 'package:qr_gen_rd/services/auth.dart';

/*Function To Provide New Account Regestration Service to our App via FireBase Authentication Service */

class Register extends StatefulWidget {

  //we create inside the WIDGET not the state a property to accept toggling fucntion
  final Function toggleFunction;    //the function we recived as a parameter
  Register({this.toggleFunction});  //Constructor used in making passsed parameter a property of widget!..Sounds rather tricky eh
  //however this function can be used inside state object 

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {//STATE OBJECT for the widget

  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();  //A global key of FormState..Use it to identify our form
  bool loading = false;

  final UserPersonelData data = UserPersonelData();
  String email = '';
  String password = '';
  String error = '';

  @override
  Widget build(BuildContext context) {
      return loading?Loading():Scaffold(
      appBar: AppBar(
        elevation: 0.5,
        title: Text('Sign Up for Bus Services'),
        actions: <Widget>[  // This Here Shows SignIn Option on Register screen
          FlatButton.icon(onPressed: (){
            widget.toggleFunction();
          },
          icon: Icon(Icons.person), 
          label:Text("Sign IN")
          ),
        ]
      ),

      body: Container(
        padding: EdgeInsets.symmetric(vertical:20.0,horizontal: 50),
        child: Form(
          key: _formKey,    //Associating a UID to Form
          child:ListView(
            children: <Widget>[
              //SizedBox(height: 15,),
              TextFormField(    //For email
                decoration: InputDecoration(
                  labelText: 'Email',
                  hintText: 'doe@gmail.com',
                  fillColor: Colors.white,
                  filled: true, 
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color:Colors.white,width: 2.0)
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color:Colors.blue,width: 2.0)
                  )
                ),
                validator: (value)=>value.isEmpty?'Enter Email':null, //if value empty return helper text else return nothing
                //Validator takes a function and returns result to know if form is valid
                //our form is valid if there is somethin in there
                onChanged: (value){
                  setState(() {
                    email = value;
                    data.email = email;
                  });
                },
              ),


              SizedBox(height:15,),
              TextFormField(    //for password
                decoration: InputDecoration(
                  hintText: 'Password',
                  fillColor: Colors.white,
                  filled: true,
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color:Colors.white,width: 2.0)
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color:Colors.blue,width: 2.0)
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

              SizedBox(height:15,),
              TextFormField(    //for Name
                decoration: InputDecoration(
                  labelText: 'Name',
                  hintText: 'Name',
                  fillColor: Colors.white,
                  filled: true,
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color:Colors.white,width: 2.0)
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color:Colors.blue,width: 2.0)
                  )
                ),
                validator: (value)=>value.isEmpty?'Enter your name':null,
                onChanged: (value){
                  setState(() {
                    data.name = value;
                  });
                }
              ),

              SizedBox(height:15,),
              TextFormField(    //for DOB
                decoration: InputDecoration(
                  labelText: 'Date-OF-Birth',
                  hintText: 'dd-mm-yyyy',
                  fillColor: Colors.white,
                  filled: true,
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color:Colors.white,width: 2.0)
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color:Colors.blue,width: 2.0)
                  )
                ),
                validator: (value)=>value.isEmpty?'Enter your date-of-birth(dd-mm-yyyy)':null,
                onChanged: (value){
                  setState(() {
                    data.dob = value;
                  });
                }
              ),

              SizedBox(height:15,),
              TextFormField(    //for corona history
                decoration: InputDecoration(
                  labelText: 'Ever Tested positive for corona?',
                  hintText: 'Y/N',
                  fillColor: Colors.white,
                  filled: true,
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color:Colors.white,width: 2.0)
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color:Colors.blue,width: 2.0)
                  )
                ),
                validator: (value)=>value.isEmpty?'provide valid answer':null,
                onChanged: (value){
                  setState(() {
                    (value.toLowerCase() == 'y')?data.previousCoronaPos = true:data.previousCoronaPos = false;
                  });
                }
              ),

              SizedBox(height: 15,),
              TextFormField(    //for corona history
                decoration: InputDecoration(
                  labelText: 'Any Heath Issue?',
                  hintText: 'if none,type null',
                  fillColor: Colors.white,
                  filled: true,
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color:Colors.white,width: 2.0)
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color:Colors.blue,width: 2.0)
                  )
                ),
                validator: (value)=>value.isEmpty?'provide valid answer':null,
                onChanged: (value){
                  setState(() {
                    data.healthIssues = value.toLowerCase();
                  });
                }
              ),

              RaisedButton(
                color: Colors.greenAccent,
                splashColor: Colors.blueGrey,
                child: Text("Register"),
                onPressed: () async { //This here is where Registeration will happen
                  if(_formKey.currentState.validate()){//condition:- is our form valid?
                  //this validate() method uses validator properties of form
                    setState(()=> loading = true);
                    //print(data.email);
                    dynamic result = await _auth.registerWithEmailAndPassword(email,password,data);
                    if(result == null){
                      setState((){
                        loading = false;
                        error = 'Please Supply a Valid email!';
                      });
                      //Now understand this... IF there is Sucessful Registeration we have a Stream Setup already
                      //to send user to HomeScreen
                    }
                  } 
                }
              ),
              Text(error,
              style: TextStyle(color: Colors.red),
              ),
            ]
          )
        )

      )
    );
  }
}