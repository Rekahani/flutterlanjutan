import 'package:flutter/material.dart';

void main() {
  runApp(LoginApp());
}

class LoginApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Login App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LoginPage(),
    );
  }
}

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  List<String> _errorMessages = [];
  bool _isPasswordVisible = false;

  void _login() {
    String username = _usernameController.text;
    String password = _passwordController.text;

    // Mengosongkan daftar pesan kesalahan
    _errorMessages = [];

    // Melakukan validasi password
    if (password.isEmpty) {
      _errorMessages.add('Password belum diisi');
    }
    if (password.length < 6) {
      _errorMessages.add('Password harus memiliki minimal 6 karakter');
    }
    if (!_containsUppercase(password)) {
      _errorMessages.add('Password harus memiliki minimal 1 huruf kapital');
    }
    if (!_containsNumber(password)) {
      _errorMessages.add('Password harus memiliki minimal 1 angka');
    }
    if (!_containsSpecialChar(password)) {
      _errorMessages.add('Password harus memiliki minimal 1 karakter khusus');
    }

    if (_errorMessages.isEmpty) {
      _errorMessages.add('Password sudah kuat');
    }

    setState(() {});
  }

  void _togglePasswordVisibility() {
    setState(() {
      _isPasswordVisible = !_isPasswordVisible;
    });
  }

  bool _containsUppercase(String password) {
    return password.contains(RegExp(r'[A-Z]'));
  }

  bool _containsNumber(String password) {
    return password.contains(RegExp(r'[0-9]'));
  }

  bool _containsSpecialChar(String password) {
    return password.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: TextField(
                controller: _usernameController,
                decoration: InputDecoration(
                  labelText: 'Username',
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: TextField(
                controller: _passwordController,
                obscureText: !_isPasswordVisible,
                decoration: InputDecoration(
                  labelText: 'Password',
                  suffixIcon: IconButton(
                    icon: Icon(
                      _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                    ),
                    onPressed: _togglePasswordVisibility,
                  ),
                ),
              ),
            ),
            SizedBox(height: 24.0),
            ElevatedButton(
              onPressed: _login,
              child: Text('Login'),
            ),
            SizedBox(height: 8.0),
            if (_errorMessages.isNotEmpty)
              Column(
                children: _errorMessages.map((message) => Text(
                  message,
                  style: TextStyle(
                    color: Colors.green,
                  ),
                )).toList(),
              ),
          ],
        ),
      ),
    );
  }
}
