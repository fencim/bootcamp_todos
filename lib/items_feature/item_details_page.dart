import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todo_app/items_feature/new_item_page.dart';
import 'package:todo_app/models/item_model.dart';
import 'package:todo_app/widgets/item_button.dart';

class ItemDetailsPage extends StatefulWidget {
  final int id;
  final ItemModel itemModel;
  final Function(bool isUpdated)? onItemUpdated;
  final VoidCallback? onItemDeleted;

  const ItemDetailsPage({
    super.key,
    required this.id,
    required this.itemModel,
    this.onItemUpdated,
    this.onItemDeleted,
  });

  @override
  State<ItemDetailsPage> createState() => _ItemDetailsPageState();
}

class _ItemDetailsPageState extends State<ItemDetailsPage> {
  String? updatedTitle;
  String? updatedDescription;
  String? updatedDate;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            updatedTitle ?? widget.itemModel.title,
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    updatedDescription ?? widget.itemModel.description,
                    style: const TextStyle(
                      fontSize: 24,
                    ),
                  ),
                  Text(
                    updatedDate ?? widget.itemModel.date,
                    style: const TextStyle(
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ItemButton(
                      title: 'Edit',
                      color: Colors.blue,
                      onItemPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) {
                            return NewItemPage(
                              itemModel: updatedTitle != null &&
                                      updatedDescription != null &&
                                      updatedDate != null
                                  ? ItemModel(
                                      title: updatedTitle!,
                                      description: updatedDescription!,
                                      date: updatedDate!,
                                    )
                                  : widget.itemModel,
                              itemPageMode: ItemPageMode.edit,
                            );
                          }),
                        ).then((value) {
                          /// This checks if the value from the
                          /// previous route is an instance of
                          /// `ItemModel`. If so, read
                          /// the value accordingly.
                          if (value is ItemModel) {
                            /// `setState` notifies the Flutter
                            /// to rebuild the UI
                            setState(() {
                              /// Updates local value of the item models
                              /// to display it on the current page.
                              updatedTitle = value.title;
                              updatedDescription = value.description;
                              updatedDate = value.date;

                              /// Stores updated value of the item
                              /// in the database.
                              final box = Hive.box('todo_items');
                              box.putAt(widget.id, value.toMap());

                              /// Re-loads homepage when there
                              /// is an updated.
                              if (widget.onItemUpdated != null) {
                                widget.onItemUpdated!(true);
                              }
                            });
                          }
                        });
                      },
                    ),
                    ItemButton(
                      title: 'Delete',
                      color: Colors.red,
                      onItemPressed: () {
                        widget.onItemDeleted!();
                        Navigator.pop(context);
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
