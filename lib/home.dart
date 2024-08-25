import 'package:flutter/material.dart';
import 'package:untitled/model/user.dart';
import 'package:untitled/services/user_api.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<List<User>> futureUsers;

  @override
  void initState() {
    super.initState();
    futureUsers = fetchUsers(); // Initialize the future in initState
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Rest API Call"),),
      body:  FutureBuilder(future: futureUsers, builder: (context,snapshot){
        if (snapshot.connectionState == ConnectionState.waiting) {
          // While waiting for the future to resolve, show a loading spinner
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (snapshot.hasError) {
          // If an error occurs, show an error message
          return Center(
            child: Text('Error: ${snapshot.error}'),
          );
        } else if (snapshot.hasData) {
          // If data is successfully retrieved, build the list
          final users = snapshot.data!;
          return ListView.builder(
            itemCount: users.length,
            itemBuilder: (context, index) {
              final user = users[index];
              final email = user.email;
              final name = user.fullName;
              return ListTile(
                title: Text(name),
                subtitle: Text(email),
                leading: CircleAvatar(
                  child: Text('${index + 1}'),
                ),
              );
            },
          );
        } else {
          // Handle the case where no data is available
          return const Center(
            child: Text('No users found'),
          );
        }
      })
    );
  }

  // Fetch users using a Future
  Future<List<User>> fetchUsers() async {
    final response = await UserApi.fetchUsers();
    return response;
  }
  // Future<void> fetchUsers() async{
  //   const url = "https://randomuser.me/api/?results=10";
  //   final uri = Uri.parse(url);
  //   final response = await http.get(uri);
  //   final body = response.body;
  //   final json = jsonDecode(body);
  //   final results = json['results'] as List<dynamic>;
  //
  //   final transformed = results.map((e){
  //     final name = UserName(
  //       title: e['name']['title'],
  //       first: e['name']['first'],
  //       last: e['name']['last'],
  //     );
  //     return User(
  //       email: e['email'],
  //       name: name
  //     );
  //   }).toList();
  //
  //
  //   setState(() {
  //     users = transformed;
  //   });
  // }
}
