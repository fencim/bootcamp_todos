import 'package:flutter/material.dart';
import 'package:todo_app/network/http.dart';

import '../models/item_model.dart';

class OtherTodosPage extends StatelessWidget {
  const OtherTodosPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<ItemModel>>(
        future: TodoHttpClient().read(),
        builder: (context, snapshot) {
          if (snapshot.hasData == false &&
              snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (snapshot.hasError) {
            return Text("${snapshot.error}");
          }

          final itemModels = snapshot.data ?? [];

          return ListView.builder(
            itemCount: itemModels.length,
            itemBuilder: (context, index) {
              final itemModel = itemModels[index];
              return ListTile(
                title: Text(itemModel.title),
                leading: Checkbox(
                  value: itemModel.completed,
                  onChanged: (value) {},
                ),
              );
            },
          );
        },
      ),
    );
  }
}
