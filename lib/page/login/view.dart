import 'package:wood/widget/button_text.dart';
import 'package:wood/widget/form.dart';
import 'package:flutter/material.dart';
import '../../core/config/design_config.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController numberController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final FocusNode numberFocusNode = FocusNode();
  final FocusNode passwordFocusNode = FocusNode();

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: scaffoldKey,
        backgroundColor: Color(0xFFFFF7ED),
        body: CustomScrollView(
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
                        onFieldSubmitted: (s) {},
                      ),
                      ButtonText(
                          textColor: DesignConfig.textFieldColor,
                          minWidth: MediaQuery.of(context).size.width,
                          text: 'LOGIN',
                          buttonColor: Colors.transparent,
                          borderColor: DesignConfig.textFieldColor,
                          onTap: (){},
                          height: 50,
                      margin: EdgeInsets.only(bottom: 20)),
                    ],
                  )
              ),
            ),
          ],
        ));
  }
}



