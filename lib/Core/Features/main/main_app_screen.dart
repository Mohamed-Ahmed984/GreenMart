import 'package:flutter/material.dart';
import 'package:flutter_application_13/Core/Constant/app_image.dart';
import 'package:flutter_application_13/Core/Features/home/pages/home_screen.dart';
import 'package:flutter_application_13/Core/Style/app_colors.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_application_13/Core/Features/intro/welcome_screen.dart';

class MainAppScreen extends StatefulWidget {
  const MainAppScreen({super.key, this.email});
  final String? email;

  @override
  State<MainAppScreen> createState() => _MainAppScreenState();
}

class _MainAppScreenState extends State<MainAppScreen> {
  int currentindex = 0;

  List<Widget> screens = const [
    HomeScreen(),
    Center(child: Text('Explore')),
    Center(child: Text('Cart')),
    Center(child: Text('Favorites')),
    SizedBox.shrink(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: currentindex == 4 ? Scaffold(
        appBar: AppBar(title: const Text('Your account')),
        body: ListView(padding: const EdgeInsets.all(24), children: [
          const Icon(Icons.person_outline, size: 72),
          const SizedBox(height: 20),
          Text(widget.email ?? 'Guest shopper', textAlign: TextAlign.center),
          const SizedBox(height: 16),
          const Text('This is a local shopping demo. No real account, payment, or delivery service is connected.'),
          const SizedBox(height: 24),
          OutlinedButton(onPressed: () => Navigator.pushAndRemoveUntil(context,
            MaterialPageRoute<void>(builder: (_) => const WelcomeScreen()), (_) => false),
            child: const Text('Leave demo')),
        ]),
      ) : screens[currentindex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: currentindex,
        onTap: (index) {
          setState(() {
            currentindex = index;
          });
        },
        backgroundColor: AppColors.background,
        selectedItemColor: AppColors.primaryColor,

        selectedFontSize: 11,
        unselectedFontSize: 11,
        showUnselectedLabels: true,
        items: [
          BottomNavigationBarItem(
            icon: SvgPicture.asset(AppImage.storeSvg, width: 24, height: 24),
            label: 'Home',
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.search, size: 24),
            label: 'Explore',
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart_outlined, size: 24),
            label: 'Cart',
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.favorite_border, size: 24),
            label: 'Favorites',
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.person_outline, size: 24),
            label: 'Account',
          ),
        ],
      ),
    );
  }
}
