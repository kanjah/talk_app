//Used to pick profile pics from phone gallery
//create user account and save in firebase db

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:talk_app/authenticationScreen/login_screen.dart';
import 'package:talk_app/homeScreen/home_screen.dart';
import 'package:talk_app/models/person.dart' as personModel;

class AuthenticationController extends GetxController {
  static AuthenticationController authController = Get.find();

  //used for checking if user is logged in
  late Rx<User?> firebaseCurrentUser;

  //used to pick profile pic
  Rx<File?>? pickedFile;

  File? get profileImage => pickedFile?.value;
  XFile? imageFile; //for displaying user image in avatar

  pickImageFileFromGallery() async {
    //send user to phone gallery to pick an image
    imageFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (imageFile != null) {
      Get.snackbar("Profile Image", "Profile Image from gallery Selected");
    }
    pickedFile = Rx<File?>(File(imageFile!.path));
  }

  captureImageFromPhoneCamera() async {
    //send user to phone gallery to pick an image
    imageFile = await ImagePicker().pickImage(source: ImageSource.camera);
    if (imageFile != null) {
      Get.snackbar("Profile Image", "successully Captured a DP ");
    }
    pickedFile = Rx<File?>(File(imageFile!.path));
  }

//Upload image to storage method
  // will return an url once the upload is done
  Future<String> uploadImageToStrorage(File imageFile) async {
    //refrence firebase storage and create a profile image folder & save userprofile image using user uniqueId(uid)
    Reference referenceStorage = FirebaseStorage.instance
        .ref()
        .child("Profile Images")
        .child(FirebaseAuth.instance.currentUser!.uid);

    //upload the file to profile image, once completed get a download url
    UploadTask task = referenceStorage.putFile(imageFile);
    TaskSnapshot snapshot = await task;

    String downloadUrlOfImage = await snapshot.ref.getDownloadURL();

    return downloadUrlOfImage;
  }

  //CREATE USER ACCOUNT
  createNewUserAccount(
    //personal info from person.dart
    File imageProfile, //user chose from phone gallery
    String name,
    String email,
    String password,
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
    try {
      //1. authenticate user and create user with email $ password(firebase authentication)
      UserCredential credential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);

      //2. Upload image to strorage
      String urlOfDownloadedImage = await uploadImageToStrorage(imageProfile);

      //3. Save user to firestore db
      //personModel is personal.dart imported as personModel, thus getting access to Person constractor
      personModel.Person personInstance = personModel.Person(

          //personal info
          uid: FirebaseAuth.instance.currentUser!.uid,
          imageProfile: urlOfDownloadedImage,
          name: name,
          email: email,
          password: password,
          age: int.parse(age),
          phoneNo: phoneNo,
          city: city,
          country: country,
          profileHeading: profileHeading,
          lookingForInaPartner: lookingForInaPartner,
          publishedDateTime: DateTime.now().millisecondsSinceEpoch,

          //Appearance
          height: height,
          weight: weight,
          bodyType: bodyType,

          //Life style
          drink: drink,
          smoke: smoke,
          maritalStatus: maritalStatus,
          haveChildren: haveChildren,
          noOfChildren: noOfChildren,
          profession: profession,
          employmentStatus: employmentStatus,
          income: income,
          livingSituation: livingSituation,
          willingToRelocate: willingToRelocate,
          relationshipYouAreLookingFor: relationshipYouAreLookingFor,

          //Background & Culture values
          nationality: nationality,
          education: education,
          languageSpoken: languageSpoken,
          religion: religion,
          ethinicity: ethinicity);

      //create folder users and store all users with uid and data to db using to json method
      await FirebaseFirestore.instance
          .collection("users")
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .set(personInstance.toJson());

      Get.snackbar("Account Created",
          "Succesfully created an account, Login to continue");

      //send user to homescreen
      Get.to(const HomeScreen());
    } catch (errorMsg) {
      Get.snackbar("Account Creation Failed", "An Errour occured:$errorMsg");
    }
  }

  //LOGIN METHOD
  loginUser(String emailUser, String passwordUser) async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: emailUser, password: passwordUser);

      Get.snackbar("Logged-in Successfully",
          "You are logged in successfly continue to your dashboard");
      Get.to(HomeScreen());
    } catch (errorMsg) {
      Get.snackbar("Login Unsuccessfull", "Error occured: $errorMsg");
    }
  }

  //CHECK IF USER LOGGED IS ALREADY METHOD
  checkIfUserIsLoggedIn(User? currentUser) {
    if (currentUser == null) {
      Get.to(LoginScreen());
    } else {
      Get.to(HomeScreen());
    }
  }

  @override
  void onReady() {
    super.onReady();

    firebaseCurrentUser = Rx<User?>(FirebaseAuth.instance.currentUser);

    //checks for the user authStatechange, of either logged in or out
    firebaseCurrentUser.bindStream(FirebaseAuth.instance.authStateChanges());

    //check if the authStateChange has changed/logged in
    ever(firebaseCurrentUser, checkIfUserIsLoggedIn);
  }
}
