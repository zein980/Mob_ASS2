// ignore_for_file: sized_box_for_whitespace, prefer_const_constructors

import 'package:ass2/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'cubit.dart';
import 'login.dart';

class signUp extends StatelessWidget {
  var name = TextEditingController();
  var Age = TextEditingController();
  var email = TextEditingController();
  var password = TextEditingController();
  var formKey = GlobalKey<FormState>();
  bool found = false;
  bool obText = true;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<cubit_App, states_App>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
            body: Padding(
              padding: const EdgeInsets.all(15),
              child: Center(
                child: Form(
                  key: formKey,
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          "im/sticker-online-sign-up-button-click-on-white-vector-38556452.jpg",
                          height: 150.0,
                          width: 150.0,
                        ),
                        const SizedBox(
                          height: 40,
                        ),
                        const Text(
                          "Sign Up",
                          style: TextStyle(
                              fontSize: 40,
                              fontWeight: FontWeight.bold,
                              color: Colors.deepPurple),
                        ),
                        const SizedBox(
                          height: 40,
                        ),
                        TextFormField(
                          controller: name,
                          validator: (value) {
                            if (value!.isEmpty || value.length < 2) {
                              return " name is small";
                            }
                          },
                          keyboardType: TextInputType.name,
                          decoration: const InputDecoration(
                              label: Text("name"),
                              border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(25)))),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        TextFormField(
                          controller: Age,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Age is required";
                            }
                          },
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                              label: Text("Age"),
                              border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(25)))),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        TextFormField(
                          controller: email,
                          validator: (value) {
                            if (value!.isEmpty ||
                                value.endsWith("@gmail.com") == false ||
                                value.indexOf("@gmail.com") != 8) {
                              return "Email required include  id@gmail.com ";
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
                          height: 30,
                        ),
                        TextFormField(
                          obscureText: obText,
                          controller: password,
                          validator: (value) {
                            if (value!.length < 8) {
                              return " password should be at least 8 characters ";
                            }
                          },
                          keyboardType: TextInputType.visiblePassword,
                          decoration: InputDecoration(
                              label: Text("password"),
                              border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(25)))),
                        ),
                        const SizedBox(
                          height: 30,
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
                                        password.text == element["password"]) {
                                      found = true;
                                    }
                                  });
                                  if (found == false) {
                                    cubit_App.get(context).insert_data_SignUp(
                                        name: name.text,
                                        email: email.text,
                                        password: password.text,
                                        Age: Age.text);
                                    cubit_App.get(context).get_data_signUp();
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(const SnackBar(
                                      content: Text("تم تسجيل الحساب"),
                                    ));
                                  } else {
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(const SnackBar(
                                      content: Text("الحساب موجود مسبقا "),
                                    ));
                                  }
                                }
                              },
                              child: Text(
                                "Sign Up",
                                style: TextStyle(
                                    color: Colors.white,
                                  fontSize: 20,
                                ),
                              )),
                        ),
                        const SizedBox(height: 20.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                                "Already Have an account?",
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
                                          login(),
                                    ),
                                  );
                                },
                                child: Text(
                                  "Login",
                                  style: TextStyle(
                                      color: Colors.deepPurple,
                                    fontSize: 15,
                                  ),
                                ))
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        });
  }
}
