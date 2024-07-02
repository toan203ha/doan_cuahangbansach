import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class dangnhapWidget extends StatefulWidget {
  const dangnhapWidget({Key? key}) : super(key: key);

  @override
  State<dangnhapWidget> createState() => _loginwidgetState();
}

class _loginwidgetState extends State<dangnhapWidget> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  // ẩn hiện password
  bool passwordVisible = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:SingleChildScrollView( child:  Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const Text(
              'Chào mừng!',
              style: TextStyle(
                fontSize: 36,
                fontWeight: FontWeight.bold,
                color: Color(0xFF4D9194),
              ),
            ),
            const Text(
              'Đăng nhập vào tài khoản của bạn',
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 0, 0, 0),
                ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _emailController,
              obscureText: false,
              decoration: const InputDecoration(
                labelText: 'Email',        
                filled: true,
                border: InputBorder.none,
                //fillColor: Color.fromARGB(255, 182, 167, 167),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Color.fromARGB(255, 0, 0, 0)),
                  //borderRadius: BorderRadius.circular(25.7),
                ),
              ),
            ),
            const SizedBox(height: 16),

            TextField(
              controller: _passwordController,
              obscureText: passwordVisible,
              decoration: InputDecoration(
                focusedBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: Color.fromARGB(255, 0, 0, 0)),
                  //borderRadius: BorderRadius.circular(25.7),
                ),
                border: InputBorder.none,
                labelText: "Mật khẩu",
                helperText: "Thông báo",
                helperStyle: const TextStyle(color: Colors.green),
                suffixIcon: IconButton(
                  icon: Icon(passwordVisible
                      ? Icons.visibility
                      : Icons.visibility_off),
                  onPressed: () {
                    setState(
                      () {
                        passwordVisible = !passwordVisible;
                      },
                    );
                  },
                ),
                alignLabelWithHint: false,
                filled: true,
              ),
              keyboardType: TextInputType.visiblePassword,
              textInputAction: TextInputAction.done,
            ),
            const SizedBox(height: 20),
            GestureDetector(
              onTap: () {
                // Handle "Quên mật khẩu" logic here
                print('Quên mật khẩu');
              },
              child: const Text(
                'Quên mật khẩu?',
                style: TextStyle(
                    color: Colors.blue,
                    decoration: TextDecoration.underline,
                    fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 20),
            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.label_important_outlined,
                  color: Color(0xFF4D9194),
                  size: 30.0,
                ),
                Text('Hoặc đăng nhập bằng hình thức khác'),
                Icon(
                  Icons.label_important_outlined,
                  color: Color(0xFF4D9194),
                  size: 30.0,
                ),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(width: 16),
                // Facebook Login Button with Border
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.blue, width: 2),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: IconButton(
                    icon: const Icon(Icons.facebook, color: Colors.blue),
                    onPressed: () {
                      // Handle Facebook login
                      print('Đăng nhập bằng Facebook');
                    },
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: ElevatedButton(
                onPressed: () {
                  // Handle login logic here
                  print('Đăng nhập');
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF4D9194),
                  //  minimumSize: Size(double.infinity, 40), // Full-width button
                ),
                child: const Padding(
                  padding: EdgeInsets.all(30),
                  child: Text(
                    'Đăng nhập',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 25,
                      fontFamily: 'Nunito',
                      fontWeight: FontWeight.w900,
                      height: 0.01,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      )
    );
  }
}
