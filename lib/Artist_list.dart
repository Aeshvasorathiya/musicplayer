import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:musicplayer/song_list.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:on_audio_room/on_audio_room.dart';

import 'controller.dart';

class artist_list extends StatefulWidget {
  const artist_list({super.key});

  @override
  State<artist_list> createState() => _artist_listState();
}

class _artist_listState extends State<artist_list> {
  @override
  Widget build(BuildContext context) {
    controller c=Get.put(controller());

    return Scaffold(

      backgroundColor: Colors.black,


      // body: FutureBuilder(future: c.get_artist(),builder: (context, snapshot) {
      //
      //   if(snapshot.connectionState==ConnectionState.done){
      //     List<ArtistModel>l=snapshot.data as List<ArtistModel>;
      //     return  ListView.builder(
      //   itemCount: l.length,
      //   itemBuilder: (context, index) {
      //     InkWell(onTap: () {
      //       ListView.builder(itemCount: l.length,
      //         itemBuilder: (context, index) {
      //         return ListTile(
      //           title: Obx(() =>
      //               Text("${c.song_list.value[c.artist_list.value[index].artist.length].data}"),
      //               ),
      //         );
      //
      //       },);
      //
      //     },
      //       child:  ListTile(
      //       title: Text("${l[index].artist}",style: TextStyle(color: Colors.white),),
      //       subtitle: Text("${l[index].numberOfAlbums}",style: TextStyle(color: Colors.white)),
      //       ),
      //
      //     );
      //
      //   },);
      //
      //   }
      //   else
      //     {
      //       return CircularProgressIndicator();
      //     }
      // },),
      body: FutureBuilder(future: c.get_artist(),builder: (context, snapshot) {

        if(snapshot.connectionState==ConnectionState.done){
          List<ArtistModel>l=snapshot.data as List<ArtistModel>;
          return ListView.builder(
            itemCount: l.length,
            itemBuilder: (context, index) {
              return InkWell(onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return song_list();

                },));
              },
                child: ListTile(
                  title: Text("${l[index].artist}",style: TextStyle(color: Colors.white),),
                  trailing: Text("${l[index].numberOfAlbums}",style: TextStyle(color: Colors.white)),
                ),
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
