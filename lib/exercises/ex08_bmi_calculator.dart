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

  void _calculateBMI() {
    final height = double.tryParse(_heightCtrl.text);
    final weight = double.tryParse(_weightCtrl.text);

    if (height == null || weight == null || height <= 0) {
      setState(() {
        _bmi = null;
        _category = "Sai dữ liệu!";
      });
      return;
    }

    final bmi = weight / (height * height);

    setState(() {
      _bmi = double.parse(bmi.toStringAsFixed(2));

      if (bmi < 18.5) {
        _category = "Thiếu cân";
      } else if (bmi < 25) {
        _category = "Bình thường";
      } else if (bmi < 30) {
        _category = "Thừa cân";
      } else {
        _category = "Béo phì";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          width: 380,
          padding: const EdgeInsets.all(20),
          color: Colors.grey.shade200,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(12),
                color: const Color(0xFF2F53D8),
                child: const Center(
                  child: Text(
                    "Tính chỉ số BMI",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: _heightCtrl,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: "Chiều cao (m)",
                  prefixIcon: const Icon(Icons.height),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              const SizedBox(height: 15),
              TextField(
                controller: _weightCtrl,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: "Cân nặng (kg)",
                  prefixIcon: const Icon(Icons.monitor_weight),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF2F53D8),
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  icon: const Icon(Icons.calculate, color: Colors.white),
                  label: const Text(
                    "Tính BMI",
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                  onPressed: _calculateBMI,
                ),
              ),
              const SizedBox(height: 20),
              if (_bmi != null)
                Column(
                  children: [
                    Text(
                      "Chỉ số BMI: $_bmi",
                      style: const TextStyle(
                        fontSize: 18,
                        color: Colors.red,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      "Phân loại: $_category",
                      style: const TextStyle(fontSize: 16, color: Colors.red),
                    ),
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }
}
