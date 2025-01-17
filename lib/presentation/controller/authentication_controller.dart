// ignore_for_file: use_build_context_synchronously, avoid_print

import 'dart:io';

import 'package:clean_arch/core/utils/string_const.dart';
import 'package:clean_arch/di.dart';
import 'package:clean_arch/domain/enteties/token.dart';
import 'package:clean_arch/domain/enteties/user.dart';
import 'package:clean_arch/domain/usecases/authentication_usecases/create_account_usecase.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

// ignore: depend_on_referenced_packages
import 'package:path/path.dart';

class AuthenticationController extends GetxController {
  late Token token;
  late String myemail;
  bool termsAccepted = false;
  bool isLoading = false;
  late User currentUser;
  String userImage = '';
  //XFile? img;
  File? f;
  String? gender;
  String? birthDate;
  String? city;
  String? speciality;
  String? description;
  //final ImagePicker _picker = ImagePicker();

  bool get missingData =>
      currentUser.phone == null ||
      currentUser.adresse == null ||
      currentUser.birthDate == null ||
      currentUser.gender == null;

  void setBirthDate(DateTime date) {
    final year = date.year;
    final month = date.month;
    final day = date.day;
    birthDate = '$year-$month-$day';
    update();
  }

  void setGender(String value) {
    gender = value;
    update();
  }

  /* Future<void> pickImage() async {
    try {
      img = await _picker.pickImage(source: ImageSource.gallery);
      if (img != null) {
        f = File(img!.path);
        setuserImage(basename(f!.path));
      }
    } catch (e) {
      print(e);
    }
  }*/

  void aceptTerms(bool v) {
    termsAccepted = v;
    update(['terms']);
  }

  void setuserImage(String image) {
    userImage = image;
    update([ControllerID.UPDATE_USER_IMAGE]);
  }

