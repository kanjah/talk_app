//USED FOR REGISTERING NEW USER

import 'package:cloud_firestore/cloud_firestore.dart';

class Person {
  //personal info
  String? uid;
  String? imageProfile;
  String? email;
  String? password;
  String? name;
  int? age;
  String? phoneNo;
  String? city;
  String? country;
  String? profileHeading;
  String? lookingForInaPartner;
  int? publishedDateTime;

  //Appearance
  String? height;
  String? weight;
  String? bodyType;

  //Life style
  String? drink;
  String? smoke;
  String? maritalStatus;
  String? haveChildren;
  String? noOfChildren;
  String? profession;
  String? employmentStatus;
  String? income;
  String? livingSituation;
  String? willingToRelocate;
  String? relationshipYouAreLookingFor;

  //Background & Culture values
  String? nationality;
  String? education;
  String? languageSpoken;
  String? religion;
  String? ethinicity;

  Person(
      {
      //personal info
      this.uid,
      this.imageProfile,
      this.email,
      this.password,
      this.name,
      this.age,
      this.phoneNo,
      this.city,
      this.country,
      this.profileHeading,
      this.lookingForInaPartner,
      this.publishedDateTime,

      //Appearance
      this.height,
      this.weight,
      this.bodyType,

      //Life style
      this.drink,
      this.smoke,
      this.maritalStatus,
      this.haveChildren,
      this.noOfChildren,
      this.profession,
      this.employmentStatus,
      this.income,
      this.livingSituation,
      this.willingToRelocate,
      this.relationshipYouAreLookingFor,

      //Background & Culture values
      this.nationality,
      this.education,
      this.languageSpoken,
      this.religion,
      this.ethinicity});

//GET DATA IN JSON FORMAT
//this will get the person's data from db(DocumentSnapshot, snapshot) in json format
  static Person fromDataSnapshot(DocumentSnapshot snapshot) {
    var dataSnapshot = snapshot.data() as Map<String, dynamic>;
    return Person(
      //personal info
      uid: dataSnapshot["uid"],
      imageProfile: dataSnapshot["imageProfile"],
      email: dataSnapshot["email"],
      password: dataSnapshot["password"],
      name: dataSnapshot["name"],
      age: dataSnapshot["age"],
      phoneNo: dataSnapshot["phoneNo"],
      city: dataSnapshot["city"],
      country: dataSnapshot["country"],
      profileHeading: dataSnapshot["profileHeading"],
      lookingForInaPartner: dataSnapshot["lookingForInaPartner"],
      publishedDateTime: dataSnapshot["publishedDateTime"],

      //Appearance
      height: dataSnapshot["height"],
      weight: dataSnapshot["weight"],
      bodyType: dataSnapshot["bodyType"],

      //Life style
      drink: dataSnapshot["drink"],
      smoke: dataSnapshot["smoke"],
      maritalStatus: dataSnapshot["maritalStatus"],
      haveChildren: dataSnapshot["haveChildren"],
      noOfChildren: dataSnapshot["noOfChildren"],
      profession: dataSnapshot["profession"],
      employmentStatus: dataSnapshot["employmentStatus"],
      income: dataSnapshot["income"],
      livingSituation: dataSnapshot["livingSituation"],
      willingToRelocate: dataSnapshot["willingToRelocate"],
      relationshipYouAreLookingFor:
          dataSnapshot["relationshipYouAreLookingFor"],

      //Background & Culture values
      nationality: dataSnapshot["nationality"],
      education: dataSnapshot["education"],
      languageSpoken: dataSnapshot["languageSpoken"],
      religion: dataSnapshot["religion"],
      ethinicity: dataSnapshot["ethinicity"],
    );
  }

//CONVERT DATA TO JSON FORMAT
//this will convert data from user(String) to json to be stored in db
  Map<String, dynamic> toJson() => {
        //personal info
        "uid": uid,
        "imageProfile": imageProfile,
        "email": email,
        "password": password,
        "name": name,
        "age": age,
        "phoneNo": phoneNo,
        "city": city,
        "country": country,
        "profileHeading": profileHeading,
        "lookingForInaPartner": lookingForInaPartner,
        "publishedDateTime": publishedDateTime,

        //Appearance
        "height": height,
        "weight": weight,
        "bodyType": bodyType,

        //Life style
        "drink": drink,
        "smoke": smoke,
        "maritalStatus": maritalStatus,
        "haveChildren": haveChildren,
        "noOfChildren": noOfChildren,
        "profession": profession,
        "employmentStatus": employmentStatus,
        "income": income,
        "livingSituation": livingSituation,
        "willingToRelocate": willingToRelocate,
        "relationshipYouAreLookingFor": relationshipYouAreLookingFor,

        //Background & Culture values
        "nationality": nationality,
        "education": education,
        "languageSpoken": languageSpoken,
        "religion": religion,
        "ethinicity": ethinicity
      };
}
