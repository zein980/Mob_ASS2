import 'dart:math';

import 'package:ass2/sign_up.dart';
import 'package:ass2/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'cubit.dart';
import 'home_screen.dart';

class login extends StatelessWidget {
  var email = TextEditingController();
  var password = TextEditingController();
  var formKey = GlobalKey<FormState>();
  var scafoldKey = GlobalKey<ScaffoldState>();
  bool find = false;
  bool obstext = true;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<cubit_App, states_App>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
            key: scafoldKey,
            body: SafeArea(
                child: Center(
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: SingleChildScrollView(
                  child: Form(
                    key: formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          "im/38696043-login-purple-square-button.jpg",
                          height: 150.0,
                          width: 150.0,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        const Text(
                          "Login",
                          style: TextStyle(
                              fontSize: 40,
                              fontWeight: FontWeight.bold,
                              color: Colors.deepPurple),
                        ),
                        const SizedBox(
                          height: 80,
                        ),
                        TextFormField(
                          controller: email,
                          validator: (value) {
                            if (value!.isEmpty ||
                                value.endsWith("@gmail.com") == false ||
                                value.indexOf("@gmail.com") != 8) {
                              return "Email required include id@gmail.com ";
                            }
                          },
                          keyboardType: TextInputType.emailAddress,
                          decoration: const InputDecoration(
                              label: Text("Email"),
                              border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(25)))),
                        ),
                        const SizedBox(
                          height: 50,
                        ),
                        TextFormField(
                          obscureText: obstext,
                          controller: password,
                          validator: (value) {
                            if (value!.length < 8) {
                              return " password very Small ";
                            }
                          },
                          keyboardType: TextInputType.visiblePassword,
                          decoration: InputDecoration(
                              suffixIcon: IconButton(
                                  onPressed: () {
                                    obstext == true
                                        ? obstext = false
                                        : obstext = true;
                                  },
                                  icon: const Icon(Icons.remove_red_eye)),
                              label: const Text("password"),
                              border: const OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(25)))),
                        ),
                        const SizedBox(
                          height: 40,
                        ),
                        Container(
                            width: 200,
                            child: ElevatedButton(
                                style: ButtonStyle(
                                    backgroundColor:
                                        MaterialStateProperty.all(Colors.deepPurple),
                                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(30.0),
                                    ),
                                  ),
                                ),
                                onPressed: () {
                                  if (formKey.currentState!.validate()) {
                                    cubit_App
                                        .get(context)
                                        .signUp_data
                                        .forEach((element) {
                                      if (email.text == element["email"] &&
                                          password.text ==
                                              element["password"]) {
                                        find = true;
                                      }
                                    });
                                    if (find == true) {
                                      Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute<void>(
                                          builder: (BuildContext context) =>
                                              const home_screen(),
                                        ),
                                      );
                                      Fluttertoast.showToast(
                                          msg: "Login Successfuly",
                                          toastLength: Toast.LENGTH_SHORT,
                                          gravity: ToastGravity.CENTER,
                                          timeInSecForIosWeb: 1,
                                          backgroundColor: Colors.deepPurple,
                                          textColor: Colors.white,
                                          fontSize: 16.0);
                                    } else {
                                      Fluttertoast.showToast(
                                          msg: "Fail Login",
                                          toastLength: Toast.LENGTH_SHORT,
                                          gravity: ToastGravity.CENTER,
                                          timeInSecForIosWeb: 1,
                                          backgroundColor: Colors.deepPurple,
                                          textColor: Colors.white,
                                          fontSize: 16.0);
                                    }
                                  }
                                },
                                child: const Text(
                                    "Login",
                                    style: TextStyle(
                                        color: Colors.white
                                    )
                                )
                            )
                        ),
                        const SizedBox(height: 20.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              "Don't Have an account?",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 15,
                              ),
                            ),
                            TextButton(
                                onPressed: () {
                                  Navigator.push<void>(
                                    context,
                                    MaterialPageRoute<void>(
                                      builder: (BuildContext context) =>
                                          signUp(),
                                    ),
                                  );
                                },
                                child: const Text("Sign Up",
                                    style: TextStyle(
                                      color: Colors.deepPurple,
                                      fontSize: 15,
                                    )))
                          ],
                        ),
                        const SizedBox(
                          height: 100,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            )),
          );
        });
  }
}
