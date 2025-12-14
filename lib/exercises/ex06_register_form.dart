import 'package:flutter/material.dart';

const Color mainColor = Color(0xFF2F53D8);
const Color errorColor = Color(0xFFC62828);
const Color borderColor = Color(0xFFD9D9D9);

class RegisterForm extends StatefulWidget {
  const RegisterForm({super.key});

  @override
  State<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  final _formKey = GlobalKey<FormState>();
  bool _hidePass = true;

  final _name = TextEditingController();
  final _email = TextEditingController();
  final _pass = TextEditingController();
  final _confirm = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              color: mainColor,
              child: const Center(
                child: Text(
                  "Form Đăng ký tài khoản",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: _name,
                      decoration: _inputDecoration("Họ tên", Icons.person),
                      validator: (v) =>
                          v!.isEmpty ? "Vui lòng nhập họ tên" : null,
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      controller: _email,
                      decoration: _inputDecoration("Email", Icons.email),
                      validator: (v) =>
                          v!.isEmpty ? "Vui lòng nhập email" : null,
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      controller: _pass,
                      obscureText: _hidePass,
                      decoration: _inputDecoration(
                        "Mật khẩu",
                        Icons.lock,
                        isPassword: true,
                      ),
                      validator: (v) =>
                          v!.isEmpty ? "Vui lòng nhập mật khẩu" : null,
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      controller: _confirm,
                      obscureText: _hidePass,
                      decoration: _inputDecoration(
                        "Xác nhận mật khẩu",
                        Icons.lock_outline,
                        isPassword: true,
                      ),
                      validator: (v) {
                        if (v!.isEmpty) return "Vui lòng xác nhận mật khẩu";
                        if (v != _pass.text) {
                          return "Mật khẩu không trùng khớp";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 30),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: mainColor,
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                        icon: const Icon(
                          Icons.person_add_alt_1,
                          color: Colors.white,
                        ),
                        label: const Text(
                          "Đăng ký",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text("Đăng ký thành công!"),
                              ),
                            );
                          }
                        },
                      ),
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  InputDecoration _inputDecoration(
    String label,
    IconData icon, {
    bool isPassword = false,
  }) {
    return InputDecoration(
      labelText: label,
      prefixIcon: Icon(icon),
      suffixIcon: isPassword
          ? IconButton(
              icon: Icon(
                _hidePass ? Icons.visibility_off : Icons.visibility,
                color: Colors.grey,
              ),
              onPressed: () => setState(() => _hidePass = !_hidePass),
            )
          : null,
      enabledBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: borderColor, width: 1.2),
        borderRadius: BorderRadius.circular(12),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: mainColor, width: 1.5),
        borderRadius: BorderRadius.circular(12),
      ),
      errorBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: errorColor, width: 1.5),
        borderRadius: BorderRadius.circular(12),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: errorColor, width: 1.5),
        borderRadius: BorderRadius.circular(12),
      ),
    );
  }
}
