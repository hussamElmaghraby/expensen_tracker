import 'package:flutter/material.dart';

class CustomAppBar extends StatefulWidget implements PreferredSizeWidget {
  @override
  final Size preferredSize;

  final String selectedPeriod;
  final Function(String) onFilterChanged;

  const CustomAppBar({
    Key? key,
    required this.selectedPeriod,
    required this.onFilterChanged,
  })  : preferredSize = const Size.fromHeight(80.0),
        super(key: key);

  @override
  _CustomAppBarState createState() => _CustomAppBarState();
}

class _CustomAppBarState extends State<CustomAppBar> {
  late String selectedPeriod;

  final List<String> periods = ['All','Today', 'This week', 'This month', 'This year'];

  @override
  void initState() {
    super.initState();
    selectedPeriod = widget.selectedPeriod;
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: const Color(0xFF1d55f3),
      elevation: 0,
      title: const Row(
        children: [
          CircleAvatar(
            backgroundImage: NetworkImage('https://i.pravatar.cc/150?img=3'),
            radius: 22,
          ),
          SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Good Morning', style: TextStyle(color: Colors.white70, fontSize: 14)),
              Text('Shihab Rahman',
                  style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
            ],
          ),
        ],
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 12.0),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                value: selectedPeriod,
                icon: const Icon(Icons.keyboard_arrow_down, color: Colors.grey),
                style: const TextStyle(color: Colors.black, fontSize: 14),
                dropdownColor: Colors.white,
                onChanged: (value) {
                  if (value != null) {
                    setState(() => selectedPeriod = value);
                    widget.onFilterChanged(value);
                  }
                },
                items: periods.map((String period) {
                  return DropdownMenuItem<String>(
                    value: period,
                    child: Text(period),
                  );
                }).toList(),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
