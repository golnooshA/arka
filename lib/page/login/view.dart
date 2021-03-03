import 'package:provider/provider.dart';
import 'package:wood/core/localization/language.dart';
import 'package:wood/core/router/routes.dart';
import 'package:wood/core/storage/settings.dart';
import 'package:wood/widget/button_text.dart';
import 'package:wood/widget/form.dart';
import 'package:flutter/material.dart';
import 'package:wood/widget/set_state.dart';
import '../../core/config/design_config.dart';
import 'package:wood/core/helper/ui.dart' as ui;

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController numberController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final FocusNode numberFocusNode = FocusNode();
  final FocusNode passwordFocusNode = FocusNode();

  final SetStateController buttonController = SetStateController();

  Settings settings;
  Language language;

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  void initState() {
    if(settings == null){
      settings = Provider.of<Settings>(context, listen: false);
    }

    super.initState();
  }

  Future<void> sendInformation(BuildContext context) async{

    final number = int.tryParse(numberController.text.trim());

    if(number == null){
      return ui.showSnackBar(
        context: context,
        text: "fill all box"
      );

    }

    if(passwordController.text.length <6){
     return ui.showSnackBar(
        context: context,
        text: 'fill more than 5 character'
      );
    }

    buttonController.setState();
    final res = await settings.login(number, passwordController.text, language: language);
    buttonController.setState();

    ui.showSnackBar(
        context: context,
        text: 'login to app'
    );
    if(res.isOk){
      Navigator.pushNamedAndRemoveUntil(context, Routes.home, (route) => false);
    }


  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: scaffoldKey,
        backgroundColor: Color(0xFFFFF7ED),
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          iconTheme: IconThemeData(color: DesignConfig.textColor),
        ),
        body:CustomScrollView(
          slivers: [

            SliverToBoxAdapter(
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height / 1.6,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/2.png"),
                    fit: BoxFit.fill,
                  ),
                ),
              ),
            ),

            SliverToBoxAdapter(
              child: Container(
                  width: MediaQuery.of(context).size.width,
                  margin: EdgeInsets.symmetric(horizontal: 40),
                  child:  Column(
                    children: [
                      TextFieldSimple(
                        title: "Username",
                        controller: numberController,
                        margin: EdgeInsets.only(bottom: 4),
                        width: MediaQuery.of(context).size.width,
                        maxLines: 1,
                        keyboardType: TextInputType.number,
                        keyboardButtonAction: TextInputAction.search,
                        focusNode: numberFocusNode,
                        onFieldSubmitted: (s) {
                          numberFocusNode.unfocus();
                          passwordFocusNode.requestFocus();
                        },
                      ),
                      TextFieldSimple(
                        title: "Password",
                        controller: passwordController,
                        margin:
                        EdgeInsets.only(top: 8, bottom: 40),
                        width: MediaQuery.of(context).size.width,
                        maxLines: 1,
                        keyboardType: TextInputType.text,
                        keyboardButtonAction: TextInputAction.search,
                        focusNode: passwordFocusNode,
                        onFieldSubmitted: (s) {

                            sendInformation(context);

                        },
                      ),
                    SetState(
                      controller: buttonController,
                      builder: (){
                        return   ButtonText(
                            textColor: DesignConfig.textFieldColor,
                            minWidth: MediaQuery.of(context).size.width,
                            text: 'LOGIN',
                            buttonColor: Colors.transparent,
                            borderColor: DesignConfig.textFieldColor,
                            onTap: (){
                              sendInformation(context);
                            },
                            height: 50,
                            margin: EdgeInsets.only(bottom: 20));
                      },
                    )
                    ],
                  )
              ),
            ),
          ],
        ));
  }
}



