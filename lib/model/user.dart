import 'package:untitled/model/user_dob.dart';
import 'user_name.dart';

class User{
  final String email;
  final UserName name;
  final UserDob dob;

  User({required this.name,required this.email, required this.dob});


  factory User.fromMap(Map<String, dynamic> e){

    final name = UserName.fromMap(e['name']);

    final dob = UserDob.fromMap(e['dob']);

    return User(
        email: e['email'],
        name: name,
        dob: dob
    );
  }

  String get fullName{
    return '${this.name.title} ${this.name.first} ${this.name.last}';
  }

}

