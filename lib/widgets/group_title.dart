import 'package:doglover/screens/arguments/breed_details_args.dart';
import 'package:doglover/screens/breed_screen.dart';
import 'package:doglover/widgets/expanded_list/entry.dart';
import 'package:flutter/material.dart';

class GroupTitle extends StatelessWidget {
  final Entry entry;

  const GroupTitle({this.entry});

  @override
  Widget build(BuildContext context) {
    return _buildTitles(entry, context);
  }

  Widget _buildTitles(Entry root, BuildContext context) {
    if (root.children.isEmpty) {
      return ListTile(
        onTap: () {
          Navigator.pushNamed(context, BreedScreen.id,
              arguments: BreedDetailsArgs(root.id));
        },
        title: Text(root.title),
      );
    }
    return ExpansionTile(
        key: PageStorageKey<Entry>(root),
        title: Text(
          entry.title,
          style: TextStyle(fontSize: 24.0),
        ),
        children: root.children
            .map((child) => _buildTitles(child, context))
            .toList());
  }
}
