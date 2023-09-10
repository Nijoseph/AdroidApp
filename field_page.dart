import 'package:data_capture/database/db_service.dart';
import 'package:data_capture/database/tables/estate.dart';
import 'package:data_capture/pages/division_page.dart';
import 'package:data_capture/pages/field_section_page.dart';
import 'package:data_capture/responsive/responsive_layout.dart';
import 'package:data_capture/util/constat.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class FieldPage extends StatefulWidget {
  const FieldPage({Key? key}) : super(key: key);

  @override
  State<FieldPage> createState() => _FieldPageState();
}

class _FieldPageState extends State<FieldPage> {
  @override
  Widget build(BuildContext context) {
    final divisionControl = Get.put(DivisionController());
    final fieldControl = Get.put(FieldController());

    return ResponsiveLayout(
        mobileBody: Scaffold(),
        tabletBody: Scaffold(
          appBar: AppBar(
            title: Text(
              "Fields (${divisionControl.currentDivision.value.name} Division)",
              style: GoogleFonts.notoSerif(
                  textStyle: Theme.of(context).textTheme.headline5,
                  color: MyBlueGrayBlueGray400),
            ),
            backgroundColor: primaryColor,
            elevation: 0,
            actions: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: InkWell(
                  onTap: () {
                    Get.bottomSheet(FieldForm(
                      division: divisionControl.currentDivision.value,
                    ));
                  },
                  child: Row(
                    children: const [
                      Icon(Icons.add_box_rounded),
                      MySpecing(size: 1),
                      Text("Add New")
                    ],
                  ),
                ),
              )
            ],
          ),
          body: Container(
            color: MyBlueGrayBlueGray300,
            child: StreamBuilder<List<Field>>(
                stream: fieldControl.streamField(
                    id: divisionControl.currentID.value),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  return ListView.separated(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, i) {
                      return InkWell(
                        onTap: () async {
                          fieldControl.currentID.value = snapshot.data![i].id!;
                          await fieldControl.selectedField();
                          Get.to(const FieldSectionPage());
                        },
                        // child: EstateCard(estate: snapshot.data![i])
                        child: FieldCard(field: snapshot.data![i]),
                      );
                    },
                    separatorBuilder: (context, index) {
                      return const Divider(
                        height: 1,
                      );
                    },
                  );
                }),
          ),
        ),
        desktopBody: Scaffold());
  }
}

class FieldController extends GetxController {
  final db = DatabaseService();
  var fields = <Field>[].obs;
  var currentID = 0.obs;
  var fieldId = 0.obs;
  var currentField = Field().obs;

  final txtName = TextEditingController();
  final txtAcronym = TextEditingController();
  Stream<List<Field>> streamField({required int id}) {
    return db.listenToField(id);
  }

  Future<void> selectedField() async {
    currentField.value = (await db.getField(currentID.value))!;
    update();
  }

  Future<bool> saveData(Division division) async {
    final newField = Field()
      ..name = txtName.text
      ..acronym = txtName.text
      ..landUse = LandUse.teaPlantation
      ..division.value = division;

    try {
      db.saveField(newField);
    } catch (ex) {
      print(ex.toString());
      return false;
    }
    txtAcronym.clear();
    txtName.clear();
    return true;
  }
}

class FieldForm extends StatelessWidget {
  const FieldForm({Key? key, required this.division, this.field})
      : super(key: key);
  final Division division;
  final Field? field;
  @override
  Widget build(BuildContext context) {
    final fieldControl = Get.put(FieldController());

    return Container(
      decoration: MyBoxDecoration(),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                padding:
                const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                child: Text(
                  "Add New Field",
                  style: GoogleFonts.notoSerif(
                      textStyle: Theme.of(context).textTheme.headline5,
                      color: MyBlueGrayBlueGray700),
                ),
              )
            ],
          ),
          Expanded(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 30),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      MyInputField(
                        title: "Estate",
                        hint: division.name ?? "",
                        widget: Icon(Icons.map),
                      ),
                      MyInputField(
                        title: "Division Name",
                        hint: "Ex: F001[F###]",
                        controller: fieldControl.txtName,
                      ),
                      // MyInputField(
                      //   title: "Division Acronym",
                      //   hint: "Ex: F001[F###]",
                      //   controller: fieldControl.txtAcronym,
                      // ),
                    ],
                  ),
                ),
              )),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
            child: Row(
              children: [
                MyButton01(
                  btnText: "Save Data",
                  onPressed: () async {
                    var isSaved = await fieldControl.saveData(division);
                    if (isSaved) {
                      Get.back();
                    }
                  },
                ),
                const MySpecing(size: 5),
                MyButton01(
                    btnText: "Close Page",
                    onPressed: () {
                      Get.back();
                    },
                    btnColor: MyRedRed600),
              ],
            ),
          )
        ],
      ),
    );

  }
}
