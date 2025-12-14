import 'dart:async';
import 'package:flutter/material.dart';

class CountdownTimerPage extends StatefulWidget {
  const CountdownTimerPage({Key? key}) : super(key: key);

  @override
  _CountdownTimerPageState createState() => _CountdownTimerPageState();
}

class _CountdownTimerPageState extends State<CountdownTimerPage> {
  final TextEditingController _controller = TextEditingController();
  Timer? _timer;
  int _remainingSeconds = 0;
  bool _isRunning = false;
  String _message = "";

  void _startTimer() {
    if (_isRunning) return;

    final input = int.tryParse(_controller.text);
    if (input == null || input <= 0) {
      setState(() {
        _message = "Vui lòng nhập số giây hợp lệ!";
      });
      return;
    }

    setState(() {
      _remainingSeconds = input;
      _isRunning = true;
      _message = "";
    });

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (_remainingSeconds > 0) {
          _remainingSeconds--;
        } else {
          _isRunning = false;
          _message = "⏰ Hết thời gian!";
          _timer?.cancel();
        }
      });
    });
  }

  void _resetTimer() {
    setState(() {
      _timer?.cancel();
      _remainingSeconds = 0;
      _isRunning = false;
      _message = "";
      _controller.clear();
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Bộ đếm thời gian"),
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Nhập số giây cần đếm",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(height: 5),
                  TextField(
                    controller: _controller,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: "Nhập số giây ở đây",
                    ),
                    enabled: !_isRunning,
                  ),
                ],
              ),
              const SizedBox(height: 30),
              Text(
                _remainingSeconds > 0 ? '$_remainingSeconds s' : '0',
                style: TextStyle(
                  fontSize: 60,
                  fontWeight: FontWeight.bold,
                  color:
                      _remainingSeconds > 0 ? Colors.green : Colors.redAccent,
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton.icon(
                    onPressed: _isRunning ? null : _startTimer,
                    icon: const Icon(Icons.play_arrow),
                    label: const Text("Bắt đầu"),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 12,
                      ),
                    ),
                  ),
                  const SizedBox(width: 15),
                  ElevatedButton.icon(
                    onPressed: _resetTimer,
                    icon: const Icon(Icons.refresh),
                    label: const Text("Đặt lại"),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.grey,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 12,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Text(
                _message,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                  color: Colors.red,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
