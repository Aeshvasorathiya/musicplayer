import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:on_audio_room/on_audio_room.dart';
import 'package:permission_handler/permission_handler.dart';

import 'first.dart';

void main()
{
  OnAudioRoom().initRoom();
  runApp(MaterialApp(
    home: main1(),
    debugShowCheckedModeBanner: false,

  ));
}
class main1 extends StatefulWidget {
  const main1({super.key});

  @override
  State<main1> createState() => _main1State();

}

class _main1State extends State<main1> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    permisstion();

    Future.delayed(Duration(seconds: 3)).then((value) {
      Navigator.push(context, MaterialPageRoute(builder: (context) {
         return first();
      },));
    });
  }
  permisstion()
  async {
    var status = await Permission.camera.status;
    if (status.isDenied) {
      Map<Permission, PermissionStatus> statuses = await [
        Permission.location,
        Permission.storage,
      ].request();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Music",style: TextStyle(color: Colors.white),),
        backgroundColor: Colors.black,
        centerTitle: true,
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        alignment: Alignment.center,
        color: Colors.black,
        child: Text("Music player",style: TextStyle(color: Colors.white,fontSize: 30),),
      ),
    );
  }
}



