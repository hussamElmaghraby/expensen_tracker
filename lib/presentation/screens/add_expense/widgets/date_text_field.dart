import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DateTextField extends FormField<DateTime> {
  DateTextField({
    Key? key,
    required String label,
    DateTime? initialDate,
    FormFieldValidator<DateTime>? validator,
    void Function(DateTime)? onDateSelected,
    AutovalidateMode autovalidateMode = AutovalidateMode.disabled,
  }) : super(
    key: key,
    initialValue: initialDate,
    validator: validator,
    autovalidateMode: autovalidateMode,
    builder: (FormFieldState<DateTime> state) {
      final selectedDate = state.value;
      final formattedDate = selectedDate != null
          ? DateFormat('dd/MM/yy').format(selectedDate)
          : 'Select date';

      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
              color: Colors.black87,
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 6),
          GestureDetector(
            onTap: () async {
              final now = DateTime.now();
              final picked = await showDatePicker(
                context: state.context,
                initialDate: selectedDate ?? now,
                firstDate: DateTime(2000),
                lastDate: DateTime(2100),
              );
              if (picked != null) {
                state.didChange(picked);
                if (onDateSelected != null) {
                  onDateSelected(picked);
                }
              }
            },
            child: Container(
              height: 48,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: Colors.grey.withOpacity(0.08),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    formattedDate,
                    style: TextStyle(
                      color: selectedDate != null
                          ? Colors.black87
                          : Colors.grey[700],
                      fontSize: 14,
                    ),
                  ),
                  Icon(Icons.calendar_today, size: 25, color: Colors.grey[700]),
                ],
              ),
            ),
          ),
          if (state.hasError)
            Padding(
              padding: const EdgeInsets.only(top: 6),
              child: Text(
                state.errorText!,
                style: TextStyle(color: Colors.red[700], fontSize: 12),
              ),
            ),
        ],
      );
    },
  );
}
