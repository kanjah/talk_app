import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:talk_app/pushNotificationScreen/push_notification_system.dart';
import 'package:talk_app/tabScreens/favorite_sent_favorite_recieved_screen.dart';
import 'package:talk_app/tabScreens/like_sent_like_recieved_screen.dart';
import 'package:talk_app/tabScreens/swipping_screen.dart';
import 'package:talk_app/tabScreens/user_details_screen.dart';
import 'package:talk_app/tabScreens/view_sent_view_recieved_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  //add all tabscreen to a List with their index
  int screenIndex = 0; // current number of the screen
  List tabScreenList = [
    SwippingScreen(),
    ViewSentViewRecievedScreen(),
    FavoriteSendFavoriteRecievedScreen(),
    LikeSentLikeRecievedScreen(),
    //userId from userDetailsScreen.dart
    UserDetailsScreen(
      userID: FirebaseAuth.instance.currentUser!.uid,
    )
  ];

//for notification generation and listening(foreground, background, terminated)
  @override
  void initState() {
    super.initState();
    PushNotificationSystem notificationSystem = PushNotificationSystem();
    notificationSystem.generateDeviceRegistrationToken();
    notificationSystem.whenNotificationRecieved(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //Bottom navigation Bar
      bottomNavigationBar: BottomNavigationBar(
        onTap: (indexNumber) {
          setState(() {
            screenIndex = indexNumber;
          });
        },
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.black,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white12,
        currentIndex: screenIndex,
        items: const [
          //SwippingScreen icon button
          BottomNavigationBarItem(
              icon: Icon(
                Icons.home,
                size: 30,
              ),
              label: ""),

          //ViewSentViewRecievedScreen icon button
          BottomNavigationBarItem(
              icon: Icon(
                Icons.remove_red_eye,
                size: 30,
              ),
              label: ""),

          //FavoriteSendFavoriteRecieved icon button
          BottomNavigationBarItem(
              icon: Icon(
                Icons.star,
                size: 30,
              ),
              label: ""),

          //LikeSentLikeREcievedScreen icon button
          BottomNavigationBarItem(
              icon: Icon(
                Icons.favorite,
                size: 30,
              ),
              label: ""),

          //User-Detail  icon button
          BottomNavigationBarItem(
              icon: Icon(
                Icons.person,
                size: 30,
              ),
              label: ""),
        ],
      ),

      //Add the icon button to a tabscreenList then display the tab onscreen
      body: tabScreenList[screenIndex],
    );
  }
}
