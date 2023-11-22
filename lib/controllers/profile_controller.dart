import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:talk_app/global.dart';

import '../models/person.dart';

class ProfileController extends GetxController {
  //obtain details from Person class in person.dart and save it to usersProfilelist and init it as an empty list
  final Rx<List<Person>> usersProfileList = Rx<List<Person>>([]);
  List<Person> get allUsersProfileList => usersProfileList.value;

  @override
  void onInit() {
    super.onInit();

    //get all users from db from users table without the current user
    usersProfileList.bindStream(
      FirebaseFirestore.instance
          .collection("users")
          .where("uid", isNotEqualTo: FirebaseAuth.instance.currentUser!.uid)
          .snapshots()

          //querydatasnapshot contains all user table data
          .map(
        (QuerySnapshot queryDataSnapshot) {
          List<Person> profileList = [];
          for (var eachProfile in queryDataSnapshot.docs) {
            //add to profileList
            //fromDataSnaposhot is a found in modules/person.dart
            profileList.add(Person.fromDataSnapshot(eachProfile));
          }
          return profileList;
        },
      ),
    );
  }

  //FAVORITE SEND & FAVORITE RECIED METHOD
  favoriteSentAndFavoriteRecieved(String toUserID, String senderName) async {
    //check if the favorite profile exists or not in the current user list
    var document = await FirebaseFirestore.instance
        .collection("users")
        .doc(toUserID) // id of the profile being liked
        .collection("favoriteRecieved")
        .doc(currentUserID)
        .get();

    //remove favorite from db list if it exists/or user clicks fav button twice
    if (document.exists) {
      //remove current user from the favoriteRecieved list of that profile person[toUserId]
      await FirebaseFirestore.instance
          .collection("users")
          .doc(toUserID)
          .collection("favoriteRecieved")
          .doc(currentUserID)
          .delete();

      //remove profile person [toUserID: person who's profile is being liked] rom the favoriteSent list of the currentUSer
      await FirebaseFirestore.instance
          .collection("users")
          .doc(currentUserID)
          .collection("favoriteSent")
          .doc(toUserID)
          .delete();
    } else {
      // marks as favorite in db/ add favorite in db
      //add currentUserID to the favoriteRecieved list of that profile person [toUserID]
      await FirebaseFirestore.instance
          .collection("users")
          .doc(toUserID)
          .collection(
              "favoriteRecieved") //creates new favoriteRecieved folder under the liked person profile
          .doc(currentUserID)
          .set({});

      //add profile person [toUserID] to the favoriteSent list of the currentUser
      await FirebaseFirestore.instance
          .collection("users")
          .doc(currentUserID)
          .collection(
              "favoriteSent") //creates new favoriteRecieved folder under the current user profile
          .doc(toUserID)
          .set({});

      //send notification
    }

    update();
  }

//LIKE SEND & LIKE RECIEVED METHOD
  likeSentAndLikeRecieved(String toUserID, String senderName) async {
    //check if the likeRecieved exists or not in the current user list
    var document = await FirebaseFirestore.instance
        .collection("users")
        .doc(toUserID) // id of the profile being liked
        .collection("likeRecieved")
        .doc(currentUserID)
        .get();

    //remove likeRecieved from db list if it exists/or user clicks fav button twice
    if (document.exists) {
      //remove current user from the likeRecieved list of that profile person[toUserId]
      await FirebaseFirestore.instance
          .collection("users")
          .doc(toUserID)
          .collection("likeRecieved")
          .doc(currentUserID)
          .delete();

      //remove profile person [toUserID: person who's profile is being liked] rom the likeSent list of the currentUSer
      await FirebaseFirestore.instance
          .collection("users")
          .doc(currentUserID)
          .collection("likeSent")
          .doc(toUserID)
          .delete();
    } else {
      // marks as likeRecieved in db/ add favorite in db
      //add currentUserID to the likeRecieved list of that profile person [toUserID]
      await FirebaseFirestore.instance
          .collection("users")
          .doc(toUserID)
          .collection(
              "likeRecieved") //creates new likeRecieved folder under the liked person profile
          .doc(currentUserID)
          .set({});

      //add profile person [toUserID] to the likeSent list of the currentUser
      await FirebaseFirestore.instance
          .collection("users")
          .doc(currentUserID)
          .collection(
              "likeSent") //creates new likeRecieved folder under the current user profile
          .doc(toUserID)
          .set({});

      //send notification
    }

    update();
  }
}
