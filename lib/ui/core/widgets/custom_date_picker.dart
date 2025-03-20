import 'package:flutter/material.dart';

import '../../../utils/format_date.dart';
import '../themes/app_colors.dart';
import 'custom_icons.dart';

class CustomDatePicker extends StatefulWidget {
  final DateTime? date;
  final void Function(DateTime? date)? onChanged;

  const CustomDatePicker({super.key, this.onChanged, this.date});

  @override
  State<CustomDatePicker> createState() => _CustomDatePickerState();
}

class _CustomDatePickerState extends State<CustomDatePicker> {
  late DateTime? selectedDate;

  @override
  void initState() {
    super.initState();
    selectedDate = widget.date ?? DateTime.now();
  }

  Future<void> _selectDate() async {
    final date = DateTime.now();

    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: date,
      firstDate: date,
      lastDate: DateTime(date.year + 1),
    );

    if (pickedDate != null) {
      selectedDate = pickedDate;
    }

    if (widget.onChanged != null) {
      widget.onChanged!(selectedDate);
    }
  }

  @override
  Widget build(BuildContext context) {
    var formattedDate = formatDate(selectedDate);
    final color = AppColors.of(context);

    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: color.secondary,
      ),
      child: Row(
        spacing: 8,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(formattedDate),
          InkWell(
            onTap: _selectDate,
            child: CustomIcon(
              icon: Icon(Icons.calendar_month, color: color.accent),
            ),
          ),
        ],
      ),
    );
  }
}
