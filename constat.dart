import 'package:data_capture/database/db_service.dart';
import 'package:data_capture/database/tables/daily_numbers.dart';
import 'package:data_capture/database/tables/estate.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:uuid/uuid.dart';
import 'package:week_of_year/date_week_extensions.dart';
import 'package:intl/intl.dart';

//#region ThemeColors
//entries
const primaryColor = MyBlueGrayBlueGray700;
const secondaryColor = MyBlueGrayBlueGray900;
const iconColor = MyBlueGrayBlueGray500;
const buttonColor = MyEmeraldEmerald900;
const selectedItemColor = MyAmberAmber500;
const activeBtnColor = MyAmberAmber500;
const bgColor = MyBlueGrayBlueGray400;
const bgColor1 = MyBlueGrayBlueGray100;
//#endregion
//#region Colors
const MyGreenGreen900 = Color(0xFF14532D);
const MyGreenGreen800 = Color(0xFF166534);
const MyGreenGreen700 = Color(0xFF15803D);
const MyGreenGreen600 = Color(0xFF16A34A);
const MyGreenGreen500 = Color(0xFF22C55E);
const MyGreenGreen400 = Color(0xFF4ADE80);
const MyGreenGreen300 = Color(0xFF86EFAC);
const MyGreenGreen200 = Color(0xFFBBF7D0);
const MyGreenGreen100 = Color(0xFFDCFCE7);
const MyGreenGreen50 = Color(0xFFF0FDF4);
const MyEmeraldEmerald900 = Color(0xFF064E3B);
const MyEmeraldEmerald800 = Color(0xFF065F46);
const MyEmeraldEmerald700 = Color(0xFF047857);
const MyEmeraldEmerald600 = Color(0xFF059669);
const MyEmeraldEmerald500 = Color(0xFF10B981);
const MyEmeraldEmerald400 = Color(0xFF34D399);
const MyEmeraldEmerald300 = Color(0xFF6EE7B7);
const MyEmeraldEmerald200 = Color(0xFFA7F3D0);
const MyEmeraldEmerald100 = Color(0xFFD1FAE5);
const MyEmeraldEmerald50 = Color(0xFFECFDF5);
const MyTealTeal900 = Color(0xFF134E4A);
const MyTealTeal800 = Color(0xFF115E59);
const MyTealTeal700 = Color(0xFF0F766E);
const MyTealTeal600 = Color(0xFF0D9488);
const MyTealTeal500 = Color(0xFF14B8A6);
const MyTealTeal400 = Color(0xFF2DD4BF);
const MyTealTeal300 = Color(0xFF5EEAD4);
const MyTealTeal200 = Color(0xFF99F6E4);
const MyTealTeal100 = Color(0xFFCCFBF1);
const MyTealTeal50 = Color(0xFFF0FDFA);
const MyCyanCyan900 = Color(0xFF164E63);
const MyCyanCyan800 = Color(0xFF155E75);
const MyCyanCyan700 = Color(0xFF0E7490);
const MyCyanCyan600 = Color(0xFF0891B2);
const MyCyanCyan500 = Color(0xFF06B6D4);
const MyCyanCyan400 = Color(0xFF22D3EE);
const MyCyanCyan300 = Color(0xFF67E8F9);
const MyCyanCyan200 = Color(0xFFA5F3FC);
const MyCyanCyan100 = Color(0xFFCFFAFE);
const MyCyanCyan50 = Color(0xFFECFEFF);
const MyLightBlueLightBlue900 = Color(0xFF0C4A6E);
const MyLightBlueLightBlue800 = Color(0xFF075985);
const MyLightBlueLightBlue700 = Color(0xFF0369A1);
const MyLightBlueLightBlue600 = Color(0xFF0284C7);
const MyLightBlueLightBlue500 = Color(0xFF0EA5E9);
const MyLightBlueLightBlue400 = Color(0xFF38BDF8);
const MyLightBlueLightBlue300 = Color(0xFF7DD3FC);
const MyLightBlueLightBlue200 = Color(0xFFBAE6FD);
const MyLightBlueLightBlue100 = Color(0xFFE0F2FE);
const MyLightBlueLightBlue50 = Color(0xFFF0F9FF);
const MyBlueBlue900 = Color(0xFF1E3A8A);
const MyBlueBlue800 = Color(0xFF1E40AF);
const MyBlueBlue700 = Color(0xFF1D4ED8);
const MyBlueBlue600 = Color(0xFF2563EB);
const MyBlueBlue500 = Color(0xFF3B82F6);
const MyBlueBlue400 = Color(0xFF60A5FA);
const MyBlueBlue300 = Color(0xFF93C5FD);
const MyBlueBlue200 = Color(0xFFBFDBFE);
const MyBlueBlue100 = Color(0xFFDBEAFE);
const MyBlueBlue50 = Color(0xFFEFF6FF);
const MyBlueGrayBlueGray900 = Color(0xFF0F172A);
const MyBlueGrayBlueGray800 = Color(0xFF1E293B);
const MyBlueGrayBlueGray700 = Color(0xFF334155);
const MyBlueGrayBlueGray600 = Color(0xFF475569);
const MyBlueGrayBlueGray500 = Color(0xFF64748B);
const MyBlueGrayBlueGray400 = Color(0xFF94A3B8);
const MyBlueGrayBlueGray300 = Color(0xFFCBD5E1);
const MyBlueGrayBlueGray200 = Color(0xFFE2E8F0);
const MyBlueGrayBlueGray100 = Color(0xFFF1F5F9);
const MyBlueGrayBlueGray50 = Color(0xFFF8FAFC);
const MyRedRed900 = Color(0xFF7F1D1D);
const MyRedRed800 = Color(0xFF991B1B);
const MyRedRed700 = Color(0xFFB91C1C);
const MyRedRed600 = Color(0xFFDC2626);
const MyRedRed500 = Color(0xFFEF4444);
const MyRedRed400 = Color(0xFFF87171);
const MyRedRed300 = Color(0xFFFCA5A5);
const MyRedRed200 = Color(0xFFFECACA);
const MyRedRed100 = Color(0xFFFEE2E2);
const MyRedRed50 = Color(0xFFFEF2F2);
const MyAmberAmber900 = Color(0xFF78350F);
const MyAmberAmber800 = Color(0xFF92400E);
const MyAmberAmber700 = Color(0xFFB45309);
const MyAmberAmber600 = Color(0xFFD97706);
const MyAmberAmber500 = Color(0xFFF59E0B);
const MyAmberAmber400 = Color(0xFFFBBF24);
const MyAmberAmber300 = Color(0xFFFCD34D);
const MyAmberAmber200 = Color(0xFFFDE68A);
const MyAmberAmber100 = Color(0xFFFEF3C7);
const MyAmberAmber50 = Color(0xFFFFFBEB);
const MyIndigoIndigo900 = Color(0xFF312E81);
const MyIndigoIndigo800 = Color(0xFF3730A3);
const MyIndigoIndigo700 = Color(0xFF4338CA);
const MyIndigoIndigo600 = Color(0xFF4F46E5);
const MyIndigoIndigo500 = Color(0xFF6366F1);
const awe = Color(0xfff44336);

