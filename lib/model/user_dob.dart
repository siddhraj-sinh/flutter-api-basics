
class UserDob{
  final DateTime date;
  final int age;

  UserDob({required this.date, required this.age});

  factory UserDob.fromMap(Map<String,dynamic> e){
    return UserDob(date: DateTime.parse(e['date']), age: e['age']);
  }
}