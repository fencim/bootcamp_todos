import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../widgets/item_button.dart';

/// This is an example todo app with real-time database
/// using Firebase Firestore
class SocialPage extends StatefulWidget {
  const SocialPage({Key? key}) : super(key: key);

  @override
  State<SocialPage> createState() => _SocialPageState();
}

class _SocialPageState extends State<SocialPage> {
  final postsCollection = FirebaseFirestore.instance.collection('posts');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Social'),
      ),
      body: Center(
        child: Stack(
          children: [
            Center(
              child: SingleChildScrollView(
                child: StreamBuilder<QuerySnapshot>(
                  stream: postsCollection.snapshots(),
                  builder: (context, snapshot) {
                    print('JDG ${snapshot.data?.docs.length}');
                    if (snapshot.hasData && snapshot.data!.docs.isNotEmpty) {
                      return ListView.builder(
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return const Text('Hello world');
                        },
                      );
                    }

                    return const Center(
                      child: Text('No items found.'),
                    );
                  },
                ),
              ),
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
