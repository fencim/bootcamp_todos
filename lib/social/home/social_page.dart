import 'package:flutter/material.dart';

import '../../widgets/item_button.dart';

/// This is an example todo app
/// with real-time database
/// using Firebase Firestore
class SocialPage extends StatefulWidget {
  const SocialPage({Key? key}) : super(key: key);

  @override
  State<SocialPage> createState() => _SocialPageState();
}

class _SocialPageState extends State<SocialPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Social'),
      ),
      body: Center(
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Container(),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: ItemButton(
                title: 'New Item',
                color: Colors.green,
                onItemPressed: () {
                  // TODO(joshua): Add button for todo CRUD here
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
