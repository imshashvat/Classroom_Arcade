import 'package:flutter/material.dart';

class TeamBadge extends StatelessWidget {
  final String name;
  final IconData icon;

  TeamBadge({required this.name, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Draggable(
      feedback: Container(
        width: 80,
        height: 80,
        decoration: BoxDecoration(color: Colors.pinkAccent, shape: BoxShape.circle),
        child: Icon(icon, color: Colors.white),
      ),
      child: Container(
        width: 60,
        height: 60,
        decoration: BoxDecoration(
          color: Colors.blueAccent,
          shape: BoxShape.circle,
          boxShadow: [BoxShadow(color: Colors.cyan, blurRadius: 10)],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: Colors.white),
            Text(name, style: TextStyle(color: Colors.white, fontSize: 10)),
          ],
        ),
      ),
    );
  }
}