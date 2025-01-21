import 'dart:async';
import 'package:clean_arch/di.dart';
import 'package:clean_arch/domain/usecases/authentication_usecases/auto_login_usecase.dart';
import 'package:clean_arch/domain/usecases/authentication_usecases/get_user_by_id_usecase.dart';
import 'package:clean_arch/presentation/controller/authentication_controller.dart';
import 'package:clean_arch/presentation/screens/auth-screens/login-page.dart';
import 'package:clean_arch/presentation/screens/auth-screens/signUp-page.dart';
import 'package:clean_arch/presentation/screens/home-screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _textOpacityAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );
    _animationController.forward();

    _textOpacityAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOut,
      ),
    );

    // Navigate to the login page after 3 seconds
    // Future.delayed(const Duration(seconds: 3), () {
    //   if (mounted) {
    //     Navigator.pushReplacement(
    //       context,
    //       MaterialPageRoute(builder: (context) => const LoginPage()),
    //     );
    //   }
    // });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  static Future<void> init(BuildContext context, int duration) async {
    //Get.put(SettingsController());
    Get.put(AuthenticationController());
    // Get.put(CartController());
    // Get.put(WishListController());
    // Get.put(MainScreenController());
    // Get.put(SupplierController());
    // Get.put(ProductController());
    // Get.put(CategoryController());
    // Get.put(PromotionController());
    // final SettingsController settingsController = Get.find();
    final AuthenticationController authController = Get.find();
    // final WishListController wishListController = Get.find();
    // final CartController cartController = Get.find();

    // final lang = await settingsController.loadLocale();
    // settingsController.setLocal(lang);
    bool res = true;
    final autologiVarReturn = await AutoLoginUsecase(sl()).call();
    autologiVarReturn.fold((l) {
      res = false;
    }, (r) async {
      print(r.toString());
      if (r != null) {
        authController.token = r;
        final user = await GetUserByIdUsecase(sl()).call(userId: r.userId);
        user.fold((l) {
          res = false;
        }, (r) async {
          authController.currentUser = r;
          // await wishListController
          //     .getUserWishlist(authController.currentUser.id!);
          // await cartController.getUserCart(authController.currentUser.id!);
          // Get.put(NotificationsController());
        });
        print(authController.currentUser.birthDate);
      } else {
        res = false;
      }
    });
    Future.delayed(Duration(seconds: duration), () {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (_) => res ? const HomePage() : const LoginPage()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: FutureBuilder(
            future: init(context, 2),
            builder: (context, snapshot) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ScaleTransition(
                    scale: Tween<double>(begin: 0, end: 1).animate(
                      CurvedAnimation(
                        parent: _animationController,
                        curve: Curves.easeInOut,
                      ),
                    ),
                    child: Image.asset(
                      'assets/images/logo.png',
                      height: 150,
                    ),
                  ),
                  FadeTransition(
                    opacity: _textOpacityAnimation,
                    child: const Text(
                      'Welcome to our first E-commerce App',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ],
              );
            }),
      ),
      bottomNavigationBar: const SizedBox(
        height: 20,
        child: Text(
          'Powered b 9odret rabi ',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w700,
            fontStyle: FontStyle.italic,
          ),
        ),
      ),
    );
  }
}
