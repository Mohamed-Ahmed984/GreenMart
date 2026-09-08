import 'package:flutter/material.dart';
import 'package:flutter_application_13/Core/Constant/app_image.dart';
import 'package:flutter_application_13/Core/Features/main/main_app_screen.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _form = GlobalKey<FormState>();
  final _email = TextEditingController();
  final _password = TextEditingController();
  bool _hidden = true;

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  void _enter({bool guest = false}) {
    if (!guest && !_form.currentState!.validate()) return;
    FocusScope.of(context).unfocus();
    Navigator.pushAndRemoveUntil(context,
      MaterialPageRoute<void>(builder: (_) => MainAppScreen(
        email: guest ? null : _email.text.trim().toLowerCase())), (_) => false);
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(title: const Text('Welcome back')),
        body: SafeArea(child: Center(child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 520),
          child: SingleChildScrollView(padding: const EdgeInsets.all(24),
            child: Form(key: _form, child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SvgPicture.asset(AppImage.carrot, height: 56),
                const SizedBox(height: 24),
                Text('Try the store', style: Theme.of(context).textTheme.headlineMedium),
                const SizedBox(height: 12),
                const Text('Demo sign-in only. No account is created or verified. Use sample details, or continue as a guest.'),
                const SizedBox(height: 24),
                TextFormField(key: const Key('login-email'), controller: _email,
                  keyboardType: TextInputType.emailAddress, autocorrect: false,
                  textInputAction: TextInputAction.next,
                  decoration: const InputDecoration(labelText: 'Email'),
                  validator: (value) => RegExp(r'^[^\s@]+@[^\s@]+\.[^\s@]+$').hasMatch(value?.trim() ?? '')
                    ? null : 'Enter a valid email address'),
                const SizedBox(height: 20),
                TextFormField(key: const Key('login-password'), controller: _password,
                  obscureText: _hidden, autocorrect: false, enableSuggestions: false,
                  onFieldSubmitted: (_) => _enter(),
                  decoration: InputDecoration(labelText: 'Demo password',
                    suffixIcon: IconButton(tooltip: _hidden ? 'Show password' : 'Hide password',
                      onPressed: () => setState(() => _hidden = !_hidden),
                      icon: Icon(_hidden ? Icons.visibility_outlined : Icons.visibility_off_outlined))),
                  validator: (value) => (value?.trim().length ?? 0) >= 6
                    ? null : 'Use at least 6 characters'),
                const SizedBox(height: 28),
                FilledButton(key: const Key('demo-login'), onPressed: _enter,
                  child: const Text('Continue with demo sign-in')),
                const SizedBox(height: 12),
                OutlinedButton(key: const Key('guest-login'), onPressed: () => _enter(guest: true),
                  child: const Text('Continue as guest')),
              ],
            )),
          ),
        ))),
      );
}
