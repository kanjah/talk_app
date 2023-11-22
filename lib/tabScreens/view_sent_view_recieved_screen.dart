import 'package:flutter/material.dart';

class ViewSentViewRecievedScreen extends StatefulWidget {
  const ViewSentViewRecievedScreen({super.key});

  @override
  State<ViewSentViewRecievedScreen> createState() =>
      _ViewSentViewRecievedScreenState();
}

class _ViewSentViewRecievedScreenState
    extends State<ViewSentViewRecievedScreen> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text(
          "View Sent View Recieved Screen",
          style: TextStyle(color: Colors.green, fontSize: 20),
        ),
      ),
    );
  }
}
