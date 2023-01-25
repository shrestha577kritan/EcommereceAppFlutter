




class Product{

final String product_name;
final String product_detail;
final int price;
final String image;
final String public_id;
final String id;

Product({
  required this.image,
  required this.price,
  required this.product_detail,
  required this.product_name,
  required this.public_id,
  required this.id
});

factory Product.fromJson(Map<String, dynamic> json){
  return Product(
      image: json['image'],
      price: json['price'],
      product_detail: json['product_detail'],
      product_name: json['product_name'],
      public_id: json['public_id'],
    id: json['_id']
  );
}

}