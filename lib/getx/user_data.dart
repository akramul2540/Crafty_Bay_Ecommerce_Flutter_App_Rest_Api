class UserDetails{
  final String firstName, lastName, mobile, shippingAddress, emial, city;
  final int id;

  UserDetails(this.firstName, this.lastName, this.mobile, this.shippingAddress, this.emial, this.city, this.id);


  factory UserDetails.fromJson(Map<String, dynamic>map){
   return UserDetails(
    map['fistName'],
    map['lastName'],
    map['mobile'],
    map['shippingAddress'],
    map['email'],
    map['city'],
    map['id']
   );
  }

  Map <String, dynamic> toJson(){
    Map <String, dynamic> map ={};
    map['fistName']= firstName;
    map['lastName']= lastName;
    map['mobile']= mobile;
    map['shippingAddress']= shippingAddress;
    map['email']= emial;
    map['city']= city;
    map['id']= id;
    return map;
  }
}