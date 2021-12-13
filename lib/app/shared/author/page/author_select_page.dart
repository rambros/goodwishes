import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

import '/app/shared/author/controller/author_add_controller.dart';
import '/app/shared/user/user_app_model.dart';
import '/app/shared/utils/color.dart';
import '/app/shared/utils/ui_utils.dart';

class AuthorSelectPage extends StatefulWidget {
  final UserApp? author;
  const AuthorSelectPage({Key? key, this.author}) : super(key: key);

  @override
  _AuthorSelectPageState createState() => _AuthorSelectPageState();
}

class _AuthorSelectPageState
    extends ModularState<AuthorSelectPage, AuthorAddController> {
  final GlobalKey<FormBuilderState> _fbKey = GlobalKey<FormBuilderState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //backgroundColor: Colors.blueAccent,
        title: Text('Selecionar Usuário'),
      ),
      body: Observer(builder: (BuildContext context) {
        return SingleChildScrollView(
            child: controller.isAuthorSelected == false
                ? Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30.0),
                    child: Column(
                      children: <Widget>[
                        verticalSpace(24.0),
                        Text('Selecione Usuário'),
                        FormBuilder(
                          key: _fbKey,
                          initialValue: {
                            'email': '',
                          },
                          autovalidateMode: AutovalidateMode.always,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              verticalSpace(16.0),
                              FormBuilderTextField(
                                name: 'email',
                                decoration: InputDecoration(
                                  labelText: 'Email do usuário',
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                ),
                                validator: FormBuilderValidators.compose([
                                  FormBuilderValidators.email(context,
                                    errorText:
                                        'A pesquisa exige um email válido',
                                  ),
                                ]),
                              ),
                              verticalSpaceSmall,
                            ],
                          ),
                        ),
                        Row(
                          children: <Widget>[
                            Expanded(
                              child: MaterialButton(
                                color: Theme.of(context).colorScheme.secondary,
                                child: Text(
                                  'Pesquisar',
                                  style: TextStyle(color: Colors.white),
                                ),
                                onPressed: () {
                                  _fbKey.currentState!.save();
                                  if (_fbKey.currentState!.validate()) {
                                    print(_fbKey.currentState!.value);
                                    var form = _fbKey.currentState!.value;
                                    controller.selectAuthor(
                                      email: form['email'],
                                    );
                                  } else {
                                    print('validation failed');
                                  }
                                },
                              ),
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            Expanded(
                              child: MaterialButton(
                                color: Theme.of(context).colorScheme.secondary,
                                child: Text(
                                  'Reset',
                                  style: TextStyle(color: Colors.white),
                                ),
                                onPressed: () {
                                  _fbKey.currentState!.reset();
                                  controller.clearUser();
                                },
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  )
                : Observer(
                    builder: (BuildContext context) {
                      return Column(children: <Widget>[
                        _listUser(controller.author!),
                        _formChangeUserRole(),
                      ]);
                    },
                  ));
      }),
    );
  }

  Widget _listUser(UserApp author) {
    return Container(
      margin: const EdgeInsets.only(left: 0, right: 0, bottom: 0.0, top: 16.0),
      height: 120,
      decoration: BoxDecoration(
          //color: Colors.white,
          //borderRadius: BorderRadius.circular(5),
          //boxShadow: [
          //  BoxShadow(blurRadius: 8, color: Colors.grey[200], spreadRadius: 3)
          //],
          ),
      alignment: Alignment.center,
      child: Material(
        borderRadius: BorderRadius.circular(6.0),
        elevation: 0.2,
        child: Container(
          height: 96.0,
          child: Row(
            //crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Expanded(
                  child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Hero(
                      tag: author.email!,
                      child: author.userImageUrl != null
                          ? CircleAvatar(
                              backgroundColor: Colors.white,
                              radius: 32,
                              child: CircleAvatar(
                                radius: 32.0,
                                backgroundImage:
                                    NetworkImage(author.userImageUrl!),
                                backgroundColor: Colors.white,
                              ),
                            )
                          : Container(
                              child: Icon(Icons.perm_identity,
                                  size: 64.0, color: primaryColor),
                            ),
                    ),
                    Flexible(
                      child: Container(
                        margin: EdgeInsets.only(
                            left: 10, right: 10, bottom: 5.0, top: 5.0),
                        child:
                            Column(crossAxisAlignment: CrossAxisAlignment.start,
                                //mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                              //verticalSpace(2),
                              Text(
                                author.fullName!,
                                maxLines: 1,
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14,
                                ),
                              ),
                              verticalSpace(2),
                              Text(
                                author.email!,
                                maxLines: 1,
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14,
                                ),
                              ),
                              Text(
                                'Perfil: ${author.userRole}',
                                maxLines: 1,
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14,
                                ),
                              ),
                            ]),
                      ),
                    ),
                  ],
                ),
              )),
              // Column(
              //     children: <Widget>[
              //       Expanded(
              //         child: IconButton(
              //           icon: Icon(
              //             Icons.edit,
              //           ),
              //           onPressed: () {}//=> controller.editAuthor(author),
              //         ),
              //       ),
              //     ],
              //   ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _formChangeUserRole() {
    final _fbKeyUR = GlobalKey<FormBuilderState>();
    return FormBuilder(
          key: _fbKeyUR,
          child: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.fromLTRB(24, 0, 16, 8),
            child: FormBuilderRadioGroup(
              decoration: InputDecoration(
                labelText: 'Alterar perfil para',
                focusColor: primaryColor,
                labelStyle: TextStyle(color: Colors.black, fontSize: 20),
                border: InputBorder.none,
                contentPadding: EdgeInsets.all(4),
              ),
              name: 'userRole',
              initialValue: controller.author!.userRole,
              //leadingInput: true,
              options: [
                FormBuilderFieldOption(
                  value: kRoleUser,
                  child: Text('Usuário - acesso apenas de leitura'),
                ),
                FormBuilderFieldOption(
                  value: kRoleAuthor,
                  child: Text('Autor - Torna o usuário um Autor'),
                ),
                FormBuilderFieldOption(
                  value: kRoleAdmin,
                  child: Text('Administrador - cuidado. Acesso total!'),
                ),
              ],
            ),
          ),
          Row(children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: MaterialButton(
                color: Theme.of(context).colorScheme.secondary,
                child: Text(
                  'Confirmar alteração de perfil',
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () {
                  _fbKeyUR.currentState!.save();
                  if (_fbKeyUR.currentState!.validate()) {
                    //print(_fbKeyUR.currentState.value);
                    var form = _fbKeyUR.currentState!.value;
                    controller.changeUserRole(
                      form['userRole'],
                    );
                  } else {
                    print('validation failed');
                  }
                },
              ),
            ),
          ])
        ],
      ),
    );
  }
}
