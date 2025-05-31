import 'package:flutter/material.dart';

class BalanceCardWidget extends StatelessWidget {
  const BalanceCardWidget({super.key, required this.totlalBalance, required this.totalIncome, required this.totalExpenses});
  final double totlalBalance ;
  final double totalIncome;
  final double totalExpenses;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
      decoration: BoxDecoration(
        color: const Color(0xff4a6df1),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Top row: Title + more options
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Text(
                    'Total Balance',
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Icon(Icons.keyboard_arrow_up,
                      color: Colors.white70, size: 18),
                ],
              ),
              Icon(Icons.more_horiz, color: Colors.white),
            ],
          ),

          const SizedBox(height: 10),

          // Main balance
          Text(
            '\$ ${totlalBalance.toStringAsFixed(2)}',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 28,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 20),

          // Income & Expenses
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Income
              Column(
                children: [
                  const Row(
                    children: [
                      CircleAvatar(
                        radius: 14,
                        backgroundColor: Colors.white24,
                          child: Icon(Icons.arrow_downward,
                              color: Colors.white70, size: 16)),
                      SizedBox(width: 6),
                      Text(
                        'Income',
                        style: TextStyle(color: Colors.white70, fontSize: 16),
                      ),
                      SizedBox(width: 4),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Text(
                    '\$ $totalIncome',
                    style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 18),
                  ),
                ],
              ),
              // Expenses

              Column(
                children: [
                  const Row(
                    children: [
                      CircleAvatar(
                          radius: 14,
                          backgroundColor: Colors.white24,
                          child: Icon(Icons.arrow_downward,
                              color: Colors.white70, size: 16)),
                      SizedBox(width: 6),
                      Text(
                        'Expenses',
                        style: TextStyle(color: Colors.white70, fontSize: 16),
                      ),
                      SizedBox(width: 4),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Text(
                    '\$ ${totalExpenses.toStringAsFixed(2)}',
                    style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 18),
                  ),
                ],
              ),
            ],
          )
        ],
      ),
    );
  }
}
