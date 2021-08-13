import 'package:flutter/material.dart';

import '../models/lasttime.dart';

class LastTimeDialog extends StatefulWidget {
  final LastTime? lasttime;
  final Function(String title, String group) onClickedDone;

  const LastTimeDialog({
    Key? key,
    this.lasttime,
    required this.onClickedDone,
  }) : super(key: key);

  @override
  _LastTimeDialogState createState() => _LastTimeDialogState();
}

class _LastTimeDialogState extends State<LastTimeDialog> {
  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final groupController = TextEditingController();

  bool isWeekly = true;

  @override
  void initState() {
    super.initState();

    if (widget.lasttime != null) {
      final lasttime = widget.lasttime!;

      nameController.text = lasttime.title;
      groupController.text = lasttime.group;
    }
  }

  @override
  void dispose() {
    nameController.dispose();
    groupController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isEditing = widget.lasttime != null;
    final title = isEditing ? 'Edit LastTime' : 'Add LastTime';

    return AlertDialog(
      title: Text(title),
      content: Form(
        key: formKey,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              SizedBox(height: 8),
              buildName(),
              // SizedBox(height: 8),
              // buildAmount(),
              SizedBox(height: 8),
              buildRadioButtons(),
            ],
          ),
        ),
      ),
      actions: <Widget>[
        buildCancelButton(context),
        buildAddButton(context, isEditing: isEditing),
      ],
    );
  }

  Widget buildName() => TextFormField(
        controller: nameController,
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          hintText: 'Enter Title',
        ),
        validator: (name) =>
            name != null && name.isEmpty ? 'Enter a Title' : null,
      );

  // Widget buildAmount() => TextFormField(
  //       decoration: InputDecoration(
  //         border: OutlineInputBorder(),
  //         hintText: 'Enter Group',
  //       ),
  //       keyboardType: TextInputType.number,
  //       validator: (amount) => amount != null && double.tryParse(amount) == null
  //           ? 'Enter a valid number'
  //           : null,
  //       controller: groupController,
  //     );

  Widget buildRadioButtons() => Column(
        children: [
          RadioListTile<bool>(
            title: Text('งานประจำ'),
            value: true,
            groupValue: isWeekly,
            onChanged: (value) => setState(() => isWeekly = value!),
          ),
          RadioListTile<bool>(
            title: Text('งานไม่ประจำ'),
            value: false,
            groupValue: isWeekly,
            onChanged: (value) => setState(() => isWeekly = value!),
          ),
        ],
      );

  Widget buildCancelButton(BuildContext context) => TextButton(
        child: Text('Cancel'),
        onPressed: () => Navigator.of(context).pop(),
      );

  Widget buildAddButton(BuildContext context, {required bool isEditing}) {
    final text = isEditing ? 'Save' : 'Add';

    return TextButton(
      child: Text(text),
      onPressed: () async {
        final isValid = formKey.currentState!.validate();

        if (isValid) {
          final name = nameController.text;
          // final group = groupController.text;

          widget.onClickedDone(name, isWeekly ? 'งานประจำ' : 'งานไม่ประจำ');

          Navigator.of(context).pop();
        }
      },
    );
  }
}
