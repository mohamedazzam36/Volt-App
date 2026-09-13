import 'package:flutter/material.dart';

class TopStatsBar extends StatelessWidget {
  const TopStatsBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildStat(Icons.local_fire_department, "12", Colors.orange),
          _buildStat(Icons.diamond, "527", Colors.blue),
          _buildStat(Icons.favorite, "5", Colors.red),
        ],
      ),
    );
  }

  Widget _buildStat(IconData icon, String text, Color color) {
    return Row(
      children: [
        Icon(icon, color: color, size: 24),
        const SizedBox(width: 4),
        Text(
          text,
          style: TextStyle(color: color, fontWeight: FontWeight.bold, fontSize: 16),
        ),
      ],
    );
  }
}
