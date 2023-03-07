import 'package:flashcards/models/card_model.dart';
import 'package:flashcards/models/tag_model.dart';
import 'package:flashcards/screens/addcard_screen.dart';
import 'package:flashcards/screens/addtag_screen.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class ListViewScreen extends StatefulWidget {
  final bool forCards;
  const ListViewScreen({super.key, required this.forCards});

  @override
  State<ListViewScreen> createState() => _ListViewScreenState();
}

class _ListViewScreenState extends State<ListViewScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue[200],
        actions: [
          IconButton(
            onPressed: () async {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => widget.forCards ? const AddCardScreen() : const AddTagScreen(),
                ),
              ).whenComplete(() {
                setState(() {});
              });
            },
            icon: Icon(
              widget.forCards ? Icons.add_box_rounded : Icons.add_circle_rounded
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 30.0, right: 20, left: 20),
        child: Column(
          children: [
            Text(
              widget.forCards ? 'Карточки' : 'Категории',
              style: const TextStyle(fontSize: 30),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: widget.forCards ? Hive.box<CardModel>('cards').length : Hive.box<Tag>('tags').length,
                itemBuilder: (context, index) {
                  if (widget.forCards) {
                    var list = Hive.box<CardModel>('cards').values.toList();
                    return ListTile(
                      title: Text(list[index].word),
                      subtitle: Text(list[index].meaning),
                      trailing: IconButton(
                        onPressed: () {
                          list[index].delete();
                        },
                        icon: const Icon(Icons.delete),
                      ),
                    );
                  } else {
                    var list = Hive.box<Tag>('tags').values.toList();
                    return ListTile(
                      title: Text(list[index].name),
                      trailing: IconButton(
                        onPressed: () {
                          list[index].delete();
                        },
                        icon: const Icon(Icons.delete),
                      ),
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
