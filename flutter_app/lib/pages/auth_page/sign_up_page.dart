import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_app/pages/auth_page/login_page.dart';
import 'package:http/http.dart' as http;
import 'package:crypto/crypto.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _cfpasswordController = TextEditingController();

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
                'Sign Up',
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
                  child: ListView(children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        // Email
                        const SizedBox(height: 10),
                        TextFormField(
                          controller: _emailController,
                          decoration: InputDecoration(
                            labelText: 'Email',
                            hintText: 'Enter your Email',
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10)),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your email';
                            }
                            return null;
                          },
                        ),

                        const SizedBox(height: 20),
                        // Username
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

                        // Confirm Password
                        const SizedBox(height: 20),
                        TextFormField(
                          controller: _cfpasswordController,
                          decoration: InputDecoration(
                            labelText: 'Confirm Password',
                            hintText: 'Enter your password',
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10)),
                          ),
                          obscureText: true,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your password';
                            }
                            if (value != _passwordController.text) {
                              return 'Password does not match';
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
                              registerUser();
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
                            'Sign Up',
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
                              'Does have an account?',
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
                                        builder: (context) => LoginPage()));
                              },
                              child: const Text('Log In',
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Color(0xFF65558F),
                                  )),
                            )
                          ],
                        )
                      ],
                    ),
                  ]),
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

  Future<void> registerUser() async {
    final url = Uri.parse('http://202.44.40.179:3000/auth/register');
    String email = _emailController.text;
    String username = _usernameController.text;
    String password = _passwordController.text;

    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'username': username,
        'password': hashPassword(password), // แฮชพาสเวิร์ดก่อนส่ง
        'email': email,
      }),
    );

    if (response.statusCode == 201) {
      print('ลงทะเบียนสำเร็จ');
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => LoginPage()));
    } else {
      print('เกิดข้อผิดพลาด: ${response.body}');
    }
  }
}
