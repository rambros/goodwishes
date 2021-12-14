import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '/app/modules/autentica/controller/sign_up_controller.dart';
import '/app/modules/autentica/util/icons_data.dart';
import '/app/shared/utils/ui_utils.dart';

class SignUpPage extends StatefulWidget {
  SignUpPage({Key? key}) : super(key: key);

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends ModularState<SignUpPage, SignUpController> {
  bool offsecureText = true;
  Icon lockIcon = LockIcon().lock;
  var emailCtrl = TextEditingController();
  var passCtrl = TextEditingController();
  var nameCtrl = TextEditingController();
  var formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  String? email;
  String? pass;
  String? name;
  bool? privacyConsent = false;

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
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey, 
        body: signUpUI());
  }

  Widget signUpUI() {
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
            Text('Create an account',
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.w900)),
            SizedBox(
              height: 30,
            ),
            TextFormField(
              controller: nameCtrl,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                labelText: 'Name',
                hintText: 'Enter with name',
                //prefixIcon: Icon(Icons.person)
              ),
              validator: (String? value) {
                if (value!.isEmpty) return "Name can't be empty";
                return null;
              },
              onChanged: (String value) {
                setState(() {
                  name = value;
                });
              },
            ),
            SizedBox(
              height: 20,
            ),
            TextFormField(
              decoration: InputDecoration(
                hintText: 'name@mail.com',
                labelText: 'Email',
                //prefixIcon: Icon(Icons.email)
              ),
              controller: emailCtrl,
              keyboardType: TextInputType.emailAddress,
              validator: (String? value) {
                if (value!.isEmpty) return "Email can't be empty";
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
              controller: passCtrl,
              obscureText: offsecureText,
              decoration: InputDecoration(
                labelText: 'Password',
                hintText: 'Enter a password',
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
              height: 20,
            ),

            Padding(
                  padding: EdgeInsets.all(4),
                  child: Row(
                    children: <Widget>[
                        Checkbox(
                        value: privacyConsent,
                        onChanged: (bool? newValue) {
                            setState(() {
                              privacyConsent = newValue;
                            });
                        },),
                      Expanded(
                        child: RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: 'I read and agree with ',
                                style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.grey)
                              ),
                              TextSpan(
                                text: 'Privacy Policy',
                                style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.blueAccent,
                                      decoration: TextDecoration.underline,
                                ),
                                recognizer: TapGestureRecognizer()
                                     ..onTap = () {
                                      Modular.to.pushReplacementNamed('/privacy');
                                },
                              ),
                            ],),
                        ),
                      ),
                    
                    ],
                  ),
                ),

            verticalSpace(24),
            Observer(
              builder: (BuildContext context) {
                return Container(
                  height: 45,
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Theme.of(context).colorScheme.secondary,// background
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))
                    ),
                    //color: Theme.of(context).accentColor, //Colors.deepPurpleAccent,
                    onPressed: () {
                      if (privacyConsent == false) {
                              controller.validatePrivacyConsent(privacyConsent);
                      } else if (formKey.currentState!.validate()) {
                        formKey.currentState!.save();
                        FocusScope.of(context).requestFocus(FocusNode());
                        controller.handleSignUpwithEmailPassword(
                            name: name, email: email, pass: pass);
                      }
                    },
                    child: controller.signUpStarted == false
                        ? Text(
                            'Register',
                            style: TextStyle(fontSize: 16, 
                                  //color: Colors.white,
                               ),
                          )
                        : controller.signUpCompleted == false
                            ? CircularProgressIndicator()
                            : Text('Account created with success!',
                                style: TextStyle(
                                    fontSize: 16, color: Colors.white)),//Theme.of(context).accentColor
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
                Text('Have an account?'),
                TextButton(
                  onPressed: () {
                    Modular.to.pushReplacementNamed('/login/signin');
                  },
                  child: Text(
                    'Login',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
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



