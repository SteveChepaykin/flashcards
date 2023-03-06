import 'package:flashcards/models/card_model.dart';
import 'package:flashcards/models/tag_model.dart';
import 'package:flashcards/screens/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

void main() async {
  // await Hive.initFlutter(path)s
  WidgetsFlutterBinding.ensureInitialized();
  final appDocumentDirectory = await getApplicationDocumentsDirectory();
  Hive.init(appDocumentDirectory.path);
  Hive.registerAdapter(CardModelAdapter());
  Hive.registerAdapter(TagAdapter());
  await Hive.openBox<Tag>('tags');
  await Hive.openBox<CardModel>('cards');
  // var tag = Tag('asdasd');
  // print(tag.key);
  // box.add(tag);
  // print(tag.key);
  
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {

  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      home: const MainScreen() 
    );
  }
}
