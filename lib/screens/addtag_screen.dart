import 'package:flashcards/models/tag_model.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class AddTagScreen extends StatefulWidget {
  const AddTagScreen({super.key});

  @override
  State<AddTagScreen> createState() => _AddTagScreenState();
}

class _AddTagScreenState extends State<AddTagScreen> {
  TextEditingController namecont = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.blue[300],
              ),
              child: TextField(
                controller: namecont,
                style: const TextStyle(fontSize: 20),
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Work email adress',
                  hintStyle: TextStyle(color: Colors.black.withOpacity(0.4), fontSize: 20),
                  contentPadding: const EdgeInsets.all(25)
                ),
              ),
            ),
            const SizedBox(height: 20,),
            ElevatedButton(
        onPressed: () {
          if(namecont.text != '') {
            var tag = Tag(namecont.text);
            Hive.box<Tag>('tags').add(tag);
            Navigator.pop(context);
          }
        },
        style: ElevatedButton.styleFrom(
          minimumSize: const Size.fromHeight(70),
          padding: const EdgeInsets.symmetric(horizontal: 20),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
        child: const Text('добавить категорию')),
          ],
        ),
      ),
    );
  }
}