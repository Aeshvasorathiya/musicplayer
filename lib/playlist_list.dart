import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:musicplayer/controller.dart';
import 'package:on_audio_room/details/rooms/favorites/favorites_entity.dart';
import 'package:on_audio_room/on_audio_room.dart';

import 'fav_fullscreen.dart';

class playlist_list extends StatefulWidget {
  // const playlist_list({super.key});
  // playlist_list list;
  // playlist_list(this.list);

  @override
  State<playlist_list> createState() => _playlist_listState();
}

class _playlist_listState extends State<playlist_list> {
  @override
  Widget build(BuildContext context) {
    controller c=Get.put(controller());
    return Scaffold(
      body: FutureBuilder(future: c.get_fav(),builder: (context, snapshot) {

        if(snapshot.connectionState==ConnectionState.done){
          List<FavoritesEntity>list=snapshot.data as List<FavoritesEntity>;
          return ListTile(onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return fav_fullscreen();
            },));
          },
            title: Text("Song"),
            subtitle: Text("${list.length}"),

          );
        }
        else
        {
          return CircularProgressIndicator();
        }
      },),
    );
  }
}
