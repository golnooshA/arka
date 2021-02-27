import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'dart:ui';
import 'package:wood/core/storage/settings.dart';
import 'package:wood/core/helper/ui.dart' as ui;
import 'package:wood/data/city.dart';
import 'package:wood/data/province.dart';
import 'package:wood/page/main/view.dart';
import 'package:wood/widget/action_sheet_simple.dart';
import 'package:wood/widget/button_text.dart';
import 'package:wood/widget/default_network_image.dart';
import 'package:wood/widget/form.dart';
import 'package:wood/widget/ink_wrapper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:wood/widget/set_state.dart';
import '../../core/config/design_config.dart';

class EditProfile extends StatefulWidget {
  @override
  _GalleryState createState() => _GalleryState();
}

class _GalleryState extends State<EditProfile> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController postalCodeController = TextEditingController();
  final TextEditingController addressController = TextEditingController();

  final FocusNode nameFocus = FocusNode();
  final FocusNode postalCodeFocus = FocusNode();
  final FocusNode addressFocus = FocusNode();

  String provinceText = 'Province';

  Settings settings;

  bool isLoading = false;
  final SetStateController buttonController = SetStateController();
  final SetStateController provinceController = SetStateController();
  final SetStateController citiesController = SetStateController();

  Province selectedProvince;
  City selectedCity;

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  // @override
  // void initState() {
  //   if (settings == null) {
  //     settings = Provider.of<Settings>(context, listen: false);
  //   }
  //   nameController.text = settings.user.name;
  //   postalCodeController.text = settings.user?.postalCode?.toString() ?? '';
  //   addressController.text = settings.user?.address ?? '';
  //   if(settings.user.province != null){
  //     selectedProvince = Province(
  //         name: settings.user.province,
  //         cities: []
  //     );
  //   }
  //   if(settings.user.city != null){
  //     selectedCity = City(
  //       name: settings.user.province,
  //     );
  //   }
  //   super.initState();
  // }

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
                    title: "Username",
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
                    onFieldSubmitted: (s) {},
                  ),
                  ButtonText(
                      textColor: DesignConfig.textFieldColor,
                      minWidth: MediaQuery.of(context).size.width,
                      text: 'LOGIN',
                      buttonColor: Colors.transparent,
                      borderColor: DesignConfig.textFieldColor,
                      onTap: () {},
                      height: 50,
                      margin: EdgeInsets.only(bottom: 20, top: 30)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
