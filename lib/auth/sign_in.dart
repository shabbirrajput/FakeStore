import 'dart:convert';

import 'package:fake_store/main.dart';
import 'package:fake_store/model/user_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final Future<SharedPreferences> _pref = SharedPreferences.getInstance();

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  void login(String email, password) async {
    try {
      Response response = await post(Uri.parse('https://reqres.in/api/login'),
          body: {'email': email, 'password': password});

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body.toString());
        print(data['token']);
        print('StatusCode------------------>${response.statusCode}');
        print('Login successfully');
      } else {
        print('responseBODY----->${response.body}');
        print('StatusCode------------------>${response.statusCode}');
        print('failed');
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Future setSP(UserModel user) async {
    final SharedPreferences sp = await _pref;

    print('object----------------> Shared_Preferences');
    sp.setString("email", user.email!);
    sp.setString("pass", user.password!);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurpleAccent,
        title: const Text('Sign In'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Text(
                  'Log-In',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 30,
                      fontWeight: FontWeight.w900,
                      fontStyle: FontStyle.normal),
                ),
              ],
            ),
            TextFormField(
              controller: emailController,
              style: const TextStyle(color: Colors.black),
              decoration: const InputDecoration(
                  filled: true,
                  fillColor: Colors.white38,
                  border: InputBorder.none,
                  hintText: 'Enter Email',
                  hintStyle: TextStyle(color: Colors.grey)),
            ),
            const SizedBox(
              height: 15,
            ),
            TextFormField(
              obscureText: true,
              controller: passwordController,
              style: const TextStyle(color: Colors.black),
              decoration: const InputDecoration(
                  filled: true,
                  fillColor: Colors.white38,
                  border: InputBorder.none,
                  hintText: 'Enter Password',
                  hintStyle: TextStyle(color: Colors.grey)),
            ),
            const SizedBox(
              height: 15,
            ),
            SizedBox(
              height: 50,
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  login(emailController.text.toString(),
                      passwordController.text.toString());
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              const MyHomePage(title: 'Fake Store')));
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.resolveWith<Color?>(
                    (Set<MaterialState> states) => Colors.deepPurpleAccent,
                  ),
                ),
                child: const Text(
                  'Sign-In',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
