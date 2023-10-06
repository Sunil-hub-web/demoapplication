
class User1 {
  int userId;
  String name;
  String email;
  String phone;
  String type;
  String token;
  String renewalToken;

  User1({required this.userId, required this.name, required this.email, required this.phone, required this.type, required this.token,
    required this.renewalToken});

  // now create converter

 factory User1.fromJson(Map<String,dynamic> responseData){
   return User1(
     userId: responseData['id'],
     name: responseData['Username'],
     email : responseData['Email'],
     phone: responseData['phone'],
     type : responseData['type'],
     token: responseData['token'],
     renewalToken : responseData['token'],
   );
 }
}