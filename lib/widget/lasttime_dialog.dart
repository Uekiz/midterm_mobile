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

  bool isExpense = true;

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
    final title = isEditing ? 'Edit lasttime' : 'Add lasttime';

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
              SizedBox(height: 8),
              buildAmount(),
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
          hintText: 'Enter Name',
        ),
        validator: (name) =>
            name != null && name.isEmpty ? 'Enter a name' : null,
      );

  Widget buildAmount() => TextFormField(
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          hintText: 'Enter Amount',
        ),
        keyboardType: TextInputType.number,
        validator: (amount) => amount != null && double.tryParse(amount) == null
            ? 'Enter a valid number'
            : null,
        controller: groupController,
      );

  Widget buildRadioButtons() => Column(
        children: [
          RadioListTile<bool>(
            title: Text('Expense'),
            value: true,
            groupValue: isExpense,
            onChanged: (value) => setState(() => isExpense = value!),
          ),
          RadioListTile<bool>(
            title: Text('Income'),
            value: false,
            groupValue: isExpense,
            onChanged: (value) => setState(() => isExpense = value!),
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
          final group = groupController.text;

          widget.onClickedDone(name, group);

          Navigator.of(context).pop();
        }
      },
    );
  }
}