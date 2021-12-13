import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import '/app/modules/config/controller/account_controller.dart';
import '/app/shared/utils/animation.dart';
import '/app/shared/utils/ui_utils.dart';

class AccountPage extends StatefulWidget {
  @override
  _AccountPageState createState() => _AccountPageState();
}

class _AccountPageState extends ModularState<AccountPage, AccountController> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    controller.init();
  }

  String? userName;
  String? userEmail;
  String? userPassword;
  bool _novaImagem = false;

  @override
  Widget build(BuildContext context) {
    return Observer(builder: (BuildContext context) {
      return Scaffold(
      appBar: AppBar(
        title: const Text('Editar seu perfil'),
      ),
      key: _scaffoldKey,
      //backgroundColor: Colors.white,
      body: controller.busy
            ? Container(
                height: MediaQuery.of(context).size.height,
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text('Aguarde enquanto os arquivos são salvos'),
                      verticalSpace(30),
                      CircularProgressIndicator(),
                    ],
                  ),
                ))
      : SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              height: MediaQuery.of(context).size.height,
              child: Stack(
                children: <Widget>[
                  backgroundImageWidget(),
                  Positioned(
                    top: 10,
                    width: MediaQuery.of(context).size.width,
                    child: Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: 50, horizontal: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          SizedBox(
                            height: 180,
                          ),
                          ((controller.userApp != null)) //  && controller.isUserEmail) 
                          ? signupFormWidget()
                          : verticalSpace(8),
                        ],
                        
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  });
  }

  ///Background image and logo
  Widget backgroundImageWidget() {
    return Positioned(
      top: -40,
      height: MediaQuery.of(context).size.height * .38,
      width: MediaQuery.of(context).size.width,
      child: FadeAnimation(
        1,
        Container(
            height: MediaQuery.of(context).size.height * .24,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Theme.of(context).accentColor,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                verticalSpace(8),
                Observer(
                  builder: (BuildContext context) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        _showUserPicture(),
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: RaisedButton(
                            onPressed: () async {
                              await controller.selectImage();
                              _novaImagem = true;
                            },
                            color: Colors.white,
                            textColor: Theme.of(context).accentColor,
                            splashColor: Colors.blue[100],
                            padding: EdgeInsets.all(15),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(25.0)),
                            child: const Text('Mudar Imagem'),
                          ),
                        ),
                      ],
                    );
                  },
                ),
                verticalSpace(10),
                Text(
                  controller.userApp!.fullName ?? 'Usuario',
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 24,
                    //color: Colors.white,
                  ),
                ),
                Text(
                  controller.userApp!.email ?? 'email',
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                    //color: Colors.white,
                  ),
                ),
              ],
            )),
      ),
    );
  }

  Widget _showUserPicture() {
    if (controller.userHasNoImageUrl) {
      if (controller.selectedImage == null) {
        return Icon(Icons.perm_identity, size: 72.0, color: Colors.white);
      } else {
        return CircleAvatar(
          //backgroundColor: Colors.white,
          radius: 50,
          child: CircleAvatar(
            radius: 48.0,
            backgroundImage: Image.file(controller.selectedImage!).image,
            //backgroundColor: Colors.white,
          ),
        );
      }
    }
    // tem imagemUrl prévia
    if (controller.selectedImage == null) {
        return CircleAvatar(
          //backgroundColor: Colors.white,
          radius: 50,
          child: CircleAvatar(
            radius: 48.0,
            backgroundImage: NetworkImage(controller.userApp!.userImageUrl!),
            //backgroundColor: Colors.white,
          ),
        );
      } else {
        return CircleAvatar(
          //backgroundColor: Colors.white,
          radius: 50,
          child: CircleAvatar(
            radius: 48.0,
            backgroundImage: Image.file(controller.selectedImage!).image,
            //backgroundColor: Colors.white,
          ),
        );
      }
    }

