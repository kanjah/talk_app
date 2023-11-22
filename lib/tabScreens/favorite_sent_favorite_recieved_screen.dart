import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../global.dart';

class FavoriteSendFavoriteRecievedScreen extends StatefulWidget {
  const FavoriteSendFavoriteRecievedScreen({super.key});

  @override
  State<FavoriteSendFavoriteRecievedScreen> createState() =>
      _FavoriteSendFavoriteRecievedScreenState();
}

class _FavoriteSendFavoriteRecievedScreenState
    extends State<FavoriteSendFavoriteRecievedScreen> {
  bool isFavoriteSentClicked = true;

  //for saving favoriteSentUser uid keys
  List<String> favoriteSentList = [];

  //for saving favorite recieved User uid keys
  List<String> favoriteRecievedList = [];

  //for storing matching uid and keylist
  List favoriteList = [];

//get keys from the favorite sent/ favorite recied from db
  getFavoriteListKeys() async {
    //sent
    if (isFavoriteSentClicked) {
      //my favorite button clicked
      var favoriteSentDocument = await FirebaseFirestore.instance
          .collection('users')
          .doc(currentUserID.toString())
          .collection("favoriteSent")
          .get();

      //get the key(user uid)
      for (int i = 0; i < favoriteSentDocument.docs.length; i++) {
        //add the keys to favoriteSentList
        favoriteSentList.add(favoriteSentDocument.docs[i].id);
      }
      getKeysDatafromUsersCollection(favoriteSentList);
    } else {
      //Recieved/ I am their favorite button clicked
      var favoriteRecievedDocument = await FirebaseFirestore.instance
          .collection("users")
          .doc(currentUserID.toString())
          .collection("favoriteRecieved")
          .get();

      //sent the key(user uid)
      for (int i = 0; i < favoriteRecievedDocument.docs.length; i++) {
        //add the keys to favoriteRecieveList
        favoriteRecievedList.add(favoriteRecievedDocument.docs[i].id);
      }

      getKeysDatafromUsersCollection(favoriteRecievedList);
    }
  }

  getKeysDatafromUsersCollection(List<String> keyList) async {
    //get all doc
    var allUsersDocument =
        await FirebaseFirestore.instance.collection("users").get();

    //go thro all the docs
    for (int i = 0; i < allUsersDocument.docs.length; i++) {
      //obtain keylist and check for favorite send/recieved
      for (int k = 0; k < keyList.length; k++) {
        //compare user uid with keyList one by one
        if ((allUsersDocument.docs[i].data() as dynamic)["uid"] == keyList[k]) {
          //if match is found, store it in favoriteList
          favoriteList.add(allUsersDocument.docs[i].data());
        }
      }
    }
    setState(() {
      favoriteList;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getFavoriteListKeys();
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
                  favoriteSentList.clear();
                  favoriteSentList = [];
                  favoriteRecievedList.clear();
                  favoriteRecievedList = [];
                  favoriteList.clear();
                  favoriteList = [];
                  setState(() {
                    isFavoriteSentClicked = true;
                  });
                  getFavoriteListKeys();
                },
                child: Text(
                  "My Favorite",
                  style: TextStyle(
                    color: isFavoriteSentClicked ? Colors.white : Colors.grey,
                    fontWeight: isFavoriteSentClicked
                        ? FontWeight.w500
                        : FontWeight.normal,
                    fontSize: 14,
                  ),
                )),
            const Text(
              "   |   ",
              style: TextStyle(color: Colors.grey),
            ),
            TextButton(
                onPressed: () {
                  favoriteSentList.clear();
                  favoriteSentList = [];
                  favoriteRecievedList.clear();
                  favoriteRecievedList = [];
                  favoriteList.clear();
                  favoriteList = [];
                  setState(() {
                    isFavoriteSentClicked = false;
                  });
                  getFavoriteListKeys();
                },
                child: Text(
                  "Am their Favorite",
                  style: TextStyle(
                    color: isFavoriteSentClicked ? Colors.grey : Colors.white,
                    fontWeight: isFavoriteSentClicked
                        ? FontWeight.normal
                        : FontWeight.w500,
                    fontSize: 14,
                  ),
                ))
          ],
        ),
        centerTitle: true,
      ),
      body: favoriteList.isEmpty
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
                favoriteList.length,
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
                                      favoriteList[index]["imageProfile"]),
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
                                        "${favoriteList[index]["name"]}◉${favoriteList[index]["age"]}",
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
                                          "${favoriteList[index]["city"]},${favoriteList[index]["country"]}",
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
