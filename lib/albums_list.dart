import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:musicplayer/albumpage.dart';
import 'package:on_audio_query/on_audio_query.dart';

import 'controller.dart';

class albums_list extends StatefulWidget {
  const albums_list({super.key});

  @override
  State<albums_list> createState() => _albums_listState();
}

class _albums_listState extends State<albums_list> {
  @override
  Widget build(BuildContext context) {
    controller c=Get.put(controller());

    return Scaffold(
      backgroundColor: Colors.black,
      body: FutureBuilder(future: c.get_albums(),builder: (context, snapshot) {

        if(snapshot.connectionState==ConnectionState.done){
          List<AlbumModel>l=snapshot.data as List<AlbumModel>;
          return ListView.builder(
            itemCount: l.length,
            itemBuilder: (context, index) {
              return ListTile(onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return albumpage(l[index]);
                },));
              },
                title: Text("${l[index].artist}",style: TextStyle(color: Colors.white),),
                // trailing: Text("${l[index].numberOfAlbums}",style: TextStyle(color: Colors.white)),
              );
            },);
        }
        else
        {
          return CircularProgressIndicator();
        }
      },),
    );
  }
}
