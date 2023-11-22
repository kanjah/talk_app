import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../global.dart';

class LikeSentLikeRecievedScreen extends StatefulWidget {
  const LikeSentLikeRecievedScreen({super.key});

  @override
  State<LikeSentLikeRecievedScreen> createState() =>
      _LikeSentLikeRecievedScreenState();
}

class _LikeSentLikeRecievedScreenState
    extends State<LikeSentLikeRecievedScreen> {
  bool isLikeSentClicked = true;

  //for saving likeSentUser uid keys
  List<String> likeSentList = [];

  //for saving like recieved User uid keys
  List<String> likeRecievedList = [];

  //for storing matching uid and keylist
  List likesList = [];

//get keys from the like sent/ favorite recied from db
  getLikesListKeys() async {
    //sent
    if (isLikeSentClicked) {
      //my like button clicked
      var likeSentDocument = await FirebaseFirestore.instance
          .collection('users')
          .doc(currentUserID.toString())
          .collection("likeSent")
          .get();

      //get the key(user uid)
      for (int i = 0; i < likeSentDocument.docs.length; i++) {
        //add the keys to likeSentList
        likeSentList.add(likeSentDocument.docs[i].id);
      }
      getKeysDatafromUsersCollection(likeSentList);
    } else {
      //Recieved/ I am their like button clicked
      var likeRecievedDocument = await FirebaseFirestore.instance
          .collection("users")
          .doc(currentUserID.toString())
          .collection("likeRecieved")
          .get();

      //sent the key(user uid)
      for (int i = 0; i < likeRecievedDocument.docs.length; i++) {
        //add the keys to likeRecieveList
        likeRecievedList.add(likeRecievedDocument.docs[i].id);
      }

      getKeysDatafromUsersCollection(likeRecievedList);
    }
  }

  getKeysDatafromUsersCollection(List<String> keyList) async {
    //get all doc
    var allUsersDocument =
        await FirebaseFirestore.instance.collection("users").get();

    //go thro all the docs
    for (int i = 0; i < allUsersDocument.docs.length; i++) {
      //obtain keylist and check for like send/recieved
      for (int k = 0; k < keyList.length; k++) {
        //compare user uid with keyList one by one
        if ((allUsersDocument.docs[i].data() as dynamic)["uid"] == keyList[k]) {
          //if match is found, store it in likesList
          likesList.add(allUsersDocument.docs[i].data());
        }
      }
    }
    setState(() {
      likesList;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getLikesListKeys();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton(
                onPressed: () {
                  likeSentList.clear();
                  likeSentList = [];
                  likeRecievedList.clear();
                  likeRecievedList = [];
                  likesList.clear();
                  likesList = [];
                  setState(() {
                    isLikeSentClicked = true;
                  });
                  getLikesListKeys();
                },

                //My Likes
                child: Text(
                  "My Likes",
                  style: TextStyle(
                    color: isLikeSentClicked ? Colors.white : Colors.grey,
                    fontWeight:
                        isLikeSentClicked ? FontWeight.w500 : FontWeight.normal,
                    fontSize: 14,
                  ),
                )),
            const Text(
              "   |   ",
              style: TextStyle(color: Colors.grey),
            ),
            TextButton(
                onPressed: () {
                  likeSentList.clear();
                  likeSentList = [];
                  likeRecievedList.clear();
                  likeRecievedList = [];
                  likesList.clear();
                  likesList = [];
                  setState(() {
                    isLikeSentClicked = false;
                  });
                  getLikesListKeys();
                },

                //Liked Me
                child: Text(
                  "Liked Me",
                  style: TextStyle(
                    color: isLikeSentClicked ? Colors.grey : Colors.white,
                    fontWeight:
                        isLikeSentClicked ? FontWeight.normal : FontWeight.w500,
                    fontSize: 14,
                  ),
                ))
          ],
        ),
        centerTitle: true,
      ),
      body: likesList.isEmpty
          ? const Center(
              child: Icon(
                Icons.person_off_sharp,
                color: Colors.white,
                size: 60,
              ),
            )
          : GridView.count(
              crossAxisCount: 2,
              padding: const EdgeInsets.all(8),
              children: List.generate(
                likesList.length,
                (index) {
                  return GridTile(
                    child: Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: Card(
                        color: Colors.blue.shade200,
                        child: GestureDetector(
                          onTap: () {},
                          child: DecoratedBox(
                            decoration: BoxDecoration(
                              image: DecorationImage(

                                  //Profile Pics
                                  image: NetworkImage(
                                      likesList[index]["imageProfile"]),
                                  fit: BoxFit.cover),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Center(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Spacer(),

                                    Expanded(
                                      //Name, Age Text
                                      child: Text(
                                        "${likesList[index]["name"]}◉${likesList[index]["age"]}",
                                        style: const TextStyle(
                                            overflow: TextOverflow.ellipsis,
                                            color:
                                                Color.fromARGB(211, 207, 8, 8),
                                            fontSize: 16,
                                            fontWeight: FontWeight.w700),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 4,
                                    ),

                                    //Icons
                                    Row(children: [
                                      const Icon(
                                        Icons.location_on_outlined,
                                        color: Color.fromARGB(211, 207, 8, 8),
                                        size: 16,
                                      ),
                                      Expanded(
                                        //City, Country Text
                                        child: Text(
                                          "${likesList[index]["city"]},${likesList[index]["country"]}",
                                          maxLines: 2,
                                          style: const TextStyle(
                                              overflow: TextOverflow.ellipsis,
                                              color: Colors.white,
                                              fontSize: 16),
                                        ),
                                      ),
                                    ]),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
    );
  }
}
