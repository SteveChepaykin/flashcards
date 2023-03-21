import 'package:flashcards/models/card_model.dart';
import 'package:flashcards/models/tag_model.dart';
import 'package:flashcards/widgets/taggrid_widget.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class AddCardScreen extends StatefulWidget {
  const AddCardScreen({super.key});

  @override
  State<AddCardScreen> createState() => _AddCardScreenState();
}

class _AddCardScreenState extends State<AddCardScreen> {
  TextEditingController wordcont = TextEditingController();
  TextEditingController meancont = TextEditingController();
  List<Tag> tags = <Tag>[];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Новая карточка'),
        backgroundColor: Colors.blue[200],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.blue[200],
              ),
              child: TextField(
                maxLines: 1,
                controller: wordcont,
                style: const TextStyle(fontSize: 20),
                decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Слово...',
                    hintStyle: TextStyle(color: Colors.black.withOpacity(0.4), fontSize: 20),
                    contentPadding: const EdgeInsets.all(25)),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.blue[200],
              ),
              child: TextField(
                controller: meancont,
                style: const TextStyle(fontSize: 20),
                decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Значение...',
                    hintStyle: TextStyle(color: Colors.black.withOpacity(0.4), fontSize: 20),
                    contentPadding: const EdgeInsets.all(25)),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Категории',
                  style: TextStyle(fontSize: 16, color: Colors.black87),
                )),
            Expanded(
              child: TagsGrid(add: (e) {
                tags.add(e);
              }, delete: (e) {
                tags.remove(e);
              }),
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
                onPressed: () {
                  if (wordcont.text != '' && meancont.text != '') {
                    CardModel card = CardModel(
                      word: wordcont.text,
                      meaning: meancont.text,
                      rating: 0,
                      tags: tags,
                    );
                    Hive.box<CardModel>('cards').add(card).whenComplete(() {
                      Navigator.pop(context);
                    });
                  }
                },
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size.fromHeight(70),
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                child: const Text(
                  'добавить карточку',
                  style: TextStyle(fontSize: 18),
                )),
          ],
        ),
      ),
    );
  }
}