//#endregion
//#region Variables 001
enum ScreenMode { live, Gsllery }

var uuid = Uuid();

var appTitle = AppBar(
  elevation: 0,
  title: const Text("INKUBA Notifier"),
  centerTitle: false,
  backgroundColor: MyBlueGrayBlueGray700,
  actions: [IconButton(onPressed: () {}, icon: Icon(Icons.add_comment_sharp))],
);

//#endregion
//#region Other001
class MyMenuItem {
  final String title;
  final IconData icon;
  final Function()? onPressed;
  MyMenuItem(this.onPressed, {required this.title, required this.icon});
}

class MenuCardWidget extends StatelessWidget {
  const MenuCardWidget({Key? key, required this.menuItem}) : super(key: key);
  final MyMenuItem menuItem;
  @override
  Widget build(BuildContext context) {
    final TextStyle? textStyle = Theme.of(context).textTheme.displayMedium;
    return Card(
      color: Colors.white,
      child: InkWell(
        onTap: menuItem.onPressed,
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Icon(
                  menuItem.icon,
                  size: 80,
                  color: textStyle?.color,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  menuItem.title,
                  maxLines: 1,
                  // overflow:TextOverflow.ellipsis,
                  style: GoogleFonts.aBeeZee(fontSize: 18),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

Text MyText(
        {required String text,
        required TextStyle textStyle,
        Color color = MyBlueGrayBlueGray400}) =>
    Text(
      text,
      style: GoogleFonts.notoSerif(textStyle: textStyle, color: color),
    );

BoxDecoration MyBoxDecoration(
    {Color color = Colors.white70,
    Color bColor = Colors.black45,
    double lTSize = 0,
    double lBSize = 0,
    double rTSize = 0,
    double rBSize = 0}) {
  return BoxDecoration(
      color: color,
      border: Border.all(color: bColor, width: 0.0),
      borderRadius: BorderRadius.only(
        bottomLeft: Radius.circular(lBSize),
        topLeft: Radius.circular(lTSize),
        bottomRight: Radius.circular(rBSize),
        topRight: Radius.circular(rTSize),
      ));
}

class EstateCard extends StatelessWidget {
  const EstateCard({
    Key? key,
    required this.estate,
    this.section,
    this.clone,
    this.area, this.fields,
  }) : super(key: key);
  final Estate estate;
  final int? fields;
  final int? section;
  final int? clone;
  final int? area;


  @override
  Widget build(BuildContext context) {
    final db = DatabaseService();
    return Container(
      height: 110,
      margin: EdgeInsets.all(2),
      decoration: MyBoxDecoration(bColor: Colors.transparent),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
            decoration: MyBoxDecoration(color: MyBlueGrayBlueGray700),
            width: 100,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "${estate.acronym}",
                  style: GoogleFonts.anton(
                      textStyle: Theme.of(context).textTheme.headline3,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 4,
                      color: MyBlueGrayBlueGray100),
                ),
              ],
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      "${estate.name} Estate",
                      style: GoogleFonts.notoSerif(
                          textStyle:
                          Theme.of(context).textTheme.headline5,
                          color: MyBlueGrayBlueGray400),
                    ),
                    Text(
                      "${estate.divisions.length} Divisions, $fields Fields, 62 Sections",
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.notoSerif(
                          textStyle:
                          Theme.of(context).textTheme.bodyText2,
                          color: MyBlueGrayBlueGray400),
                    ),
                    //    double mds=(task.manDays.value?.female)+( task.manDays.value?.male);
                    Text(
                        "12 Users | "
                            "2 Manager(s)"
                            ", 3 Clark"
                            ", 7 Supervisors"
                            " and 1453 Employees",
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.notoSerif(
                            textStyle:
                            Theme.of(context).textTheme.bodyText2,
                            color: MyBlueGrayBlueGray400)),
                    Text(
                      "Area: 473 ha | Tea plantation 443.72 ha (82%), 20 Corne",
                      style: GoogleFonts.notoSerif(
                          textStyle:
                          Theme.of(context).textTheme.bodyText2,
                          color: MyBlueGrayBlueGray400),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}



class DivisionCard extends StatelessWidget {
  const DivisionCard({
    Key? key,
    required this.division,
  }) : super(key: key);
  final Division division;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 110,
      margin: EdgeInsets.all(1),
      decoration: MyBoxDecoration(bColor: Colors.transparent),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
            decoration: MyBoxDecoration(color: MyBlueGrayBlueGray700),
            width: 85,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  division.acronym ?? "_",
                  style: GoogleFonts.anton(
                      textStyle: Theme.of(context).textTheme.headline3,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 4,
                      color: MyBlueGrayBlueGray100),
                ),
              ],
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      "${division.name!} Division",
                      style: GoogleFonts.notoSerif(
                          textStyle: Theme.of(context).textTheme.headline5,
                          color: MyBlueGrayBlueGray400),
                    ),
                    Text(
                      "${division.fields.length} Fields, 62 Sections",
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.notoSerif(
                          textStyle: Theme.of(context).textTheme.bodyText2,
                          color: MyBlueGrayBlueGray400),
                    ),
                    //    double mds=(task.manDays.value?.female)+( task.manDays.value?.male);
                    Text(
                        "6 Users | "
                        "1 Manager(s)"
                        ", 1 Clark"
                        ", 4 Supervisors"
                        " and 1,453 Employees",
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.notoSerif(
                            textStyle: Theme.of(context).textTheme.bodyText2,
                            color: MyBlueGrayBlueGray400)),
                    Text(
                      "Area: 473 ha | Tea plantation 443.72 ha (82%), 20 Corne",
                      style: GoogleFonts.notoSerif(
                          textStyle: Theme.of(context).textTheme.bodyText2,
                          color: MyBlueGrayBlueGray400),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class FieldCard extends StatelessWidget {
  const FieldCard({
    Key? key,
    required this.field,
  }) : super(key: key);
  final Field field;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 90,
      margin: EdgeInsets.all(1),
      decoration: MyBoxDecoration(bColor: Colors.transparent),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
            decoration: MyBoxDecoration(color: MyBlueGrayBlueGray700),
            width: 120,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  field.name!,
                  style: GoogleFonts.anton(
                      textStyle: Theme.of(context).textTheme.headline3,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 4,
                      color: MyBlueGrayBlueGray100),
                ),
              ],
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      "${field.division.value?.name} ${field.name}",
                      style: GoogleFonts.notoSerif(
                          textStyle: Theme.of(context).textTheme.headline5,
                          color: MyBlueGrayBlueGray400),
                    ),
                    Text(
                      "${field.sections.length} Sections",
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.notoSerif(
                          textStyle: Theme.of(context).textTheme.bodyText2,
                          color: MyBlueGrayBlueGray400),
                    ),
                    Text(
                      "Area: 12 ha | 864,457 bushes, 2 Corne",
                      style: GoogleFonts.notoSerif(
                          textStyle: Theme.of(context).textTheme.bodyText2,
                          color: MyBlueGrayBlueGray400),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class SectionCard extends StatelessWidget {
  const SectionCard({
    Key? key,
    required this.section,
  }) : super(key: key);
  final FieldSection section;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 68,
      margin: EdgeInsets.all(1),
      decoration: MyBoxDecoration(bColor: Colors.transparent),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
            decoration: MyBoxDecoration(color: MyBlueGrayBlueGray700),
            width: 130,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "${section.field.value?.name} ${section.name}",
                  style: GoogleFonts.anton(
                      textStyle: Theme.of(context).textTheme.headline4,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 4,
                      color: MyBlueGrayBlueGray100),
                ),
              ],
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      "${section.field.value?.division.value?.name} ${section.field.value?.name} ${section.name}",
                      style: GoogleFonts.notoSerif(
                          textStyle: Theme.of(context).textTheme.headline5,
                          color: MyBlueGrayBlueGray400),
                    ),
                    Text(
                      "Area: 7.2 ha | 264,457 bushes, 1 Corne",
                      style: GoogleFonts.notoSerif(
                          textStyle: Theme.of(context).textTheme.bodyText2,
                          color: MyBlueGrayBlueGray400),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class TransactionCard extends StatelessWidget {
  const TransactionCard({
    Key? key,
    required this.transaction,
  }) : super(key: key);
  final Transaction transaction;

  @override
  Widget build(BuildContext context) {
    var dTarget = ((transaction.openingNumber.value!.totalManDays) ?? 0) *
        (transaction.activity.value!.dailyTarget ?? 0);
    return Container(
      height: 140,
      margin: EdgeInsets.all(1),
      decoration: MyBoxDecoration(bColor: Colors.transparent),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
            decoration: MyBoxDecoration(bColor: Colors.transparent),
            width: 85,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Week",
                  style: GoogleFonts.anton(
                      textStyle: Theme.of(context).textTheme.bodyText1,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 1,
                      color: MyBlueGrayBlueGray200),
                ),
                Text(
                  NumberFormat("00")
                      .format(getWeekNumber(transaction.dateTime!)),
                  style: GoogleFonts.anton(
                      textStyle: Theme.of(context).textTheme.headline4,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 4,
                      color: MyBlueGrayBlueGray300),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (transaction.status == TransactionStatus.saved)
                      const Icon(
                        Icons.cloud_done_rounded,
                        color: MyGreenGreen400,
                      ),
                    if (transaction.status == TransactionStatus.sent)
                      const Icon(
                        Icons.cloud_upload_rounded,
                        color: MyAmberAmber400,
                      ),
                    if (transaction.status == TransactionStatus.seen)
                      const Icon(
                        Icons.done_all_rounded,
                        color: MyGreenGreen400,
                      ),
                  ],
                )
              ],
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      DateFormat("EEEE, dd/MM/y").format(transaction.dateTime!),
                      style: GoogleFonts.notoSerif(
                          textStyle: Theme.of(context).textTheme.headline5,
                          color: MyBlueGrayBlueGray400),
                    ),
                    Text(
                      "${transaction.activity.value?.name}, ${transaction.field.value?.field.value?.division.value?.name} ${transaction.field.value?.field.value?.name}${transaction.field.value?.name}",
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.notoSerif(
                          textStyle: Theme.of(context).textTheme.bodyText2,
                          color: MyBlueGrayBlueGray400),
                    ),
                    //    double mds=(task.manDays.value?.female)+( task.manDays.value?.male);
                    Text(
                        "Man-days: ${NumberFormat("#,##0").format(transaction.openingNumber.value!.totalManDays)} | "
                        "Female: ${NumberFormat("#,##0").format(transaction.openingNumber.value?.female ?? 0)} (${NumberFormat("##0.0#").format((((transaction.openingNumber.value?.female) ?? 0) / (transaction.openingNumber.value?.totalManDays ?? 0)) * 100)}%), "
                        "PAP: ${NumberFormat("#,##0").format((transaction.openingNumber.value?.pap ?? 0))} (${NumberFormat("##0.0#").format(((transaction.openingNumber.value?.pap) ?? 0) / ((transaction.openingNumber.value?.female) ?? 0) * 100)}%)",
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.notoSerif(
                            textStyle: Theme.of(context).textTheme.bodyText2,
                            color: MyBlueGrayBlueGray400)),
                    Text(
                      "Dairy target: ${NumberFormat("#,##0.00#").format(dTarget)} ${transaction.activity.value?.targetMeasure}",
                      style: GoogleFonts.notoSerif(
                          textStyle: Theme.of(context).textTheme.bodyText2,
                          color: MyBlueGrayBlueGray400),
                    ),
                    Text(
                      "Done: ${NumberFormat("#,##0.00#").format(wDone(transaction.closingNumber.value!).workDone ?? 0)} ${wDone(transaction.closingNumber.value!).activityData?.measure} "
                      "( ${NumberFormat("##0.0#").format(((wDone(transaction.closingNumber.value!).workDone) ?? 0) / dTarget * 100)}%)",
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.notoSerif(
                          textStyle: Theme.of(context).textTheme.bodyText2,
                          color: MyBlueGrayBlueGray400),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                if (transaction.status == TransactionStatus.seen)
                  const Icon(
                    Icons.done_all_rounded,
                    color: MyGreenGreen700,
                  ),
                if (transaction.status == TransactionStatus.sent)
                  const Icon(
                    Icons.done_rounded,
                    color: MyGreenGreen300,
                  ),
                if (transaction.status == TransactionStatus.saved)
                  const Icon(
                    Icons.watch_later_outlined,
                    color: MyBlueGrayBlueGray400,
                  ),
                const Spacer(),
                ApprovalStatus(
                    title: "Man-days: ", approvalState: transaction.numbers),
                ApprovalStatus(
                    title: "work done: ", approvalState: transaction.work),
                const MySpecing(size: 1),
                InkWell(
                  onTap: () {
                    Get.bottomSheet(Container(
                      color: MyAmberAmber400,
                    ));
                  },
                  child: Row(
                    children: [
                      const Icon(Icons.comment_rounded),
                      Text(" (${transaction.comments.length})")
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

WorkDoneData wDone(ClosingNumber closingNumber) {
  var ww = closingNumber.workDoneData!.where((element) {
    return element.activityData!.isWageBase == true;
  }).first;
  if (ww != null) {
    return ww;
  }
  return closingNumber.workDoneData!.first;
}

class ApprovalStatus extends StatelessWidget {
  const ApprovalStatus({
    Key? key,
    required this.title,
    this.approvalState = VerificationStatus.pending,
  }) : super(key: key);
  final String title;
  final VerificationStatus? approvalState;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: title,
                style: GoogleFonts.notoSerif(
                    textStyle: Theme.of(context).textTheme.bodyText2,
                    color: MyBlueGrayBlueGray400),
              )
            ],
          ),
        ),
        if (approvalState == VerificationStatus.verified)
          const Icon(Icons.verified, color: MyGreenGreen700),
        if (approvalState == VerificationStatus.pending)
          const Icon(Icons.hourglass_top, color: MyBlueGrayBlueGray400),
        if (approvalState == VerificationStatus.rejected)
          const Icon(Icons.dangerous_rounded, color: MyRedRed600),
      ],
    );
  }
}

