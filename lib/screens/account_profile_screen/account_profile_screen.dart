import 'dart:convert';
import 'dart:io';

import 'package:digi_school/api/api.dart';
import 'package:digi_school/api/repository/user_repository.dart';
import 'package:digi_school/api/response/login_response.dart';
import 'package:digi_school/auth_viewmodel.dart';
import 'package:digi_school/common_viewmodel.dart';
import 'package:digi_school/constants/colors.dart';
import 'package:digi_school/constants/fonts.dart';
import 'package:digi_school/widgets/cache_image_util.dart';
import 'package:digi_school/widgets/utils.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../configs/api_response.config.dart';
import '../../configs/preference.config.dart';
import '../../widgets/snakbar.utils.dart';

class AccountProfileScreen extends StatefulWidget {
  AccountProfileScreen({Key? key}) : super(key: key);
  static const String routeName = "/account-profile";
  @override
  _AccountProfileScreenState createState() => _AccountProfileScreenState();
}

class _AccountProfileScreenState extends State<AccountProfileScreen> {
  TextEditingController _firstNameController = TextEditingController();
  TextEditingController _lastNameController = TextEditingController();
  TextEditingController _panController = TextEditingController();
  TextEditingController _aboutYouController = TextEditingController();

  FocusNode _panNode = FocusNode();
  FocusNode _firstNameNode = FocusNode();
  FocusNode _lastNameNode = FocusNode();
  FocusNode _aboutYou = FocusNode();
  final _formKey = GlobalKey<FormState>();

  late UserData _user;

