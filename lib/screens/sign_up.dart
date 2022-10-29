import 'package:colors/screens/home.dart';
import 'package:colors/screens/sign_in.dart';
import 'package:colors/screens/sign_up.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});
  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final GlobalKey<FormState> key = GlobalKey();

  var email = TextEditingController(),
      password = TextEditingController(),
      name = TextEditingController(),
      auth = FirebaseAuth.instance,
      store = FirebaseFirestore.instance,
      loading = false,
      dropValue = 'red';

  authentication() async {
    if (!key.currentState!.validate()) {
      return;
    }
    setState(() {
      loading = true;
    });
    try {
      await auth.createUserWithEmailAndPassword(
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

      await store.collection('users').doc(auth.currentUser!.uid).set(
          {'name': dropValue, 'email': email.text, 'password': password.text});
      // ignore: use_build_context_synchronously

      setState(() {
        loading = false;
      });
      // ignore: use_build_context_synchronously

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
                  'Sign Up',
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
                    if (value!.isEmpty || value.length < 7) {
                      return 'Password should at least 6 characters';
                    }
                    return null;
                  },
                  controller: password,
                  decoration: InputDecoration(
                      hintText: 'Password', prefixIcon: Icon(Icons.password)),
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Pick your color:'),
                    DropdownButton(
                      value: dropValue,
                      hint: Text('pick the color'),
                      items: <String>['red', 'blue', 'green', 'mix color']
                          .map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          dropValue = value!;
                        });
                      },
                    ),
                  ],
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
                              'Sign up',
                              style: const TextStyle(
                                  color: Colors.white, fontSize: 18),
                            )),
                      ),
                TextButton(
                    onPressed: () {
                      Navigator.pushReplacement(context, MaterialPageRoute(
                        builder: (context) {
                          return SignIn();
                        },
                      ));
                    },
                    child: Text(
                      'Already have account? sign In',
                      style: TextStyle(color: Colors.black),
                    )),
              ],
            ),
          )),
    );
  }
}
