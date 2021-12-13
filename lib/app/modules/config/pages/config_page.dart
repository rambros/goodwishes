import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '/app/shared/services/user_service.dart';
import '/app/shared/utils/ui_utils.dart';
import '../controller/account_controller.dart';

class ConfigPage extends StatefulWidget {
  const ConfigPage({
    Key? key,
  }) : super(key: key);

  @override
  _ConfigPageState createState() => _ConfigPageState();
}

class _ConfigPageState extends ModularState<ConfigPage, AccountController> {
  final _userService = Modular.get<UserService>();

  @override
  void initState() {
    super.initState();
    controller.init();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  AppBar(
        title: const Text('Configurações do App'),
      ),
               //HomeAppBar(context: context, title: 'Configurações'),
      body: controller.busy
          ? Container(
              height: MediaQuery.of(context).size.height,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text('Aguarde enquanto os arquivos são salvos'),
                    verticalSpace(16),
                    CircularProgressIndicator(),
                  ],
                ),
              ),
            )
          : Container(
              child: ListView(
                children: <Widget>[
                  Container(
                      height: MediaQuery.of(context).size.height * .15,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.secondary,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          //verticalSpace(8),
                          // controller.userHasNoImageUrl
                          //     ? Icon(Icons.perm_identity,
                          //         size: 72.0, color: Colors.white)
                          //     : CircleAvatar(
                          //         backgroundColor: Colors.white,
                          //         radius: 52,
                          //         child: CircleAvatar(
                          //           radius: 50.0,
                          //           backgroundImage: NetworkImage(
                          //               controller.user.userImageUrl),
                          //           backgroundColor: Colors.white,
                          //         ),
                          //       ),
                          //_showUserPicture(),
                          //verticalSpace(10),
                          Text(
                            _userService.currentUser!.fullName ?? 'Usuario',
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 24,
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            _userService.currentUser!.email ?? 'email',
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 16,
                              color: Colors.white,
                            ),
                          ),

                          // Padding(
                          //   padding: const EdgeInsets.only(right: 18.0),
                          //   child: Align(
                          //       alignment: Alignment.bottomRight,
                          //       child: GestureDetector(
                          //         child: ClipOval(
                          //             child: Container(
                          //               width: 35,
                          //                 height: 35,
                          //                 color: Colors.black,
                          //                 child: Icon(
                          //                   Icons.edit,
                          //                   color: Colors.white,
                          //                 ),
                          //                 )),
                          //         onTap: () {
                          //         },
                          //       )),
                          // ),
                        ],
                      )),
                  if ((controller.userApp != null) // && controller.isUserEmail) 
                           || (_userService.isUserAdmin))
                    ...[ListTile(
                        leading: Icon(Icons.portrait,
                            color: Theme.of(context).colorScheme.secondary),
                        trailing: Icon(Icons.navigate_next,
                            color: Theme.of(context).colorScheme.secondary, size: 28),
                        title: Text('Editar seu Perfil'),
                        onTap: () {
                          Modular.to.pushNamed('/account');
                        }),
                        //Divider(),
                        ],
                  ListTile(
                      leading: Icon(Icons.share,
                          color: Theme.of(context).colorScheme.secondary),
                      trailing: Icon(Icons.navigate_next,
                          color: Theme.of(context).colorScheme.secondary, size: 28),
                      title: Text('Convide seus amigos'),
                      onTap: () {
                        Modular.to.pushNamed('/invite');
                      }),
                  ListTile(
                      leading: Icon(Icons.star_border,
                          color: Theme.of(context).colorScheme.secondary),
                      trailing: Icon(Icons.navigate_next,
                          color: Theme.of(context).colorScheme.secondary, size: 28),
                      title: Text('Avalie o MeditaBK'),
                      onTap: () {
                        Modular.to.pushNamed('/avaliar');
                      }),    
                  ListTile(
                      leading: Icon(Icons.alarm,
                          color: Theme.of(context).colorScheme.secondary),
                      trailing: Icon(Icons.navigate_next,
                          color: Theme.of(context).colorScheme.secondary, size: 28),
                      title: Text('Lembretes para meditar'),
                      onTap: () {
                        Modular.to.pushNamed('/alarm');
                      }),
                 // Divider(),
                  _userService.isUserAdmin
                      ? ListTile(
                          leading: Icon(Icons.category,
                              color: Theme.of(context).colorScheme.secondary),
                          trailing: Icon(Icons.navigate_next,
                              color: Theme.of(context).colorScheme.secondary, size: 28),
                          title: Text('Gestão de Categorias'),
                          onTap: () {
                            Modular.to.pushNamed('/category/list');
                          })
                      : Container(),
                  ListTile(
                      leading: Icon(Icons.settings,
                          color: Theme.of(context).colorScheme.secondary),
                      trailing: Icon(Icons.navigate_next,
                          color: Theme.of(context).colorScheme.secondary, size: 28),
                      title: Text('Configurações'),
                      onTap: () {
                        Modular.to.pushNamed('/settings');
                      }),
                  ListTile(
                      leading: Icon(Icons.people,
                          color: Theme.of(context).colorScheme.secondary),
                      trailing: Icon(Icons.navigate_next,
                          color: Theme.of(context).colorScheme.secondary, size: 28),
                      title: Text('Sobre os autores das meditações'),
                      onTap: () {
                        //Navigator.pop(context);
                        Modular.to.pushNamed('/author/list');
                      }),
                  ListTile(
                      leading: Icon(Icons.smartphone,
                          color: Theme.of(context).colorScheme.secondary),
                      trailing: Icon(Icons.navigate_next,
                          color: Theme.of(context).colorScheme.secondary, size: 28),
                      title: Text('Sobre a Brahma Kumaris'),
                      onTap: () {
                        //Navigator.pop(context);
                        Modular.to.pushNamed('/about');
                      }),
                  ListTile(
                    leading: Icon(Icons.delete_forever,
                        color: Theme.of(context).colorScheme.secondary),
                    trailing: Icon(Icons.navigate_next,
                        color: Theme.of(context).colorScheme.secondary, size: 28),
                    title: Text('Deletar conta e dados do app'),
                    onTap: () {
                      Modular.to.pushNamed('/delete_account');
                      //controller.user = null;
                      //_userController.logout();
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.power_settings_new,
                        color: Theme.of(context).colorScheme.secondary),
                    title: Text('Sair (Logoff)'),
                    onTap: () {
                      controller.userApp = null;
                      controller.logout();
                      WidgetsBinding.instance!.addPostFrameCallback((_){
                            Modular.to.pushReplacementNamed('/login/sociallogin');
                      });
                      // SchedulerBinding.instance.addPostFrameCallback((_) {
                      //     Modular.to.pushReplacementNamed('/login/sociallogin');
                      // });
                    },
                  ),
                ],
              ),
            ),
    );
  }
  

  // Widget _showUserPicture() {
  //   return Observer(builder: (BuildContext context) {
  //     if (controller.userHasNoImageUrl) {
  //       return Icon(Icons.perm_identity, size: 72.0, color: Colors.white);
  //     } else {
  //       return CircleAvatar(
  //         backgroundColor: Colors.white,
  //         radius: 52,
  //         child: CircleAvatar(
  //           radius: 50.0,
  //           backgroundImage: NetworkImage(controller.user.userImageUrl),
  //           backgroundColor: Colors.white,
  //         ),
  //       );
  //     }
  //   });
  //}
}


