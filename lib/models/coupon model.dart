class Coupon {
  int? newOrderPrice;
  int? shippingDiscount;

  Coupon.fromJson(Map<String, dynamic> json) {
    newOrderPrice = json['newOrderPrice'];
    shippingDiscount = json['shippingDiscount'];
  }
}