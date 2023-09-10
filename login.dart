import 'package:data_capture/pages/activities/activity_page.dart';
import 'package:data_capture/pages/estate_page.dart';
import 'package:data_capture/responsive/responsive_layout.dart';
import 'package:data_capture/util/constat.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';


class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final bool isConfig = false;
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    double w = MediaQuery.of(context).size.width;
    return Scaffold(
      body: ResponsiveLayout(
        desktopBody: Scaffold(),
        mobileBody: const Scaffold(
          backgroundColor: primaryColor,
          body: LoginWidget(),
        ),
        tabletBody: Scaffold(
          backgroundColor: primaryColor,
          body: SafeArea(
            child: SingleChildScrollView(
              child: LayoutBuilder(
                builder: (context, constraints) {
                  if (constraints.maxWidth < 550) {
                    return Padding(
                      padding: EdgeInsets.symmetric(horizontal: w * .05),
                      child: LoginWidget(),
                    );
                  } else if (constraints.maxWidth < 750) {
                    return Padding(
                      padding: EdgeInsets.symmetric(horizontal: w * .1),
                      child: LoginWidget(),
                    );
                  } else if (constraints.maxWidth < 850) {
                    return Padding(
                      padding: EdgeInsets.symmetric(horizontal: w * .15),
                      child: LoginWidget(),
                    );
                  } else if (constraints.maxWidth < 950) {
                    return Padding(
                      padding: EdgeInsets.symmetric(horizontal: w * .2),
                      child: LoginWidget(),
                    );
                  } else {
                    return Padding(
                      padding: EdgeInsets.symmetric(horizontal: w * .3),
                      child: LoginWidget(),
                    );
                  }
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class LoginWidget extends StatelessWidget {
  const LoginWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _loginControl = Get.find<LoginController>();
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            children: [
              Container(
                  margin: EdgeInsets.only(top: 20),
                  alignment: Alignment.center,
                  child: const PgnImageAsset(
                    imgae: "user",
                    size: 120,
                    color: MyBlueGrayBlueGray50,
                  )),
              Text(
                "User Login",

                style: GoogleFonts.mochiyPopOne(
                    textStyle: Theme.of(context).textTheme.headline5,
                    color: MyBlueGrayBlueGray100),
              ),
              Container(
                decoration: BoxDecoration(
                    color: Colors.white70,
                    border: Border.all(color: Colors.black45, width: 1.0),
                    borderRadius: BorderRadius.circular(10)),
                margin: EdgeInsets.all(20),
                padding: EdgeInsets.all(20),

                child: Column(
                  children: [
                    MyInputField(
                      title: "Username",
                      hint: "Enter Username",
                      controller: _loginControl.txtUsername,
                    ),
                    MyInputField(
                      title: "Password",
                      hint: "Enter password",
                      controller: _loginControl.txtPassword,
                      isPassword: true,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: MyButton01(
                            btnText: "Login",
                            onPressed: () {
                              Get.off(const ActivityPage());

                            },
                            btnColor: MyBlueGrayBlueGray500,
                          ),
                        ),
                        MySpecing(size: 2),
                        Expanded(
                          child: MyButton01(
                            btnText: "Api Config",
                            onPressed: () {
                              print(MediaQuery.of(context).size);
                            },
                            btnColor: MyBlueGrayBlueGray700,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class LoginController extends GetxController {
  final txtUsername = TextEditingController();
  final txtPassword = TextEditingController();
}