  void _requestFocus(_focusNode) {
    setState(() {
      FocusScope.of(context).unfocus();
      FocusScope.of(context).requestFocus(_focusNode);
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    getData();
    super.initState();
  }

  getData() async {
    final SharedPreferences localStorage = PreferenceUtils.instance;
    _user = UserData.fromJson(
        jsonDecode(localStorage.getString("LOGGED_IN_USER")!));

    _firstNameController.text = _user.firstname ?? "N/A";
    _lastNameController.text = _user.lastname ?? "N/A";
    _panController.text = _user.panNumber.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Consumer2<AuthViewModel, CommonViewModel>(
          builder: (context, auth, common, child) {
        return Scaffold(
            bottomNavigationBar: Container(
              child: Container(
                decoration: BoxDecoration(
                  color: kWhite,
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(10),
                    topLeft: Radius.circular(10),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      spreadRadius: 1,
                      blurRadius: 7,
                      offset: const Offset(-2, 0), // changes position of shadow
                    ),
                  ],
                ),
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                margin: EdgeInsets.zero,
                child: Row(
                  children: [
                    Expanded(
                        child: Container(
                            child: ElevatedButton(
                                style: ButtonStyle(
                                  side: MaterialStateProperty.all<BorderSide>(
                                    BorderSide(color: kPrimaryColor, width: 1),
                                  ),
                                  backgroundColor:
                                      MaterialStateProperty.all<Color>(
                                          Colors.white),
                                ),
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: Text(
                                  "Back",
                                  style: TextStyle(color: kBlack),
                                )))),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                        child: Container(
                            child: ElevatedButton(
                                style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all<Color>(
                                          kPrimaryColor),
                                ),
                                onPressed: () {
                                  // paymentGateway();
                                  if (_formKey.currentState!.validate()) {
                                    try {
                                      print("This is pan number"+_panController.text);
                                      auth.setRegisterFirstname(
                                          _firstNameController.text);
                                      auth.setRegisterLastname(
                                          _lastNameController.text);
                                      auth.setPanNumber(_panController.text);
                                      auth.updateProfile().then((value) {
                                        if (!isError(
                                            auth.updateUserApiResponse)) {
                                          Navigator.pop(context);
                                          common.getMyDetails();
                                          snackThis(
                                              context: context,
                                              color: Colors.green,
                                              content: Text(auth
                                                  .updateUserApiResponse.message
                                                  .toString()),
                                              duration: 3);
                                        } else {
                                          snackThis(
                                              context: context,
                                              color: Colors.red,
                                              content: Text(auth
                                                  .updateUserApiResponse.message
                                                  .toString()),
                                              duration: 3);
                                        }
                                        // print(auth.loginApiResponse.toString());
                                        common.setLoading(false);
                                      }).catchError((e) {
                                        snackThis(
                                            context: context,
                                            color: Colors.red,
                                            content: Text(auth
                                                .updateUserApiResponse.message
                                                .toString()),
                                            duration: 3);
                                        common.setLoading(false);
                                      });
                                    } catch (e) {
                                      print(e.toString());
                                    }
                                  }
                                },
                                child: Text("Save")))),
                  ],
                ),
              ),
            ),
            body: Container(
                color: kWhite,
                child: SafeArea(
                    child: ScrollConfiguration(
                        behavior:
                            const ScrollBehavior().copyWith(overscroll: false),
                        child: CustomScrollView(slivers: <Widget>[
                          SliverAppBar(
                            toolbarHeight: 50,
                            backgroundColor: kWhite,
                            pinned: true,
                            automaticallyImplyLeading: true,
                            leading: backButton(context),
                            titleSpacing: 0,
                            title: Container(
                              margin: EdgeInsets.only(right: 10),
                              alignment: Alignment.centerRight,
                              height: 50,
                              decoration: BoxDecoration(
                                  // color: Colors.red
                                  ),
                              padding: EdgeInsets.symmetric(
                                  horizontal: 0, vertical: 5),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [scafoldHeader("About You")],
                              ),
                            ),
                          ),
                          SliverToBoxAdapter(
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                SizedBox(
                                  height: 20,
                                ),
                                Container(
                                  alignment: Alignment.center,
                                  child: Stack(children: [
                                    Padding(
                                      padding: const EdgeInsets.only(left: 8.0),
                                      child: SizedBox(
                                        height: 100,
                                        width: 100,
                                        child:
                                        // ClipRRect(
                                        //   borderRadius: BorderRadius.circular(50),
                                        //   child:
                                        //   CacheImageUtil(
                                        //     image: common.userDetail[
                                        //     'userImage'],
                                        //     height: 100,
                                        //     width: 100,
                                        //   ),
                                        // )
                                        CircleAvatar(
                                            radius: 18,
                                            backgroundColor: common.userDetail[
                                                        'userImage'] ==
                                                    null
                                                ? Colors.grey
                                                : Colors.white,
                                            child: _imageFile == null
                                                ? common.userDetail[
                                                            'userImage'] ==
                                                        null
                                                    ? Text(
                                                        common.userDetail[
                                                                    'firstname']
                                                                    [0]
                                                                .toUpperCase() +
                                                            "" +
                                                            common.userDetail[
                                                                    'lastname']
                                                                    [0]
                                                                .toUpperCase(),
                                                        style: const TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color:
                                                                Colors.white),
                                                      )
                                                    : ClipOval(
                                                        child: Image.network(
                                                          domain +
                                                              '/' +
                                                              common.userDetail[
                                                                  'userImage'],
                                                          height: 100,
                                                          width: 100,
                                                          fit: BoxFit.cover,
                                                        ),
                                                      )
                                                : ClipOval(
                                                    child: Image.file(
                                                      File(_imageFile!.path),
                                                      height: 100,
                                                      width: 100,
                                                      fit: BoxFit.cover,
                                                    ),
                                                  )),
                                      ),
                                    ),
                                    Positioned(
                                        bottom: 0,
                                        right: 6,
                                        child: InkWell(
                                          onTap: () async {
                                            showModalBottomSheet(
                                              context: context,
                                              builder: ((builder) =>
                                                  bottomSheet(common)),
                                            );
                                          },
                                          child: Container(
                                            height: 40,
                                            width: 40,
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              border: Border.all(
                                                width: 4,
                                                color: Theme.of(context)
                                                    .scaffoldBackgroundColor,
                                              ),
                                              color: Colors.grey,
                                            ),
                                            child: const Icon(
                                              Icons.edit,
                                              color: Colors.white,
                                            ),
                                          ),
                                        )),
                                  ]),
                                ),
                                SizedBox(
                                  height: 40,
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10.0, vertical: 5.0),
                                  child: TextFormField(
                                    focusNode: _firstNameNode,
                                    onTap: () => _requestFocus(_firstNameNode),
                                    enabled: true,
                                    keyboardType: TextInputType.text,
                                    validator: (value) {
                                      // Null check
                                      if (value == "") {
                                        return 'Please enter first name';
                                      }
                                      // success condition
                                      return null;
                                    },
                                    decoration: InputDecoration(
                                        hintText: "Enter First Name",
                                        fillColor: gray_100,
                                        contentPadding: EdgeInsets.symmetric(
                                            vertical: -10, horizontal: 10),
                                        filled: true,
                                        enabledBorder: const OutlineInputBorder(
                                            borderSide:
                                                BorderSide(color: gray_500)),
                                        focusColor: kPrimaryColor,
                                        focusedBorder: const OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: kPrimaryColor)),
                                        floatingLabelBehavior:
                                            FloatingLabelBehavior.always,
                                        label: Text(
                                          "First Name",
                                          style:
                                              TextStyle(color: kPrimaryColor),
                                        )),
                                    controller: _firstNameController,
                                  ),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10.0, vertical: 5.0),
                                  child: TextFormField(
                                    enabled: true,
                                    keyboardType: TextInputType.text,
                                    validator: (value) {
                                      // Null check
                                      if (value == "") {
                                        return 'Please enter last name';
                                      }
                                      // success condition
                                      return null;
                                    },
                                    focusNode: _lastNameNode,
                                    onTap: () => _requestFocus(_lastNameNode),
                                    decoration: const InputDecoration(
                                        hintText: "Enter Last Name",
                                        fillColor: gray_100,
                                        contentPadding: EdgeInsets.symmetric(
                                            vertical: -10, horizontal: 10),
                                        filled: true,
                                        enabledBorder: OutlineInputBorder(
                                            borderSide:
                                                BorderSide(color: gray_500)),
                                        focusColor: kPrimaryColor,
                                        focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: kPrimaryColor)),
                                        floatingLabelBehavior:
                                            FloatingLabelBehavior.always,
                                        label: Text(
                                          "Last Name",
                                          style:
                                              TextStyle(color: kPrimaryColor),
                                        )),
                                    controller: _lastNameController,
                                  ),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10.0, vertical: 5.0),
                                  child: TextFormField(
                                    enabled: true,
                                    focusNode: _panNode,
                                    onTap: () => _requestFocus(_panNode),
                                    keyboardType: TextInputType.number,
                                    validator: (value) {
                                      // Null check
                                      if (value == "") {
                                        return 'Please pan number';
                                      }
                                      // success condition
                                      return null;
                                    },
                                    decoration: const InputDecoration(
                                        contentPadding: EdgeInsets.symmetric(
                                            vertical: -10, horizontal: 10),
                                        filled: true,
                                        hintText: "Enter pan number",
                                        fillColor: gray_100,
                                        enabledBorder: OutlineInputBorder(
                                            borderSide:
                                                BorderSide(color: gray_500)),
                                        focusColor: kPrimaryColor,
                                        focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: kPrimaryColor)),
                                        floatingLabelBehavior:
                                            FloatingLabelBehavior.always,
                                        // labelText: "Certificate Name",
                                        label: Text(
                                          "Pan Number",
                                          style:
                                              TextStyle(color: kPrimaryColor),
                                        )),
                                    controller: _panController,
                                  ),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                // Padding(
                                //   padding:
                                //   const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
                                //   child: TextFormField(
                                //     enabled: true,
                                //     focusNode: _aboutYou,
                                //     onTap: ()=>_requestFocus(_aboutYou),
                                //     maxLines: 5,
                                //     keyboardType: TextInputType.multiline,
                                //     validator: (value) {
                                //       // Null check
                                //       if (value == "") {
                                //         return 'Please enter something about you';
                                //       }
                                //       // success condition
                                //       return null;
                                //     },
                                //     decoration: InputDecoration(
                                //         contentPadding: EdgeInsets.symmetric(
                                //             vertical: 20, horizontal: 10),
                                //         filled: true,
                                //         hintText: "Say a few things about you",
                                //         fillColor: gray_100,
                                //         enabledBorder:
                                //         const OutlineInputBorder(
                                //             borderSide: BorderSide(
                                //                 color: gray_500)),
                                //         focusColor: kPrimaryColor,
                                //         focusedBorder:
                                //         const OutlineInputBorder(
                                //             borderSide: BorderSide(
                                //                 color: kPrimaryColor)),
                                //         floatingLabelBehavior:
                                //         FloatingLabelBehavior.always,
                                //         // labelText: "Certificate Name",
                                //         label: Text("About You", style: TextStyle(
                                //             color: kPrimaryColor
                                //         ),)
                                //     ),
                                //     controller: _aboutYouController,
                                //   ),
                                // ),
                              ],
                            ),
                          )
                        ])))));
      }),
    );
  }

  Widget bottomSheet(CommonViewModel model) {
    return Container(
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
      height: 80.0,
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Column(
        children: <Widget>[
          const Text(
            "Choose Photo",
            style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 8,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextButton.icon(
                icon: const Icon(Icons.camera, color: Colors.red),
                onPressed: () async {
                  _pickImage(ImageSource.camera, model);
                  Navigator.of(context, rootNavigator: true).pop();
                },
                label: const Text("Camera"),
              ),
              SizedBox(
                width: 15,
              ),
              TextButton.icon(
                icon: const Icon(Icons.image, color: Colors.green),
                onPressed: () {
                  _pickImage(ImageSource.gallery, model);
                  Navigator.of(context, rootNavigator: true).pop();
                },
                label: const Text("Gallery"),
              ),
            ],
          )
        ],
      ),
    );
  }

  PickedFile? _imageFile;
  final ImagePicker _picker = ImagePicker();
  Future<void> _pickImage(ImageSource source, CommonViewModel model) async {
    var selected =
        await ImagePicker().pickImage(source: source, imageQuality: 10);

    setState(() {
      if (selected != null) {
        _imageFile = PickedFile(selected.path);
        Update(_imageFile!, model);
      } else {
        snackThis(
            context: context,
            content: const Text('No image selected'),
            color: Colors.red,
            duration: 2);
        // snacl777.showToast(msg: 'No image selected.');
      }
    });
  }

  Update(PickedFile abc, CommonViewModel common) async {
    try {
      final result = await UserRepository().updatedisplaypicture(abc);
      // final result = await Imageservice().updateImage("image", abc);
      if (result.success == true) {
        common.setLoading(true);
        snackThis(
            context: context,
            content: Text(result.msg.toString()),
            duration: 2,
            color: Colors.green);
        common.setLoading(false);
      } else {
        common.setLoading(true);
        snackThis(
            context: context,
            content: Text(result.msg.toString()),
            duration: 2,
            color: Colors.red);
        common.setLoading(false);
      }
    } on Exception catch (e) {
      common.setLoading(true);
      snackThis(
          context: context,
          content: Text(e.toString()),
          duration: 2,
          color: Colors.red);
      common.setLoading(false);
      // TODO
    }
  }
}
