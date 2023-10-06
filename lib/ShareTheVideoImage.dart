import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_share_me/flutter_share_me.dart';
import 'package:image_picker/image_picker.dart';

enum Share {
  facebook,
  twitter,
  whatsapp,
  whatsapp_business,
  share_system,
}

// enum Share {
//   facebook,
//   messenger,
//   twitter,
//   whatsapp,
//   whatsapp_personal,
//   whatsapp_business,
//   share_system,
//   share_instagram,
//   share_telegram
// }

class ShareTheVideoImage extends StatefulWidget {
  const ShareTheVideoImage({super.key});

  @override
  State<ShareTheVideoImage> createState() => _ShareTheVideoImageState();
}

class _ShareTheVideoImageState extends State<ShareTheVideoImage> {

  File? file;
  ImagePicker picker = ImagePicker();
  bool videoEnable = false;

  List<Data> dataList = [
    Data(name: "Facebook",imageURL: 'assets/images/facebook_share.png'),
    Data(name: "Whatsapp",imageURL: 'assets/images/whatsapp_share.png'),
    Data(name: "Whatsapp Business",imageURL: 'assets/images/whatsappbusiness_share.png'),
    Data(name: "Twitter",imageURL: 'assets/images/twitter_share.png'),
    Data(name: "More",imageURL: 'assets/images/more_share.png'),
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Container(
          width: double.infinity,
          child: Column(
            children: <Widget>[
              const SizedBox(height: 30),
              ElevatedButton(onPressed: pickImage, child: Text('Pick Image')),
              ElevatedButton(onPressed: pickVideo, child: Text('Pick Video')),
              ElevatedButton(
                  onPressed: () => onButtonTap(Share.twitter),
                  child: const Text('share to twitter')),
              ElevatedButton(
                onPressed: () => onButtonTap(Share.whatsapp),
                child: const Text('share to WhatsApp'),
              ),
              ElevatedButton(
                onPressed: () => onButtonTap(Share.whatsapp_business),
                child: const Text('share to WhatsApp Business'),
              ),
              // ElevatedButton(
              //   onPressed: () => onButtonTap(Share.whatsapp_personal),
              //   child: const Text('share to WhatsApp Personal'),
              // ),
              ElevatedButton(
                onPressed: () => onButtonTap(Share.facebook),
                child: const Text('share to  FaceBook'),
              ),
              // ElevatedButton(
              //   onPressed: () => onButtonTap(Share.messenger),
              //   child: const Text('share to  Messenger'),
              // ),
              // ElevatedButton(
              //   onPressed: () => onButtonTap(Share.share_instagram),
              //   child: const Text('share to Instagram'),
              // ),
              // ElevatedButton(
              //   onPressed: () => onButtonTap(Share.share_telegram),
              //   child: const Text('share to Telegram'),
              // ),
              ElevatedButton(
                onPressed: () => onButtonTap(Share.share_system),
                child: const Text('share to System'),
              ),

              Container(
                height: 80,
                width: MediaQuery.of(context).size.width,
                margin: EdgeInsets.only(top: 20,left: 10,right: 10),
                decoration: BoxDecoration(
                  color: Color(0xFFffffff),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 5.0, // soften the shadow
                      spreadRadius: 5.0, //extend the shadow
                      offset: Offset(
                        1.0, // Move to right 5  horizontally
                        1.0, // Move to bottom 5 Vertically
                      ),
                    )
                  ],
                  borderRadius: BorderRadius.circular(10),
                ),
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: dataList.map((data){
                    return InkWell(
                      onTap: (){

                        if(data.name == "Facebook"){

                          onButtonTap(Share.facebook);

                        }else if(data.name == "Whatsapp"){

                          onButtonTap(Share.whatsapp);

                        }else if(data.name == "Whatsapp Business"){

                          onButtonTap(Share.whatsapp_business);

                        }else if(data.name == "Twitter"){

                          onButtonTap(Share.twitter);

                        }else if(data.name == "More"){

                          onButtonTap(Share.share_system);

                        }

                      },
                      child: Container(
                        margin: EdgeInsets.all(10),
                        decoration: BoxDecoration(border: Border(bottom: BorderSide(width: 1.5,color: Colors.white))),
                        child: Column(
                          children: [

                            Image.asset(data.imageURL,height: 40,width: 40,),
                            Text(data.name),
                          ],
                        ),
                      ),
                    );
                  }).toList(),

              )
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<void> pickImage() async {
    final XFile? xFile = await picker.pickImage(source: ImageSource.gallery);
    print(xFile);
    if (xFile != null) {
      file = File(xFile.path);
      setState(() {
        videoEnable = false;
      });
    }
  }

  Future<void> pickVideo() async {
    final XFile? xFile = await picker.pickVideo(source: ImageSource.gallery);
    print(xFile);
    if (xFile != null) {
      file = File(xFile.path);
      setState(() {
        videoEnable = true;
      });
    }
  }

  Future<void> onButtonTap(Share share) async {
    String msg =
        'Flutter share is great!!\n Check out full example at https://pub.dev/packages/flutter_share_me';
    String url = 'https://pub.dev/packages/flutter_share_me';

    String? response;
    final FlutterShareMe flutterShareMe = FlutterShareMe();
    switch (share) {
      case Share.facebook:
        response = await flutterShareMe.shareToFacebook(url: url, msg: msg);
        break;
      // case Share.messenger:
      //   response = await flutterShareMe.shareToMessenger(url: url, msg: msg);
      //   break;
      case Share.twitter:
        response = await flutterShareMe.shareToTwitter(url: url, msg: msg);
        break;
      case Share.whatsapp:
        if (file != null) {
          response = await flutterShareMe.shareToWhatsApp(
              imagePath: file!.path,
              msg: msg);
        } else {
          response = await flutterShareMe.shareToWhatsApp(msg: msg);
        }
        break;
      case Share.whatsapp_business:
        response = await flutterShareMe.shareToWhatsApp(msg: msg);
        break;
      case Share.share_system:
        response = await flutterShareMe.shareToSystem(msg: msg);
        break;
      // case Share.whatsapp_personal:
      //   response = await flutterShareMe.shareWhatsAppPersonalMessage(
      //       message: msg, phoneNumber: 'phone-number-with-country-code');
      //   break;
      // case Share.share_instagram:
      //   response = await flutterShareMe.shareToInstagram(
      //       filePath: file!.path,
      //       fileType: videoEnable ? FileType.video : FileType.image);
      //   break;
      // case Share.share_telegram:
      //   response = await flutterShareMe.shareToTelegram(msg: msg);
      //   break;

    }
    debugPrint(response);
  }

}

class Data {

  String name;
  String imageURL;

  Data({required this.name,required this.imageURL});

}
