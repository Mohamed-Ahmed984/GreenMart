enum ProductCategory { fruit, vegetables }

class ProductModel {
  const ProductModel({required this.id, required this.name,
    required this.priceCents, required this.quantity, required this.category,
    required this.image, this.imageAsset});
  final String id;
  final String name;
  final int priceCents;
  final String quantity;
  final ProductCategory category;
  final String image;
  final String? imageAsset;
  double get price => priceCents / 100;
}

String money(int cents) => '\$${(cents / 100).toStringAsFixed(2)}';

const allProducts = <ProductModel>[
  ProductModel(id: '1', name: 'Apple', priceCents: 1500, quantity: '1KG', category: ProductCategory.fruit, image: 'https://www.vhv.rs/dpng/d/425-4254380_apples-png-image-apple-fruit-transparent-background.png', imageAsset: 'Assets/products/1.png'),
  ProductModel(id: '2', name: 'Banana', priceCents: 2000, quantity: '2KG', category: ProductCategory.fruit, image: 'https://tse4.mm.bing.net/th/id/OIP.jkYeodcv6w7348t0g0coTAHaEo?rs=1&pid=ImgDetMain&o=7&rm=3', imageAsset: 'Assets/products/2.webp'),
  ProductModel(id: '3', name: 'Orange', priceCents: 1500, quantity: '2KG', category: ProductCategory.fruit, image: 'https://tse3.mm.bing.net/th/id/OIP.dYmc5vqaU7fkw_LhoGpjTwHaEJ?rs=1&pid=ImgDetMain&o=7&rm=3', imageAsset: 'Assets/products/3.webp'),
  ProductModel(id: '4', name: 'Pineapple', priceCents: 3000, quantity: '3KG', category: ProductCategory.fruit, image: 'https://tse2.mm.bing.net/th/id/OIP.wwj8nUBSEAUquuPfT_fF3QHaHa?rs=1&pid=ImgDetMain&o=7&rm=3', imageAsset: 'Assets/products/4.webp'),
  ProductModel(id: '5', name: 'Strawberry', priceCents: 1800, quantity: '1KG', category: ProductCategory.fruit, image: 'https://upload.wikimedia.org/wikipedia/commons/2/29/PerfectStrawberry.jpg', imageAsset: 'Assets/products/5.jpg'),
  ProductModel(id: '6', name: 'Mango', priceCents: 2200, quantity: '2KG', category: ProductCategory.fruit, image: 'https://upload.wikimedia.org/wikipedia/commons/9/90/Hapus_Mango.jpg', imageAsset: 'Assets/products/6.jpg'),
  ProductModel(id: '7', name: 'Blueberry', priceCents: 2800, quantity: '1KG', category: ProductCategory.fruit, image: 'https://upload.wikimedia.org/wikipedia/commons/0/0b/Blueberries.jpg'),
  ProductModel(id: '8', name: 'Grapes', priceCents: 1600, quantity: '2KG', category: ProductCategory.fruit, image: 'https://upload.wikimedia.org/wikipedia/commons/1/1b/Grapes_on_white.jpg'),
  ProductModel(id: '9', name: 'Watermelon', priceCents: 4000, quantity: '5KG', category: ProductCategory.fruit, image: 'https://upload.wikimedia.org/wikipedia/commons/f/fb/Watermelon_cross_BNC.jpg'),
  ProductModel(id: '10', name: 'Kiwi', priceCents: 2500, quantity: '1KG', category: ProductCategory.fruit, image: 'https://upload.wikimedia.org/wikipedia/commons/7/7b/Kiwi_%28Actinidia_chinensis%29_1_Luc_Viatour.jpg'),
  ProductModel(id: '11', name: 'Tomato', priceCents: 1200, quantity: '1KG', category: ProductCategory.vegetables, image: 'https://pngimg.com/uploads/tomato/tomato_PNG12581.png', imageAsset: 'Assets/products/11.png'),
  ProductModel(id: '12', name: 'Potato', priceCents: 1000, quantity: '2KG', category: ProductCategory.vegetables, image: 'https://pngimg.com/uploads/potato/potato_PNG7089.png'),
  ProductModel(id: '13', name: 'Carrot', priceCents: 1400, quantity: '1KG', category: ProductCategory.vegetables, image: 'https://pngimg.com/uploads/carrot/carrot_PNG4985.png'),
  ProductModel(id: '14', name: 'Cucumber', priceCents: 1100, quantity: '1KG', category: ProductCategory.vegetables, image: 'https://pngimg.com/uploads/cucumber/cucumber_PNG84305.png'),
  ProductModel(id: '15', name: 'Onion', priceCents: 900, quantity: '2KG', category: ProductCategory.vegetables, image: 'https://pngimg.com/uploads/onion/onion_PNG99213.png'),
  ProductModel(id: '16', name: 'Broccoli', priceCents: 2100, quantity: '1KG', category: ProductCategory.vegetables, image: 'https://pngimg.com/uploads/broccoli/broccoli_PNG72918.png', imageAsset: 'Assets/products/16.png'),
  ProductModel(id: '17', name: 'Pepper', priceCents: 1900, quantity: '1KG', category: ProductCategory.vegetables, image: 'https://pngimg.com/uploads/pepper/pepper_PNG3238.png'),
  ProductModel(id: '18', name: 'Eggplant', priceCents: 1700, quantity: '1KG', category: ProductCategory.vegetables, image: 'https://pngimg.com/uploads/eggplant/eggplant_PNG10411.png'),
 ];
final offers = List<ProductModel>.unmodifiable(allProducts.where((p) => p.category == ProductCategory.fruit));
final bestSelling = List<ProductModel>.unmodifiable(allProducts.where((p) => p.category == ProductCategory.vegetables));

List<ProductModel> getProductsByName(String searchKey,
    {ProductCategory? category, List<ProductModel> products = allProducts}) {
  final query = searchKey.trim().toLowerCase();
  return products.where((p) => (category == null || p.category == category) &&
      p.name.toLowerCase().contains(query)).toList(growable: false);
}
