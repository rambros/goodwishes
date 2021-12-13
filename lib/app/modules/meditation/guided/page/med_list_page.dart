import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../controller/med_list_controller.dart';
import '/app/modules/category/category_model.dart';
import '/app/shared/utils/color.dart';
import '/app/shared/utils/shared_styles.dart';

import 'med_item.dart';

class MeditationListPage extends StatefulWidget {
  const MeditationListPage({Key? key}) : super(key: key);

  @override
  _MeditationListPageState createState() => _MeditationListPageState();
}

class _MeditationListPageState
    extends ModularState<MeditationListPage, MeditationListController> {
  final GlobalKey<FormBuilderState> _fbKey = GlobalKey<FormBuilderState>();

  @override
  void initState() {
    controller.init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final userRole = controller.getUserRole;
    return Scaffold(
      appBar: AppBar(
        title: Text('Meditações'),
        actions: <Widget>[
          IconButton(
            padding: EdgeInsets.only(right: 28.0),
            icon: Icon(Icons.search, size: 32.0 ),
            onPressed: () {
              controller.searchMeditation();
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              FormBuilder(
                key: _fbKey,
                autovalidateMode: AutovalidateMode.always,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Observer(
                      builder: (BuildContext context) {
                        return Center(
                          child: controller.hasCategories != null
                              ? FormBuilderChoiceChip(
                                  name: 'category',
                                  initialValue: [],
                                  backgroundColor: Theme.of(context).colorScheme.secondary,
                                  selectedColor: selectedColor,
                                  spacing: 4.0,
                                  alignment: WrapAlignment.center,
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    labelText:
                                        'Selecione meditações por categoria',
                                    labelStyle: TextStyle(
                                                fontSize: 21,
                                                //color: Colors.black,
                                                fontWeight: FontWeight.w400),
                                  ),
                                  options: controller.listaCategoriasField(kTipoMeditation),
                                  onChanged: (dynamic value) => controller.filterByCategory(value),
                                )
                              : Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: Center(
                                    child: CircularProgressIndicator(
                                      valueColor: AlwaysStoppedAnimation(
                                          Theme.of(context).colorScheme.secondary),
                                    ),
                                  ),
                                ),
                        );
                      },
                    ),
                  ],
                ),
              ),

              //verticalSpace(8),
              Text(
                'Meditações',
                style: titleTextStyle,
              ),
              _meditationsRecentes(controller),
            ],
          ),
        ),
      ),
      // ),
    );
  }
}

Widget _meditationsEmDestaque(MeditationListController controller) {
  return Observer(
    builder: (BuildContext context) {
      return SizedBox(
        height: 160,
        child: controller.listFeatured!.isEmpty
            ? Padding(
                padding: const EdgeInsets.all(12.0),
                child: Center(
                  child: CircularProgressIndicator(
                    valueColor:
                        AlwaysStoppedAnimation(Theme.of(context).primaryColor),
                  ),
                ),
              )
            : ListView.builder(
                shrinkWrap: true,
                itemCount: controller.listFeatured!.length,
                padding: EdgeInsets.only(top: 8.0, bottom: 8.0),
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) => GestureDetector(
                  onTap: () => controller.showMeditationDetailsFeatured(
                    index,
                  ),
                  child: Container(
                    width: 160.0,
                    height: 160.0,
                    margin: EdgeInsets.symmetric(horizontal: 8),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8.0),
                      child: Image.network(
                        controller.listFeatured![index].imageUrl!,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              ),
      );
    },
  );
}


Widget _meditationsRecentes(MeditationListController controller) {
  final userRole = controller.getUserRole;
  return Observer(
    builder: (BuildContext context) {
      return Container(
          child: controller.meditationsFiltered != null
              ? ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: controller.meditationsFiltered.length,
                  padding:EdgeInsets.only(top: 8.0, left: 8.0, bottom: 4.0),
                  itemBuilder: (context, index) => GestureDetector(
                    onTap: () => controller.showMeditationDetails(index),
                    child: MeditationItem(
                      meditation: controller.meditationsFiltered[index],
                      onChangeStatusItem: () => controller.changeStatusToDraft(index),
                      onEditItem: () => controller.editMeditation(index),
                      userRole: userRole,
                    ),
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