  Future<String> createAccount(
      {required TextEditingController email,
      required TextEditingController firstName,
      required TextEditingController adresse,
      required TextEditingController lastName,
      required TextEditingController phone,
      required TextEditingController password,
      required TextEditingController cpassword,
      required BuildContext context}) async {
    final res = await CreateAccountUsecase(sl()).call(
        email: email.text,
        password: password.text,
        adresse: adresse.text,
        phone: phone.text,
        firstName: firstName.text,
        lastName: lastName.text,
        image: '',
        birthDate: DateTime.parse("2020-07-17T03:18:31.177769-04:00"),
        gender: 'Male');
    String userid = "";
    String message = '';
    res.fold((l) => message = l.message!, (r) async {
      message = AppLocalizations.of(context)!.account_created;

      // await CreateWishListUsecase(sl())(userId: r);
      // await CreateCartUsecase(sl())(userId: r);

      email.clear();
      password.clear();
      firstName.clear();
      lastName.clear();
      cpassword.clear();
      phone.clear();
      adresse.clear();
      gender = null;
      birthDate = null;
      termsAccepted = false;
      update();
    });
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.black,
        textColor: Colors.white,
        fontSize: 16.0);
    update();
    return userid;
  }

  /*Future<void> updateImage(BuildContext context) async {
    if (userImage == '') {
      await ClearUserImageUsecase(sl())(currentUser.id!);
    } else {
      await UpdateUserImageUsecase(sl())
          .call(userId: currentUser.id!, file: f!);
    }
    await getCurrentUser(currentUser.id!).then((value) =>
        Fluttertoast.showToast(
            msg: AppLocalizations.of(context)!.profile_picture_updated,
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: AppColors.toastColor,
            textColor: AppColors.white,
            fontSize: 16.0));
  }

  Future<void> login(TextEditingController email,
      TextEditingController password, BuildContext context) async {
    isLoading = true;
    update();
    final res =
        await LoginUsecase(sl())(email: email.text, password: password.text);
    res.fold(
        (l) => Fluttertoast.showToast(
            msg: l.message!,
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: AppColors.toastColor,
            textColor: AppColors.white,
            fontSize: 16.0), (r) async {
      token = r;
      email.clear();
      password.clear();
      await getCurrentUser(r.userId).then((value) async {
        final WishListController wishListController = Get.find();
        final CartController cartController = Get.find();
        // final CategoryController categorControlller = Get.find();
        final AuthenticationController authController = Get.find();
        await wishListController
            .getUserWishlist(authController.currentUser.id!);
        await cartController.getUserCart(authController.currentUser.id!);
        return Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (_) => const MainScreen()));
      });
    });
    isLoading = false;
    update();
  }

  Future<void> sendFrogetPasswordRequest(TextEditingController useremail,
      String destionation, BuildContext context) async {
    String message = '';
    final res = await ForgetPasswordUsecase(sl())(
        email: useremail.text, destination: destionation);
    res.fold((l) => message = l.message!, (r) {
      myemail = useremail.text;
      useremail.clear();
      message = AppLocalizations.of(context)!.email_sent;
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (_) => const OTPScreen()));
    });

    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: AppColors.toastColor,
        textColor: AppColors.white,
        fontSize: 16.0);
  }

  Future<void> verifyOTP(
      TextEditingController otp, BuildContext context) async {
    if (otp.text.length == 4 && isNumeric(otp.text)) {
      final res = await OTPVerificationUsecase(sl())(
          email: myemail, otp: int.parse(otp.text));
      res.fold(
          (l) => Fluttertoast.showToast(
              msg: l.message!,
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: AppColors.toastColor,
              textColor: AppColors.white,
              fontSize: 16.0), (r) {
        otp.clear();
        Navigator.of(context).push(
            MaterialPageRoute(builder: (_) => const ResetPasswordScreen()));
      });
    }
  }

  Future<void> resetPassword(TextEditingController password,
      TextEditingController cpassword, BuildContext context) async {
    String message = '';
    final res = await ResetPasswordUsecase(sl())(
        password: password.text, email: myemail);
    res.fold((l) => message = l.message!, (r) {
      password.clear();
      cpassword.clear();
      message = AppLocalizations.of(context)!.password_reset;
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (_) => const LoginScreen()));
    });
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: AppColors.toastColor,
        textColor: AppColors.white,
        fontSize: 16.0);
  }

 

  Future<void> getCurrentUser(String userId) async {
    final res = await GetUserUsecase(sl())(userId);
    res.fold(
        (l) => Fluttertoast.showToast(
            msg: l.message!,
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: AppColors.toastColor,
            textColor: AppColors.white,
            fontSize: 16.0), (r) {
      currentUser = r;
      city = currentUser.address;
      gender = currentUser.gender;
      birthDate = currentUser.birthDate;
    });
    update();
  }

  Future<void> updateProfile(
      {required String address,
      required TextEditingController email,
      required TextEditingController firstName,
      required TextEditingController lastName,
      required TextEditingController phone,
      required id,
      required String birthDate,
      required String gender,
      required BuildContext context}) async {
    String message = '';
    final res = await UpdateProfilUsecase(sl())(
        email: email.text,
        firstName: firstName.text,
        lastName: lastName.text,
        address: address,
        phone: phone.text,
        id: id,
        gender: gender,
        birthDate: birthDate);
    res.fold((l) => message = l.message!, (r) async {
      message = AppLocalizations.of(context)!.profile_updated;
      await getCurrentUser(currentUser.id!);
    });
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: AppColors.toastColor,
        textColor: AppColors.white,
        fontSize: 16.0);
  }

  Future<void> updatePassword(
      TextEditingController currentPassword,
      TextEditingController password,
      TextEditingController cPassword,
      TextEditingController recovery,
      BuildContext context) async {
    String message = 'error';
    final res = await UpdatePasswordUsecase(sl())(
        userId: currentUser.id!,
        newPassword: password.text,
        oldPassword: currentPassword.text,
        recoverEmail: recovery.text);
    res.fold((l) => message = l.message!, (r) async {
      message = AppLocalizations.of(context)!.profile_updated;
      password.clear();
      cPassword.clear();
      currentPassword.clear();
      await getCurrentUser(currentUser.id!);
    });
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: AppColors.toastColor,
        textColor: AppColors.white,
        fontSize: 16.0);
  }

  Future<void> logout(BuildContext context) async {
    isLoading = false;
    update();
    await LogoutUsecase(sl())();
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => const LoginScreen()));
  }

  Future<void> facebookLogin(BuildContext context) async {
    isLoading = true;

    final res = await FacebookLoginUsecase(sl())();
    res.fold((l) => null, (r) async {
      final user = await CreateAccountUsecase(sl()).call(
          oauth: 'F',
          email: r['id'].toString(),
          password: '${r['id']}',
          address: null,
          phone: '',
          firstName: r['name'].split(' ')[0].toString(),
          lastName: r['name'].split(' ')[1].toString(),
          image: r['picture']['data']['url'],
          birthdate: null,
          gender: null,
          recoveryEmail: null);
      user.fold((l) => null, (ur) async {
        await CreateWishListUsecase(sl())(userId: ur);
        await CreateCartUsecase(sl())(userId: ur);
      });
      TextEditingController email = TextEditingController(text: r['id']);
      TextEditingController password =
          TextEditingController(text: '${r['id']}');

      await login(email, password, context);
    });
    isLoading = false;
    update();
  }

  Future<void> googleLogin(BuildContext context) async {
    isLoading = true;

    final res = await GoogleLoginUsecase(sl())();
    res.fold((l) => null, (r) async {
      final user = await CreateAccountUsecase(sl()).call(
          oauth: 'G',
          email: r['email'],
          password: '${r['id']}',
          address: null,
          phone: '',
          firstName: r['firstName'],
          lastName: r['lastName'],
          image: r['image'],
          birthdate: null,
          gender: null,
          recoveryEmail: null);
      user.fold((l) => null, (ur) async {
        await CreateWishListUsecase(sl())(userId: ur);
        await CreateCartUsecase(sl())(userId: ur);
      });

      TextEditingController email = TextEditingController(text: r['email']);
      TextEditingController password =
          TextEditingController(text: '${r['id']}');

      await login(email, password, context);
    });
    isLoading = false;
    update();
  }

  bool isNumeric(String number) {
    for (int i = 0; i < number.length; i++) {
      if (!'0123456789'.contains(number[i])) {
        return false;
      }
    }
    return true;
  }

  Future<String?> getRecoveryEmail(String email) async {
    String? result;
    final res = await GetRecoveryEmailUsecase(sl())(email: email);
    res.fold((l) => null, (r) => result = r);
    return result;
  }*/
}
