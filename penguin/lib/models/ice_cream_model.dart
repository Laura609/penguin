class IceCream {
  final String id;
  final String name;
  final int price;
  final String imageUrl;

  IceCream({
    required this.id,
    required this.name,
    required this.price,
    required this.imageUrl,
  });

  factory IceCream.fromMap(Map<String, dynamic> map, String id) {
    return IceCream(
      id: id,
      name: map['name'],
      price: (map['price'] as num?)?.toInt() ?? 0,
      imageUrl: map['image_url']?.toString() ?? 'assets/penguin.png',
    );
  }
}