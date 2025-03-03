import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/pages/auth_page/sign_up_page.dart';
import 'package:flutter_app/widgets/main_wrapper.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  late SharedPreferences logindata;
  late bool newuser;

  @override
  void initState() {
    super.initState();
    check_if_already_login();
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void check_if_already_login() async {
    logindata = await SharedPreferences.getInstance();
    String? token = logindata.getString('token');

    if (token != null) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => MainWrapper()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(top: 50),
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color.fromARGB(255, 113, 67, 128),
              Color.fromARGB(255, 201, 92, 159)
            ],
            begin: Alignment.topLeft,
            end: Alignment.topRight,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.only(left: 30),
              child: Text(
                'Log In',
                style: TextStyle(
                  fontSize: 40,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            // Form
            const SizedBox(height: 90),
            Expanded(
              child: Container(
                padding: EdgeInsets.only(top: 70, left: 30, right: 30),
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(50),
                    topRight: Radius.circular(50),
                  ),
                ),
                child: Form(
                  key: _formKey,
                  child: ListView(
                    children: <Widget>[
                      // Username
                      const Text(
                        'Username',
                        style: TextStyle(
                          fontSize: 18,
                          color: Color.fromARGB(255, 113, 67, 128),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 10),
                      TextFormField(
                        controller: _usernameController,
                        decoration: InputDecoration(
                          labelText: 'Username',
                          hintText: 'Enter your username',
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your username';
                          }
                          return null;
                        },
                      ),

                      const SizedBox(height: 20),
                      // Password
                      const Text(
                        'Password',
                        style: TextStyle(
                          fontSize: 18,
                          color: Color.fromARGB(255, 113, 67, 128),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 10),
                      TextFormField(
                        controller: _passwordController,
                        decoration: InputDecoration(
                          labelText: 'Password',
                          hintText: 'Enter your password',
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)),
                        ),
                        obscureText: true,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your password';
                          }
                          return null;
                        },
                      ),

                      const SizedBox(height: 45),
                      // Login button
                      ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            // Process login
                            loginUser();
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.all(15),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          backgroundColor: Color(0xFF65558F),
                        ),
                        child: const Text(
                          'Sign In',
                          style: TextStyle(
                              fontSize: 18,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        ),
                      ),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            'Doesn\'t have an account?',
                            style: TextStyle(
                              fontSize: 16,
                              color: Color.fromARGB(255, 80, 80, 80),
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => SignUpPage()));
                            },
                            child: const Text('Sign Up',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Color(0xFF65558F),
                                )),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String hashPassword(String password) {
    var bytes = utf8.encode(password);
    var hashed = sha256.convert(bytes);
    return hashed.toString();
  }

  Future<void> loginUser() async {
    final url = Uri.parse('http://202.44.40.179:3000/auth/login');
    String username = _usernameController.text;
    String password = _passwordController.text;

    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'username': username,
        'password': hashPassword(password), // แฮชพาสเวิร์ดก่อนส่ง
      }),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      String token = data['token'];
      print('JWT Token: $token');

      // Save the token in SharedPreferences
      logindata = await SharedPreferences.getInstance();
      logindata.setString('token', token);

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => MainWrapper()),
      );
    } else {
      print('ล็อกอินล้มเหลว: ${response.body}');
    }
  }
}
