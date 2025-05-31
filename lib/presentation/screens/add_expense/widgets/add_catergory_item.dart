
import 'package:flutter/material.dart';

class AddCategoryItem extends StatelessWidget {
  final VoidCallback? onTap;

  const AddCategoryItem({Key? key, this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: Colors.blue, width: 1.5),
            ),
            child: const Icon(Icons.add, color: Colors.blue, size: 24),
          ),
          const SizedBox(height: 8),
          const Text(
            "Add Category",
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w500,
              color: Colors.black87,
            ),
          )
        ],
      ),
    );
  }
}
