import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_slider/carousel.dart';
import 'package:get/get.dart';

import '../accountSettingScreen/account_settings_screen.dart';
import '../global.dart';

class UserDetailsScreen extends StatefulWidget {
  //pass userId to userDetailScreen
  String? userID;
  UserDetailsScreen({super.key, this.userID});

  @override
  State<UserDetailsScreen> createState() => _UserDetailsScreenState();
}

class _UserDetailsScreenState extends State<UserDetailsScreen> {
  //Personal Info
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
  String haveChidren = '';
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

  //Slider Images
  String urlImage1 =
      "https://firebasestorage.googleapis.com/v0/b/lets-talk-8ee16.appspot.com/o/PlaceHolder%2Fprofile_avatar.jpg?alt=media&token=d618774a-8947-4a44-b06f-b16360b7e84f";
  String urlImage2 =
      "https://firebasestorage.googleapis.com/v0/b/lets-talk-8ee16.appspot.com/o/PlaceHolder%2Fprofile_avatar.jpg?alt=media&token=d618774a-8947-4a44-b06f-b16360b7e84f";
  String urlImage3 =
      "https://firebasestorage.googleapis.com/v0/b/lets-talk-8ee16.appspot.com/o/PlaceHolder%2Fprofile_avatar.jpg?alt=media&token=d618774a-8947-4a44-b06f-b16360b7e84f";
  String urlImage4 =
      "https://firebasestorage.googleapis.com/v0/b/lets-talk-8ee16.appspot.com/o/PlaceHolder%2Fprofile_avatar.jpg?alt=media&token=d618774a-8947-4a44-b06f-b16360b7e84f";
  String urlImage5 =
      "https://firebasestorage.googleapis.com/v0/b/lets-talk-8ee16.appspot.com/o/PlaceHolder%2Fprofile_avatar.jpg?alt=media&token=d618774a-8947-4a44-b06f-b16360b7e84f";

  //retrieve Users Info
  retriveUserInfo() {
    FirebaseFirestore.instance
        .collection("users")
        .doc(widget.userID)
        .get()
        .then((snapshot) {
      //check if user exists in db
      if (snapshot.exists) {
        //if exist get data from db
        if (snapshot.data()!["urlImage1"] != null) {
          setState(() {
            urlImage1 = snapshot.data()!["urlImage1"];
            urlImage2 = snapshot.data()!["urlImage2"];
            urlImage3 = snapshot.data()!["urlImage3"];
            urlImage4 = snapshot.data()!["urlImage4"];
            urlImage5 = snapshot.data()!["urlImage5"];
          });
        }
        setState(() {
          //personal info
          name = snapshot.data()!["name"];
          age = snapshot.data()!['age'].toString();
          phoneNo = snapshot.data()!['phoneNo'];
          city = snapshot.data()!["city"];
          country = snapshot.data()!["country"];
          profileHeading = snapshot.data()!["profileHeading"];
          lookingForInaPartner = snapshot.data()!["lookingForInaPartner"];

          //Appearance
          height = snapshot.data()!["height"];
          weight = snapshot.data()!["weight"];
          bodyType = snapshot.data()!["bodyType"];

          //Life style
          drink = snapshot.data()!["drink"];
          smoke = snapshot.data()!["smoke"];
          maritalStatus = snapshot.data()!["maritalStatus"];
          haveChidren = snapshot.data()!["haveChildren"];
          noOfChildren = snapshot.data()!["noOfChildren"];
          profession = snapshot.data()!["profession"];
          employmentStatus = snapshot.data()!["employmentStatus"];
          income = snapshot.data()!["income"];
          livingSituation = snapshot.data()!["livingSituation"];
          willingToRelocate = snapshot.data()!["willingToRelocate"];
          relationshipYouAreLookingFor =
              snapshot.data()!["relationshipYouAreLookingFor"];

          //Background & Culture values
          nationality = snapshot.data()!["nationality"];
          education = snapshot.data()!["education"];
          languageSpoken = snapshot.data()!["languageSpoken"];
          religion = snapshot.data()!["religion"];
          ethinicity = snapshot.data()!["ethinicity"];
        });
      }
    });
  }