//#endregion
//#region Directories
int getWeekNumber(DateTime dateTime) => dateTime.weekOfYear;

//#endregion
//#region My Widget

class MyInputField extends StatelessWidget {
  final String title;
  final String hint;
  final TextEditingController? controller;
  final Widget? widget;
  final bool? isPassword;
  final TextStyle? style;
  final Color? bgColor;

  const MyInputField(
      {Key? key,
      required this.title,
      required this.hint,
      this.controller,
      this.widget,
      this.isPassword,
      this.style,
      this.bgColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Text(
              title,
              style: style ??
                  GoogleFonts.bitter(
                    textStyle: const TextStyle(
                        wordSpacing: .5,
                        fontSize: 16,
                        fontWeight: FontWeight.w400),
                  ),
            ),
          ),
          Container(
            height: 45,
            padding: const EdgeInsets.only(left: 15, right: 8),
            margin: const EdgeInsets.only(top: 10),
            decoration: BoxDecoration(
                color: bgColor,
                border: Border.all(color: Colors.black45, width: 1.0),
                borderRadius: BorderRadius.circular(10)),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    obscureText: isPassword == true ? true : false,
                    readOnly: widget == null ? false : true,
                    autofocus: false,
                    cursorColor: Colors.grey[500],
                    controller: controller,
                    style: GoogleFonts.bitter(
                      textStyle: const TextStyle(
                          wordSpacing: .5,
                          color: Colors.black,
                          fontSize: 14,
                          fontWeight: FontWeight.w400),
                    ),
                    decoration: InputDecoration(
                        hintText: hint,
                        hintStyle: GoogleFonts.bitter(
                          textStyle: const TextStyle(
                              wordSpacing: .5,
                              fontSize: 16,
                              fontWeight: FontWeight.w400),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: context.theme.backgroundColor,
                            width: 0,
                          ),
                        ),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: context.theme.backgroundColor,
                            width: 0,
                          ),
                        )),
                  ),
                ),
                widget == null
                    ? Container()
                    : Container(
                        child: widget,
                      )
              ],
            ),
          )
        ],
      ),
    );
  }
}

