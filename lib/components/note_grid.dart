import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:private_notes/components/note_item.dart';

class NoteGrid extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StaggeredGridView.countBuilder(
      crossAxisCount: 2,
      itemCount: 8,
      itemBuilder: (BuildContext context, int index) => NoteItem(
        times: index % 2 == 0 ? 1 : 2,
      ),
      // staggeredTileBuilder: (int index) => StaggeredTile.count(
      //   1,
      //   index % 2 == 0 ? 2 : 1,
      // ),
      staggeredTileBuilder: (int index) => StaggeredTile.fit(1),
      mainAxisSpacing: 4.0,
      crossAxisSpacing: 4.0,
    );
  }
}
