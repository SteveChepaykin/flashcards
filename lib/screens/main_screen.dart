import 'package:flashcards/models/tag_model.dart';
import 'package:flashcards/screens/addcard_screen.dart';
import 'package:flashcards/screens/addtag_screen.dart';
import 'package:flashcards/screens/listview_screen.dart';
import 'package:flashcards/widgets/cardcarousel_widget.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
// import 'package:hive/hive.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  Tag? filter;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: Column(
          children: [
            const SizedBox(
              height: 40,
            ),
            ListTile(
              title: const Text('Карточки'),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => const ListViewScreen(forCards: true)));
              },
            ),
            ListTile(
              title: const Text('Категории'),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => const ListViewScreen(forCards: false)));
              },
            )
          ],
        ),
      ),
      appBar: AppBar(
        backgroundColor: Colors.blue[200],
        actions: [
          DropdownButtonHideUnderline(
            child: DropdownButton<Tag?>(
              icon: const Icon(Icons.filter_list_rounded),
              value: filter,
              items: [
                const DropdownMenuItem(
                  value: null,
                  child: Text('нет фильтров'),
                ),
                ...Hive.box<Tag>('tags').values.toList().map(
                      (e) => DropdownMenuItem(
                        value: e,
                        child: Text(e.name),
                      ),
                    ),
              ],
              onChanged: (v) {
                setState(() {
                  filter = v;
                });
              },
            ),
          ),
          IconButton(
            onPressed: () async {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const AddCardScreen(),
                ),
              ).whenComplete(() {
                setState(() {});
              });
            },
            icon: const Icon(
              Icons.add_box_rounded,
            ),
          ),
          IconButton(
            onPressed: () async {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const AddTagScreen(),
                ),
              );
            },
            icon: const Icon(
              Icons.add_circle_rounded,
            ),
          ),
        ],
      ),
      body: Hive.box('cards').values.isEmpty
          ? const Center(child: Text('У вас еще нет карточек. Создайте несолько!'))
          : Center(
              child: CardCarousel(
              filter: filter,
            )),
    );
  }
}
