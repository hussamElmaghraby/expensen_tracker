import 'package:flutter/material.dart';

class DropdownTextField extends StatelessWidget {
  final String label;
  final String value;
  final List<String> items;
  final ValueChanged<String?> onChanged;
  final String? Function(String?)? validator;

  const DropdownTextField({
    Key? key,
    required this.label,
    required this.value,
    required this.items,
    required this.onChanged,
    this.validator,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            color: Colors.black87,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 6),
        DropdownButtonFormField<String>(
          value: value,
          validator: validator,

          onChanged: onChanged,
          items: items.map((item) {
            return DropdownMenuItem<String>(
              value: item,
              child: Text(item),
            );
          }).toList(),
          decoration: InputDecoration(
            labelStyle: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: Colors.black45,
            ),
            filled: true,
            fillColor: Colors.grey.withOpacity(0.08),
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(16),
            ),
            errorBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.red),
              borderRadius: BorderRadius.circular(16),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.blue.shade200),
              borderRadius: BorderRadius.circular(16),
            ),
          ),
          icon: Icon(Icons.keyboard_arrow_down, color: Colors.grey[700]),
          style: const TextStyle(color: Colors.black87, fontSize: 14),
          dropdownColor: Colors.white,
        ),
      ],
    );
  }
}
