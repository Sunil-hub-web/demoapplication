
import 'package:flutter/cupertino.dart';

import '../domain/user1.dart';

class UserProvider extends ChangeNotifier{

  User1 _user = User1(userId: 0, name: '', email: '', phone: '', type: '', token: '', renewalToken: '');

  User1 get user => _user;

  void setUser (User1 user){
    _user = user;
    notifyListeners();
  }
}