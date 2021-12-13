import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '/app/modules/autentica/controller/sign_in_controller.dart';
import '/app/modules/autentica/util/icons_data.dart';

import 'forgot_password_page.dart';

class SignInPage extends StatefulWidget {
  SignInPage({Key? key}) : super(key: key);

  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends ModularState<SignInPage, SignInController> {
  bool offsecureText = true;
  Icon lockIcon = LockIcon().lock;
  var emailCtrl = TextEditingController();
  var passCtrl = TextEditingController();

  var formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  String? email;
  String? pass;

  void lockPressed() {
    if (offsecureText == true) {
      setState(() {
        offsecureText = false;
        lockIcon = LockIcon().open;
      });
    } else {
      setState(() {
        offsecureText = true;
        lockIcon = LockIcon().lock;
      });
    }
  }

    @override
  void initState() {
    controller.init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey, 
        //backgroundColor: Colors.white, 
        body: signInUI());
  }

  Widget signInUI() {
    return Form(
      key: formKey,
      child: Padding(
        padding: const EdgeInsets.only(left: 30, right: 30, bottom: 0),
        child: ListView(
          children: <Widget>[
            SizedBox(
              height: 20,
            ),
            Container(
              alignment: Alignment.centerLeft,
              width: double.infinity,
              child: IconButton(
                  alignment: Alignment.centerLeft,
                  padding: EdgeInsets.all(0),
                  icon: Icon(Icons.keyboard_backspace),
                  onPressed: () {
                    Navigator.pop(context);
                  }),
            ),
            Text('Login',
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.w900)),
            // Text('Siga estes passos simples',
            //     style: TextStyle(
            //         fontSize: 14,
            //         fontWeight: FontWeight.w500,
            //         color: Colors.grey)),
            SizedBox(
              height: 80,
            ),
            TextFormField(
              decoration: InputDecoration(
                  hintText: 'name@mail.com',
                  //prefixIcon: Icon(Icons.email),
                  labelText: 'Email'),
              controller: emailCtrl,
              keyboardType: TextInputType.emailAddress,
              validator: (String? value) {
                if (value!.isEmpty) return 'Email is necessary to access app';
                return null;
              },
              onChanged: (String value) {
                setState(() {
                  email = value;
                });
              },
            ),
            SizedBox(
              height: 20,
            ),
            TextFormField(
              obscureText: offsecureText,
              controller: passCtrl,
              decoration: InputDecoration(
                labelText: 'Password',
                hintText: 'Input your password',
                //prefixIcon: Icon(Icons.vpn_key),
                suffixIcon: IconButton(
                    icon: lockIcon,
                    onPressed: () {
                      lockPressed();
                    }),
              ),
              validator: (String? value) {
                if (value!.isEmpty) return "Password can't be empty";
                return null;
              },
              onChanged: (String value) {
                setState(() {
                  pass = value;
                });
              },
            ),
            SizedBox(
              height: 50,
            ),
            Container(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () {
                  //nextScreen(context, ForgotPasswordPage());
                  Navigator.push(
                      context,
                      CupertinoPageRoute(
                          builder: (context) => ForgotPasswordPage()));
                },
                child: Text(
                  'Forgot your password?',
                  style: TextStyle(
                    fontSize: 16,
                    //color: Theme.of(context).primaryColorDark,
                    color: Colors.grey,
                    ),
                ),
              ),
            ),
            Observer(
              builder: (BuildContext context) { 
                return Container(
                  height: 45,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Theme.of(context).accentColor, // background
                      onPrimary: Colors.grey[900], // foreground
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))
                    ),
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        formKey.currentState!.save();
                        FocusScope.of(context).requestFocus(FocusNode());
                        controller.handleSignInwithEmailPassword(
                            email: email, pass: pass);
                      };
                    },
                    child: controller.signInStart == false
                        ? Text(
                            'Login',
                            style: TextStyle(fontSize: 16, 
                               //color: Colors.white,
                               ),
                          )
                        : controller.signInComplete == false
                            ? CircularProgressIndicator()
                            : Text('Login completed with success!',
                                style:
                                    TextStyle(fontSize: 16, color: Colors.white)),
                  ),
                );
              },
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text("Don't have an account?"),
                TextButton(
                  onPressed: () {
                    Modular.to.pushReplacementNamed('/login/signup');
                  },
                  child: Text('Sign up',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey[500],
                        //color: Theme.of(context).primaryColorDark,
                        ),
                    ),
                )
              ],
            ),
            SizedBox(
              height: 50,
            ),
          ],
        ),
      ),
    );
  }
}
