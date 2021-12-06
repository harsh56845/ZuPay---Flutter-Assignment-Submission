import 'package:flutter/material.dart';

import 'package:moviesapp_zu/providers/auth_view_model.dart';
import 'package:provider/provider.dart';

import 'login.dart';

class Signup extends StatefulWidget {
  const Signup({Key? key}) : super(key: key);

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController comfirmPasswordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  AutovalidateMode autoValidate = AutovalidateMode.disabled;
  final FocusNode _nameFocus = FocusNode();
  final FocusNode _emailFocus = FocusNode();
  final FocusNode _passwordFocus = FocusNode();
  final FocusNode _comfirmPasswordFocus = FocusNode();

   @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    comfirmPasswordController.dispose();
    _nameFocus.dispose();
    _emailFocus.dispose();
    _passwordFocus.dispose();
    _comfirmPasswordFocus.dispose();
    super.dispose();
  }

  late String pass;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
      
        body: SingleChildScrollView(
          child: Form(
            key: _formKey,
                  autovalidateMode: autoValidate,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Text(
                  "Sign Up",
                  style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 20),
                const Text("Create an account, it's free"),
                const SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.all(25.0),
                  child: Column(
                    children: [
                      const Text("Name",
                          style:
                              TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 10),
                      TextFormField(
                 controller: nameController,
                            focusNode: _nameFocus,
                            textInputAction: TextInputAction.next,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your username';
                          }
    
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
                      const Text("Email",
                          style:
                              TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 10),
                      TextFormField(  
                               controller: emailController, focusNode: _emailFocus,
                            textInputAction: TextInputAction.next,
                        validator: (value) {
                            if (value!.isEmpty) {
                              return "Email can't be Empty";
                            }
                            if (!RegExp(
                                    r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                .hasMatch(value)) {
                              return "in valiad email";
                            }
    
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
                          style:
                              TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 10),
                      TextFormField(
                        obscureText: true,
                            controller: passwordController,  focusNode: _passwordFocus,
                            textInputAction: TextInputAction.done,
                        validator: (value) {
                           pass = value!;
                          if (value.isEmpty) 
                          {
                          
                            return 'Please enter your password';
                          }
                    
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
                      const Text("Confirm Password",
                          style:
                              TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 10),
                      TextFormField(
                        obscureText: true,
                        controller: comfirmPasswordController,
                        focusNode: _comfirmPasswordFocus,
                        textInputAction: TextInputAction.done,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Re-enter your password';
                          }
                          if(value!=pass){
                              return 'Re-enter Same password';
                          }
                         
                        },
                        decoration: const InputDecoration(
                          enabledBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.black, width: 1.0)),
                        ),
                      ),
                      const SizedBox(height: 40),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            fixedSize: const Size.fromWidth(250),
                            maximumSize: const Size.fromHeight(50),
                            primary: Colors.blue[900],
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18.0),
                                side: const BorderSide(color: Colors.blue))),
                        onPressed: () {
                           if (_formKey.currentState!.validate()) {
                                signUpUser(
                                    email: emailController.text.trim(),
                                    name: nameController.text.trim(),
                                    password: passwordController.text.trim(),
                                   
                                    context: context);
                              } else {
                                setState(() {
                                  autoValidate =
                                      AutovalidateMode.onUserInteraction;
                                });
                              }
                        },
                        child: const Text(
                          "Sign up",
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                      ),
                      const SizedBox(height: 15),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text("Don't have an account?", style: TextStyle(
                              fontSize: 20,
                            
                            ),),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>  Login()),
                              );
                            },
                            child: const Text(
                              "Login",
                              style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold
                            ),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

 signUpUser(
      {required String email,
      required String password,
      required String name,
      required BuildContext context}) {
    Provider.of<AuthViewModel>(context, listen: false)
        .createUserWithEmailAndPassword(
            email: email, password: password, name: name, context: context);
  }


