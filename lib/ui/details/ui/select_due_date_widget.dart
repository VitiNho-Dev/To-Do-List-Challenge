import 'package:flutter/material.dart';
import 'package:todo_list_app/ui/core/widgets/circular_button.dart';

import '../../../utils/format_date.dart';
import '../../core/themes/colors.dart';
import '../../core/widgets/custom_date_picker.dart';
import 'content_topic_widget.dart';

class SelectDueDateWidget extends StatelessWidget {
  final DateTime? dueDate;
  final void Function(DateTime? date) onChanged;
  final void Function()? removeDate;

  const SelectDueDateWidget({
    super.key,
    this.dueDate,
    required this.onChanged,
    this.removeDate,
  });

  @override
  Widget build(BuildContext context) {
    final color = AppColors.of(context);

    return dueDate == null
        ? ContentTopicWidget(
          title: 'Adicionar data de vencimento da tarefa',
          child: CustomDatePicker(onChanged: onChanged),
        )
        : ContentTopicWidget(
          title: 'Atualizar data de vencimento da tarefa',
          child: Column(
            spacing: 12,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomDatePicker(date: dueDate, onChanged: onChanged),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Data de vencimento: ${formatDate(dueDate)}'),
                  CircularButton(
                    width: 28,
                    height: 28,
                    padding: EdgeInsets.zero,
                    onTap: removeDate,
                    color: color.lightRed,
                    child: Icon(Icons.delete, color: color.error),
                  ),
                ],
              ),
            ],
          ),
        );
  }
}
