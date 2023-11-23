import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../global.dart';
import '../homeScreen/home_screen.dart';
import '../widgets/custom_text_field_widget.dart';

class AccountSettingsScreen extends StatefulWidget {
  const AccountSettingsScreen({super.key});

  @override
  State<AccountSettingsScreen> createState() => _AccountSettingsScreenState();
}

class _AccountSettingsScreenState extends State<AccountSettingsScreen> {
  //for uploading & next button when selecting images
  bool uploading = false, next = false;

  //for storing images
  final List<File> _image = [];

  //for storing url from images
  List<String> urlList = [];

  //for keeping stock of numbers of image
  double val = 0;

  //personal info
  TextEditingController emailTextEditingController = TextEditingController();
  TextEditingController passwordTextEditingController = TextEditingController();
  TextEditingController nameTextEditingController = TextEditingController();
  TextEditingController ageTextEditingController = TextEditingController();
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

  //personal info
  String uid = '';
  String imageProfile = '';
  String email = '';
  String password = '';
  String name = '';
  String age = '';
  String phoneNo = '';
  String city = '';
  String country = '';
  String profileHeading = '';
  String lookingForInaPartner = '';

  //Appearance
  String height = '';
  String weight = '';
  String bodyType = '';

  //Life style
  String drink = '';
  String smoke = '';
  String maritalStatus = '';
  String haveChildren = '';
  String noOfChildren = '';
  String profession = '';
  String employmentStatus = '';
  String income = '';
  String livingSituation = '';
  String willingToRelocate = '';
  String relationshipYouAreLookingFor = '';

  //Background & Culture values
  String nationality = '';
  String education = '';
  String languageSpoken = '';
  String religion = '';
  String ethinicity = '';

//choose image method
  chooseImage() async {
    XFile? PickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    setState(() {
      _image.add(File(PickedFile!.path));
    });
  }

