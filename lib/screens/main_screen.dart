import 'package:flashcards/screens/addcard_screen.dart';
import 'package:flashcards/screens/addtag_screen.dart';
import 'package:flashcards/widgets/cardcarousel_widget.dart';
import 'package:flutter/material.dart';
// import 'package:hive/hive.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
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
              color: Colors.black,
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
              color: Colors.black,
            ),
          ),
        ],
      ),
      // body: ListView.builder(
      //   itemCount: Hive.box<CardModel>('cards').length,
      //   itemBuilder: (context, index) {
      //     CardModel item = Hive.box<CardModel>('cards').getAt(index)!;
      //     return ListTile(
      //       title: Text(item.word),
      //       subtitle: Text(item.meaning),
      //     );
      //   },
      // ),
      body: const Center(child: CardCarousel(),),
    );
  }
}
