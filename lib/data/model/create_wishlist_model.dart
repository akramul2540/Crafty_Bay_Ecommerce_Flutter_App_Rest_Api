class CreateWishLIstModel {
  String? msg;
  CreateWishListData? data;

  CreateWishLIstModel({this.msg, this.data});

  CreateWishLIstModel.fromJson(Map<String, dynamic> json) {
    msg = json['msg'];
    data = json['data'] != null ? new CreateWishListData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['msg'] = msg;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class CreateWishListData {
  int? id;
  String? email;
  String? productId;
  String? createdAt;
  String? updatedAt;

  CreateWishListData({this.id, this.email, this.productId, this.createdAt, this.updatedAt});

  CreateWishListData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    email = json['email'];
    productId = json['product_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['email'] = email;
    data['product_id'] = productId;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
