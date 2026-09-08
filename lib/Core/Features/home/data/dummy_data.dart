
class ProductModel {
  final String id;
  final String image;
  final String name;
  final double price;
  final String quantity;

  ProductModel({
    required this.id,
    required this.image,
    required this.name,
    required this.price,
    required this.quantity,
  });
}

List<ProductModel> offers = [
  ProductModel(
    id: '1',
    image:
        'https://www.vhv.rs/dpng/d/425-4254380_apples-png-image-apple-fruit-transparent-background.png',
    name: 'Apple',
    price: 15.0,
    quantity: "1KG",
  ),
  ProductModel(
    id: '2',
    image:
        'https://tse4.mm.bing.net/th/id/OIP.jkYeodcv6w7348t0g0coTAHaEo?rs=1&pid=ImgDetMain&o=7&rm=3',
    name: 'Banana',
    price: 20.0,
    quantity: "2KG",
  ),
  ProductModel(
    id: '3',
    image:
        'https://tse3.mm.bing.net/th/id/OIP.dYmc5vqaU7fkw_LhoGpjTwHaEJ?rs=1&pid=ImgDetMain&o=7&rm=3',
    name: 'Orange',
    price: 15.0,
    quantity: "2KG",
  ),
  ProductModel(
    id: '4',
    image:
        'https://tse2.mm.bing.net/th/id/OIP.wwj8nUBSEAUquuPfT_fF3QHaHa?rs=1&pid=ImgDetMain&o=7&rm=3',
    name: 'Pineapple',
    price: 30.0,
    quantity: "3KG",
  ),
  ProductModel(
    id: '5',
    image:
        'https://upload.wikimedia.org/wikipedia/commons/2/29/PerfectStrawberry.jpg',
    name: 'Strawberry',
    price: 18.0,
    quantity: "1KG",
  ),
  ProductModel(
    id: '6',
    image:
        'https://upload.wikimedia.org/wikipedia/commons/9/90/Hapus_Mango.jpg',
    name: 'Mango',
    price: 22.0,
    quantity: "2KG",
  ),
  ProductModel(
    id: '7',
    image:
        'https://upload.wikimedia.org/wikipedia/commons/0/0b/Blueberries.jpg',
    name: 'Blueberry',
    price: 28.0,
    quantity: "1KG",
  ),
  ProductModel(
    id: '8',
    image:
        'https://upload.wikimedia.org/wikipedia/commons/1/1b/Grapes_on_white.jpg',
    name: 'Grapes',
    price: 16.0,
    quantity: "2KG",
  ),
  ProductModel(
    id: '9',
    image:
        'https://upload.wikimedia.org/wikipedia/commons/f/fb/Watermelon_cross_BNC.jpg',
    name: 'Watermelon',
    price: 40.0,
    quantity: "5KG",
  ),
  ProductModel(
    id: '10',
    image:
        'https://upload.wikimedia.org/wikipedia/commons/7/7b/Kiwi_%28Actinidia_chinensis%29_1_Luc_Viatour.jpg',
    name: 'Kiwi',
    price: 25.0,
    quantity: "1KG",
  ),
];

List<ProductModel> bestSelling = [
  ProductModel(
    id: '11',
    image: 'https://pngimg.com/uploads/tomato/tomato_PNG12581.png',
    name: 'Tomato',
    price: 12.0,
    quantity: "1KG",
  ),
  ProductModel(
    id: '12',
    image: 'https://pngimg.com/uploads/potato/potato_PNG7089.png',
    name: 'Potato',
    price: 10.0,
    quantity: "2KG",
  ),
  ProductModel(
    id: '13',
    image: 'https://pngimg.com/uploads/carrot/carrot_PNG4985.png',
    name: 'Carrot',
    price: 14.0,
    quantity: "1KG",
  ),
  ProductModel(
    id: '14',
    image: 'https://pngimg.com/uploads/cucumber/cucumber_PNG84305.png',
    name: 'Cucumber',
    price: 11.0,
    quantity: "1KG",
  ),
  ProductModel(
    id: '15',
    image: 'https://pngimg.com/uploads/onion/onion_PNG99213.png',
    name: 'Onion',
    price: 9.0,
    quantity: "2KG",
  ),
  ProductModel(
    id: '16',
    image: 'https://pngimg.com/uploads/broccoli/broccoli_PNG72918.png',
    name: 'Broccoli',
    price: 21.0,
    quantity: "1KG",
  ),
  ProductModel(
    id: '17',
    image: 'https://pngimg.com/uploads/pepper/pepper_PNG3238.png',
    name: 'Pepper',
    price: 19.0,
    quantity: "1KG",
  ),
  ProductModel(
    id: '18',
    image: 'https://pngimg.com/uploads/eggplant/eggplant_PNG10411.png',
    name: 'Eggplant',
    price: 17.0,
    quantity: "1KG",
  ),
];

/// combine all lists
List<ProductModel> allProducts = [...offers, ...bestSelling];

/// search function
List<ProductModel> getProductsByName(String searchKey) {
  return allProducts
      .where(
        (product) =>
            product.name.toLowerCase().contains(searchKey.toLowerCase()),
      )
      .toList();
}