class MyInputField001 extends StatelessWidget {
  final String title;
  final String hint;
  final TextEditingController? controller;

  const MyInputField001(
      {Key? key, required this.title, required this.hint, this.controller})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Text(
              title,
              style: GoogleFonts.bitter(
                textStyle: const TextStyle(
                    wordSpacing: .5, fontSize: 16, fontWeight: FontWeight.w400),
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.only(left: 15, right: 8),
            margin: const EdgeInsets.only(top: 10),
            decoration: BoxDecoration(
                border: Border.all(color: Colors.black45, width: 1.0),
                borderRadius: BorderRadius.circular(10)),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    keyboardType: TextInputType.multiline,
                    minLines: 6,
                    maxLines: 20,
                    autofocus: false,
                    cursorColor: Colors.grey[500],
                    controller: controller,
                    style: GoogleFonts.bitter(
                      textStyle: const TextStyle(
                          wordSpacing: .5,
                          color: Colors.black,
                          fontSize: 14,
                          fontWeight: FontWeight.w400),
                    ),
                    decoration: InputDecoration(
                        hintText: hint,
                        hintStyle: GoogleFonts.bitter(
                          textStyle: const TextStyle(
                              wordSpacing: .5,
                              fontSize: 16,
                              fontWeight: FontWeight.w400),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: context.theme.backgroundColor,
                            width: 0,
                          ),
                        ),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: context.theme.backgroundColor,
                            width: 0,
                          ),
                        )),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class MyButton01 extends StatelessWidget {
  const MyButton01(
      {Key? key,
      required this.btnText,
      this.onPressed,
      this.btnColor = buttonColor,
      this.btnTextColor})
      : super(key: key);
  final String btnText;
  final Color? btnTextColor;
  final Color? btnColor;
  final Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 12, bottom: 8),
      child: ElevatedButton(
        style: ButtonStyle(
          elevation: MaterialStateProperty.all(0),
          backgroundColor: MaterialStateProperty.all(btnColor),
          textStyle: MaterialStateProperty.all(TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w800,
              color: btnTextColor ?? MyBlueGrayBlueGray100)),
        ),
        onPressed: onPressed,
        child: Container(
          // width: MediaQuery.of(context).size.width,
          height: 45,
          child: Center(
            child: Text(
              btnText,
              style: GoogleFonts.bitter(
                textStyle: TextStyle(
                    color: btnTextColor ?? MyBlueGrayBlueGray100,
                    wordSpacing: .5,
                    fontSize: 16,
                    fontWeight: FontWeight.w400),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class MySpecing extends StatelessWidget {
  final double size;
  const MySpecing({
    Key? key,
    required this.size,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: size * 5,
      width: size * 5,
    );
  }
}

class PgnImageAsset extends StatelessWidget {
  const PgnImageAsset({
    Key? key,
    required this.imgae,
    this.size,
    this.color,
  }) : super(key: key);
  final String imgae;
  final double? size;
  final Color? color;
  @override
  Widget build(BuildContext context) {
    return Image.asset(
      "assets/img_icons/$imgae.png",
      color: color,
      height: size,
      fit: BoxFit.cover,
    );
  }
}

class ImgIcon extends StatelessWidget {
  const ImgIcon(
      {Key? key,
      required this.imageIcon,
      this.currentIndex,
      this.index,
      this.iColor = iconColor})
      : super(key: key);

  final String imageIcon;
  final int? currentIndex;
  final int? index;
  final Color? iColor;
  @override
  Widget build(BuildContext context) {
    return Image.asset(
      "assets/img_icons/$imageIcon.png",
      height: 30,
      width: 30,
      color: index == null
          ? iColor
          : index == currentIndex
              ? selectedItemColor
              : iColor,
    );
  }
}
//#endregion
//#region Directories

//#endregion
