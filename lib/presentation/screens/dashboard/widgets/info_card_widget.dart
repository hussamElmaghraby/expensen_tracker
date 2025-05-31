
import 'package:flutter/material.dart';

class InfoCard extends StatelessWidget {
  final String title;
  final String amount;
  final IconData icon;

  const InfoCard({
    Key? key,
    required this.title,
    required this.amount,
    required this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          Row(
            children: [
              Icon(icon, color: Colors.white70, size: 14),
              const SizedBox(width: 4),
              Text(
                title,
                style: const TextStyle(color: Colors.white70, fontSize: 13),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Text(
            amount,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w600,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }
}
