import 'package:untitled11/app/app.dart';
import 'package:untitled11/app/di.dart';
import 'package:flutter/material.dart';
import 'package:untitled11/app/user_info.dart';
import 'package:untitled11/data/network/firebase_factory.dart';
import 'package:untitled11/domain/usecase/get_user_usecase.dart';
import 'package:permission_handler/permission_handler.dart';
Future<void> requestStoragePermission() async {
  var status = await Permission.storage.status;
  if (!status.isGranted) {
    await Permission.storage.request();
  }
}
void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  await FirebaseService.initialize();
  await initAppModule();
  await requestStoragePermission();
  GetUserUsecase getUserUsecase=GetUserUsecase(instance());
  (await getUserUsecase.execute("userId1")).fold((failure) {
    return 0;
  }, (data) async {
      UserInfo.name=data.name;
      UserInfo.userId=data.id;
      UserInfo.image=data.image;
  });
  runApp( const MyApp());



}

