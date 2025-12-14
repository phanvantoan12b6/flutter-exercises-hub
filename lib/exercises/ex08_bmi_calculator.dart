import 'package:flutter/material.dart';

class BmiPage extends StatefulWidget {
  const BmiPage({super.key});

  @override
  State<BmiPage> createState() => _BmiPageState();
}

class _BmiPageState extends State<BmiPage> {
  final _heightCtrl = TextEditingController();
  final _weightCtrl = TextEditingController();

  double? _bmi;
  String _category = "";
  Color _categoryColor = Colors.grey;

  void _calculateBMI() {
    final height = double.tryParse(_heightCtrl.text);
    final weight = double.tryParse(_weightCtrl.text);

    if (height == null || weight == null || height <= 0) {
      setState(() {
        _bmi = null;
        _category = "Dữ liệu không hợp lệ";
        _categoryColor = Colors.red;
      });
      return;
    }

    final bmi = weight / (height * height);

    setState(() {
      _bmi = double.parse(bmi.toStringAsFixed(1));

      if (bmi < 18.5) {
        _category = "Thiếu cân";
        _categoryColor = Color(0xFF4facfe);
      } else if (bmi < 25) {
        _category = "Bình thường";
        _categoryColor = Color(0xFF43e97b);
      } else if (bmi < 30) {
        _category = "Thừa cân";
        _categoryColor = Color(0xFFfee140);
      } else {
        _category = "Béo phì";
        _categoryColor = Color(0xFFfa709a);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFF43e97b), Color(0xFF38f9d7)],
          ),
        ),
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(24),
              child: Container(
                constraints: BoxConstraints(maxWidth: 450),
                padding: EdgeInsets.all(32),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(32),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.15),
                      blurRadius: 30,
                      offset: Offset(0, 15),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Icon(
                      Icons.monitor_weight_outlined,
                      size: 64,
                      color: Color(0xFF43e97b),
                    ),
                    SizedBox(height: 16),
                    Text(
                      'BMI Calculator',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey[800],
                      ),
                    ),
                    Text(
                      'Tính chỉ số khối cơ thể',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[600],
                      ),
                    ),
                    SizedBox(height: 32),
                    _buildInputField(
                      controller: _heightCtrl,
                      label: "Chiều cao (m)",
                      icon: Icons.height,
                      hint: "Ví dụ: 1.70",
                    ),
                    SizedBox(height: 16),
                    _buildInputField(
                      controller: _weightCtrl,
                      label: "Cân nặng (kg)",
                      icon: Icons.monitor_weight,
                      hint: "Ví dụ: 65",
                    ),
                    SizedBox(height: 24),
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        gradient: LinearGradient(
                          colors: [Color(0xFF43e97b), Color(0xFF38f9d7)],
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Color(0xFF43e97b).withOpacity(0.4),
                            blurRadius: 15,
                            offset: Offset(0, 8),
                          ),
                        ],
                      ),
                      child: ElevatedButton(
                        onPressed: _calculateBMI,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.transparent,
                          shadowColor: Colors.transparent,
                          padding: EdgeInsets.symmetric(vertical: 18),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                        child: Text(
                          "Tính BMI",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    if (_bmi != null) ...[
                      SizedBox(height: 32),
                      AnimatedContainer(
                        duration: Duration(milliseconds: 500),
                        padding: EdgeInsets.all(24),
                        decoration: BoxDecoration(
                          color: _categoryColor.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: _categoryColor.withOpacity(0.3),
                            width: 2,
                          ),
                        ),
                        child: Column(
                          children: [
                            Text(
                              '$_bmi',
                              style: TextStyle(
                                fontSize: 56,
                                fontWeight: FontWeight.bold,
                                color: _categoryColor,
                              ),
                            ),
                            SizedBox(height: 8),
                            Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 8),
                              decoration: BoxDecoration(
                                color: _categoryColor,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Text(
                                _category,
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInputField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    required String hint,
  }) {
    return TextField(
      controller: controller,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        prefixIcon: Icon(icon, color: Color(0xFF43e97b)),
        filled: true,
        fillColor: Colors.grey[50],
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: Colors.grey[200]!, width: 1),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: Color(0xFF43e97b), width: 2),
        ),
      ),
    );
  }
}
