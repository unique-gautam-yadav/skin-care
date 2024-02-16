class ItemsData {
  static final ItemsData _itemsData = ItemsData._internal();

  factory ItemsData() {
    return _itemsData;
  }

  ItemsData._internal();

  List<ItemModel> savedItems = [];

  static List<ItemModel> data = [
    ItemModel(
      name: 'Cleanser',
      brand: 'The Face Shop',
      price: '339',
      image: 'assets/images/item2.png',
    ),
    ItemModel(
      name: 'Night Gel',
      brand: 'Plum',
      price: '176',
      image: 'assets/images/item3.png',
    ),
    ItemModel(
      name: 'Refreshing Facewash',
      brand: 'Simple',
      price: '250',
      image: 'assets/images/item4.png',
    ),
    ItemModel(
      name: 'Face Wash',
      brand: 'Cetaphil',
      price: '333',
      image: 'assets/images/item1.png',
    ),
    ItemModel(
      name: 'Face Serum',
      brand: 'Pilgrim Korean',
      price: '180',
      image: 'assets/images/item5.png',
    ),
    ItemModel(
      name: 'Night Cream',
      brand: 'WOW Skin',
      price: '99',
      image: 'assets/images/item6.png',
    ),
    ItemModel(
      name: 'Moisturizer',
      brand: 'Foxtale',
      price: '55',
      image: 'assets/images/item7.png',
    ),
  ];
  //
}

class ItemModel {
  String name;
  String brand;
  String price;
  String image;
  ItemModel({
    required this.name,
    required this.brand,
    required this.price,
    required this.image,
  });
}
