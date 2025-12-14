import 'package:flutter/material.dart';

class FeedbackForm extends StatefulWidget {
  const FeedbackForm({super.key});

  @override
  State<FeedbackForm> createState() => _FeedbackFormState();
}

class _FeedbackFormState extends State<FeedbackForm> {
  final TextEditingController _nameCtrl = TextEditingController();
  final TextEditingController _contentCtrl = TextEditingController();

  int _rating = 4;

  final Color mainColor = const Color(0xFFFF5722);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: Center(
        child: Container(
          width: 380,
          padding: const EdgeInsets.all(20),
          color: Colors.grey.shade100,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(15),
                color: mainColor,
                child: const Center(
                  child: Text(
                    "Gửi phản hồi",
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
                controller: _nameCtrl,
                decoration: InputDecoration(
                  labelText: "Họ tên",
                  prefixIcon: const Icon(Icons.person),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              const SizedBox(height: 15),
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Đánh giá (1 - 5 sao)",
                  style: TextStyle(fontSize: 13),
                ),
              ),
              const SizedBox(height: 5),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: DropdownButton<int>(
                  value: _rating,
                  isExpanded: true,
                  underline: const SizedBox(),
                  icon: const Icon(Icons.arrow_drop_down),
                  items: List.generate(5, (index) {
                    final star = index + 1;
                    return DropdownMenuItem(
                      value: star,
                      child: Row(
                        children: [
                          const Icon(Icons.star, color: Colors.amber),
                          const SizedBox(width: 5),
                          Text("$star sao"),
                        ],
                      ),
                    );
                  }),
                  onChanged: (val) {
                    setState(() => _rating = val!);
                  },
                ),
              ),
              const SizedBox(height: 15),
              TextField(
                controller: _contentCtrl,
                maxLines: 5,
                decoration: InputDecoration(
                  labelText: "Nội dung góp ý",
                  alignLabelWithHint: true,
                  prefixIcon: const Icon(Icons.feedback),
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
                    backgroundColor: mainColor,
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  icon: const Icon(Icons.send, color: Colors.white),
                  label: const Text(
                    "Gửi phản hồi",
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Đã gửi phản hồi!")),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
