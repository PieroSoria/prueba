class AppConstants {
  static const String appName = 'HxMark Client';
  static const String baseUrl = 'https://dummyjson.com/';
  static const List<String> createTableSQL = [
    '''
  CREATE TABLE products(
    id INTEGER PRIMARY KEY,
    name TEXT,
    title TEXT,
    description TEXT,
    category TEXT,
    price REAL,
    discountPercentage REAL,
    rating REAL,
    stock INTEGER,
    brand TEXT,
    sku TEXT,
    weight INTEGER,
    warrantyInformation TEXT,
    shippingInformation TEXT,
    availabilityStatus TEXT,
    returnPolicy TEXT,
    minimumOrderQuantity INTEGER,
    thumbnail TEXT
  )
  ''',
  ];

  ///Urls of BaseApi
  static const String urlGetProducts = "products";

  ///
}
