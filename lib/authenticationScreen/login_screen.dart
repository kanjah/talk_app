import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:talk_app/authenticationScreen/registration_screen.dart';
import 'package:talk_app/controllers/authentication_controller.dart';
import 'package:talk_app/widgets/custom_text_field_widget.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailTextEditingController = TextEditingController();
  TextEditingController passwordTextEditingController = TextEditingController();

  //Login progressbar
  bool showProgressBar = false;

  //Login controller init
  var controllerAuth = AuthenticationController.authController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              const SizedBox(
                height: 120,
              ),

              //LOGO
              Image.asset(
                "images/logo.png",
                width: 250,
              ),
              const SizedBox(
                height: 18,
              ),

              //TITLE
              const Text(
                "Karibu",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),

              const Text(
                "Login to find your favorite practioner",
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.w300),
              ),

              const SizedBox(
                height: 28,
              ),

              // Email
              SizedBox(
                //subtracts 36 from the screen size, to make email container fit well
                width: MediaQuery.of(context).size.width - 36,
                height: 55,
                child: CustomTextFieldWidget(
                  editingController: emailTextEditingController,
                  labelText: "Email",
                  iconData: Icons.attach_email_outlined,
                  isObsecure: false,
                ),
              ),

              const SizedBox(
                height: 24,
              ),

              // Password
              SizedBox(
                //subtracts 36 from the screen size, to make email container fit well
                width: MediaQuery.of(context).size.width - 36,
                height: 55,
                child: CustomTextFieldWidget(
                  editingController: passwordTextEditingController,
                  labelText: "Password",
                  iconData: Icons.lock_outline,
                  isObsecure: true,
                ),
              ),

              const SizedBox(
                height: 30,
              ),

              //LOGIN BUTTON
              Container(
                width: MediaQuery.of(context).size.width - 36,
                height: 50,
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(12))),
                child: InkWell(
                  onTap: () async {
                    //form validation
                    if (emailTextEditingController.text.trim().isNotEmpty &&
                        passwordTextEditingController.text.trim().isNotEmpty) {
                      setState(() {
                        showProgressBar = true;
                      });
                      //Login user
                      await controllerAuth.loginUser(
                          emailTextEditingController.text.trim(),
                          passwordTextEditingController.text.trim());

                      setState(() {
                        showProgressBar = false;
                      });
                    } else {
                      Get.snackbar("Email or Password missing",
                          "make sure that are all fields are filled to as to continue");
                    }
                  },
                  child: const Center(
                    child: Text(
                      "Login",
                      style: TextStyle(
                          fontSize: 20,
                          color: Colors.black,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
              ),

              const SizedBox(
                height: 16,
              ),

              //DONT HAVE AN ACCNT/REGISTER HERE
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Don't have an account? ",
                    style: TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                  InkWell(
                    onTap: () {
                      Get.to(const RegistrationScreen());
                    },
                    child: const Text(
                      "Register here",
                      style: TextStyle(
                          fontSize: 16.5,
                          color: Colors.white,
                          fontWeight: FontWeight.w600),
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 16,
              ),

              //PROGRESS BAR
              showProgressBar == true
                  ? const CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.pink),
                    )
                  : Container(),

              const SizedBox(
                height: 30,
              )
            ],
          ),
        ),
      ),
    );
  }
}
