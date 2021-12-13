import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '/app/modules/autentica/controller/forget_password_controller.dart';

class ForgotPasswordPage extends StatefulWidget {
  ForgotPasswordPage({Key? key}) : super(key: key);

  @override
  _ForgotPasswordPageState createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends ModularState<ForgotPasswordPage, ForgetPasswordController> {

  var formKey = GlobalKey<FormState>();
  var scaffoldKey = GlobalKey<ScaffoldState>();
  var emailCtrl = TextEditingController();
  late String email;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: scaffoldKey,
        body: Form(
            key: formKey,
            child: Padding(
            padding: const EdgeInsets.only(left: 30, right: 30, bottom: 0),
            child: ListView(
              children: <Widget>[
                
                SizedBox(height: 20,),
                Container(
                  alignment: Alignment.centerLeft,
                  width: double.infinity,
                  child: IconButton(
                    alignment: Alignment.centerLeft,
                    padding: EdgeInsets.all(0),
                    icon: Icon(Icons.keyboard_backspace), 
                    onPressed: (){
                      Navigator.pop(context);
                      
                    }),
                ),
                Text('Reset Password', style: TextStyle(
                  fontSize: 25, fontWeight: FontWeight.w700
                )),
                // Text('Siga estes passos simples', style: TextStyle(
                //   fontSize: 14, fontWeight: FontWeight.w500, color: Colors.grey
                // )),
                SizedBox(
                  height: 50,
                ),
                
                TextFormField(
                  decoration: InputDecoration(
                    hintText: 'name@mail.com',
                    labelText: 'Email'
                    
                  ),
                  controller: emailCtrl,
                  keyboardType: TextInputType.emailAddress,
                  validator: (String? value){
                    if (value!.isEmpty ) return "Email can't be empty";
                    return null;
                  },
                  onChanged: (String value){
                    setState(() {
                      email = value;
                    });
                  },
                ),
                SizedBox(height: 80,),
                Container(
                  height: 45,
                  width: double.infinity,
                  child: RaisedButton(
                    color: Theme.of(context).accentColor,
                    child: Text('Submit', style: TextStyle(
                      fontSize: 16, color: Colors.white
                    ),),
                    onPressed: (){
                          if(formKey.currentState!.validate()){
                              formKey.currentState!.save();
                              controller.resetPassword(email);
                          };
                  }),
                ),
                SizedBox(height: 50,),
                
               
                
              ],
            ),
          ),
        ),
      
    );
  }
}