  @override
  void initState() {
    super.initState();
    retriveUserInfo();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            "User Profile",
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          centerTitle: true,

          //Back button
          //automaticallyImplyLeading: widget.userID == currentUserID ? false : true,
          leading: widget.userID != currentUserID
              ? IconButton(
                  onPressed: () {
                    Get.back();
                  },
                  icon: const Icon(
                    Icons.arrow_back_ios_new,
                    size: 30,
                  ))
              : Container(),

          //sign out button
          actions: [
            widget.userID == currentUserID
                ? Row(
                    children: [
                      //Settings Icon
                      IconButton(
                          onPressed: () {
                            Get.to(AccountSettingsScreen());
                          },
                          icon: const Icon(
                            Icons.settings,
                            size: 30,
                          )),

                      //Sign out Icon
                      IconButton(
                        onPressed: () {
                          FirebaseAuth.instance.signOut();
                        },
                        icon: const Icon(
                          Icons.logout,
                          size: 30,
                        ),
                      ),
                    ],
                  )
                : Container()
          ],
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(30),
            child: Column(
              children: [
                //Display Image Slider
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.4,
                  width: MediaQuery.of(context).size.width,
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Carousel(
                      indicatorBarColor: Colors.black.withOpacity(0.3),
                      autoScrollDuration: const Duration(seconds: 2),
                      animationPageDuration: const Duration(milliseconds: 500),
                      activateIndicatorColor: Colors.black,
                      animationPageCurve: Curves.easeIn,
                      indicatorBarHeight: 30,
                      indicatorHeight: 10,
                      indicatorWidth: 10,
                      unActivatedIndicatorColor: Colors.grey,
                      stopAtEnd: true,
                      autoScroll: false,
                      items: [
                        Image.network(
                          urlImage1,
                          fit: BoxFit.cover,
                        ),
                        Image.network(
                          urlImage2,
                          fit: BoxFit.cover,
                        ),
                        Image.network(
                          urlImage3,
                          fit: BoxFit.cover,
                        ),
                        Image.network(
                          urlImage4,
                          fit: BoxFit.cover,
                        ),
                        Image.network(
                          urlImage5,
                          fit: BoxFit.cover,
                        ),
                      ],
                    ),
                  ),
                ),

                //Persnal Info Title
                const SizedBox(
                  height: 10,
                ),

                const SizedBox(
                  height: 30,
                ),

                const Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    "Personal Info",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.w500),
                  ),
                ),
                const Divider(
                  color: Colors.white,
                  thickness: 2,
                ),

                //Personal Info table data
                Container(
                  color: Colors.black,
                  padding: const EdgeInsets.all(20.0),
                  child: Table(
                    children: [
                      //Name
                      TableRow(
                        children: [
                          const Text(
                            "Name",
                            style: TextStyle(color: Colors.white, fontSize: 18),
                          ),
                          Text(
                            name,
                            style: const TextStyle(
                                color: Colors.grey, fontSize: 18),
                          )
                        ],
                      ),

                      //extra row for spacing
                      TableRow(children: [const Text("data"), const Text("")]),

                      //Age
                      TableRow(
                        children: [
                          const Text(
                            "Age",
                            style: TextStyle(color: Colors.white, fontSize: 18),
                          ),
                          Text(
                            age,
                            style: const TextStyle(
                                color: Colors.grey, fontSize: 18),
                          ),
                        ],
                      ),

                      //extra row for spacing
                      TableRow(children: [
                        Text(""),
                        Text(""),
                      ]),

                      //Phone Number
                      TableRow(
                        children: [
                          const Text(
                            "Phone Number",
                            style: TextStyle(color: Colors.white, fontSize: 18),
                          ),
                          Text(
                            phoneNo,
                            style: const TextStyle(
                                color: Colors.grey, fontSize: 18),
                          ),
                        ],
                      ),

                      //extra row for spacing
                      TableRow(children: [
                        Text(""),
                        Text(""),
                      ]),

                      //City
                      TableRow(
                        children: [
                          const Text(
                            "City",
                            style: TextStyle(color: Colors.white, fontSize: 18),
                          ),
                          Text(
                            city,
                            style: const TextStyle(
                                color: Colors.grey, fontSize: 18),
                          )
                        ],
                      ),

                      //extra row for spacing
                      TableRow(children: [
                        Text(""),
                        Text(""),
                      ]),

                      //Country
                      TableRow(
                        children: [
                          const Text(
                            "Country",
                            style: TextStyle(color: Colors.white, fontSize: 18),
                          ),
                          Text(
                            country,
                            style: const TextStyle(
                                color: Colors.grey, fontSize: 18),
                          )
                        ],
                      ),

                      //extra row for spacing
                      TableRow(children: [
                        Text(""),
                        Text(""),
                      ]),

                      //Profile Heading
                      TableRow(
                        children: [
                          const Text(
                            "Title",
                            style: TextStyle(color: Colors.white, fontSize: 18),
                          ),
                          Text(
                            profileHeading,
                            style: const TextStyle(
                                color: Colors.grey, fontSize: 18),
                          )
                        ],
                      ),

                      //extra row for spacing
                      TableRow(children: [
                        Text(""),
                        Text(""),
                      ]),

                      //Looking for In a partner
                      TableRow(
                        children: [
                          const Text(
                            "Seeking",
                            style: TextStyle(color: Colors.white, fontSize: 18),
                          ),
                          Text(
                            lookingForInaPartner,
                            style: const TextStyle(
                                color: Colors.grey, fontSize: 18),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                //Appearance
                const SizedBox(
                  height: 10,
                ),

                const SizedBox(
                  height: 30,
                ),

                const Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    "Appearance",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.w500),
                  ),
                ),
                const Divider(
                  color: Colors.white,
                  thickness: 2,
                ),

                Container(
                  color: Colors.black,
                  padding: const EdgeInsets.all(20.0),
                  child: Table(
                    children: [
                      //extra row for spacing
                      TableRow(children: [
                        const Text(""),
                        const Text(""),
                      ]),

                      //Height
                      TableRow(
                        children: [
                          const Text(
                            "Height",
                            style: TextStyle(color: Colors.white, fontSize: 18),
                          ),
                          Text(
                            height,
                            style: const TextStyle(
                                color: Colors.grey, fontSize: 18),
                          ),
                        ],
                      ),

                      //extra row for spacing
                      TableRow(children: [
                        const Text(""),
                        const Text(""),
                      ]),

                      //Weight
                      TableRow(
                        children: [
                          const Text(
                            "Weight",
                            style: TextStyle(color: Colors.white, fontSize: 18),
                          ),
                          Text(
                            weight,
                            style: const TextStyle(
                                color: Colors.grey, fontSize: 18),
                          ),
                        ],
                      ),

                      //extra row for spacing
                      TableRow(children: [
                        const Text(""),
                        const Text(""),
                      ]),

                      //Body Type
                      TableRow(
                        children: [
                          const Text(
                            "Body Type",
                            style: TextStyle(color: Colors.white, fontSize: 18),
                          ),
                          Text(
                            bodyType,
                            style: const TextStyle(
                                color: Colors.grey, fontSize: 18),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                //lIFE STYLE
                const SizedBox(
                  height: 10,
                ),

                const SizedBox(
                  height: 30,
                ),

                const Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    "Life Style",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.w500),
                  ),
                ),
                const Divider(
                  color: Colors.white,
                  thickness: 2,
                ),

                //Life style data
                Container(
                  color: Colors.black,
                  padding: const EdgeInsets.all(20.0),
                  child: Table(
                    children: [
                      //extra row for spacing
                      TableRow(children: [
                        const Text(""),
                        const Text(""),
                      ]),

                      //Drink
                      TableRow(
                        children: [
                          const Text(
                            "Drink",
                            style: TextStyle(color: Colors.white, fontSize: 18),
                          ),
                          Text(
                            drink,
                            style: const TextStyle(
                                color: Colors.grey, fontSize: 18),
                          ),
                        ],
                      ),

                      //extra row for spacing
                      TableRow(children: [
                        const Text(""),
                        const Text(""),
                      ]),

                      //Smoke
                      TableRow(
                        children: [
                          const Text(
                            "Smoke",
                            style: TextStyle(color: Colors.white, fontSize: 18),
                          ),
                          Text(
                            smoke,
                            style: const TextStyle(
                                color: Colors.grey, fontSize: 18),
                          ),
                        ],
                      ),

                      //extra row for spacing
                      TableRow(children: [
                        const Text(""),
                        const Text(""),
                      ]),

                      //Marital status
                      TableRow(
                        children: [
                          const Text(
                            "Marital Status",
                            style: TextStyle(color: Colors.white, fontSize: 18),
                          ),
                          Text(
                            maritalStatus,
                            style: const TextStyle(
                                color: Colors.grey, fontSize: 18),
                          ),
                        ],
                      ),

                      //extra row for spacing
                      TableRow(children: [
                        const Text(""),
                        const Text(""),
                      ]),

                      //Have children
                      TableRow(
                        children: [
                          const Text(
                            "Have Children",
                            style: TextStyle(color: Colors.white, fontSize: 18),
                          ),
                          Text(
                            haveChidren,
                            style: const TextStyle(
                                color: Colors.grey, fontSize: 18),
                          ),
                        ],
                      ),

                      //extra row for spacing
                      TableRow(children: [
                        const Text(""),
                        const Text(""),
                      ]),

                      //Number of Children
                      TableRow(
                        children: [
                          const Text(
                            "No of Children",
                            style: TextStyle(color: Colors.white, fontSize: 18),
                          ),
                          Text(
                            noOfChildren,
                            style: const TextStyle(
                                color: Colors.grey, fontSize: 18),
                          ),
                        ],
                      ),

                      //extra row for spacing
                      TableRow(children: [
                        const Text(""),
                        const Text(""),
                      ]),

                      //Proffesion
                      TableRow(
                        children: [
                          const Text(
                            "Proffesion",
                            style: TextStyle(color: Colors.white, fontSize: 18),
                          ),
                          Text(
                            profession,
                            style: const TextStyle(
                                color: Colors.grey, fontSize: 18),
                          ),
                        ],
                      ),

                      //extra row for spacing
                      TableRow(children: [
                        const Text(""),
                        const Text(""),
                      ]),

                      //Employment Status
                      TableRow(
                        children: [
                          const Text(
                            "Employment Status",
                            style: TextStyle(color: Colors.white, fontSize: 18),
                          ),
                          Text(
                            employmentStatus,
                            style: const TextStyle(
                                color: Colors.grey, fontSize: 18),
                          ),
                        ],
                      ),

                      //extra row for spacing
                      TableRow(children: [
                        const Text(""),
                        const Text(""),
                      ]),

                      //Income
                      TableRow(
                        children: [
                          const Text(
                            "Income",
                            style: TextStyle(color: Colors.white, fontSize: 18),
                          ),
                          Text(
                            income,
                            style: const TextStyle(
                                color: Colors.grey, fontSize: 18),
                          ),
                        ],
                      ),

                      //extra row for spacing
                      TableRow(children: [
                        const Text(""),
                        const Text(""),
                      ]),

                      //Living Condition
                      TableRow(
                        children: [
                          const Text(
                            "Living Conditions",
                            style: TextStyle(color: Colors.white, fontSize: 18),
                          ),
                          Text(
                            livingSituation,
                            style: const TextStyle(
                                color: Colors.grey, fontSize: 18),
                          ),
                        ],
                      ),

                      //extra row for spacing
                      TableRow(children: [
                        const Text(""),
                        const Text(""),
                      ]),

                      //Willing to relocate
                      TableRow(
                        children: [
                          const Text(
                            "Willing to relocate",
                            style: TextStyle(color: Colors.white, fontSize: 18),
                          ),
                          Text(
                            willingToRelocate,
                            style: const TextStyle(
                                color: Colors.grey, fontSize: 18),
                          ),
                        ],
                      ),

                      //extra row for spacing
                      TableRow(children: [
                        const Text(""),
                        const Text(""),
                      ]),

                      //Relationship that your looking for
                      TableRow(
                        children: [
                          const Text(
                            "Looking for : ",
                            style: TextStyle(color: Colors.white, fontSize: 18),
                          ),
                          Text(
                            relationshipYouAreLookingFor,
                            style: const TextStyle(
                                color: Colors.grey, fontSize: 18),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                //BACKGROUND & CULTURE VALUES

                const SizedBox(
                  height: 20,
                ),

                const Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    "Background & Culture values",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.w500),
                  ),
                ),
                const Divider(
                  color: Colors.white,
                  thickness: 2,
                ),

                //Background & Culture values
                Container(
                  color: Colors.black,
                  padding: const EdgeInsets.all(20.0),
                  child: Table(
                    children: [
                      //extra row for spacing
                      const TableRow(children: [
                        Text(""),
                        Text(""),
                      ]),

                      //Nationality
                      TableRow(
                        children: [
                          const Text(
                            "Nationality",
                            style: TextStyle(color: Colors.white, fontSize: 18),
                          ),
                          Text(
                            nationality,
                            style: const TextStyle(
                                color: Colors.grey, fontSize: 18),
                          ),
                        ],
                      ),

                      //extra row for spacing
                      const TableRow(children: [
                        Text(""),
                        Text(""),
                      ]),

                      //Education
                      TableRow(
                        children: [
                          const Text(
                            "Education Level",
                            style: TextStyle(color: Colors.white, fontSize: 18),
                          ),
                          Text(
                            education,
                            style: const TextStyle(
                                color: Colors.grey, fontSize: 18),
                          ),
                        ],
                      ),

                      //extra row for spacing
                      const TableRow(children: [
                        Text(""),
                        Text(""),
                      ]),

                      //Languages Spoken
                      TableRow(
                        children: [
                          const Text(
                            "Languages Spoken",
                            style: TextStyle(color: Colors.white, fontSize: 18),
                          ),
                          Text(
                            languageSpoken,
                            style: const TextStyle(
                                color: Colors.grey, fontSize: 18),
                          ),
                        ],
                      ),

                      //extra row for spacing
                      const TableRow(children: [
                        Text(""),
                        Text(""),
                      ]),

                      //Religion
                      TableRow(
                        children: [
                          const Text(
                            "Religion",
                            style: TextStyle(color: Colors.white, fontSize: 18),
                          ),
                          Text(
                            religion,
                            style: const TextStyle(
                                color: Colors.grey, fontSize: 18),
                          ),
                        ],
                      ),

                      //extra row for spacing
                      const TableRow(children: [
                        Text(""),
                        Text(""),
                      ]),

                      //Ethinicity
                      TableRow(
                        children: [
                          const Text(
                            "Ethinicity",
                            style: TextStyle(color: Colors.white, fontSize: 18),
                          ),
                          Text(
                            ethinicity,
                            style: const TextStyle(
                                color: Colors.grey, fontSize: 18),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
