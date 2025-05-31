import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomInputField extends StatefulWidget {
  final String label;
  final String hint;
  final IconData? suffixIcon;
  final Future<String?> Function()? onTapSelect;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final bool readOnly;

  const CustomInputField({
    Key? key,
    required this.label,
    required this.hint,
    this.suffixIcon,
    this.onTapSelect,
    this.controller,
    this.validator,
    this.readOnly = true,
  }) : super(key: key);

  @override
  CustomInputFieldState createState() => CustomInputFieldState();
}

class CustomInputFieldState extends State<CustomInputField> {
  late final TextEditingController _controller;

  TextEditingController get controller => _controller;

  @override
  void initState() {
    super.initState();
    _controller = widget.controller ?? TextEditingController();
  }

  @override
  void dispose() {
    if (widget.controller == null) {
      _controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bool hasValue = _controller.text.isNotEmpty;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.label,
          style: const TextStyle(
            color: Colors.black87,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 6),
        TextFormField(
          controller: _controller,
          validator: widget.validator,
          readOnly: widget.readOnly,
          keyboardType: TextInputType.name,
          inputFormatters: [
            FilteringTextInputFormatter.deny(RegExp(r'^[a-zA-Z\s]+$')),
          ],
          onTap: () async {
            if (widget.onTapSelect != null) {
              final result = await widget.onTapSelect!();
              if (result != null) {
                setState(() {
                  _controller.text = result;
                });
              }
            }
          },
          style: const TextStyle(color: Colors.black87, fontSize: 16),
          decoration: InputDecoration(
            hintText: widget.hint,
            filled: true,
            fillColor: Colors.grey.withOpacity(0.08),
            contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            suffixIcon: widget.suffixIcon != null
                ? Icon(widget.suffixIcon, size: 18, color: Colors.grey[700])
                : null,
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(16),
            ),
            errorBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.red),
              borderRadius: BorderRadius.circular(16),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.blue.shade300),
              borderRadius: BorderRadius.circular(16),
            ),
          ),
        ),
      ],
    );
  }
}
