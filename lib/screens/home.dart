import 'package:colors/screens/sign_in.dart';
import 'package:colors/screens/view.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:new_gradient_app_bar/new_gradient_app_bar.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Color> color = [Colors.red];
  var radio = 'admin',
      loading = false,
      auth = FirebaseAuth.instance,
      store = FirebaseFirestore.instance;

  getData() async {
    await store
        .collection('users')
        .doc(auth.currentUser!.uid)
        .get()
        .then((value) {
      setState(() {
        loading = true;
        switch (value['name']) {
          case 'red':
            color = [Colors.red, Colors.red];
            break;
          case 'blue':
            color = [Colors.blue, Colors.blue];
            break;
          case 'green':
            color = [Colors.green, Colors.green];
            break;
          default:
            color = [Colors.yellow, Colors.red];
            break;
        }
      });
    });
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: NewGradientAppBar(
        leading: IconButton(
          icon: Icon(Icons.power_settings_new),
          onPressed: () {
            auth.signOut();
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => SignIn(),
                ));
          },
        ),
        title: Text('Home'),
        gradient: LinearGradient(colors: color),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Text(
              'Choice your type?',
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(
              height: 20,
            ),
            RadioListTile(
              title: Text('Admin'),
              value: 'Admin',
              groupValue: radio,
              onChanged: (value) {
                setState(() {
                  radio = value!;
                });
                print(color);
              },
            ),
            RadioListTile(
              title: Text('Normal user'),
              value: 'Normal user',
              groupValue: radio,
              onChanged: (value) {
                setState(() {
                  radio = value!;
                });
              },
            ),
            SizedBox(
              height: 50,
            ),
            SizedBox(
              height: 50,
              width: 150,
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: color[0],
                    shape: const StadiumBorder(),
                  ),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ViewScreen(
                            user: radio,
                            color: color,
                          ),
                        ));
                  },
                  child: Text(
                    'Submit',
                    style: const TextStyle(color: Colors.white, fontSize: 18),
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
