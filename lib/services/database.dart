import 'package:cloud_firestore/cloud_firestore.dart';

//Used to create a User Class and hold User data
class User{
  final String uid;
  User({this.uid});
}

//A User Data Model
class UserPersonelData{
  String email;
  String name;
  String dob;
  //String haddr;
  bool previousCoronaPos;
  String healthIssues;

  UserPersonelData({    //constructor
    this.email,
    this.name,
    this.dob,
    //this.haddr,
    this.previousCoronaPos,
    this.healthIssues,
  }); 

}

final Firestore _firestore  = Firestore.instance;
final String  _collection = 'user_data';
class DatabaseService{

  final String uid;
  DatabaseService({this.uid});  //Document uid

  //Collection Reference:-:reference to collection of a database


  Future updateUserData(UserPersonelData data)async {
    return await _firestore.collection(_collection).document(uid).setData({
      'uid' : uid,
      'email': data.email,
      'name' : data.name,
      'DOB'  : data.dob,
      'CoronaHist'  : data.previousCoronaPos,
      'HealthIssue'  : data.healthIssues,
    });
  }
}
