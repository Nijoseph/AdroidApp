import 'package:data_capture/database/db_service.dart';
import 'package:data_capture/database/tables/estate.dart';
import 'package:data_capture/pages/division_page.dart';
import 'package:data_capture/responsive/responsive_layout.dart';
import 'package:data_capture/util/constat.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class EstatePage extends StatefulWidget {
  const EstatePage({Key? key}) : super(key: key);

  @override
  State<EstatePage> createState() => _EstatePageState();
}

class _EstatePageState extends State<EstatePage> {
  @override
  Widget build(BuildContext context) {
    final estateControl = Get.put(EstateController());
    return ResponsiveLayout(
        mobileBody: Scaffold(),
        tabletBody: Scaffold(
          appBar: AppBar(
            title: Text(
              "Estate",
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
                    Get.bottomSheet(EstateForm());
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
            child: StreamBuilder<List<Estate>>(

                stream: estateControl.streamEstate(),
                builder: (context, snapshot) {

                  if (!snapshot.hasData) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  return ListView.separated(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, i) {
                      estateControl.updateNumbers(snapshot.data![i]);
                       return FutureBuilder(
                        future: estateControl.db.estateFields(snapshot.data![i]),
                        builder: (ctx, snapshot1) {

                          return InkWell(
                              onTap: () async {
                                estateControl.currentID.value =
                                    snapshot.data![i].id!;
                                await estateControl.selectedEstate();
                                Get.to(const DivisionPage());
                              },
                              child: EstateCard(
                                estate: snapshot.data![i],
                                fields: snapshot1.data?.length,
                              ));
                        }
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

class EstateController extends GetxController {
  final db = DatabaseService();
  var estates = <Estate>[].obs;
  var currentID = 0.obs;
  var estateFields = 0.obs;
  var estateSection = 0.obs;
  var currentEstate = Estate().obs;

  final txtName = TextEditingController();
  final txtAcronym = TextEditingController();

  Stream<List<Estate>> streamEstate() => db.listenToEstate();
  Future<void> selectedEstate() async {
    currentEstate.value = (await db.getEstate(currentID.value))!;
    update();
  }
Future<void> updateNumbers(Estate estate)async{
    var l1=await db.estateFields(estate);
    estateFields.value=l1.length;

    update();
}
  Future<void> estateFieldNumber(Estate estate) async {
    var list = await db.getAllField();
    estateFields.value = list
        .where((element) => element.division.value?.estate.value == estate)
        .length;
  }

  Future<bool> saveData() async {
    final newEstate = Estate()
      ..name = txtName.text
      ..acronym = txtAcronym.text;

    try {
      db.saveEstate(newEstate);
    } catch (ex) {
      print(ex.toString());
      return false;
    }
    txtAcronym.clear();
    txtName.clear();
    return true;
  }
}

class EstateForm extends StatelessWidget {
  const EstateForm({Key? key, this.estate}) : super(key: key);
  final Estate? estate;
  @override
  Widget build(BuildContext context) {
    final estateControl = Get.put(EstateController());
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
                  "Add New Estate",
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
                    title: "Estate Name",
                    hint: "Full Name",
                    controller: estateControl.txtName,
                  ),
                  MyInputField(
                    title: "Estate Acronym",
                    hint: "2 characters",
                    controller: estateControl.txtAcronym,
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
                    var isSaved = await estateControl.saveData();
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
