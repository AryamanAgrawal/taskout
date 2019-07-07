import 'package:flutter/material.dart';

class TaskTags extends StatefulWidget {
  List<String> tags = [];
  @override
  State<StatefulWidget> createState() {
    return _TaskTagsState();
  }
}

class _TaskTagsState extends State<TaskTags> {
  void _addTag(String tag) {
    setState(() {
      widget.tags.add(tag);
    });
  }

  void _removeTag(String tag) {
    setState(() {
      widget.tags.remove(tag);
    });
  }

  Widget _buildTagChip(IconData icon, String tag, Color selectedColor) {
    return Container(
      margin: EdgeInsets.only(
        right: 10.0,
      ),
      child: RawChip(
        label: Text(
          tag,
          style: TextStyle(
            color: widget.tags.contains(tag) ? Colors.white : Colors.black,
          ),
        ),
        padding: EdgeInsets.symmetric(horizontal: 5.0),
        labelPadding: EdgeInsets.only(left: 0.0, right: 5.0),
        backgroundColor:
            widget.tags.contains(tag) ? selectedColor : Colors.white,
        avatar: Icon(
          icon,
          size: 20.0,
          color: widget.tags.contains(tag) ? Colors.white : Colors.black,
        ),
        shape: StadiumBorder(
          side: BorderSide(width: 0.1),
        ),
        elevation: 1.0,
        onPressed: () {
          widget.tags.contains(tag) ? _removeTag(tag) : _addTag(tag);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40.0,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: <Widget>[
          _buildTagChip(Icons.home, "Home", Colors.black),
          _buildTagChip(Icons.work, "Work", Colors.black),
          _buildTagChip(Icons.person, "Personal", Colors.black),
          _buildTagChip(Icons.adjust, "Others", Colors.black),
        ],
      ),
    );
  }
}
