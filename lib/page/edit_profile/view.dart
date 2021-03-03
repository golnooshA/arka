import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:wood/core/localization/language.dart';
import 'package:wood/core/router/routes.dart';
import 'dart:ui';
import 'package:wood/core/storage/settings.dart';
import 'package:wood/core/helper/ui.dart' as ui;
import 'package:wood/data/city.dart';
import 'package:wood/data/province.dart';
import 'package:wood/widget/action_sheet_simple.dart';
import 'package:wood/widget/button_text.dart';
import 'package:wood/widget/form.dart';
import 'package:wood/widget/ink_wrapper.dart';
import 'package:flutter/material.dart';
import 'package:wood/widget/set_state.dart';
import '../../core/config/design_config.dart';

class EditProfile extends StatefulWidget {
  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController postalCodeController = TextEditingController();
  final TextEditingController addressController = TextEditingController();

  final FocusNode nameFocus = FocusNode();
  final FocusNode postalCodeFocus = FocusNode();
  final FocusNode addressFocus = FocusNode();

  String provinceText = 'Province';

  Settings settings;
  Language language;

  bool isLoading = false;
  final SetStateController buttonController = SetStateController();
  final SetStateController provinceController = SetStateController();
  final SetStateController citiesController = SetStateController();

  Province selectedProvince;
  City selectedCity;

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    if (settings == null) {
      settings = Provider.of<Settings>(context, listen: false);
    }
    nameController.text = settings.user.name;
    postalCodeController.text = settings.user?.postalCode?.toString() ?? '';
    addressController.text = settings.user?.address ?? '';
    if(settings.user.province != null){
      selectedProvince = Province(
          name: settings.user.province,
          cities: []
      );
    }
    if(settings.user.city != null){
      selectedCity = City(
        name: settings.user.province,
      );
    }
    super.initState();
  }


  Future<void> sendInformation(BuildContext context) async{

    final name = nameController.text.trim();

    if(name == null){
      return ui.showSnackBar(
          context: context,
          text: "name field should not be empty"
      );
    }


    final postalCode = postalCodeController.text.trim();

    if(postalCode == null){
      return ui.showSnackBar(
          context: context,
          text: "postal code field should not be empty"
      );
    }


    final address = addressController.text.trim();

    if(address == null){
      return ui.showSnackBar(
          context: context,
          text: "fill address text field"
      );
    }


    if((provinceController == null && provinceController != null) || (citiesController == null && citiesController != null)){
      return ui.showSnackBar(
          context: context,
          text: 'select a province then a city'
      );
    }

    isLoading = true;

    buttonController.setState();
    final res = await settings.editProfile
      (name: nameController.text,
    address: address == '' ? null : addressController.text,
    postalCode: postalCode == '' ? null : postalCodeController.text,
    province: selectedProvince ?.name,
    city:  selectedCity?.name);

    isLoading = false;
    buttonController.setState();

    ui.showSnackBar(
        context: context,
        text: 'edit your profile',
      backgroundColor: Colors.green
    );
    if(res.isOk){
      Navigator.pushNamedAndRemoveUntil(context, Routes.home, (route) => false);
    }


  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: DesignConfig.backgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        iconTheme: IconThemeData(color: DesignConfig.appBarOptionsColor),
        elevation: 0,
        centerTitle: true,
        title: Text('Edit Profile',
            textAlign: TextAlign.center,
            style: TextStyle(
                color: DesignConfig.appBarOptionsColor,
                fontSize: DesignConfig.appBarTextFontSize,
                fontWeight: FontWeight.w400)),
      ),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Container(
              width: MediaQuery.of(context).size.width,
              margin: EdgeInsets.symmetric(horizontal: 40),
              child: Column(
                children: [
                  TextFieldSimple(
                    title: "Name",
                    controller: nameController,
                    margin: EdgeInsets.only(bottom: 4, top: 40),
                    width: MediaQuery.of(context).size.width,
                    maxLines: 1,
                    keyboardType: TextInputType.text,
                    keyboardButtonAction: TextInputAction.search,
                    focusNode: nameFocus,
                  ),
                  InkWrapper(
                    highlightColor: DesignConfig.highlightColor,
                    splashColor: DesignConfig.splashColor,
                    child: Container(
                      alignment: AlignmentDirectional.centerStart,
                      margin: EdgeInsets.only(top: 24),
                      padding: EdgeInsets.only(bottom: 8),
                      decoration: BoxDecoration(
                          border: Border(
                              bottom: BorderSide(
                                  color: DesignConfig.textFieldColor))),
                      child: SetState(
                          builder: () {
                            return Text(selectedProvince?.name ?? 'Province',
                                textDirection: TextDirection.ltr,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: DesignConfig.textFieldColor,
                                    fontSize: DesignConfig.textFontSize,
                                    fontWeight: FontWeight.w600));
                          },
                          controller: citiesController),
                    ),

                    onTap: () async {
                      selectedProvince = await showModalBottomSheet<Province>(
                          context: context,
                          isDismissible: true,
                          builder: (BuildContext buildContext) {
                            return ActionSheetSimple(
                              data: (settings.provinces).map((e) {
                                return ActionSheeSimpleData(
                                    title: e.name,
                                    onTap: () {
                                      Navigator.pop(context, e);
                                    });
                              }).toList(),
                            );
                          });

                      if (selectedProvince != null) {
                        provinceController.setState();
                        selectedCity = null;
                        citiesController.setState();
                      }
                    },
                  ),

                  InkWrapper(
                    highlightColor: DesignConfig.highlightColor,
                    splashColor: DesignConfig.splashColor,
                    child: Container(
                      alignment: AlignmentDirectional.centerStart,
                      margin: EdgeInsets.only(top: 30),
                      padding: EdgeInsets.only(bottom: 8),
                      decoration: BoxDecoration(
                          border: Border(
                              bottom: BorderSide(
                                  color: DesignConfig.textFieldColor))),
                      child: SetState(
                          builder: () {
                            return Text(selectedCity?.name ?? 'City',
                                textDirection: TextDirection.ltr,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: DesignConfig.textFieldColor,
                                    fontSize: DesignConfig.textFontSize,
                                    fontWeight: FontWeight.w600));
                          },
                          controller: citiesController),
                    ),

                    onTap:  () async {
                      if (selectedProvince?.name == null ||
                          selectedProvince.cities.isEmpty) {
                        ui.showSnackBar(
                            context: context,
                            text: 'At First, Select Your Province');
                        return;
                      }
                      selectedCity = await showModalBottomSheet<City>(
                          context: context,
                          isDismissible: true,
                          builder: (BuildContext buildContext) {
                            return ActionSheetSimple(
                              data: (selectedProvince.cities).map((e) {
                                return ActionSheeSimpleData(
                                    title: e.name,
                                    onTap: () {
                                      Navigator.pop(context, e);
                                    });
                              }).toList(),
                            );
                          });

                      if (selectedCity != null) {
                        citiesController.setState();
                      }
                    },
                  ),

                  TextFieldSimple(
                    title: "Postal Code",
                    controller: postalCodeController,
                    margin: EdgeInsets.only(bottom: 4, top: 16),
                    width: MediaQuery.of(context).size.width,
                    maxLines: 1,
                    keyboardType: TextInputType.text,
                    keyboardButtonAction: TextInputAction.search,
                    focusNode: postalCodeFocus,
                    onFieldSubmitted: (s) {
                      postalCodeFocus.unfocus();
                      addressFocus.requestFocus();
                    },
                  ),
                  TextFieldSimple(
                    title: "Address",
                    controller: addressController,
                    margin: EdgeInsets.only(bottom: 4, top: 8),
                    width: MediaQuery.of(context).size.width,
                    maxLines: 1,
                    keyboardType: TextInputType.text,
                    keyboardButtonAction: TextInputAction.search,
                    focusNode: addressFocus,
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
                          text: 'Edit Profile',
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
              ),
            ),
          ),
        ],
      ),
    );
  }
}
