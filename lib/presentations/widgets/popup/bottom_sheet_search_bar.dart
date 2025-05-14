import 'package:flutter/material.dart';

class SearchBarBottom extends StatelessWidget {
  const SearchBarBottom({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 38,
      padding: const EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
        color: Colors.grey.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Icon(Icons.search, size: 18, color: Colors.grey[600]),
          const SizedBox(width: 3),
          Text(
            "Tìm",
            style: TextStyle(
              color: Colors.grey[600]?.withOpacity(0.7),
              fontSize: 14,
              fontWeight: FontWeight.bold
            ),
          ),
        ],
      ),
    );
  }
}