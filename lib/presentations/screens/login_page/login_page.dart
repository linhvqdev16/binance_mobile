import 'package:binance_mobile/presentations/screens/home_page/home_page.dart';
import 'package:binance_mobile/presentations/screens/register_page/register_page.dart';
import 'package:binance_mobile/presentations/widgets/common/change_language.dart';
import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return LoginScreenState();
  }
}

class LoginScreenState extends State<LoginScreen> {
  bool _isChecked = true;
  bool _isPasswordVisible = false;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //nút chuyển ngôn ngữ
            const SizedBox(height: 50),
            const ChangeLanguage(),
            const SizedBox(height: 20),
            Text(
              appLocalizations.chaoMungDenVoiBinance,
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            Text(appLocalizations.email_sdt,
                style: TextStyle(fontSize: 16, color: Colors.grey[700])),
            //email
            const SizedBox(height: 5),
            TextField(
              controller: _emailController,
              decoration: InputDecoration(
                hintText: appLocalizations.validateEmail,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                filled: true,
                fillColor: Colors.grey[200],
                suffixIcon: _emailController.text.isNotEmpty
                    ? IconButton(
                  icon: const Icon(Icons.clear_outlined),
                  onPressed: () {
                    setState(() {
                      _emailController.clear();
                    });
                  },
                )
                    : null,
              ),
              onChanged: (value) {
                setState(() {});
              },
            ),
            //password
            const SizedBox(height: 10),
            TextField(
              controller: _passController,
              obscureText: !_isPasswordVisible,
              decoration: InputDecoration(
                hintText: appLocalizations.password,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                filled: true,
                fillColor: Colors.grey[200],
                suffixIcon: IconButton(
                  icon: Icon(
                    _isPasswordVisible
                        ? Icons.visibility
                        : Icons.visibility_off,
                  ),
                  onPressed: () {
                    setState(() {
                      _isPasswordVisible = !_isPasswordVisible;
                    });
                  },
                ),
              ),
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Checkbox(
                  value: _isChecked,
                  activeColor: Colors.black,
                  onChanged: (value) {
                    setState(() {
                      _isChecked = value!;
                    });
                  },
                ),
                Expanded(
                  child: RichText(
                    text: TextSpan(
                      style: const TextStyle(fontSize: 14, color: Colors.black),
                      children: [
                        TextSpan(text: appLocalizations.note1),
                        TextSpan(
                          text: appLocalizations.note2,
                          style: const TextStyle(
                            decoration: TextDecoration.underline,
                            color: Colors.blue,
                          ),
                        ),
                        TextSpan(text: appLocalizations.noteAnd),
                        TextSpan(
                          text: appLocalizations.note3,
                          style: const TextStyle(
                            decoration: TextDecoration.underline,
                            color: Colors.blue,
                          ),
                        ),
                        TextSpan(text: appLocalizations.note4),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.yellow,
                minimumSize: const Size(double.infinity, 50),
              ),
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const HomePage()),
                );
              },
              child: Text(appLocalizations.next,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  )),
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: Divider(color: Colors.grey[400], thickness: 1),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Text(appLocalizations.or,
                      style: const TextStyle(fontSize: 16)),
                ),
                Expanded(
                  child: Divider(color: Colors.grey[400], thickness: 1),
                ),
              ],
            ),
            const SizedBox(height: 10),
            OutlinedButton(
              style: OutlinedButton.styleFrom(
                minimumSize: const Size(double.infinity, 50),
                side: const BorderSide(color: Colors.grey),
              ),
              onPressed: () {},
              child: Row(
                children: [
                  Image.asset('assets/images/google.png', height: 20),
                  Expanded(
                    child: Text(
                      appLocalizations.continueWithGoogle,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                          fontSize: 15,
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            OutlinedButton(
              style: OutlinedButton.styleFrom(
                minimumSize: const Size(double.infinity, 50),
                side: const BorderSide(color: Colors.grey),
              ),
              onPressed: () {},
              child: Row(
                children: [
                  Image.asset('assets/images/telegram.png', height: 20),
                  Expanded(
                    child: Text(
                      appLocalizations.continueWithTelegram,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                          fontSize: 15,
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Center(
              child: RichText(
                text: TextSpan(
                  style: const TextStyle(fontSize: 14, color: Colors.black),
                  children: [
                    TextSpan(
                      text: appLocalizations.registerAsALegalEntity,
                      style: const TextStyle(color: Colors.orange),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const RegisterPage()),
                          );
                        },
                    ),
                    TextSpan(text: appLocalizations.or),
                    TextSpan(
                      text: appLocalizations.logIn,
                      style: const TextStyle(color: Colors.blue),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          print('Đăng nhập được nhấn');
                        },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
