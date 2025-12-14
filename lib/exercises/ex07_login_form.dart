import 'package:flutter/material.dart';

const Color mainColorLogin = Color(0xFF2F53D8);
const Color errorColorLogin = Color(0xFFC62828);
const Color borderColorLogin = Color(0xFFD9D9D9);

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  bool _hidePass = true;

  final _email = TextEditingController();
  final _password = TextEditingController();

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
              color: mainColorLogin,
              child: const Center(
                child: Text(
                  "Form Đăng nhập",
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
                      controller: _email,
                      decoration: _inputDecoration("Email", Icons.email),
                      validator: (v) =>
                          v!.isEmpty ? "Vui lòng nhập email" : null,
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      controller: _password,
                      obscureText: _hidePass,
                      decoration: _inputDecoration(
                        "Mật khẩu",
                        Icons.lock,
                        isPassword: true,
                      ),
                      validator: (v) =>
                          v!.isEmpty ? "Vui lòng nhập mật khẩu" : null,
                    ),
                    const SizedBox(height: 30),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: mainColorLogin,
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                        icon: const Icon(
                          Icons.login,
                          color: Colors.white,
                        ),
                        label: const Text(
                          "Đăng nhập",
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                          ),
                        ),
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text("Đăng nhập thành công!"),
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
        borderSide: const BorderSide(color: borderColorLogin, width: 1.2),
        borderRadius: BorderRadius.circular(12),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: mainColorLogin, width: 1.5),
        borderRadius: BorderRadius.circular(12),
      ),
      errorBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: errorColorLogin, width: 1.5),
        borderRadius: BorderRadius.circular(12),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: errorColorLogin, width: 1.5),
        borderRadius: BorderRadius.circular(12),
      ),
    );
  }
}
