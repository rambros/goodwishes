import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter/material.dart';

import '/app/shared/author/controller/author_list_controller.dart';
import '/app/shared/user/user_app_model.dart';
import '/app/shared/utils/color.dart';
import '/app/shared/utils/shared_styles.dart';
import '/app/shared/utils/ui_utils.dart';

class AuthorListPage extends StatefulWidget {
  const AuthorListPage({Key? key}) : super(key: key);

  @override
  _AuthorListPageState createState() => _AuthorListPageState();
}

class _AuthorListPageState
    extends ModularState<AuthorListPage, AuthorListController> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Autores'),
      ),
      //backgroundColor: Colors.white,
      floatingActionButton: controller.isUserAdmin
          ? FloatingActionButton(
              backgroundColor: Theme.of(context).colorScheme.secondary,
              child: !controller.busy
                  ? Icon(Icons.add)
                  : CircularProgressIndicator(),
              onPressed: () {
                controller.addAuthor();
              })
          : null,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              verticalSpace(10),
              _listAuthors(),
            ],
          ),
        ),
      ),
      // ),
    );
  }

  Widget _listAuthors() {
    return Observer(
      builder: (BuildContext context) {
        return Material(
            child: controller.authors != null
                ? ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: controller.authors!.length,
                    padding:  EdgeInsets.only(top: 5.0, left: 5.0),
                    itemBuilder: (context, index) => GestureDetector(
                      onTap: () => controller.showAuthorDetails(controller.authors![index]),
                      child: _authorItem(controller.authors![index]),
                    ),
                  )
                : Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Center(
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation(
                            Theme.of(context).primaryColor),
                      ),
                    ),
                  ));
      },
    );
  }

  Widget _authorItem(UserApp author) {
    return Container(
      margin: const EdgeInsets.only(left: 0, right: 0, bottom: 4.0, top: 0.0),
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
        borderRadius:  BorderRadius.circular(6.0),
        elevation: 0.2,
        child: Container(
          height: 120.0,
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
                              radius: 50,
                              child: CircleAvatar(
                                radius: 50.0,
                                backgroundImage:
                                    NetworkImage(author.userImageUrl!),
                                backgroundColor: Colors.white,
                              ),
                            )
                          : Container(
                            child: Icon(Icons.perm_identity, size: 100.0, color: accentColor),
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
                                style: titlePostTextStyle,
                              ),
                              verticalSpace(2),
                              Container(
                                //margin: EdgeInsets.only(top: 4.0),
                                child: Text(
                                  author.curriculum ?? 'Curriculum',
                                  maxLines: 4,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    height: 1.1,
                                    fontWeight: FontWeight.normal,
                                    fontSize: 12.0,
                                  ),
                                ),
                              )
                            ]),
                      ),
                    ),
                ],
              ),
                  )),
              ((controller.isUserAdmin) ||
                      (controller.getUserEmail == author.email))
                  ? Column(
                      children: <Widget>[
                        Expanded(
                          child: IconButton(
                            icon: Icon(
                              Icons.edit,
                              color: Theme.of(context).colorScheme.secondary,
                            ),
                            onPressed: () => controller.editAuthor(author),
                          ),
                        ),
                      ],
                    )
                  : Material(), //Icon(Icons.favorite_border),
            ],
          ),
        ),
      ),
    );
  }
}
