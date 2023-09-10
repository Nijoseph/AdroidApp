import 'package:data_capture/database/db_service.dart';
import 'package:data_capture/database/tables/estate.dart';
import 'package:data_capture/pages/field_page.dart';
import 'package:data_capture/responsive/responsive_layout.dart';
import 'package:data_capture/util/constat.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class FieldSectionPage extends StatefulWidget {
  const FieldSectionPage({Key? key}) : super(key: key);

  @override
  State<FieldSectionPage> createState() => _FieldSectionPageState();
}

class _FieldSectionPageState extends State<FieldSectionPage> {
  @override
  Widget build(BuildContext context) {
    final fieldControl = Get.put(FieldController());
    final fieldSectionControl = Get.put(FieldSectionController());
    return ResponsiveLayout(
        mobileBody: Scaffold(),
        tabletBody: Scaffold(
          appBar: AppBar(
            title: Text(
              "Field Sections (${fieldControl.currentField.value.name} Field)",
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
                    Get.bottomSheet(
                        FieldSectionForm(field: fieldControl.currentField.value)
                    );
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
            child: StreamBuilder<List<FieldSection>>(
                stream: fieldSectionControl.streamField(
                    id: fieldControl.currentID.value),
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
                          // Get.to(const DivisionPage());
                        },
                        // child: EstateCard(estate: snapshot.data![i])
                        child: SectionCard(section: snapshot.data![i]),
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
class FieldSectionController extends GetxController {
  final db = DatabaseService();
  var fieldSections = <FieldSection>[].obs;
  var currentID = 0.obs;
  var fieldId = 0.obs;
  var currentFieldSection = FieldSection().obs;

  final txtName = TextEditingController();
  final txtAcronym = TextEditingController();
  Stream<List<FieldSection>> streamField({required int id}) {
    return db.listenToFieldSection(id);
  }

  Future<void> selectedField() async {
    currentFieldSection.value = (await db.getFieldSection(currentID.value))!;
    update();
  }

  Future<bool> saveData(Field field) async {
    final newFieldSection = FieldSection()
      ..name = txtName.text
      ..acronym = txtName.text
      ..field.value = field;

    try {
      db.saveFieldSection(newFieldSection);
    } catch (ex) {
      print(ex.toString());
      return false;
    }
    txtAcronym.clear();
    txtName.clear();
    return true;
  }
}
class FieldSectionForm extends StatelessWidget {
  const FieldSectionForm({Key? key, required this.field, this.fieldSection})
      : super(key: key);
  final Field field;
  final FieldSection? fieldSection;
  @override
  Widget build(BuildContext context) {
    final fieldSectionControl = Get.put(FieldSectionController());

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
                        title: "Field",
                        hint: field.name ?? "",
                        widget: Icon(Icons.map),
                      ),
                      MyInputField(
                        title: "Division Name",
                        hint: "Ex: A",
                        controller: fieldSectionControl.txtName,
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
                    var isSaved = await fieldSectionControl.saveData(field);
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
