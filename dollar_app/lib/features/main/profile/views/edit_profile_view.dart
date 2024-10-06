import 'dart:developer';
import 'dart:io';

import 'package:dollar_app/features/main/profile/model/profile_model.dart';
import 'package:dollar_app/features/set_up/provider/set_up_provider.dart';
import 'package:dollar_app/features/shared/widgets/app_primary_button.dart';
import 'package:dollar_app/features/shared/widgets/app_text_field.dart';
import 'package:dollar_app/features/shared/widgets/custom_app_bar.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconly/iconly.dart';
import 'package:dollar_app/services/file_picker_service.dart' as fps;

class EditProfileView extends ConsumerStatefulWidget {
  const EditProfileView({super.key, required this.userData});
  final ProfileData userData;

  @override
  ConsumerState<EditProfileView> createState() => _SetUpViewState();
}

class _SetUpViewState extends ConsumerState<EditProfileView> {
  File? _image;
  String? _imageFromServer;
  late TextEditingController _firstNameController;
  late TextEditingController _lastNameController;
  late TextEditingController _phoneController;
  bool _validated = false;
  String? selectedValue;

  @override
  void initState() {
    super.initState();
    _firstNameController =
        TextEditingController(text: widget.userData.firstName);
    _lastNameController = TextEditingController(text: widget.userData.lastName);
    selectedValue = widget.userData.gender;
    _phoneController = TextEditingController(text: widget.userData.phoneNumber);
    _imageFromServer = widget.userData.avatar;
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  List<DropdownMenuItem<String>> get dropDownList {
    List<DropdownMenuItem<String>> menuItem = [
      DropdownMenuItem(
        value: "Male",
        child: Text(
          "Male",
          style: GoogleFonts.lato(fontSize: 12.sp),
        ),
      ),
      DropdownMenuItem(
        value: "Female",
        child: Text("Female", style: GoogleFonts.lato(fontSize: 12.sp)),
      ),
      DropdownMenuItem(
        value: "Prefer Not Stay",
        child:
            Text("Prefer Not Stay", style: GoogleFonts.lato(fontSize: 12.sp)),
      ),
    ];

    return menuItem;
  }

  void _validateFields() {
    final hasImage = _image != null;
    final hasFirstName = _firstNameController.text.isNotEmpty;
    final hasLastName = _lastNameController.text.isNotEmpty;
    final hasGender = selectedValue != null;
    final hasPhone = _phoneController.text.isNotEmpty;
    final isValid =
        hasImage && hasFirstName && hasLastName && hasGender && hasPhone;
    _validated = isValid;

    log(_validated.toString());

    setState(() {});
  }

  Future<void> _pickAttachments() async {
    try {
      FilePickerResult? result =
          await fps.FilePickerService.pickAttachments(extensions: [
        'jpg',
        'jpeg',
        'png',
      ]);
      if (result != null) {
        _image = File(result.files.single.path!);
      }
      setState(() {});
    } catch (e) {
      setState(() {
        "An error occurred while picking files: $e";
      });
    }

    _validateFields();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      appBar: CustomAppBar(
        showNofication: false,
        title: Text(
          "Edit Profile",
          style:
              GoogleFonts.aBeeZee(fontSize: 14.sp, fontWeight: FontWeight.bold),
        ),
      ),
      body: SafeArea(
          child: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 10.h,
            ),
            Align(
              alignment: Alignment.center,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _image == null
                      ? Container(
                          width: 100.w,
                          height: 100.h,
                          decoration: BoxDecoration(
                              image: _imageFromServer != null ? DecorationImage(
                                  image: NetworkImage(_imageFromServer!),
                                  fit: BoxFit.cover): null,
                              border: Border.all(
                                  color: Theme.of(context).dividerColor),
                              shape: BoxShape.circle),
                        )
                      : Container(
                          width: 100.w,
                          height: 100.h,
                          decoration: BoxDecoration(
                              image: _image != null
                                  ? DecorationImage(
                                      image: FileImage(_image!),
                                      fit: BoxFit.cover)
                                  : null,
                              border: Border.all(
                                  color: Theme.of(context).dividerColor),
                              shape: BoxShape.circle),
                        ),
                  AppPrimaryButton(
                      radius: 8,
                      color: Theme.of(context).dividerColor,
                      onPressed: _pickAttachments,
                      title: 'select image',
                      putIcon: false,
                      enabled: true,
                      height: 20.h,
                      width: 100.w),
                ],
              ),
            ),
            SizedBox(
              height: 8.h,
            ),
            AppTextField(
              controller: _firstNameController,
              keybordType: TextInputType.name,
              onchaged: (value) {
                _validateFields();
              },
              labelText: 'First Name',
              errorText: '',
              hintText: 'Enter your first name',
              icon: IconlyBold.profile,
            ),
            SizedBox(
              height: 8.h,
            ),
            AppTextField(
              controller: _lastNameController,
              keybordType: TextInputType.name,
              onchaged: (value) {
                _validateFields();
              },
              labelText: 'Last Name',
              errorText: '',
              hintText: 'Enter your last name',
              icon: IconlyBold.profile,
            ),
            SizedBox(
              height: 8.h,
            ),
            Text(
              "Gender",
              style: GoogleFonts.lato(
                  fontWeight: FontWeight.w500,
                  fontSize: 12.sp,
                  color: isDark ? Theme.of(context).dividerColor : null),
            ),
            SizedBox(
              height: 5.h,
            ),
            SizedBox(
              height: 35.h,
              child: DropdownButtonFormField(
                icon: Container(),
                decoration: InputDecoration(
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 0.h, horizontal: 10.w),
                  isDense: true,
                  prefixIcon: Icon(
                    Icons.female,
                    size: 17.r,
                    color: Theme.of(context).dividerColor,
                  ),
                  suffix: Icon(
                    Icons.arrow_drop_down,
                    size: 17.r,
                    color: Theme.of(context).dividerColor,
                  ),
                  border: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Theme.of(context).dividerColor),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Theme.of(context).dividerColor),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Theme.of(context).dividerColor),
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                style: GoogleFonts.lato(
                    fontSize: 12.sp, color: Theme.of(context).dividerColor),
                hint: Text(
                  "Select A Gender",
                  style: GoogleFonts.lato(fontSize: 12.sp),
                ),
                items: dropDownList,
                onChanged: (String? value) {
                  selectedValue = value!;

                  _validateFields();
                },
                value: selectedValue,
              ),
            ),
            SizedBox(
              height: 8.h,
            ),
            AppTextField(
              readOnly: true,
              keybordType: TextInputType.name,
              onchaged: (value) {
                _validateFields();
              },
              labelText: 'Email ',
              errorText: '',
              hintText: widget.userData.email ?? '',
              icon: IconlyBold.message,
            ),
            SizedBox(
              height: 8.h,
            ),
            AppTextField(
              controller: _phoneController,
              keybordType: TextInputType.phone,
              onchaged: (value) {
                _validateFields();
              },
              labelText: 'Phone ',
              errorText: '',
              hintText: 'Enter your phone number',
              icon: IconlyBold.calling,
            ),
            SizedBox(
              height: 30.h,
            ),
            AppPrimaryButton(
              isLoading: ref.watch(setUpProvider).isLoading,
              enabled: true,
              height: 40.h,
              putIcon: false,
              title: 'Submit',
              onPressed: () {
                ref.read(setUpProvider.notifier).setup(context,
                    firstName: _firstNameController.text,
                    lastName: _lastNameController.text,
                    attachment: _image!,
                    email: widget.userData.email!,
                    gender: selectedValue!,
                    phoneNumber: _phoneController.text);
              },
            ),
            SizedBox(
              height: 10.h,
            ),
          ],
        ),
      )),
    );
  }
}
