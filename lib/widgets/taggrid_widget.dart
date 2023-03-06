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
      crossAxisCount: 4,
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
                    backgroundColor: tags.contains(e) ? Colors.blue : Colors.white,
                  ),
                ),
              ),
            )
            .toList()
      ],
    );
  }
}
