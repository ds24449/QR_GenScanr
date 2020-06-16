import 'package:firebase_auth/firebase_auth.dart';
import 'package:qr_gen_rd/services/database.dart';

/*Contains Class for Authentication Services 
Functions:
  signInAnon :- Sign in as anonymous
  signOut :- Sign Out account*/


class AuthService{
  final FirebaseAuth _auth = FirebaseAuth.instance;   //Used to start an instance to connect to FireBase auth-
  //-services

  //create a user obj from FirebaseUser obj
  User _userFromFirebaseUser(FirebaseUser user){    //get us desired user properties
    return  user!=null?User(uid: user.uid): null;
  }

  //this below here creates a stream.. there by we can continously keep a lookout on User obj for changes
  Stream<User> get user{  //Receiving a  stream.... using getter...this returns a User datatype
    return _auth.onAuthStateChanged    //this is the Stream that returns firebase user object
      .map(_userFromFirebaseUser);     //mapping firebaseuser obj to user obj
  }
  // we are gonna recieve a Null when user signs out



  //sign in using anon
  Future signInAnon() async {
    try{
      AuthResult result = await _auth.signInAnonymously();    //signing in anon...await because we need to wait for returned value
      //in this result object we have a Firebase User object
      FirebaseUser user = result.user;
      User _user = _userFromFirebaseUser(user); 
      return _user;
    }catch(e){
      print(e.toString());
      return null;
    }
  }

  //sign in using email and password
  Future signinWithEmailAndPassword(String email,String password) async{
    try{
      AuthResult result = await _auth.signInWithEmailAndPassword(email: email, password: password);
      FirebaseUser user = result.user;
      return _userFromFirebaseUser(user);
    }catch(e){
      print(e.toString());
      return null;
    }
  }

  //register with email and password
  Future registerWithEmailAndPassword(String email,String password,UserPersonelData data) async {
    try{
      AuthResult result = await _auth.createUserWithEmailAndPassword(email: email, password: password); //using builtIn Method
      FirebaseUser user = result.user;

      //create a new document for the user with the uid
      await DatabaseService(uid: user.uid).updateUserData(data);
      return _userFromFirebaseUser(user);
    }catch(e){
      print(e.toString());
      return null;
    }
  }

  //sign out
  Future signout() async {
    try{
      return await _auth.signOut();
    }catch(e){
      print(e.toString());
      return null;
    }
  }
}