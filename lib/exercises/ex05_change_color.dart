import 'dart:math';
import 'package:flutter/material.dart';

class ChangeColorPage extends StatefulWidget {
  const ChangeColorPage({super.key});

  @override
  State<ChangeColorPage> createState() => _ChangeColorPageState();
}

class _ChangeColorPageState extends State<ChangeColorPage> {
  final List<Map<String, dynamic>> _colors = [
    {"color": Colors.purple, "name": "Tím"},
    {"color": Colors.blue, "name": "Xanh dương"},
    {"color": Colors.green, "name": "Xanh lá"},
    {"color": Colors.red, "name": "Đỏ"},
    {"color": Colors.orange, "name": "Cam"},
    {"color": Colors.teal, "name": "Xanh ngọc"},
  ];

  Color _backgroundColor = Colors.purple;
  String _colorName = "Tím";

  void _changeColor() {
    final random = Random();
    final index = random.nextInt(_colors.length);

    setState(() {
      _backgroundColor = _colors[index]["color"];
      _colorName = _colors[index]["name"];
    });
  }

  void _resetColor() {
    setState(() {
      _backgroundColor = Colors.purple;
      _colorName = "Tím";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Ứng dụng đổi màu nền",
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        backgroundColor: Colors.amber,
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: _backgroundColor,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Màu hiện tại:",
              style: TextStyle(
                color: Colors.white,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              _colorName,
              style: const TextStyle(color: Colors.white, fontSize: 20),
            ),
            const SizedBox(height: 40),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: _changeColor,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.black,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 12,
                    ),
                  ),
                  child: const Text("Đổi màu", style: TextStyle(fontSize: 16)),
                ),
                const SizedBox(width: 20),
                ElevatedButton(
                  onPressed: _resetColor,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.black,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 12,
                    ),
                  ),
                  child: const Text("Đặt lại", style: TextStyle(fontSize: 16)),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
