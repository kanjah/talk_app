import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../global.dart';

class ViewSentViewRecievedScreen extends StatefulWidget {
  const ViewSentViewRecievedScreen({super.key});

  @override
  State<ViewSentViewRecievedScreen> createState() =>
      _ViewSentViewRecievedScreenState();
}

class _ViewSentViewRecievedScreenState
    extends State<ViewSentViewRecievedScreen> {
  bool isViewSentClicked = true;

  //for saving viewSentUser uid keys
  List<String> viewSentList = [];

  //for saving view recieved User uid keys
  List<String> viewRecievedList = [];

  //for storing matching uid and keylist
  List viewsList = [];

//get keys from the view sent/ favorite recied from db
  getLikesListKeys() async {
    //sent
    if (isViewSentClicked) {
      //my vies button clicked
      var viewSentDocument = await FirebaseFirestore.instance
          .collection('users')
          .doc(currentUserID.toString())
          .collection("viewSent")
          .get();

      //get the key(user uid)
      for (int i = 0; i < viewSentDocument.docs.length; i++) {
        //add the keys to viewSentList
        viewSentList.add(viewSentDocument.docs[i].id);
      }
      getKeysDatafromUsersCollection(viewSentList);
    } else {
      //Recieved/ I am their view button clicked
      var viewRecievedDocument = await FirebaseFirestore.instance
          .collection("users")
          .doc(currentUserID.toString())
          .collection("viewRecieved")
          .get();

      //sent the key(user uid)
      for (int i = 0; i < viewRecievedDocument.docs.length; i++) {
        //add the keys to viewRecieveList
        viewRecievedList.add(viewRecievedDocument.docs[i].id);
      }

      getKeysDatafromUsersCollection(viewRecievedList);
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
          //if match is found, store it in viewsList
          viewsList.add(allUsersDocument.docs[i].data());
        }
      }
    }
    setState(() {
      viewsList;
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
                  viewSentList.clear();
                  viewSentList = [];
                  viewRecievedList.clear();
                  viewRecievedList = [];
                  viewsList.clear();
                  viewsList = [];
                  setState(() {
                    isViewSentClicked = true;
                  });
                  getLikesListKeys();
                },

                //My Views
                child: Text(
                  "My Vies",
                  style: TextStyle(
                    color: isViewSentClicked ? Colors.white : Colors.grey,
                    fontWeight:
                        isViewSentClicked ? FontWeight.w500 : FontWeight.normal,
                    fontSize: 14,
                  ),
                )),
            const Text(
              "   |   ",
              style: TextStyle(color: Colors.grey),
            ),
            TextButton(
                onPressed: () {
                  viewSentList.clear();
                  viewSentList = [];
                  viewRecievedList.clear();
                  viewRecievedList = [];
                  viewsList.clear();
                  viewsList = [];
                  setState(() {
                    isViewSentClicked = false;
                  });
                  getLikesListKeys();
                },

                //Viewed Me
                child: Text(
                  "Seen By",
                  style: TextStyle(
                    color: isViewSentClicked ? Colors.grey : Colors.white,
                    fontWeight:
                        isViewSentClicked ? FontWeight.normal : FontWeight.w500,
                    fontSize: 14,
                  ),
                ))
          ],
        ),
        centerTitle: true,
      ),
      body: viewsList.isEmpty
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
                viewsList.length,
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
                                      viewsList[index]["imageProfile"]),
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
                                        "${viewsList[index]["name"]}◉${viewsList[index]["age"]}",
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
                                          "${viewsList[index]["city"]},${viewsList[index]["country"]}",
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
