import 'package:colors/screens/home.dart';
import 'package:colors/screens/sign_up.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});
  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final GlobalKey<FormState> key = GlobalKey();

  var email = TextEditingController(),
      password = TextEditingController(),
      name = TextEditingController(),
      auth = FirebaseAuth.instance,
      store = FirebaseFirestore.instance,
      loading = false;

  authentication() async {
    if (!key.currentState!.validate()) {
      return;
    }
    setState(() {
      loading = true;
    });
    try {
      await auth.signInWithEmailAndPassword(
          email: email.text, password: password.text);
      await store
          .collection('users')
          .doc(auth.currentUser!.uid)
          .get()
          .then((value) {
        Navigator.pushReplacement(context, MaterialPageRoute(
          builder: (context) {
            return Home();
          },
        ));
      });
    } on FirebaseAuthException catch (e) {
      setState(() {
        loading = false;
      });

      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.message.toString())));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
          key: key,
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Sign In',
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 50,
                ),
                TextFormField(
                  validator: (value) {
                    if (value!.isEmpty || !value.contains('@')) {
                      return 'Please enter a valid email';
                    }
                    return null;
                  },
                  controller: email,
                  decoration: InputDecoration(
                      hintText: 'Email', prefixIcon: Icon(Icons.email)),
                ),
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  validator: (value) {
                    if (value!.isEmpty || !value.contains('@')) {
                      return 'Please enter a valid email';
                    }
                    return null;
                  },
                  controller: password,
                  decoration: InputDecoration(
                      hintText: 'Password', prefixIcon: Icon(Icons.password)),
                ),
                SizedBox(
                  height: 50,
                ),
                loading
                    ? CircularProgressIndicator()
                    : SizedBox(
                        height: 50,
                        width: 150,
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              shape: const StadiumBorder(),
                            ),
                            onPressed: () {
                              authentication();
                            },
                            child: Text(
                              'Sign in',
                              style: const TextStyle(
                                  color: Colors.white, fontSize: 18),
                            )),
                      ),
                TextButton(
                    onPressed: () {
                      Navigator.pushReplacement(context, MaterialPageRoute(
                        builder: (context) {
                          return SignUp();
                        },
                      ));
                    },
                    child: Text(
                      'Don\'t have account? sign Up',
                      style: TextStyle(color: Colors.black),
                    )),
              ],
            ),
          )),
    );
  }
}
