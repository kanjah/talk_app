import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:talk_app/global.dart';
import 'package:talk_app/tabScreens/user_details_screen.dart';

class PushNotificationSystem {
  FirebaseMessaging messaging = FirebaseMessaging.instance;

  //notification arrived/recieved
  Future whenNotificationRecieved(BuildContext context) async {
    //1.  TERMINATED
    //when app is completely closed and opened directy from the push notification
    FirebaseMessaging.instance
        .getInitialMessage()
        .then((RemoteMessage? remoteMessage) {
      if (remoteMessage != null) {
        //open ap and show notification data
        openAppandShowNotificationData(
          remoteMessage.data["userID"],
          remoteMessage.data["senderID"],
          context,
        );
      }
    });

    //2. FOREGROUND
    //when the app is open and it recieves a push notification
    FirebaseMessaging.onMessage.listen((RemoteMessage? remoteMessage) {
      if (remoteMessage != null) {
        //open ap and show notification data
        openAppandShowNotificationData(
          remoteMessage.data["userID"],
          remoteMessage.data["senderID"],
          context,
        );
      }
    });

    //3. BACKGROUND
    //When the app is in the background and opened directly from the push notification
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage? remoteMessage) {
      if (remoteMessage != null) {
        //open ap and show notification data
        openAppandShowNotificationData(
          remoteMessage.data["userID"],
          remoteMessage.data["senderID"],
          context,
        );
      }
    });
  }

  openAppandShowNotificationData(recieverID, senderID, context) async {
    await FirebaseFirestore.instance
        .collection("users")
        .doc(senderID)
        .get()
        .then((snapshot) {
      String profileImage = snapshot.data()!["imageProfile"].toString();
      String name = snapshot.data()!["name"].toString();
      String age = snapshot.data()!["age"].toString();
      String city = snapshot.data()!["city"].toString();
      String country = snapshot.data()!["country"].toString();
      String profession = snapshot.data()!["proffesion"].toString();

      showDialog(
          context: context,
          builder: (context) {
            return NotificationDialogBox(senderID, profileImage, name, age,
                city, country, profession, context);
          });
    });
  }

  NotificationDialogBox(
    senderID,
    profileImage,
    name,
    age,
    city,
    country,
    proffesion,
    context,
  ) {
    return Dialog(
      child: GridTile(
        child: Padding(
          padding: const EdgeInsets.all(2.0),
          child: SizedBox(
            height: 300,
            child: Card(
              color: Colors.blue.shade200,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: NetworkImage(profileImage), fit: BoxFit.cover),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(
                    child: Column(
                      //Name & Age text
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          name + " ⦿" + age.toString(),
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w600),
                        ),

                        const SizedBox(
                          height: 8,
                        ),

                        //City & Country Icon
                        Row(
                          children: [
                            const Icon(
                              Icons.location_on_outlined,
                              color: Colors.white,
                              size: 16,
                            ),
                            const SizedBox(width: 2),
                            Expanded(
                                child: Text(
                              city + ", " + country.toString(),
                              maxLines: 4,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                              ),
                            ))
                          ],
                        ),

                        const Spacer(),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          //View Profile Text
                          children: [
                            Center(
                              child: ElevatedButton(
                                onPressed: () {
                                  Get.back();
                                  Get.to(UserDetailsScreen(userID: senderID));
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.green,
                                ),
                                child: const Text("View Profile"),
                              ),
                            ),

                            //Close Button
                            Center(
                              child: ElevatedButton(
                                onPressed: () {
                                  Get.back();
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.red,
                                ),
                                child: const Text("Close"),
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  //get phone type
  Future generateDeviceRegistrationToken() async {
    String? deviceToken = await messaging.getToken();

    await FirebaseFirestore.instance
        .collection("users")
        .doc(currentUserID)
        .update({
      //create new folder userDeviceTocken and save the deviceToken in db
      "userDeviceToken": deviceToken,
    });
  }
}
