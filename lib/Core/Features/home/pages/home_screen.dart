import 'package:flutter/material.dart';
import 'package:flutter_application_13/Core/Features/home/data/product_model.dart';
import 'package:flutter_application_13/Core/Features/home/search/search_screen.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_application_13/Core/Constant/app_image.dart';
import 'package:flutter_application_13/Core/Style/app_colors.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: CustomImageSvg(
          path: AppImage.logo,
          color: AppColors.primaryColor,
          height: 28,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              const SizedBox(height: 20),

              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const SearchScreen(),
                    ),
                  );
                },
                child: Hero(
                  tag: 'search',
                  child: Material(
                    color: Colors.transparent,
                    child: CustomTextFormField(
                      prefixIcon: const Icon(Icons.search),
                      hintText: 'Search for products',
                      enabled: false,
                      onChanged: (String value) {},
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 20),

              Row(
                children: [
                  const Expanded(child: Text(
                    "Exclusive Offers",
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
                  )),
                  const SizedBox(width: 8),
                  Text(
                    "see all",
                    style: TextStyle(color: AppColors.primaryColor),
                  ),
                ],
              ),

              const SizedBox(height: 16),

              SizedBox(
                height: 230,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: offers.length,
                  separatorBuilder: (context, index) =>
                      const SizedBox(width: 14),
                  itemBuilder: (context, index) {
                    return _productCard(offers[index]);
                  },
                ),
              ),

              const SizedBox(height: 20),

              Row(
                children: [
                  const Expanded(child: Text(
                    "Best Selling",
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
                  )),
                  const SizedBox(width: 8),
                  Text(
                    "see all",
                    style: TextStyle(color: AppColors.primaryColor),
                  ),
                ],
              ),

              const SizedBox(height: 16),

              SizedBox(
                height: 230,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: bestSelling.length,
                  separatorBuilder: (context, index) =>
                      const SizedBox(width: 14),
                  itemBuilder: (context, index) {
                    return _productCard(bestSelling[index]);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  static Widget _productCard(ProductModel product) {
    return Container(
      width: 160,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: Colors.grey.shade300, width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 90,
            width: double.infinity,
            child: Image.network(product.image, fit: BoxFit.contain, errorBuilder: (_, error, stack) => const Icon(Icons.image_not_supported_outlined, size: 48)),
          ),
          const SizedBox(height: 10),
          Text(
            product.name,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 4),
          Text(
            product.quantity,
            style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
          ),
          const Spacer(),
          Row(
            children: [
              Text(
                '\$${product.price.toStringAsFixed(1)}',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const Spacer(),
              FloatingActionButton.small(
                heroTag: 'add-${product.id}',
                elevation: 0,
                backgroundColor: AppColors.primaryColor,
                foregroundColor: AppColors.background,
                onPressed: () {},
                child: const Icon(Icons.add),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class CustomImageSvg extends StatelessWidget {
  final String path;
  final Color? color;
  final double? height;
  final double? width;

  const CustomImageSvg({
    super.key,
    required this.path,
    this.color,
    this.height,
    this.width,
  });

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      path,
      height: height,
      width: width,
      colorFilter: color != null
          ? ColorFilter.mode(color!, BlendMode.srcIn)
          : null,
    );
  }
}

class CustomTextFormField extends StatelessWidget {
  final TextEditingController? controller;
  final String? hintText;
  final Widget? prefixIcon;
  final bool enabled;
  final ValueChanged<String> onChanged;

  const CustomTextFormField({
    super.key,
    this.controller,
    this.hintText,
    this.prefixIcon,
    this.enabled = true,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      enabled: enabled,
      onChanged: onChanged,
      controller: controller,
      decoration: InputDecoration(
        hintText: hintText,
        prefixIcon: prefixIcon,
        filled: true,
        fillColor: const Color(0xffF2F3F2),
        contentPadding: const EdgeInsets.symmetric(vertical: 14),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}
