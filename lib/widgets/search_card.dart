import 'package:doglover/styles.dart';
import 'package:flutter/material.dart';

class SearchCard extends StatelessWidget {
  final Function onSubmitted;

  const SearchCard({this.onSubmitted});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5.0),
      ),
      child: Padding(
        padding: const EdgeInsets.only(right: 16.0),
        child: Row(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Icon(Icons.search),
            ),
            Expanded(
              child: TextField(
                onSubmitted: (text) {
                  if (text.isNotEmpty) {
                    onSubmitted(text);
                  }
                },
                autofocus: false,
                decoration: InputDecoration(
                  hintStyle: TextStyle(color: Styles.eunry),
                  hintText: 'Search here',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
