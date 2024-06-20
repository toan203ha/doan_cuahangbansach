import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:flutter/material.dart';

class dangkiWidget extends StatefulWidget {
  const dangkiWidget({Key? key}) : super(key: key);

  @override
  State<dangkiWidget> createState() => _loginwidgetState();
}

class _loginwidgetState extends State<dangkiWidget> {
  // lấy dữ liệu từ bàn phím
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _sdtController = TextEditingController();
  // ẩn mật khẩu
  bool passwordVisible = true;
  // chọn số điện thoại quốc gia mặc định
  PhoneNumber number = PhoneNumber(isoCode: 'VN');
  String initialCountry = 'VN';

  void getPhoneNumber(String phoneNumber) async {
    PhoneNumber number =
        await PhoneNumber.getRegionInfoFromPhoneNumber(phoneNumber, 'VN');

    setState(() {
      this.number = number;
    });
  }

  @override
  void dispose() {
    _sdtController.dispose();
    _emailController.dispose();
    _passwordController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
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
              'Đăng ký ngay hôm nay',
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 0, 0, 0)),
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
            const Padding(padding: EdgeInsets.all(10)),
            Column(
              children: [
                InternationalPhoneNumberInput(
                  onInputChanged: (PhoneNumber number) {
                    print(number.phoneNumber);
                  },
                  onInputValidated: (bool value) {
                    print(value);
                  },
                  selectorConfig: const SelectorConfig(
                    selectorType: PhoneInputSelectorType.BOTTOM_SHEET,
                    useBottomSheetSafeArea: false,
                  ),
                  ignoreBlank: false,
                  autoValidateMode: AutovalidateMode.disabled,
                  selectorTextStyle: const TextStyle(
                    color: Colors.black,
                  ),
                  initialValue: number,
                  textFieldController: _sdtController,
                  formatInput: true,
                  keyboardType: const TextInputType.numberWithOptions(
                      signed: true, decimal: true),
                  inputDecoration: const InputDecoration(
                    labelText: 'Số điện thoại',
                    filled: true,
                    border: InputBorder.none,
                    //fillColor: Color.fromARGB(255, 182, 167, 167),
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Color.fromARGB(255, 0, 0, 0)),
                      //borderRadius: BorderRadius.circular(25.7),
                    ),
                  ),
                  inputBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Color.fromARGB(255, 0, 0, 0)),
                  ),
                  onSaved: (PhoneNumber number) {
                    print('On Saved: $number');
                  },
                ),
              ],
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

                filled: true,
                border: InputBorder.none,
                //fillColor: Color.fromARGB(255, 182, 167, 167),

                labelText: "Mật khẩu",
                helperText: "Thông báo",
                helperStyle: TextStyle(color: Colors.green),
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
              ),
              keyboardType: TextInputType.visiblePassword,
              textInputAction: TextInputAction.done,
            ),
            SizedBox(height: 20),
            GestureDetector(
              onTap: () {
                // Handle "Quên mật khẩu" logic here
                print('Quên mật khẩu');
              },
              child: const Text(
                'Quên mật khẩu?',
                style: TextStyle(
                    color: Colors.blue, decoration: TextDecoration.underline),
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
                  print('Đăng Ký');
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF4D9194),
                  //  minimumSize: Size(double.infinity, 40), // Full-width button
                ),
                child: const Padding(
                  padding: EdgeInsets.all(30),
                  child: Text(
                    'Đăng ký',
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
    );
  }
}
