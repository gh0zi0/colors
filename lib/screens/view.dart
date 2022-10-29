import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:new_gradient_app_bar/new_gradient_app_bar.dart';

class ViewScreen extends StatefulWidget {
  ViewScreen({super.key, required this.user, required this.color});
  String user;
  List<Color> color;

  @override
  State<ViewScreen> createState() => _ViewScreenState();
}

class _ViewScreenState extends State<ViewScreen> {
  var auth = FirebaseAuth.instance, store = FirebaseFirestore.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: NewGradientAppBar(
        title: Text('Your Info'),
        gradient: LinearGradient(colors: widget.color),
      ),
      body: FutureBuilder(
        future: store.collection('users').doc(auth.currentUser!.uid).get(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Padding(
              padding: const EdgeInsets.all(20),
              child: ListView(children: [
                Text(
                  'Id: ${snapshot.data!.id}',
                  style: TextStyle(fontSize: 20),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  'Email: ${snapshot.data!['email']}',
                  style: TextStyle(fontSize: 20),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  'Your color: ${snapshot.data!['name']}',
                  style: TextStyle(fontSize: 20),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  'User type: ${widget.user}',
                  style: TextStyle(fontSize: 20),
                )
              ]),
            );
          }
          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
