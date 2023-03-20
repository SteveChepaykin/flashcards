import 'package:flashcards/models/card_model.dart';
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
                Navigator.push(context, MaterialPageRoute(builder: (context) => const ListViewScreen(forCards: true))).whenComplete(() {
                  setState(() {});
                });
              },
            ),
            ListTile(
              title: const Text('Категории'),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => const ListViewScreen(forCards: false))).whenComplete(() {
                  setState(() {});
                });
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
              icon: const Icon(
                Icons.filter_alt_rounded,
                color: Colors.white,
              ),
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
              ).whenComplete(() {
                setState(() {});
              });
            },
            icon: const Icon(
              Icons.add_circle_rounded,
            ),
          ),
        ],
      ),
      body: Hive.box<CardModel>('cards').values.length < 3
          ? const Center(child: Text('У вас слишком мало карточек. Создайте несолько!'))
          : Center(
              child: CardCarousel(
              filter: filter,
              cards: Hive.box<CardModel>('cards')
                  .values
                  .where((element) => filter != null 
                    // ? element.tags.map((e) => e.name).toList().contains(filter!.name) 
                    ? element.tags.contains(filter)
                    : true,
                  )
                  .toList(),
            )),
    );
  }
}
