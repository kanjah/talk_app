import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:talk_app/global.dart';
import 'package:http/http.dart' as http;

import '../models/person.dart';

class ProfileController extends GetxController {
  //obtain details from Person class in person.dart and save it to usersProfilelist and init it as an empty list
  final Rx<List<Person>> usersProfileList = Rx<List<Person>>([]);
  List<Person> get allUsersProfileList => usersProfileList.value;

//For filter method
  getResults() {
    onInit();
  }

  @override
  void onInit() {
    super.onInit();

    if (chosenGender == null || chosenCountry == null || chosenAge == null) {
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
    } else {
      usersProfileList.bindStream(
        FirebaseFirestore.instance
            .collection("users")
            .where("gender", isEqualTo: chosenGender.toString().toLowerCase())
            .where("country", isEqualTo: chosenCountry.toString())
            .where("age",
                isGreaterThanOrEqualTo: int.parse(chosenAge.toString()))
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
      sendNotificationtoUser(toUserID, "Favorite", senderName);
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
      sendNotificationtoUser(toUserID, "like", senderName);
    }

    update();
  }

//VIEW SEND & VIEW RECIEVED METHOD
  viewSentAndviewRecieved(String toUserID, String senderName) async {
    //check if the viewRecieved exists or not in the current user list
    var document = await FirebaseFirestore.instance
        .collection("users")
        .doc(toUserID) // id of the profile being liked
        .collection("viewRecieved")
        .doc(currentUserID)
        .get();

    //remove viewRecieved from db list if it exists/or user clicks fav button twice
    if (document.exists) {
      print("already in view list");
    } else {
      // add  viewRecieved in db
      //add currentUserID to the viewRecieved list of that profile person [toUserID]
      await FirebaseFirestore.instance
          .collection("users")
          .doc(toUserID)
          .collection(
              "viewRecieved") //creates new viewRecieved folder under the liked person profile
          .doc(currentUserID)
          .set({});

      //add profile person [toUserID] to the viewSent list of the currentUser
      await FirebaseFirestore.instance
          .collection("users")
          .doc(currentUserID)
          .collection(
              "viewSent") //creates new viewRecieved folder under the current user profile
          .doc(toUserID)
          .set({});

      //send notification
      sendNotificationtoUser(toUserID, "view", senderName);
    }

    update();
  }

//SEND NOTIFICATION TO USERS
  sendNotificationtoUser(recieverID, featureType, senderName) async {
    //get user device token/type
    String userDeviceToken = "";

    await FirebaseFirestore.instance
        .collection("users")
        .doc(recieverID)
        .get()
        .then((snapshot) {
      if (snapshot.data()!["userDeviceToken"] != null) {
        userDeviceToken = snapshot.data()!["userDeviceToken"].toString();
      }
    });

    notificationFormat(userDeviceToken, recieverID, featureType, senderName);
  }

  notificationFormat(userDeviceToken, recieverID, featureType, senderName) {
    //Notification Header
    Map<String, String> headerNotification = {
      "content-Type": "application/json",
      //fcmServetToken from global.dart
      "Authorization": fcmServerToken,
    };

    //Notification Body
    Map bodyNotification = {
      //featureType can be like, favorite or view
      "body":
          "you have recieved a new $featureType form $senderName. Click to see.",
      "title": "New $featureType"
    };

    //Details of the notification
    Map dataMap = {
      "click_action": "FLUTTER_NOTIFICATION_CLICK",
      "id": "1",
      "status": "done",
      "userID": recieverID,
      "senderID": currentUserID
    };

    Map notificationOfficialFormat = {
      "notification": bodyNotification,
      "data": dataMap,
      "priority": "high",
      "to": userDeviceToken
    };

    http.post(Uri.parse("https://fcm.googleapis.com/fcm/send"),
        headers: headerNotification,
        body: jsonEncode(notificationOfficialFormat));
  }
}
