class Property {
  final String id;
  final String name;
  final String price;
  final String location;
  final String imageUrl;
  final String description;
  final int bedrooms;
  final int bathrooms;
  final String area;
  final String type;
  bool isFavorite;

  Property({
    required this.id,
    required this.name,
    required this.price,
    required this.location,
    required this.imageUrl,
    required this.description,
    required this.bedrooms,
    required this.bathrooms,
    required this.area,
    required this.type,
    this.isFavorite = false,
  });

  // Convert to Map for local storage
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'price': price,
      'location': location,
      'imageUrl': imageUrl,
      'description': description,
      'bedrooms': bedrooms,
      'bathrooms': bathrooms,
      'area': area,
      'type': type,
      'isFavorite': isFavorite,
    };
  }

  // Create from Map
  factory Property.fromMap(Map<String, dynamic> map) {
    return Property(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
      price: map['price'] ?? '',
      location: map['location'] ?? '',
      imageUrl: map['imageUrl'] ?? '',
      description: map['description'] ?? '',
      bedrooms: map['bedrooms'] ?? 0,
      bathrooms: map['bathrooms'] ?? 0,
      area: map['area'] ?? '',
      type: map['type'] ?? '',
      isFavorite: map['isFavorite'] ?? false,
    );
  }

  // Sample properties for demo
  static List<Property> sampleProperties = [
    Property(
      id: '1',
      name: 'Modern Villa in Jakarta',
      price: 'Rp 5.500.000.000',
      location: 'South Jakarta, Jakarta',
      imageUrl: 'https://images.unsplash.com/photo-1580587771525-78b9dba3b914?w=800',
      description:
          'Luxurious modern villa with stunning architecture and premium facilities. Located in prime area of South Jakarta with easy access to shopping malls and business districts.',
      bedrooms: 4,
      bathrooms: 3,
      area: '350 m²',
      type: 'Villa',
    ),
    Property(
      id: '2',
      name: 'Cozy Apartment Bali',
      price: 'Rp 2.800.000.000',
      location: 'Seminyak, Bali',
      imageUrl: 'https://images.unsplash.com/photo-1545324418-cc1a3fa10c00?w=800',
      description:
          'Beautiful beachfront apartment with ocean views. Perfect for holiday home or investment property with high rental yield.',
      bedrooms: 2,
      bathrooms: 2,
      area: '120 m²',
      type: 'Apartment',
    ),
    Property(
      id: '3',
      name: 'Family House Surabaya',
      price: 'Rp 1.200.000.000',
      location: 'West Surabaya, Surabaya',
      imageUrl: 'https://images.unsplash.com/photo-1568605114967-8130f3a36994?w=800',
      description:
          'Spacious family house in quiet residential area. Close to schools, hospitals and shopping centers. Perfect for growing families.',
      bedrooms: 3,
      bathrooms: 2,
      area: '200 m²',
      type: 'House',
    ),
    Property(
      id: '4',
      name: 'Penthouse Bandung',
      price: 'Rp 4.500.000.000',
      location: 'Dago, Bandung',
      imageUrl: 'https://images.unsplash.com/photo-1512917774080-9991f1c4c750?w=800',
      description:
          'Exclusive penthouse with panoramic city and mountain views. Premium finishes and facilities including private pool and gym.',
      bedrooms: 3,
      bathrooms: 3,
      area: '280 m²',
      type: 'Penthouse',
    ),
    Property(
      id: '5',
      name: 'Minimalist Studio Yogyakarta',
      price: 'Rp 450.000.000',
      location: 'Sleman, Yogyakarta',
      imageUrl: 'https://images.unsplash.com/photo-1502672260266-1c1ef2d93688?w=800',
      description:
          'Affordable minimalist studio apartment near university area. Great for students or young professionals. Low maintenance cost.',
      bedrooms: 1,
      bathrooms: 1,
      area: '35 m²',
      type: 'Studio',
    ),
  ];
}
