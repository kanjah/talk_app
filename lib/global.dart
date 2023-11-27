import 'package:firebase_auth/firebase_auth.dart';

//TO GET CURRENT USER
String currentUserID = FirebaseAuth.instance.currentUser!.uid;

//FOR MOBILE IDENTIFICATION/CLOUD MESSAGING
String fcmServerToken =
    "key=AAAA3wHuiZ8:APA91bGHvY4cjcd24UX4Y5tzokZ4L8aaJgPgSiSPdTnV48xhPXuxX6h2CQ4GTog40bevFV81Yf5ft-LCKo0k5Nm02Lvr1vq-EWr7JGeQaQqUEK9dSKAya-ViU7NpxLtVqTHcm7hjGe6t";

//For filter
String? chosenAge;
String? chosenCountry;
String? chosenGender;
