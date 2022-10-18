// import 'dart:html';

import 'package:flutter/material.dart';
import 'package:my_app/utils/routes.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String name = "";
  bool changeBtn = false;
  @override
  Widget build(BuildContext context) {
    return Material(
      // child: Center(
      //   child: Text(
      //     "Login page",
      //     style: TextStyle(
      //         fontSize: 40, color: Colors.blue, fontWeight: FontWeight.bold),
      //   ),
      // ),
      color: Colors.white,
      child: SingleChildScrollView(
        child: Column(
          children: [
            Image.asset(
              "assets/images/login_image.png",
              fit: BoxFit.cover,
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              "Welcome $name",
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              // padding: const EdgeInsets.all(16.0),
              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 32),
              child: Column(
                children: [
                  TextFormField(
                    decoration: InputDecoration(
                        hintText: "Enter Username", labelText: "Username"),
                    onChanged: (value) => {name = value, setState(() {})},
                  ),
                  TextFormField(
                    obscureText: true,
                    decoration: InputDecoration(
                        hintText: "Enter Password", labelText: "Password"),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  InkWell(
                    onTap: () async {
                      setState(() {
                        changeBtn = true;
                      });
                      await Future.delayed(Duration(seconds: 1));
                      Navigator.pushNamed(context, MyRoutes.homeRoute);
                    },
                    child: AnimatedContainer(
                      duration: Duration(seconds: 1),
                      width: changeBtn ? 50 : 150,
                      height: 50,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        // shape: changeBtn ? BoxShape.circle : BoxShape.rectangle,
                        color: Colors.deepPurple,
                        borderRadius: BorderRadius.circular(changeBtn ? 50 : 0),
                      ),
                      child: changeBtn
                          ? Icon(
                              Icons.done,
                              color: Colors.white,
                            )
                          : Text(
                              "Login",
                              style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                    ),
                  )
                  // ElevatedButton(
                  //     style: TextButton.styleFrom(minimumSize: Size(150, 30)),
                  //     onPressed: () {
                  //       Navigator.pushNamed(context, MyRoutes.homeRoute);
                  //     },
                  //     child: Text(
                  //       "Login",
                  //       style: TextStyle(color: Colors.white),
                  //     ))
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
