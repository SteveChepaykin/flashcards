import 'package:flashcards/models/tag_model.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class TagsGrid extends StatefulWidget {
  final Function(Tag) add;
  final Function(Tag) delete;
  const TagsGrid({super.key, required this.add, required this.delete});

  @override
  State<TagsGrid> createState() => _TagsGridState();
}

class _TagsGridState extends State<TagsGrid> {
  List<Tag> tags = <Tag>[];
  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 2,
      childAspectRatio: 2,
      children: [
        ...Hive.box<Tag>('tags')
            .values
            .toList()
            .map(
              (e) => GridTile(
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      if (tags.contains(e)) {
                        tags.remove(e);
                        widget.delete(e);
                      } else {
                        tags.add(e);
                        widget.add(e);
                      }
                    });
                  },
                  child: Chip(
                    label: Text(e.name),
                    backgroundColor: tags.contains(e) ? Colors.blue[300] : Colors.white,
                    shape: const RoundedRectangleBorder(
                      side: BorderSide(color: Colors.black54),
                      borderRadius: BorderRadius.all(Radius.circular(10))
                    ),
                  ),
                  // child: Container(
                  //   decoration: BoxDecoration(
                  //     border: Border.all(color: Colors.black54),
                  //     borderRadius: BorderRadius.circular(10),
                  //   ),
                  //   padding: const EdgeInsets.all(4),
                  //   child: Text(e.name),
                  // ),
                ),
              ),
            )
            .toList()
      ],
    );
  }
}
