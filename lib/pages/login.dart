// ignore_for_file: must_be_immutable

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:moviesapp_zu/pages/homepage.dart';
import 'package:moviesapp_zu/providers/auth_view_model.dart';
import 'package:provider/provider.dart';

import 'signup.dart';

class Login extends StatelessWidget {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  Login({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Consumer(
          builder: (context, model, child) => SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                const SizedBox(
                  height: 20,
                ),
                Form(
                  key: _formKey,
                  child: Column(
                    children: const [
                      Text(
                        "Login",
                        style: TextStyle(
                            fontSize: 40, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 10),
                      Text("Login To Your Account"),
                      SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text("Email",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 10),
                      TextFormField(
                        controller: emailController,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Email can't be empty";
                          }
                          return null;
                        },
                        decoration: const InputDecoration(
                          enabledBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.black, width: 1.0)),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const Text("Password",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 10),
                      TextFormField(
                        obscureText: true,
                        controller: passwordController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your password';
                          }
                          return null;
                        },
                        decoration: const InputDecoration(
                          enabledBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.black, width: 1.0)),
                        ),
                      ),
                      const SizedBox(height: 40),
                      Center(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              fixedSize: const Size.fromWidth(250),
                              maximumSize: const Size.fromHeight(50),
                              primary: Colors.blue[900],
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(18.0),
                                  side: const BorderSide(color: Colors.blue))),
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              loginUser(
                                  context: context,
                                  email: emailController.text.trim(),
                                  password: passwordController.text.trim());
                            }
                            // Navigator.of(context).pushReplacement(MaterialPageRoute(
                            //     builder: (_) => AdminDashboard()));
                          },
                          child: const Text(
                            "Login",
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                        ),
                      ),
                      const SizedBox(height: 15),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            "Don't have an account?",
                            style: TextStyle(
                              fontSize: 20,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const Signup()),
                              );
                            },
                            child: const Text(
                              "Sign Up",
                               style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold
                            ),
                            ),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              const  SizedBox(height: 50,),
                GestureDetector(
                  onTap:(){Navigator.push(context, MaterialPageRoute(builder: (_)=>const HomePage()));},
                  child: Text(
                                "Continue Without Login",
                                 style: TextStyle(
                                fontSize: 30,
                                fontWeight: FontWeight.bold,
                                color: Colors.blue[900],letterSpacing: 3
                              ),
                              ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

loginUser(
    {required String email,
    required String password,
    required BuildContext context}) {
  Provider.of<AuthViewModel>(context, listen: false).signInWithEmailAndPassword(
      email: email, password: password, context: context);
}
