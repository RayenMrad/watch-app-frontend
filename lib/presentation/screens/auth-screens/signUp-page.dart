import 'package:clean_arch/presentation/controller/authentication_controller.dart';
import 'package:clean_arch/presentation/widgets/inputs/input-password.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

final firstNameController = TextEditingController();
final lastNameController = TextEditingController();
final emailController = TextEditingController();
final adresseController = TextEditingController();
final phoneController = TextEditingController();
final passwordController = TextEditingController();
final confirmPasswordController = TextEditingController();

class _SignUpPageState extends State<SignUpPage> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Stack(
        children: [
          Column(
            children: [
              Container(
                height: height * 0.2,
                decoration: const BoxDecoration(
                  color: Colors.black,
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16.0, vertical: 60),
                  child: Row(
                    children: [
                      IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: const Icon(
                          Icons.arrow_back,
                          color: Colors.white,
                        ),
                      ),
                      Expanded(
                        child: Center(
                          child: const Text(
                            "Create Account",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              // Form container
              Expanded(
                child: SingleChildScrollView(
                  child: Container(
                    height: height * 0.8,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            Row(
                              children: [
                                // First name
                                Expanded(
                                  child: Container(
                                    height: 40,
                                    child: TextFormField(
                                      decoration: InputDecoration(
                                        labelText: 'First Name',
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                        ),
                                        prefixIcon: const Icon(Icons.person),
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 10),
                                // Last name
                                Expanded(
                                  child: Container(
                                    height: 40,
                                    child: TextFormField(
                                      decoration: InputDecoration(
                                        labelText: 'Last Name',
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                        ),
                                        prefixIcon: const Icon(Icons.person),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 20),
                            // Email
                            Container(
                              height: 40,
                              child: TextFormField(
                                decoration: InputDecoration(
                                  labelText: 'Email',
                                  hintText: 'Example@gmail.com',
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  prefixIcon: const Icon(Icons.email),
                                ),
                              ),
                            ),
                            const SizedBox(height: 20),
                            // Address
                            Container(
                              height: 40,
                              child: TextFormField(
                                decoration: InputDecoration(
                                  labelText: 'Address',
                                  hintText:
                                      'Avenue Habib Bourguiba, Tunis 1000, Tunisia',
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  prefixIcon: const Icon(Icons.location_on),
                                ),
                              ),
                            ),
                            const SizedBox(height: 20),
                            // Phone
                            Container(
                              height: 40,
                              child: TextFormField(
                                decoration: InputDecoration(
                                  labelText: 'Phone',
                                  hintText: '+21672000000',
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  prefixIcon: const Icon(Icons.phone),
                                ),
                              ),
                            ),
                            const SizedBox(height: 20),
                            Row(
                              children: [
                                // Gender dropdown
                                Expanded(
                                  child: Container(
                                    height: 50,
                                    child: DropdownButtonFormField<String>(
                                      decoration: InputDecoration(
                                        labelText: 'Gender',
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                        ),
                                        prefixIcon: const Icon(Icons.person),
                                      ),
                                      items: const ['Male', 'Female']
                                          .map((String value) {
                                        return DropdownMenuItem<String>(
                                          value: value,
                                          child: Text(value),
                                        );
                                      }).toList(),
                                      onChanged: (String? newValue) {
                                        print('Selected gender: $newValue');
                                      },
                                      hint: const Text('gender'),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 10),
                                // Date picker
                                Expanded(
                                  child: Container(
                                    height: 50,
                                    child: TextFormField(
                                      readOnly: true,
                                      decoration: InputDecoration(
                                        labelText: 'Birth Date',
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                        ),
                                        prefixIcon:
                                            const Icon(Icons.calendar_today),
                                      ),
                                      onTap: () async {
                                        DateTime? pickedDate =
                                            await showDatePicker(
                                          context: context,
                                          initialDate: DateTime.now(),
                                          firstDate: DateTime(1900),
                                          lastDate: DateTime.now(),
                                        );

                                        if (pickedDate != null) {
                                          String formattedDate =
                                              "${pickedDate.year}-${pickedDate.month.toString().padLeft(2, '0')}-${pickedDate.day.toString().padLeft(2, '0')}";
                                          print(
                                              'Selected date: $formattedDate');
                                        }
                                      },
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 20),
                            // Password
                            PasswordInput(
                              text: 'Password',
                              controller: passwordController,
                              validator: (p0) {
                                if (p0!.isEmpty || p0.length < 8) {
                                  return AppLocalizations.of(context)!
                                      .invalid_password;
                                } else {
                                  return null;
                                }
                              },
                            ),
                            const SizedBox(height: 20),
                            PasswordInput(
                              text: 'confirm Password',
                              controller: confirmPasswordController,
                              validator: (p0) {
                                if (p0!.isEmpty ||
                                    p0 != passwordController.text) {
                                  return AppLocalizations.of(context)!
                                      .password_does_not_match;
                                } else {
                                  return null;
                                }
                              },
                            ),
                            const SizedBox(height: 20),

                            // Create Account button
                            Container(
                              width: double.infinity,
                              height: 50,
                              decoration: BoxDecoration(
                                color: Colors.black,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: GetBuilder(
                                  init: AuthenticationController(),
                                  builder: (controller) {
                                    return TextButton(
                                      onPressed: () async {
                                        if (_formKey.currentState!.validate()) {
                                          await controller.createAccount(
                                              cpassword:
                                                  confirmPasswordController,
                                              email: TextEditingController.fromValue(
                                                  TextEditingValue(
                                                      text: "rayen@gmail.com")),
                                              firstName:
                                                  TextEditingController.fromValue(
                                                      TextEditingValue(
                                                          text: "rayen")),
                                              adresse: TextEditingController.fromValue(
                                                  TextEditingValue(
                                                      text: "borjboukhlifa")),
                                              phone:
                                                  TextEditingController.fromValue(
                                                      TextEditingValue(
                                                          text: "75000000")),
                                              lastName: TextEditingController.fromValue(
                                                  TextEditingValue(text: "mrad")),
                                              password: passwordController,
                                              context: context);
                                        } else {
                                          Fluttertoast.showToast(
                                              msg: AppLocalizations.of(context)!
                                                  .missing_data,
                                              toastLength: Toast.LENGTH_SHORT,
                                              gravity: ToastGravity.BOTTOM,
                                              timeInSecForIosWeb: 1,
                                              backgroundColor: Colors.black,
                                              textColor: Colors.white,
                                              fontSize: 16.0);
                                        }

                                        print("Account created!");
                                      },
                                      child: const Text(
                                        "Create ",
                                        style: TextStyle(
                                          color: Colors.white,
                                        ),
                                      ),
                                    );
                                  }),
                            ),
                            const SizedBox(height: 20),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
