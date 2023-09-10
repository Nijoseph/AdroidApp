import 'package:data_capture/database/db_service.dart';
import 'package:data_capture/database/tables/estate.dart';
import 'package:data_capture/pages/estate_page.dart';
import 'package:data_capture/pages/field_page.dart';
import 'package:data_capture/responsive/responsive_layout.dart';
import 'package:data_capture/util/constat.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class DivisionPage extends StatefulWidget {
  const DivisionPage({Key? key}) : super(key: key);

  @override
  State<DivisionPage> createState() => _DivisionPageState();
}

class _DivisionPageState extends State<DivisionPage> {
  @override
  Widget build(BuildContext context) {
    final estateControl = Get.put(EstateController());
    final divisionControl = Get.put(DivisionController());
    var estate = estateControl.selectedEstate().asStream().first;
    return ResponsiveLayout(
      desktopBody: Scaffold(),
      mobileBody: Scaffold(),
      tabletBody: Scaffold(
        appBar: AppBar(
          title: Text(
            "Divisions (${estateControl.currentEstate.value.name} Estate)",
            style: GoogleFonts.notoSerif(
                textStyle: Theme.of(context).textTheme.headline5,
                color: MyBlueGrayBlueGray300),
          ),
          backgroundColor: primaryColor,
          elevation: 0,
          actions: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: InkWell(
                onTap: () {
                  Get.bottomSheet(DivisionForm(
                    estate: estateControl.currentEstate.value,
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
          child: StreamBuilder<List<Division>>(
              stream: divisionControl.streamDivision(id: estateControl.currentEstate.value.id),
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

                          divisionControl.currentID.value=snapshot.data![i].id!;
                          await divisionControl.selectedDivision();
                          Get.to(FieldPage());
                        },
                        // child: EstateCard(estate: snapshot.data![i]));
                        child: DivisionCard(division: snapshot.data![i],));
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
    );
  }
}

class DivisionController extends GetxController {
  final db = DatabaseService();
  var divisions = <Division>[].obs;
  var currentID = 0.obs;
  var estateId=0.obs;
  var currentDivision = Division().obs;

  final txtName = TextEditingController();
  final txtAcronym = TextEditingController();
  Stream<List<Division>> streamDivision({required int id}) {
    return db.listenToDivision(id);
  }
  Future<void> selectedDivision() async {
    currentDivision.value = (await db.getDivision(currentID.value))!;
    update();
  }

  Future<bool> saveData(Estate estate) async {
    final newDivision = Division()
      ..name = txtName.text
      ..acronym = txtAcronym.text
      ..estate.value = estate;

    try {
      db.saveDivision(newDivision);
    } catch (ex) {
      print(ex.toString());
      return false;
    }
    txtAcronym.clear();
    txtName.clear();
    return true;
  }
}

class DivisionForm extends StatelessWidget {
  const DivisionForm({Key? key, this.division, required this.estate})
      : super(key: key);
  final Division? division;
  final Estate estate;
  @override
  Widget build(BuildContext context) {
    final divisionControl = Get.put(DivisionController());

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
                  "Add New Division",
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
                    hint: estate.name ?? "",
                    widget: Icon(Icons.map),
                  ),
                  MyInputField(
                    title: "Division Name",
                    hint: "Full Name",
                    controller: divisionControl.txtName,
                  ),
                  MyInputField(
                    title: "Division Acronym",
                    hint: "2 characters",
                    controller: divisionControl.txtAcronym,
                  ),
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
                    var isSaved = await divisionControl.saveData(estate);
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
