import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:on_audio_query/on_audio_query.dart';

import 'controller.dart';

class song_list extends StatefulWidget {
  const song_list({super.key});

  @override
  State<song_list> createState() => _song_listState();
}

class _song_listState extends State<song_list> {

  @override
  Widget build(BuildContext context) {

    controller c=Get.put(controller());

    return Scaffold(
      backgroundColor: Colors.black,
      body: FutureBuilder(future: c.get_song(),builder: (context, snapshot) {


        if(snapshot.connectionState==ConnectionState.done){
          List<SongModel>l=snapshot.data as List<SongModel>;
          return ListView.builder(itemCount: l.length,

            itemBuilder: (context, index) {
            return ListTile(
              onTap: () {
                c.get_check();
                c.get_duration();
                c.isplay.value=true;
                if(c.cur_ind.value==index)
                  {

                  }
                else{
                  c.cur_ind.value=index;
                  controller.player.play(
                      DeviceFileSource(c.song_list.value[c.cur_ind.value].data),);

                }
              },
              title: Text("${l[index].title}",style: TextStyle(color: Colors.white),selectionColor: Colors.red),
              subtitle: Text("${l[index].artist}",style: TextStyle(color: Colors.white),),
              trailing: Wrap(
                children: [
                  Obx(() => c.cur_ind==index && c.isplay.value?Image.network("https://i.pinimg.com/originals/cb/17/b8/cb17b80a942d7c317a35ff1324fae12f.gif",height: 40,width: 40,):Text("")),
                ],
              ),
            );
          },);
        }
        else
          {
            return CircularProgressIndicator();
          }
      },
      ),
    );
  }
}
