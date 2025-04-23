import 'package:flutter/material.dart';

class InfoCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String value;
  final String? subtitle;

  const InfoCard({
    required this.icon,
    required this.title,
    required this.value,
    this.subtitle,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12),
      margin: EdgeInsets.all(6),
      width: MediaQuery.of(context).size.width * 0.44,
      decoration: BoxDecoration(
        color: Colors.black.withAlpha(174),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: [
          Icon(icon, size: 30),
          SizedBox(height: 10),
          Text(
            value,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          if (subtitle != null) Text(subtitle!, style: TextStyle(fontSize: 14)),
          SizedBox(height: 6),
          Text(title, style: TextStyle(color: Colors.grey)),
        ],
      ),
    );
  }
}
