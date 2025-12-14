import 'dart:async';
import 'package:flutter/material.dart';

class CountdownTimerPage extends StatefulWidget {
  const CountdownTimerPage({Key? key}) : super(key: key);

  @override
  _CountdownTimerPageState createState() => _CountdownTimerPageState();
}

class _CountdownTimerPageState extends State<CountdownTimerPage>
    with SingleTickerProviderStateMixin {
  final TextEditingController _controller = TextEditingController();
  Timer? _timer;
  int _remainingSeconds = 0;
  int _totalSeconds = 0;
  bool _isRunning = false;
  String _message = "";
  late AnimationController _animController;

  @override
  void initState() {
    super.initState();
    _animController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 500),
    );
  }

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
      _totalSeconds = input;
      _isRunning = true;
      _message = "";
    });

    _animController.repeat();

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (_remainingSeconds > 0) {
          _remainingSeconds--;
        } else {
          _isRunning = false;
          _message = "⏰ Hết thời gian!";
          _timer?.cancel();
          _animController.stop();
        }
      });
    });
  }

  void _resetTimer() {
    setState(() {
      _timer?.cancel();
      _remainingSeconds = 0;
      _totalSeconds = 0;
      _isRunning = false;
      _message = "";
      _controller.clear();
      _animController.stop();
      _animController.reset();
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _controller.dispose();
    _animController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double progress = _totalSeconds > 0 ? _remainingSeconds / _totalSeconds : 0;

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFF667eea), Color(0xFF764ba2)],
          ),
        ),
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(24),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Countdown Timer',
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 40),
                  Container(
                    padding: EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(24),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          blurRadius: 20,
                          offset: Offset(0, 10),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        Stack(
                          alignment: Alignment.center,
                          children: [
                            SizedBox(
                              width: 200,
                              height: 200,
                              child: CircularProgressIndicator(
                                value: progress,
                                strokeWidth: 12,
                                backgroundColor: Colors.grey[200],
                                valueColor: AlwaysStoppedAnimation<Color>(
                                  _remainingSeconds > 0
                                      ? Color(0xFF667eea)
                                      : Colors.red,
                                ),
                              ),
                            ),
                            Column(
                              children: [
                                Text(
                                  _remainingSeconds > 0
                                      ? '$_remainingSeconds'
                                      : '0',
                                  style: TextStyle(
                                    fontSize: 56,
                                    fontWeight: FontWeight.bold,
                                    color: _remainingSeconds > 0
                                        ? Color(0xFF667eea)
                                        : Colors.red,
                                  ),
                                ),
                                Text(
                                  'giây',
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.grey[600],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(height: 32),
                        TextField(
                          controller: _controller,
                          keyboardType: TextInputType.number,
                          enabled: !_isRunning,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                          decoration: InputDecoration(
                            hintText: "Nhập số giây",
                            prefixIcon: Icon(Icons.timer_outlined),
                            filled: true,
                            fillColor: Colors.grey[100],
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                              borderSide: BorderSide.none,
                            ),
                          ),
                        ),
                        SizedBox(height: 24),
                        Row(
                          children: [
                            Expanded(
                              child: ElevatedButton.icon(
                                onPressed: _isRunning ? null : _startTimer,
                                icon: Icon(Icons.play_arrow),
                                label: Text('Bắt đầu'),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Color(0xFF667eea),
                                  foregroundColor: Colors.white,
                                  padding: EdgeInsets.symmetric(vertical: 16),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                  elevation: 0,
                                ),
                              ),
                            ),
                            SizedBox(width: 12),
                            Expanded(
                              child: ElevatedButton.icon(
                                onPressed: _resetTimer,
                                icon: Icon(Icons.refresh),
                                label: Text('Đặt lại'),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.grey[300],
                                  foregroundColor: Colors.grey[800],
                                  padding: EdgeInsets.symmetric(vertical: 16),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                  elevation: 0,
                                ),
                              ),
                            ),
                          ],
                        ),
                        if (_message.isNotEmpty) ...[
                          SizedBox(height: 16),
                          Text(
                            _message,
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: _message.contains('⏰')
                                  ? Colors.red
                                  : Colors.orange,
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
