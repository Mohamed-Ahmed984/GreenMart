import 'package:flutter/material.dart';
import 'package:flutter_application_13/Core/Constant/app_image.dart';
import 'package:flutter_application_13/Core/Features/aut/page/login_screen.dart';
import 'package:flutter_application_13/Core/Style/app_colors.dart';
import 'package:flutter_svg/flutter_svg.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
        body: Stack(
          fit: StackFit.expand,
          children: [
            Image.asset(AppImage.welcome, fit: BoxFit.cover),
            const DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Colors.transparent, Color(0xE6000000)],
                ),
              ),
            ),
            SafeArea(
              child: LayoutBuilder(builder: (context, constraints) {
                return SingleChildScrollView(
                  child: ConstrainedBox(
                    constraints: BoxConstraints(minHeight: constraints.maxHeight),
                    child: Padding(
                      padding: const EdgeInsets.all(24),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          SvgPicture.asset(AppImage.carrot, height: 56,
                            colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn)),
                          const SizedBox(height: 24),
                          const Text('Welcome to GreenMart', textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 32, color: Colors.white, fontWeight: FontWeight.w600)),
                          const SizedBox(height: 12),
                          const Text('Fresh picks for your everyday basket.', textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 16, color: Colors.white)),
                          const SizedBox(height: 28),
                          SizedBox(width: double.infinity, child: FilledButton(
                            style: FilledButton.styleFrom(backgroundColor: AppColors.primaryColor),
                            onPressed: () => Navigator.push(context,
                              MaterialPageRoute<void>(builder: (_) => const LoginScreen())),
                            child: const Text('Get started'),
                          )),
                        ],
                      ),
                    ),
                  ),
                );
              }),
            ),
          ],
        ),
      );
}
