import 'package:flutter/material.dart';

import '../../../services/models/icon_text_model.dart';

class RadioChips extends StatefulWidget {
  const RadioChips({
    super.key,
    required this.items,
    required this.onSelected,
    this.initialIndex = 0,
  });

  final List<GeneralModel> items;
  final Function(int i, GeneralModel value) onSelected;
  final int initialIndex;

  @override
  State<RadioChips> createState() => _RadioChipsState();
}

class _RadioChipsState extends State<RadioChips> {
  late String selectedText;

  @override
  void initState() {
    super.initState();

    selectedText = widget.items[widget.initialIndex].text;
  }

  bool isString() {
    return widget.items[0] is String;
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      alignment: WrapAlignment.center,
      spacing: 5,
      children: widget.items
          .map((e) => ChoiceChip(
                label: Text(
                  e.text,
                ),
                selected:
                    isString() ? e == selectedText : e.text == selectedText,
                onSelected: (val) {
                  if (!val) return;
                  setState(() {
                    selectedText = e.text;
                  });
                  widget.onSelected(widget.items.indexOf(e), e);
                },
              ))
          .toList(),
    );
  }
}
