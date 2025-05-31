import 'package:flutter/material.dart';

class CategoryItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  final bool isSelected;
  final VoidCallback? onTap;

  const CategoryItem({
    Key? key,
    required this.icon,
    required this.label,
    required this.color,
    this.isSelected = false,
    this.onTap,
  }) : super(key: key);

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
              color: isSelected ? color : color.withOpacity(0.15),
            ),
            child: Icon(
              icon,
              color: isSelected ? Colors.white : color,
              size: 33,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            label,
            style: const TextStyle(
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
