import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:talk_app/controllers/profile_controller.dart';
import 'package:talk_app/tabScreens/user_details_screen.dart';
import 'package:url_launcher/url_launcher.dart';

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

  //Start chat in Whatsapp method
  startChattingWhatsApp(String receiverPhoneNumber) async {
    var androidUrl =
        "whatsapp://send?phone=$receiverPhoneNumber&text=Hi, can we talk for a minute";
    var iosUrl =
        "https://wa.me/$receiverPhoneNumber?text=${Uri.parse('Hi, can we talk for a minute')}";

    try {
      if (Platform.isIOS) {
        await launchUrl((Uri.parse(iosUrl)));
      } else {
        await launchUrl((Uri.parse(androidUrl)));
      }
    } on Exception {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text("Whatsapp not Found"),
              content: const Text("Whatsapp is not installed"),
              actions: [
                TextButton(
                  onPressed: () {
                    Get.back();
                  },
                  child: const Text("Ok"),
                )
              ],
            );
          });
    }
  }

  //Apply filter
  applyFilter() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
            return AlertDialog(
              title: const Text("Matching Filter"),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text("I am looking for a: "),

                  //Dropdown item(Gender)
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: DropdownButton<String>(
                      hint: const Text(
                        "Select gender",
                      ),
                      //chosen gender from global.dart
                      value: chosenGender,
                      underline: Container(),
                      items: ['Male', 'Female', 'Others'].map((value) {
                        return DropdownMenuItem<String>(
                          //value from user chosen option, ie male, female or others
                          value: value,
                          child: Text(
                            value,
                            style: const TextStyle(fontWeight: FontWeight.w500),
                          ),
                        );
                      }).toList(),
                      onChanged: (String? value) {
                        setState(() {
                          chosenGender = value;
                        });
                      },
                    ),
                  ),
                  const SizedBox(height: 20),

                  //Dropdown item(Coutry)
                  const Text("Who lives in "),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: DropdownButton<String>(
                      hint: const Text(
                        "Select a Country",
                      ),
                      //chosen country from global.dart
                      value: chosenCountry,
                      underline: Container(),
                      items: [
                        'Tanzania',
                        'Korea',
                        'China',
                        'USA',
                        'India',
                        'Somalia',
                        'Ethiopia',
                        'Mexico',
                        'Trinidad & Tobego'
                      ].map((value) {
                        return DropdownMenuItem<String>(
                          //value from user chosen option, ie male, female or others
                          value: value,
                          child: Text(
                            value,
                            style: const TextStyle(fontWeight: FontWeight.w500),
                          ),
                        );
                      }).toList(),
                      onChanged: (String? value) {
                        setState(() {
                          chosenCountry = value;
                        });
                      },
                    ),
                  ),
                  const SizedBox(height: 20),

                  //Dropdown iten(Age)
                  const Text("Who is equat or above "),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: DropdownButton<String>(
                      hint: const Text(
                        "Select age",
                      ),
                      //chosen age from global.dart
                      value: chosenAge,
                      underline: Container(),
                      items: [
                        '18',
                        '20',
                        '23',
                        '25',
                        '30',
                        '35',
                        '40',
                        '45',
                        '50',
                        '55',
                        '60'
                      ].map((value) {
                        return DropdownMenuItem<String>(
                          //value from user chosen option, ie male, female or others
                          value: value,
                          child: Text(
                            value,
                            style: const TextStyle(fontWeight: FontWeight.w500),
                          ),
                        );
                      }).toList(),
                      onChanged: (String? value) {
                        setState(() {
                          chosenAge = value;
                        });
                      },
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
              actions: [
                ElevatedButton(
                    onPressed: () {
                      Get.back();

                      //getResults from profile_controller.dart
                      profileController.getResults();
                    },
                    child: const Text("Done"))
              ],
            );
          });
        });
  }

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
                                  onPressed: () {
                                    applyFilter();
                                  },
                                  icon: const Icon(
                                    Icons.filter_list,
                                    size: 30,
                                  )),
                            ),
                          ),

                          const Spacer(),

                          //user data
                          GestureDetector(
                            onTap: () {
                              profileController.viewSentAndviewRecieved(
                                eachProfileInfo.uid
                                    .toString(), // user being viewed current uid
                                senderName, // current user name
                              );

                              //send user to profile person
                              Get.to(UserDetailsScreen(
                                userID: eachProfileInfo.uid.toString(),
                              ));
                            },
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
                                onTap: () {
                                  startChattingWhatsApp(
                                      eachProfileInfo.phoneNo.toString());
                                },
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