//Signup form Widget
  Widget signupFormWidget() {
    return FadeAnimation(
        1.7,
        Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              //color: Colors.white,
              // boxShadow: [
              //   BoxShadow(
              //     color: Color.fromRGBO(196, 135, 198, .3),
              //     blurRadius: 20,
              //     offset: Offset(0, 10),
              //   )
              // ],
              ),
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  FadeAnimation(
                      1.8,
                      Container(
                        width: MediaQuery.of(context).size.width - 100,
                        child: Text(
                          'Editar Perfil',
                          textDirection: TextDirection.ltr,
                          style: TextStyle(
                              color: Theme.of(context).accentColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 24),
                        ),
                      )),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    height: 55.0,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30.0),
                        border: Border.all(color: Theme.of(context).accentColor)),
                    child: TextFormField(
                      initialValue: controller.userApp!.fullName,
                      style: TextStyle(fontWeight: FontWeight.w600),
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        hintText: 'Nome completo',
                        hintStyle: TextStyle(
                            fontSize: 15,
                            //color: splashIndicatorColor.withOpacity(0.8),
                            ),
                        icon: Icon(Icons.person, color: Theme.of(context).accentColor),
                        border: InputBorder.none,
                      ),
                      onSaved: (String? value) {
                        //this.displayName = value;
                        userName = value;
                      },
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Por favor entre com seu nome.';
                        }
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(height: 15),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    height: 55.0,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30.0),
                        border: Border.all(color: Theme.of(context).accentColor)),
                    child: TextFormField(
                      initialValue: controller.userApp!.email,
                      style: TextStyle(fontWeight: FontWeight.w600),
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        hintText: 'Email',
                        hintStyle: TextStyle(
                            fontSize: 15,
                            //color: splashIndicatorColor.withOpacity(0.8),
                            ),
                        icon: Icon(Icons.email, color: Theme.of(context).accentColor),
                        border: InputBorder.none,
                      ),
                      onSaved: (String? value) {
                        userEmail = value;
                      },
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Por favor entre com seu email.';
                        }
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(height: 15),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    height: 55.0,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30.0),
                        border: Border.all(color: Theme.of(context).accentColor)),
                    child: TextFormField(
                      obscureText: true,
                      style: TextStyle(fontWeight: FontWeight.w600),
                      decoration: InputDecoration(
                        hintText: 'Alterar Senha',
                        hintStyle: TextStyle(
                          fontSize: 15,
                          //color: splashIndicatorColor.withOpacity(0.9),
                        ),
                        icon: Icon(Icons.lock, color: Theme.of(context).accentColor),
                        border: InputBorder.none,
                      ),
                      onSaved: (String? value) {
                        userPassword = value;
                      },
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Por favor entre com sua senha';
                        }
                        if (value.length < 6) {
                          return 'Senha precisa ter 6 ou mais caracteres';
                        }
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(height: 15),
                  FadeAnimation(
                      1.8,
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: RaisedButton(
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              _formKey.currentState!.save();
                              await controller.updateUser(
                                  name: userName,
                                  email: userEmail,
                                  password: userPassword,
                                  novaImagem: _novaImagem,
                                  );
                            }
                          },
                          color: Theme.of(context).accentColor,
                          textColor: Colors.white,
                          splashColor: Colors.blue[100],
                          padding: EdgeInsets.all(15),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25.0)),
                          child: const Text('Salvar alterações'),
                        ),
                      ),
                  ),

                      // Padding(
                      //   padding: const EdgeInsets.all(16.0),
                      //   child: RaisedButton(
                      //     onPressed: () async {
                      //     },
                      //     color: Theme.of(context).accentColor,
                      //     textColor: Colors.white,
                      //     splashColor: Colors.blue[100],
                      //     padding: EdgeInsets.all(15),
                      //     shape: RoundedRectangleBorder(
                      //         borderRadius: BorderRadius.circular(25.0)),
                      //     child: const Text('Alterar Senha'),
                      //   ),
                      // ),


                ],
              ),
            ),
          ),
        ));
  }


}