  //Upload images to db
  uploadImages() async {
    int i = 1;
    for (var img in _image) {
      setState(() {
        val = i / _image.length;
      });

      //refrence to db
      var refImages = FirebaseStorage.instance
          .ref()
          //make folder images in db and give each image an unique name using time uploaded
          .child(
              "images/${DateTime.now().microsecondsSinceEpoch.toString()}.jpg");

      //upload image each at a time
      await refImages.putFile(img).whenComplete(() async {
        //get image url
        await refImages.getDownloadURL().then((urlImage) {
          //save to urlsList
          urlList.add(urlImage);
          i++;
        });
      });
    }
  }

//Retrieve old user Data to be edited
  retrieveUserData() async {
    await FirebaseFirestore.instance
        .collection("users")
        .doc(currentUserID)
        .get()
        .then((snapshot) {
      //check if record exists
      if (snapshot.exists) {
        setState(() {
          //personal info
          name = snapshot.data()!["name"];
          nameTextEditingController.text = name;
          age = snapshot.data()!['age'].toString();
          ageTextEditingController.text = age;
          phoneNo = snapshot.data()!['phoneNo'];
          phoneNumberEditingController.text = phoneNo;
          city = snapshot.data()!["city"];
          cityTextEditingController.text = city;
          country = snapshot.data()!["country"];
          countryTextEditingController.text = country;
          profileHeading = snapshot.data()!["profileHeading"];
          profileHeadingTextEditingController.text = profileHeading;
          lookingForInaPartner = snapshot.data()!["lookingForInaPartner"];
          lookingForInaPartnerTextEditingController.text = lookingForInaPartner;

          //Appearance
          height = snapshot.data()!["height"];
          heightTextEditingController.text = height;
          weight = snapshot.data()!["weight"];
          weightTextEditingController.text = weight;
          bodyType = snapshot.data()!["bodyType"];
          bodyTypeTextEditingController.text = bodyType;

          //Life style
          drink = snapshot.data()!["drink"];
          drinkTextEditingController.text = drink;
          smoke = snapshot.data()!["smoke"];
          smokeTextEditingController.text = smoke;
          maritalStatus = snapshot.data()!["maritalStatus"];
          maritialStatusTextEditingController.text = maritalStatus;
          haveChildren = snapshot.data()!["haveChildren"];
          haveChildrenTextEditingController.text = haveChildren;
          noOfChildren = snapshot.data()!["noOfChildren"];
          noOfChildrenTextEditingController.text = noOfChildren;
          profession = snapshot.data()!["profession"];
          proffesionTextEditingController.text = profession;
          employmentStatus = snapshot.data()!["employmentStatus"];
          employmentStatusTextEditingController.text = employmentStatus;
          income = snapshot.data()!["income"];
          incomeTextEditingControler.text = income;
          livingSituation = snapshot.data()!["livingSituation"];
          livingSituationTextEditingController.text = livingSituation;
          willingToRelocate = snapshot.data()!["willingToRelocate"];
          willingToRelocateTextEditingController.text = willingToRelocate;
          relationshipYouAreLookingFor =
              snapshot.data()!["relationshipYouAreLookingFor"];
          relationshipYouAreLookingForTextEditingController.text =
              relationshipYouAreLookingFor;

          //Background & Culture values
          nationality = snapshot.data()!["nationality"];
          nationalityTextEditingController.text = nationality;
          education = snapshot.data()!["education"];
          educationTextEditingControler.text = education;
          languageSpoken = snapshot.data()!["languageSpoken"];
          languangeTextEditingController.text = languageSpoken;
          religion = snapshot.data()!["religion"];
          religionTextEditingController.text = religion;
          ethinicity = snapshot.data()!["ethinicity"];
          ethinicityTextEditingController.text = ethinicity;
        });
      }
    });
  }

//Update method
  updateUserDataToFirestorDatabase(
    String name,
    String age,
    String phoneNo,
    String city,
    String country,
    String profileHeading,
    String lookingForInaPartner,

    //Appearance
    String height,
    String weight,
    String bodyType,

    //Life style
    String drink,
    String smoke,
    String maritalStatus,
    String haveChildren,
    String noOfChildren,
    String profession,
    String employmentStatus,
    String income,
    String livingSituation,
    String willingToRelocate,
    String relationshipYouAreLookingFor,

    //Background & Culture values
    String nationality,
    String education,
    String languageSpoken,
    String religion,
    String ethinicity,
  ) async {
    showDialog(
        context: context,
        builder: (context) {
          return const AlertDialog(
            content: SizedBox(
              height: 200,
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CircularProgressIndicator(),
                    SizedBox(
                      height: 10,
                    ),
                    Text("Uploading details please wait")
                  ],
                ),
              ),
            ),
          );
        });

    await uploadImages();

    //save info to db
    await FirebaseFirestore.instance
        .collection("users")
        .doc(currentUserID)
        .update({
      //personal info

      "name": name,
      "age": int.parse(age),
      "phoneNo": phoneNo,
      "city": city,
      "country": country,
      "profileHeading": profileHeading,
      "lookingForInaPartner": lookingForInaPartner,

      //Appearance
      "height": height,
      "weight": weight,
      "bodyType": bodyType,

      //Life style
      "drink": drink,
      "smoke": smoke,
      "maritalStatus": maritalStatus,
      "haveChildren": haveChildren,
      "noOfChildren": noOfChildren,
      "profession": profession,
      "employmentStatus": employmentStatus,
      "income": income,
      "livingSituation": livingSituation,
      "willingToRelocate": willingToRelocate,
      "relationshipYouAreLookingFor": relationshipYouAreLookingFor,

      //Background & Culture values
      "nationality": nationality,
      "education": education,
      "languageSpoken": languageSpoken,
      "religion": religion,
      "ethinicity": ethinicity,

      //images
      'urlImage1': urlList[0].toString(),
      'urlImage2': urlList[1].toString(),
      'urlImage3': urlList[2].toString(),
      'urlImage4': urlList[3].toString(),
      'urlImage5': urlList[4].toString(),
    });

    Get.snackbar("Updated", "updates succesfully updated");

    Get.to(HomeScreen());

    setState(() {
      uploading = false;
      _image.clear();
      urlList.clear();
    });
  }

  @override
  void initState() {
    super.initState();
    retrieveUserData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            //what happens when user presses the next button
            next ? "Profile Information" : "choose 5 images",
            style: const TextStyle(color: Colors.white, fontSize: 22),
          ),
          actions: [
            next
                ? Container()
                : IconButton(
                    onPressed: () {
                      if (_image.length == 5) {
                        setState(() {
                          uploading = true;
                          next = true;
                        });
                      } else {
                        Get.snackbar("Image Suggestion",
                            "choose upto 5 images to continue");
                      }
                    },
                    icon: const Icon(
                      Icons.navigate_next_outlined,
                      size: 36,
                    )),
          ],
        ),
        body:
            //if user has selected 5 photos, display  Account Edit Formif not request to choose,
            next
                //Account Edit form
                ? SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(30),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const SizedBox(height: 2),

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
                              editingController:
                                  profileHeadingTextEditingController,
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
                              editingController:
                                  lookingForInaPartnerTextEditingController,
                              labelText:
                                  "What you are looking for in a partner",
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
                              editingController:
                                  maritialStatusTextEditingController,
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
                              editingController:
                                  haveChildrenTextEditingController,
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
                              editingController:
                                  noOfChildrenTextEditingController,
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
                              editingController:
                                  proffesionTextEditingController,
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
                              editingController:
                                  employmentStatusTextEditingController,
                              labelText: "Employment Status",
                              iconData: CupertinoIcons
                                  .rectangle_stack_person_crop_fill,
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
                              editingController:
                                  livingSituationTextEditingController,
                              labelText: "Accomodation Situation",
                              iconData:
                                  CupertinoIcons.person_2_square_stack_fill,
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
                              editingController:
                                  willingToRelocateTextEditingController,
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
                              labelText:
                                  "What kind of relationship are you looking for?",
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
                              editingController:
                                  nationalityTextEditingController,
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
                              editingController:
                                  ethinicityTextEditingController,
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
                                borderRadius:
                                    BorderRadius.all(Radius.circular(12))),
                            child: InkWell(
                              onTap: () async {
                                //form validation
                                if (nameTextEditingController.text
                                        .trim()
                                        .isNotEmpty &&
                                    ageTextEditingController.text
                                        .trim()
                                        .isNotEmpty &&
                                    phoneNumberEditingController.text
                                        .trim()
                                        .isNotEmpty &&
                                    cityTextEditingController.text
                                        .trim()
                                        .isNotEmpty &&
                                    countryTextEditingController.text
                                        .trim()
                                        .isNotEmpty &&
                                    profileHeadingTextEditingController.text
                                        .trim()
                                        .isNotEmpty &&
                                    lookingForInaPartnerTextEditingController
                                        .text
                                        .trim()
                                        .isNotEmpty &&

                                    //Appearance
                                    heightTextEditingController.text
                                        .trim()
                                        .isNotEmpty &&
                                    weightTextEditingController.text
                                        .trim()
                                        .isNotEmpty &&
                                    bodyTypeTextEditingController.text
                                        .trim()
                                        .isNotEmpty &&

                                    //Lifestyle
                                    drinkTextEditingController.text
                                        .trim()
                                        .isNotEmpty &&
                                    smokeTextEditingController.text
                                        .trim()
                                        .isNotEmpty &&
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
                                    incomeTextEditingControler.text
                                        .trim()
                                        .isNotEmpty &&
                                    livingSituationTextEditingController.text
                                        .trim()
                                        .isNotEmpty &&
                                    willingToRelocateTextEditingController.text
                                        .trim()
                                        .isNotEmpty &&
                                    relationshipYouAreLookingForTextEditingController
                                        .text
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
                                  _image.length > 0
                                      ?
                                      // update user details
                                      await updateUserDataToFirestorDatabase(
                                          nameTextEditingController.text.trim(),
                                          ageTextEditingController.text.trim(),
                                          phoneNumberEditingController.text
                                              .trim(),
                                          cityTextEditingController.text.trim(),
                                          countryTextEditingController.text
                                              .trim(),
                                          profileHeadingTextEditingController.text
                                              .trim(),
                                          lookingForInaPartnerTextEditingController
                                              .text
                                              .trim(),

                                          //Appearance
                                          heightTextEditingController.text
                                              .trim(),
                                          weightTextEditingController.text
                                              .trim(),
                                          bodyTypeTextEditingController.text
                                              .trim(),

                                          //Lifestyle
                                          drinkTextEditingController.text
                                              .trim(),
                                          smokeTextEditingController.text
                                              .trim(),
                                          maritialStatusTextEditingController.text
                                              .trim(),
                                          haveChildrenTextEditingController.text
                                              .trim(),
                                          noOfChildrenTextEditingController.text
                                              .trim(),
                                          proffesionTextEditingController.text
                                              .trim(),
                                          employmentStatusTextEditingController
                                              .text
                                              .trim(),
                                          incomeTextEditingControler.text
                                              .trim(),
                                          livingSituationTextEditingController.text
                                              .trim(),
                                          willingToRelocateTextEditingController
                                              .text
                                              .trim(),
                                          relationshipYouAreLookingForTextEditingController
                                              .text
                                              .trim(),

                                          //Background
                                          nationalityTextEditingController.text
                                              .trim(),
                                          educationTextEditingControler.text
                                              .trim(),
                                          languangeTextEditingController.text
                                              .trim(),
                                          religionTextEditingController.text
                                              .trim(),
                                          ethinicityTextEditingController.text
                                              .trim())
                                      : null;
                                } else {
                                  Get.snackbar("Empty Field",
                                      "A field is empty, ensure that all fields are filled, inorder to continue with registration");
                                }
                              },
                              child: const Center(
                                child: Text(
                                  "Update",
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
                        ],
                      ),
                    ),
                  )
                : Stack(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(4),
                        child: GridView.builder(
                          itemCount: _image.length + 1,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 3),
                          itemBuilder: (context, index) {
                            //if user has not picked the pics display empty container with add icon
                            return index == 0
                                ? Container(
                                    color: Colors.white30,
                                    child: Center(
                                      child: IconButton(
                                        // allow only 5 imgs to be selected
                                        onPressed: () {
                                          if (_image.length < 5) {
                                            !uploading ? chooseImage() : null;
                                          } else {
                                            setState(() {
                                              uploading == true;
                                            });

                                            Get.snackbar("Image Selected",
                                                "Five images have already been selected");
                                          }
                                        },
                                        icon: const Icon(Icons.add),
                                      ),
                                    ),
                                  )

                                //if user has picked the pic, display the pic
                                : Container(
                                    margin: const EdgeInsets.all(3),
                                    decoration: BoxDecoration(
                                      image: DecorationImage(image: FileImage(
                                          //display the images from the first image uploaded
                                          _image[index - 1]), fit: BoxFit.cover),
                                    ),
                                  );
                          },
                        ),
                      )
                    ],
                  ));
  }
}
