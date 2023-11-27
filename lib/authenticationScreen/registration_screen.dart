import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/authentication_controller.dart';
import '../widgets/custom_text_field_widget.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  //INITIALIZE CONTROLLERS

  //personal info
  TextEditingController emailTextEditingController = TextEditingController();
  TextEditingController passwordTextEditingController = TextEditingController();
  TextEditingController nameTextEditingController = TextEditingController();
  TextEditingController ageTextEditingController = TextEditingController();
  TextEditingController genderTextEditingController = TextEditingController();
  TextEditingController phoneNumberEditingController = TextEditingController();
  TextEditingController cityTextEditingController = TextEditingController();
  TextEditingController countryTextEditingController = TextEditingController();
  TextEditingController profileHeadingTextEditingController =
      TextEditingController();
  TextEditingController lookingForInaPartnerTextEditingController =
      TextEditingController();

  //Appearance
  TextEditingController heightTextEditingController = TextEditingController();
  TextEditingController weightTextEditingController = TextEditingController();
  TextEditingController bodyTypeTextEditingController = TextEditingController();

  //Lifestyle
  TextEditingController drinkTextEditingController = TextEditingController();
  TextEditingController smokeTextEditingController = TextEditingController();
  TextEditingController maritialStatusTextEditingController =
      TextEditingController();
  TextEditingController haveChildrenTextEditingController =
      TextEditingController();
  TextEditingController proffesionTextEditingController =
      TextEditingController();
  TextEditingController employmentStatusTextEditingController =
      TextEditingController();
  TextEditingController incomeTextEditingControler = TextEditingController();
  TextEditingController livingSituationTextEditingController =
      TextEditingController();
  TextEditingController willingToRelocateTextEditingController =
      TextEditingController();
  TextEditingController relationshipYouAreLookingForTextEditingController =
      TextEditingController();
  TextEditingController noOfChildrenTextEditingController =
      TextEditingController();

  //Background
  TextEditingController nationalityTextEditingController =
      TextEditingController();
  TextEditingController educationTextEditingControler = TextEditingController();
  TextEditingController languangeTextEditingController =
      TextEditingController();
  TextEditingController religionTextEditingController = TextEditingController();
  TextEditingController ethinicityTextEditingController =
      TextEditingController();

  //progress bar
  bool showProgressBar = false;

  //init auth controller to access authentication_controlller.dart methods and attributes
  var authenticationController = AuthenticationController.authController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              //create account text
              const SizedBox(height: 100),
              const Text(
                "Create Account",
                style: TextStyle(
                    fontSize: 22,
                    color: Colors.grey,
                    fontWeight: FontWeight.w500),
              ),
              const SizedBox(height: 10),

              const Text(
                "to get started",
                style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey,
                    fontWeight: FontWeight.w400),
              ),
              const SizedBox(height: 10),

              //profile image
              authenticationController.imageFile == null
                  ? const CircleAvatar(
                      radius: 80,
                      backgroundImage: AssetImage("images/profile_avatar.jpg"),
                      backgroundColor: Colors.black,
                    )
                  : Container(
                      width: 180,
                      height: 180,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.grey,
                        image: DecorationImage(
                          fit: BoxFit.fitHeight,
                          image: FileImage(
                            File(authenticationController.imageFile!.path),
                          ),
                        ),
                      ),
                    ),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  //Pick profile pic from gallery
                  IconButton(
                    onPressed: () async {
                      await authenticationController.pickImageFileFromGallery();
                      setState(() {
                        authenticationController.imageFile; //display image
                      });
                    },
                    icon: const Icon(
                      Icons.image_outlined,
                      color: Colors.grey,
                      size: 30,
                    ),
                  ),
                  const SizedBox(width: 10),

                  //Take pic from phone camera
                  IconButton(
                    onPressed: () async {
                      await authenticationController
                          .captureImageFromPhoneCamera();
                      setState(() {
                        authenticationController.imageFile; //display file
                      });
                    },
                    icon: const Icon(Icons.camera_alt_outlined,
                        color: Colors.grey),
                  )
                ],
              ),

              const SizedBox(height: 30),

              //PERSONAL INFO
              const Text(
                "Personal Info: ",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w600),
              ),

              const SizedBox(height: 10),

              // Name
              SizedBox(
                //subtracts 36 from the screen size, to make email container fit well
                width: MediaQuery.of(context).size.width - 36,
                height: 55,
                child: CustomTextFieldWidget(
                  editingController: nameTextEditingController,
                  labelText: "Name",
                  iconData: Icons.person_outline,
                  isObsecure: false,
                ),
              ),

              const SizedBox(
                height: 24,
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
                height: 24,
              ),

              //Age
              SizedBox(
                //subtracts 36 from the screen size, to make email container fit well
                width: MediaQuery.of(context).size.width - 36,
                height: 55,
                child: CustomTextFieldWidget(
                  editingController: ageTextEditingController,
                  labelText: "Age",
                  iconData: Icons.numbers,
                  isObsecure: false,
                ),
              ),

              const SizedBox(
                height: 24,
              ),

              const SizedBox(
                height: 24,
              ),

              //Gender
              SizedBox(
                //subtracts 36 from the screen size, to make email container fit well
                width: MediaQuery.of(context).size.width - 36,
                height: 55,
                child: CustomTextFieldWidget(
                  editingController: genderTextEditingController,
                  labelText: "Gender",
                  iconData: Icons.male_outlined,
                  isObsecure: false,
                ),
              ),

              const SizedBox(
                height: 24,
              ),

              //Phone number
              SizedBox(
                //subtracts 36 from the screen size, to make email container fit well
                width: MediaQuery.of(context).size.width - 36,
                height: 55,
                child: CustomTextFieldWidget(
                  editingController: phoneNumberEditingController,
                  labelText: "Phone",
                  iconData: Icons.phone_android,
                  isObsecure: false,
                ),
              ),

              const SizedBox(
                height: 24,
              ),

              //City
              SizedBox(
                //subtracts 36 from the screen size, to make email container fit well
                width: MediaQuery.of(context).size.width - 36,
                height: 55,
                child: CustomTextFieldWidget(
                  editingController: cityTextEditingController,
                  labelText: "City",
                  iconData: Icons.location_city_sharp,
                  isObsecure: false,
                ),
              ),

              const SizedBox(
                height: 24,
              ),

              //Country
              SizedBox(
                //subtracts 36 from the screen size, to make email container fit well
                width: MediaQuery.of(context).size.width - 36,
                height: 55,
                child: CustomTextFieldWidget(
                  editingController: countryTextEditingController,
                  labelText: "Country",
                  iconData: Icons.location_city_outlined,
                  isObsecure: false,
                ),
              ),

              const SizedBox(
                height: 24,
              ),

              //Profile heading
              SizedBox(
                //subtracts 36 from the screen size, to make email container fit well
                width: MediaQuery.of(context).size.width - 36,
                height: 55,
                child: CustomTextFieldWidget(
                  editingController: profileHeadingTextEditingController,
                  labelText: "Profile Title",
                  iconData: Icons.text_fields,
                  isObsecure: false,
                ),
              ),

              const SizedBox(
                height: 24,
              ),

              //LookingForInPartner
              SizedBox(
                //subtracts 36 from the screen size, to make email container fit well
                width: MediaQuery.of(context).size.width - 36,
                height: 55,
                child: CustomTextFieldWidget(
                  editingController: lookingForInaPartnerTextEditingController,
                  labelText: "What you are looking for in a partner",
                  iconData: Icons.face,
                  isObsecure: false,
                ),
              ),

              const SizedBox(
                height: 24,
              ),

              //APPEARANCE
              const Text(
                "Appearance: ",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w600),
              ),

              const SizedBox(height: 10),

              // Height
              SizedBox(
                //subtracts 36 from the screen size, to make email container fit well
                width: MediaQuery.of(context).size.width - 36,
                height: 55,
                child: CustomTextFieldWidget(
                  editingController: heightTextEditingController,
                  labelText: "Height",
                  iconData: Icons.insert_chart,
                  isObsecure: false,
                ),
              ),
              const SizedBox(height: 24),

              //Weight
              SizedBox(
                //subtracts 36 from the screen size, to make email container fit well
                width: MediaQuery.of(context).size.width - 36,
                height: 55,
                child: CustomTextFieldWidget(
                  editingController: weightTextEditingController,
                  labelText: "Weight",
                  iconData: Icons.table_chart,
                  isObsecure: false,
                ),
              ),

              const SizedBox(
                height: 24,
              ),

              //Body type
              SizedBox(
                //subtracts 36 from the screen size, to make email container fit well
                width: MediaQuery.of(context).size.width - 36,
                height: 55,
                child: CustomTextFieldWidget(
                  editingController: bodyTypeTextEditingController,
                  labelText: "Body Type",
                  iconData: Icons.type_specimen,
                  isObsecure: false,
                ),
              ),

              const SizedBox(
                height: 24,
              ),

              //LIFESTYLE
              const Text(
                "Lifestyle: ",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w600),
              ),

              const SizedBox(height: 10),

              //Drink
              SizedBox(
                //subtracts 36 from the screen size, to make email container fit well
                width: MediaQuery.of(context).size.width - 36,
                height: 55,
                child: CustomTextFieldWidget(
                  editingController: drinkTextEditingController,
                  labelText: "Drink",
                  iconData: Icons.no_drinks_outlined,
                  isObsecure: false,
                ),
              ),
              const SizedBox(height: 24),

              //Smoke
              SizedBox(
                //subtracts 36 from the screen size, to make email container fit well
                width: MediaQuery.of(context).size.width - 36,
                height: 55,
                child: CustomTextFieldWidget(
                  editingController: smokeTextEditingController,
                  labelText: "Smoke",
                  iconData: Icons.smoking_rooms,
                  isObsecure: false,
                ),
              ),
              const SizedBox(height: 24),

              //Martal Status
              SizedBox(
                //subtracts 36 from the screen size, to make email container fit well
                width: MediaQuery.of(context).size.width - 36,
                height: 55,
                child: CustomTextFieldWidget(
                  editingController: maritialStatusTextEditingController,
                  labelText: "Marital Status",
                  iconData: CupertinoIcons.person_2,
                  isObsecure: false,
                ),
              ),
              const SizedBox(height: 24),

              //Have Children
              SizedBox(
                //subtracts 36 from the screen size, to make email container fit well
                width: MediaQuery.of(context).size.width - 36,
                height: 55,
                child: CustomTextFieldWidget(
                  editingController: haveChildrenTextEditingController,
                  labelText: "Do you have Children",
                  iconData: CupertinoIcons.person_3_fill,
                  isObsecure: false,
                ),
              ),
              const SizedBox(height: 24),

              //No of children
              SizedBox(
                //subtracts 36 from the screen size, to make email container fit well
                width: MediaQuery.of(context).size.width - 36,
                height: 55,
                child: CustomTextFieldWidget(
                  editingController: noOfChildrenTextEditingController,
                  labelText: "Number of Children",
                  iconData: CupertinoIcons.person_3_fill,
                  isObsecure: false,
                ),
              ),
              const SizedBox(height: 24),

              //Proffesion
              SizedBox(
                //subtracts 36 from the screen size, to make email container fit well
                width: MediaQuery.of(context).size.width - 36,
                height: 55,
                child: CustomTextFieldWidget(
                  editingController: proffesionTextEditingController,
                  labelText: "Proffesion",
                  iconData: Icons.business_center,
                  isObsecure: false,
                ),
              ),
              const SizedBox(height: 24),

              //Employment Status
              SizedBox(
                //subtracts 36 from the screen size, to make email container fit well
                width: MediaQuery.of(context).size.width - 36,
                height: 55,
                child: CustomTextFieldWidget(
                  editingController: employmentStatusTextEditingController,
                  labelText: "Employment Status",
                  iconData: CupertinoIcons.rectangle_stack_person_crop_fill,
                  isObsecure: false,
                ),
              ),
              const SizedBox(height: 24),

              //Annual Icome
              SizedBox(
                //subtracts 36 from the screen size, to make email container fit well
                width: MediaQuery.of(context).size.width - 36,
                height: 55,
                child: CustomTextFieldWidget(
                  editingController: incomeTextEditingControler,
                  labelText: "Income",
                  iconData: Icons.money,
                  isObsecure: false,
                ),
              ),
              const SizedBox(height: 24),

              //Living Situation
              SizedBox(
                //subtracts 36 from the screen size, to make email container fit well
                width: MediaQuery.of(context).size.width - 36,
                height: 55,
                child: CustomTextFieldWidget(
                  editingController: livingSituationTextEditingController,
                  labelText: "Accomodation Situation",
                  iconData: CupertinoIcons.person_2_square_stack_fill,
                  isObsecure: false,
                ),
              ),
              const SizedBox(height: 24),

              //Willing to relocate
              SizedBox(
                //subtracts 36 from the screen size, to make email container fit well
                width: MediaQuery.of(context).size.width - 36,
                height: 55,
                child: CustomTextFieldWidget(
                  editingController: willingToRelocateTextEditingController,
                  labelText: "Willing to relocate?",
                  iconData: CupertinoIcons.person_2_alt,
                  isObsecure: false,
                ),
              ),
              const SizedBox(height: 24),

              //Relationship you are looking for
              SizedBox(
                //subtracts 36 from the screen size, to make email container fit well
                width: MediaQuery.of(context).size.width - 36,
                height: 55,
                child: CustomTextFieldWidget(
                  editingController:
                      relationshipYouAreLookingForTextEditingController,
                  labelText: "What kind of relationship are you looking for?",
                  iconData: Icons.heart_broken,
                  isObsecure: false,
                ),
              ),
              const SizedBox(height: 24),

              //BACKGROUND
              const Text(
                "Background: ",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w600),
              ),

              const SizedBox(height: 10),

              //Nationality
              SizedBox(
                //subtracts 36 from the screen size, to make email container fit well
                width: MediaQuery.of(context).size.width - 36,
                height: 55,
                child: CustomTextFieldWidget(
                  editingController: nationalityTextEditingController,
                  labelText: "Nationality",
                  iconData: Icons.flag_outlined,
                  isObsecure: false,
                ),
              ),
              const SizedBox(height: 24),

              //Education
              SizedBox(
                //subtracts 36 from the screen size, to make email container fit well
                width: MediaQuery.of(context).size.width - 36,
                height: 55,
                child: CustomTextFieldWidget(
                  editingController: educationTextEditingControler,
                  labelText: "Education",
                  iconData: Icons.history_edu,
                  isObsecure: false,
                ),
              ),
              const SizedBox(height: 24),

              //Language Spoken
              SizedBox(
                //subtracts 36 from the screen size, to make email container fit well
                width: MediaQuery.of(context).size.width - 36,
                height: 55,
                child: CustomTextFieldWidget(
                  editingController: languangeTextEditingController,
                  labelText: "Language",
                  iconData: CupertinoIcons.person_badge_plus_fill,
                  isObsecure: false,
                ),
              ),
              const SizedBox(height: 24),

              //Religion
              SizedBox(
                //subtracts 36 from the screen size, to make email container fit well
                width: MediaQuery.of(context).size.width - 36,
                height: 55,
                child: CustomTextFieldWidget(
                  editingController: religionTextEditingController,
                  labelText: "Religion",
                  //assetRef: , //use image as icon
                  iconData: CupertinoIcons.checkmark_seal_fill,
                  isObsecure: false,
                ),
              ),
              const SizedBox(height: 24),

              //Ethinicity
              SizedBox(
                //subtracts 36 from the screen size, to make email container fit well
                width: MediaQuery.of(context).size.width - 36,
                height: 55,
                child: CustomTextFieldWidget(
                  editingController: ethinicityTextEditingController,
                  labelText: "Ethinicity",
                  iconData: Icons.person_search,
                  isObsecure: false,
                ),
              ),
              const SizedBox(height: 30),

              //SIGNUP BUTTON
              Container(
                width: MediaQuery.of(context).size.width - 36,
                height: 50,
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(12))),
                child: InkWell(
                  onTap: () async {
                    //form validation
                    if (authenticationController.profileImage != null) {
                      if (nameTextEditingController.text.trim().isNotEmpty &&
                          emailTextEditingController.text.trim().isNotEmpty &&
                          passwordTextEditingController.text
                              .trim()
                              .isNotEmpty &&
                          ageTextEditingController.text.trim().isNotEmpty &&
                          genderTextEditingController.text.trim().isNotEmpty &&
                          phoneNumberEditingController.text.trim().isNotEmpty &&
                          cityTextEditingController.text.trim().isNotEmpty &&
                          countryTextEditingController.text.trim().isNotEmpty &&
                          profileHeadingTextEditingController.text
                              .trim()
                              .isNotEmpty &&
                          lookingForInaPartnerTextEditingController.text
                              .trim()
                              .isNotEmpty &&

                          //Appearance
                          heightTextEditingController.text.trim().isNotEmpty &&
                          weightTextEditingController.text.trim().isNotEmpty &&
                          bodyTypeTextEditingController.text
                              .trim()
                              .isNotEmpty &&

                          //Lifestyle
                          drinkTextEditingController.text.trim().isNotEmpty &&
                          smokeTextEditingController.text.trim().isNotEmpty &&
                          maritialStatusTextEditingController.text
                              .trim()
                              .isNotEmpty &&
                          haveChildrenTextEditingController.text
                              .trim()
                              .isNotEmpty &&
                          noOfChildrenTextEditingController.text
                              .trim()
                              .isNotEmpty &&
                          proffesionTextEditingController.text
                              .trim()
                              .isNotEmpty &&
                          employmentStatusTextEditingController.text
                              .trim()
                              .isNotEmpty &&
                          incomeTextEditingControler.text.trim().isNotEmpty &&
                          livingSituationTextEditingController.text
                              .trim()
                              .isNotEmpty &&
                          willingToRelocateTextEditingController.text
                              .trim()
                              .isNotEmpty &&
                          relationshipYouAreLookingForTextEditingController.text
                              .trim()
                              .isNotEmpty &&

                          //Background
                          nationalityTextEditingController.text
                              .trim()
                              .isNotEmpty &&
                          educationTextEditingControler.text
                              .trim()
                              .isNotEmpty &&
                          languangeTextEditingController.text
                              .trim()
                              .isNotEmpty &&
                          religionTextEditingController.text
                              .trim()
                              .isNotEmpty &&
                          ethinicityTextEditingController.text
                              .trim()
                              .isNotEmpty) {
                        // save user details

                        setState(() {
                          showProgressBar = true;
                        });

                        await authenticationController.createNewUserAccount(
                            authenticationController.profileImage!,
                            nameTextEditingController.text.trim(),
                            emailTextEditingController.text.trim(),
                            passwordTextEditingController.text.trim(),
                            ageTextEditingController.text.trim(),
                            genderTextEditingController.text.trim(),
                            phoneNumberEditingController.text.trim(),
                            cityTextEditingController.text.trim(),
                            countryTextEditingController.text.trim(),
                            profileHeadingTextEditingController.text.trim(),
                            lookingForInaPartnerTextEditingController.text
                                .trim(),

                            //Appearance
                            heightTextEditingController.text.trim(),
                            weightTextEditingController.text.trim(),
                            bodyTypeTextEditingController.text.trim(),

                            //Lifestyle
                            drinkTextEditingController.text.trim(),
                            smokeTextEditingController.text.trim(),
                            maritialStatusTextEditingController.text.trim(),
                            haveChildrenTextEditingController.text.trim(),
                            noOfChildrenTextEditingController.text.trim(),
                            proffesionTextEditingController.text.trim(),
                            employmentStatusTextEditingController.text.trim(),
                            incomeTextEditingControler.text.trim(),
                            livingSituationTextEditingController.text.trim(),
                            willingToRelocateTextEditingController.text.trim(),
                            relationshipYouAreLookingForTextEditingController
                                .text
                                .trim(),

                            //Background
                            nationalityTextEditingController.text.trim(),
                            educationTextEditingControler.text.trim(),
                            languangeTextEditingController.text.trim(),
                            religionTextEditingController.text.trim(),
                            ethinicityTextEditingController.text.trim());

                        setState(() {
                          showProgressBar = false;
                          authenticationController.imageFile = null;
                        });
                      } else {
                        Get.snackbar("Empty Field",
                            "A field is empty, ensure that all fields are filled, inorder to continue with registration");
                      }
                    } else {
                      Get.snackbar("Image Missing",
                          "Profile Picture cannot be empty, do pick a picture from the gallery or take a Snap");
                    }
                  },
                  child: const Center(
                    child: Text(
                      "Sign Up",
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

              // HAVE AN ACCNT/REGISTER HERE
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Already have an account? ",
                    style: TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                  InkWell(
                    onTap: () {
                      Get.back();
                    },
                    child: const Text(
                      "Login here",
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
