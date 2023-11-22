import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:talk_app/controllers/profile_controller.dart';

import '../global.dart';

class SwippingScreen extends StatefulWidget {
  const SwippingScreen({super.key});

  @override
  State<SwippingScreen> createState() => _SwippingScreenState();
}

class _SwippingScreenState extends State<SwippingScreen> {
  //profileController form profilecontroller.dart
  ProfileController profileController = Get.put(ProfileController());

  String senderName = "";

  //get the name of the current user
  readCurrentUserData() async {
    await FirebaseFirestore.instance
        .collection("users")
        .doc(currentUserID)
        .get()
        .then((dataSnapshot) {
      setState(() {
        senderName = dataSnapshot.data()!["name"].toString();
      });
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    readCurrentUserData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
        () {
          return PageView.builder(
              //display all contents of allusersProfileList found in profile_controller.dart
              //then display the first object, and one per screen
              itemCount: profileController.allUsersProfileList.length,
              controller: PageController(initialPage: 0, viewportFraction: 1),
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                //display each profile
                final eachProfileInfo =
                    profileController.allUsersProfileList[index];
                return DecoratedBox(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                          image: NetworkImage(
                            eachProfileInfo.imageProfile.toString(),
                          ),
                          fit: BoxFit.cover),
                    ),

                    //DISPLAY USERS DETAILS
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: Column(
                        children: [
                          //filter Icon Button
                          Align(
                            alignment: Alignment.topRight,
                            child: Padding(
                              padding: const EdgeInsets.only(top: 8),
                              child: IconButton(
                                  onPressed: () {},
                                  icon: const Icon(
                                    Icons.filter_list,
                                    size: 30,
                                  )),
                            ),
                          ),

                          const Spacer(),

                          //user data
                          GestureDetector(
                            onTap: () {},
                            child: Column(
                              children: [
                                //Name
                                Text(
                                  eachProfileInfo.name.toString(),
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 24,
                                      letterSpacing: 4,
                                      fontWeight: FontWeight.w500),
                                ),

                                //Age - City
                                Text(
                                  "${eachProfileInfo.age}•${eachProfileInfo.city}",
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 14,
                                      letterSpacing: 4,
                                      fontWeight: FontWeight.w500),
                                ),
                                const SizedBox(
                                  height: 4,
                                ),

                                //Proffesion
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    ElevatedButton(
                                      onPressed: () {},
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.white30,
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(16)),
                                      ),
                                      child: Text(
                                        eachProfileInfo.profession.toString(),
                                        style: const TextStyle(
                                            color: Colors.white, fontSize: 14),
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 6,
                                    ),

                                    //Religion
                                    ElevatedButton(
                                      onPressed: () {},
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.white30,
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(16)),
                                      ),
                                      child: Text(
                                        eachProfileInfo.religion.toString(),
                                        style: const TextStyle(
                                            color: Colors.white, fontSize: 14),
                                      ),
                                    )
                                  ],
                                ),

                                //Country
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    ElevatedButton(
                                      onPressed: () {},
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.white30,
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(16)),
                                      ),
                                      child: Text(
                                        eachProfileInfo.country.toString(),
                                        style: const TextStyle(
                                            color: Colors.white, fontSize: 14),
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 6,
                                    ),

                                    //Ethinicity
                                    ElevatedButton(
                                      onPressed: () {},
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.white30,
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(16)),
                                      ),
                                      child: Text(
                                        eachProfileInfo.ethinicity.toString(),
                                        style: const TextStyle(
                                            color: Colors.white, fontSize: 14),
                                      ),
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),

                          const SizedBox(
                            height: 14,
                          ),

                          //image buttons - favorite -chat - like
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              //Favorite button
                              GestureDetector(
                                onTap: () {
                                  profileController
                                      .favoriteSentAndFavoriteRecieved(
                                    eachProfileInfo.uid
                                        .toString(), //Id of the profile person being liked
                                    senderName, //current user name
                                  );
                                },
                                child: Image.asset(
                                  "images/favorite.png",
                                  width: 60,
                                ),
                              ),

                              //Chat button
                              GestureDetector(
                                onTap: () {},
                                child: Image.asset(
                                  "images/chat.png",
                                  width: 90,
                                ),
                              ),

                              //Like button
                              GestureDetector(
                                onTap: () {
                                  profileController.likeSentAndLikeRecieved(
                                    eachProfileInfo.uid
                                        .toString(), //Id of the profile person being liked
                                    senderName,
                                  );
                                },
                                child: Image.asset(
                                  "images/like.png",
                                  width: 60,
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                    ));
              });
        },
      ),
    );
  }
}
