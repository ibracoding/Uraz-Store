class Product {
  final int id;
  final String imagePath;
  final String name;
  final double price;
  final String description;
  int quantity; // değer özelliği

  Product({
    required this.id,
    required this.imagePath,
    required this.name,
    required this.price,
    required this.description,
    this.quantity = 1, // Varsayılan değeri 1 kabul ediyorum
  });
}
