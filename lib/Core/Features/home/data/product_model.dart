
class ProductModel {
  final String id;
  final String image;
  final String name;
  final double price;
  final String quantity;
  final String categoryId;

  ProductModel({
    required this.id,
    required this.image,
    required this.name,
    required this.price,
    required this.quantity,
    required this.categoryId,
  });
}

List<ProductModel> offers = [
  ProductModel(
    id: '1',
    image:
        'https://www.vhv.rs/dpng/d/425-4254380_apples-png-image-apple-fruit-transparent-background.png',
    name: 'Apple',
    categoryId: '1',
    price: 15.0,
    quantity: "1KG",
  ),
  ProductModel(
    id: '2',
    image:
        'https://tse4.mm.bing.net/th/id/OIP.jkYeodcv6w7348t0g0coTAHaEo?rs=1&pid=ImgDetMain&o=7&rm=3',
    name: 'Banana',
    categoryId: '2',
    price: 20.0,
    quantity: "2KG",
  ),
  ProductModel(
    id: '3',
    image:
        'https://tse3.mm.bing.net/th/id/OIP.dYmc5vqaU7fkw_LhoGpjTwHaEJ?rs=1&pid=ImgDetMain&o=7&rm=3',
    name: 'Orange',
    categoryId: '3',
    price: 15.0,
    quantity: "2KG",
  ),
  ProductModel(
    id: '4',
    image:
        'https://tse2.mm.bing.net/th/id/OIP.wwj8nUBSEAUquuPfT_fF3QHaHa?rs=1&pid=ImgDetMain&o=7&rm=3',
    name: 'Pineapple',
    categoryId: '4',
    price: 30.0,
    quantity: "3KG",
  ),
  ProductModel(
    id: '5',
    image:
        'https://upload.wikimedia.org/wikipedia/commons/2/29/PerfectStrawberry.jpg',
    name: 'Strawberry',
    categoryId: '5',
    price: 18.0,
    quantity: "1KG",
  ),
  ProductModel(
    id: '6',
    image:
        'https://upload.wikimedia.org/wikipedia/commons/9/90/Hapus_Mango.jpg',
    name: 'Mango',
    categoryId: '6',
    price: 22.0,
    quantity: "2KG",
  ),
  ProductModel(
    id: '7',
    image:
        'https://upload.wikimedia.org/wikipedia/commons/0/0b/Blueberries.jpg',
    name: 'Blueberry',
    categoryId: '7',
    price: 28.0,
    quantity: "1KG",
  ),
  ProductModel(
    id: '8',
    image:
        'https://upload.wikimedia.org/wikipedia/commons/1/1b/Grapes_on_white.jpg',
    name: 'Grapes',
    categoryId: '8',
    price: 16.0,
    quantity: "2KG",
  ),
  ProductModel(
    id: '9',
    image:
        'https://upload.wikimedia.org/wikipedia/commons/f/fb/Watermelon_cross_BNC.jpg',
    name: 'Watermelon',
    categoryId: '9',
    price: 40.0,
    quantity: "5KG",
  ),
  ProductModel(
    id: '10',
    image:
        'https://upload.wikimedia.org/wikipedia/commons/7/7b/Kiwi_%28Actinidia_chinensis%29_1_Luc_Viatour.jpg',
    name: 'Kiwi',
    categoryId: '10',
    price: 25.0,
    quantity: "1KG",
  ),
];

List<ProductModel> bestSelling = [
  ProductModel(
    id: '11',
    image: 'https://pngimg.com/uploads/tomato/tomato_PNG12581.png',
    name: 'Tomato',
    categoryId: '11',
    price: 12.0,
    quantity: "1KG",
  ),
  ProductModel(
    id: '12',
    image: 'https://pngimg.com/uploads/potato/potato_PNG7089.png',
    name: 'Potato',
    categoryId: '12',
    price: 10.0,
    quantity: "2KG",
  ),
  ProductModel(
    id: '13',
    image: 'https://pngimg.com/uploads/carrot/carrot_PNG4985.png',
    name: 'Carrot',
    categoryId: '13',
    price: 14.0,
    quantity: "1KG",
  ),
  ProductModel(
    id: '14',
    image: 'https://pngimg.com/uploads/cucumber/cucumber_PNG84305.png',
    name: 'Cucumber',
    categoryId: '14',
    price: 11.0,
    quantity: "1KG",
  ),
  ProductModel(
    id: '15',
    image: 'https://pngimg.com/uploads/onion/onion_PNG99213.png',
    name: 'Onion',
    categoryId: '15',
    price: 9.0,
    quantity: "2KG",
  ),
  ProductModel(
    id: '16',
    image: 'https://pngimg.com/uploads/broccoli/broccoli_PNG72918.png',
    name: 'Broccoli',
    price: 21.0,
    categoryId: '16',
    quantity: "1KG",
  ),
  ProductModel(
    id: '17',
    image: 'https://pngimg.com/uploads/pepper/pepper_PNG3238.png',
    name: 'Pepper',
    price: 19.0,
    categoryId: '17',
    quantity: "1KG",
  ),
  ProductModel(
    id: '18',
    image: 'https://pngimg.com/uploads/eggplant/eggplant_PNG10411.png',
    name: 'Eggplant',
    price: 17.0,
    categoryId: '18',
    quantity: "1KG",
  ),
];
