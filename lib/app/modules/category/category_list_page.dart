import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter/material.dart';
import '/app/modules/category/category_list_controller.dart';
import '/app/modules/category/category_model.dart';
import '/app/shared/utils/ui_utils.dart';

class CategoryListPage extends StatefulWidget {
  const CategoryListPage({Key? key}) : super(key: key);

  @override
  _CategoryListPageState createState() => _CategoryListPageState();
}

class _CategoryListPageState
    extends ModularState<CategoryListPage, CategoryListController> {

  @override
  void initState() {
    controller.init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Gestão de Categorias'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              //controller.searchCategory();
            },
          ),
        ],
      ),
      //backgroundColor: Colors.white,
      floatingActionButton: FloatingActionButton(
          backgroundColor: Theme.of(context).accentColor,
          child:
              !controller.busy ? Icon(Icons.add) : CircularProgressIndicator(),
          onPressed: () {
            controller.addCategory();
          }),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              verticalSpace(10),
              Text(
                'Selecione o tipo da Categoria',
                style: TextStyle(fontSize: 18),
              ),
              _selectTipoCategory(),
              verticalSpace(10),
              Text(
                'Lista de categorias',
                style: TextStyle(fontSize: 18),
              ),
              _listaCategories(),
            ],
          ),
        ),
      ),
      // ),
    );
  }

  Widget _selectTipoCategory() {
    //final List<Category> lista = controller.categories;
    return Column(children: <Widget>[
      Observer(
        builder: (_) => Column(
              children: <Widget>[
                RadioListTile(
                    dense: true,
                    title: const Text('Todos'),
                    activeColor: Theme.of(context).accentColor,
                    value: VisibilityFilter.todos,
                    groupValue: controller.filter,
                    onChanged: (dynamic filter) => controller.filter = filter),
                RadioListTile(
                    dense: true,
                    title: const Text('Publicação'),
                    activeColor: Theme.of(context).accentColor,
                    value: VisibilityFilter.post,
                    groupValue: controller.filter,
                    onChanged: (dynamic filter) => controller.filter = filter),
                RadioListTile(
                    dense: true,
                    title: const Text('Meditação'),
                    activeColor: Theme.of(context).accentColor,
                    value: VisibilityFilter.meditation,
                    groupValue: controller.filter,
                    onChanged: (dynamic filter) => controller.filter = filter),
              ],
            ),
      ),
    ]);
  }

  Widget _listaCategories() {
    return Observer(
      builder: (BuildContext context) {
        return Material(
            child: controller.categories != null
                ? ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: controller.visibleCategories.length,
                    padding: EdgeInsets.only(top: 5.0, left: 5.0),
                    itemBuilder: (context, index) => GestureDetector(
                      child: _categoryItem(controller.visibleCategories[index]),
                    ),
                  )
                : Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Center(
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation(
                            Theme.of(context).accentColor),
                      ),
                    ),
                  ));
      },
    );
  }

  Widget _categoryItem(Category category) {
    return Container(
      margin: const EdgeInsets.only(left: 0, right: 0, bottom: 0.0, top: 10.0),
      decoration: BoxDecoration(
          //color: Colors.white,
          borderRadius: BorderRadius.circular(5),
          // boxShadow: [
          //   BoxShadow(blurRadius: 8, color: Colors.grey[200], spreadRadius: 3)
          // ],
          ),
      alignment: Alignment.center,
      child: Material(
        borderRadius: BorderRadius.circular(6.0),
        elevation: 2.0,
        child: Container(
          height: 80.0,
          child: Row(
            //crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Expanded(
                  child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Flexible(
                    child: Container(
                      margin: EdgeInsets.only(
                          left: 10, right: 10, bottom: 5.0, top: 5.0),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(category.valor!,
                            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),),
                            verticalSpace(5),
                            Text(controller.getTipoCategoria(category.tipo),
                            style: TextStyle(fontWeight: FontWeight.normal, fontSize: 14.0),),
                            verticalSpace(5),
                            // Text('120 ocorrencias',
                            // style: TextStyle(fontWeight: FontWeight.normal, fontSize: 14.0),),
                            //_getStatistics(ref),
                          ]),
                    ),
                  ),
                ],
              )),
              Column(
                children: <Widget>[
                  // Expanded(
                  //   child: IconButton(
                  //       icon: Icon(
                  //         Icons.edit,
                  //         color: Theme.of(context).accentColor,
                  //       ),
                  //       onPressed: () {
                  //         //controller.editCategory(category);
                  //       }),
                  // ),
                  Expanded(
                    child: IconButton(
                        icon: Icon(
                          Icons.delete,
                          color: Theme.of(context).accentColor,
                        ),
                        onPressed: () {
                          controller.deleteCategory(category);
                        }),
                  ),
                ],
              )
              //Icon(Icons.favorite_border),
            ],
          ),
        ),
      ),
    );
  }
}
