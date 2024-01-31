import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:musicplayer/controller.dart';
import 'package:on_audio_room/details/rooms/favorites/favorites_entity.dart';
import 'package:on_audio_room/on_audio_room.dart';

class fav_fullscreen extends StatefulWidget {
  const fav_fullscreen({super.key});

  @override
  State<fav_fullscreen> createState() => _fav_fullscreenState();
}

class _fav_fullscreenState extends State<fav_fullscreen> {
  @override
  Widget build(BuildContext context) {
    controller c=Get.put(controller());
    return Scaffold(
      appBar: AppBar(),
      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SliderTheme(data: SliderTheme.of(context).copyWith(
            // activeTrackColor: Colors.red,
            // activeTickMarkColor: Colors.red,
            trackHeight: 2,
          ), child: Obx(() => Slider(min: 0,
            max: c.song_list.value.length>0?c.song_list.value[c.cur_ind.value].duration!.toDouble():0,
            activeColor: Colors.red,
            inactiveColor: Colors.black,
            value: c.duration.value, onChanged: (value) {
              // SliderThemeData.fromPrimaryColors(primaryColor: Colors.red, primaryColorDark: Colors.red,primaryColorLight: Colors.red,
              //   valueIndicatorTextStyle: TextStyle(color: Colors.red),);

            },))),
          InkWell(onTap: () {
            showModalBottomSheet(
              barrierColor: Colors.grey,
              isScrollControlled: true,
              context: context, builder: (context) {
              return Container(
                // height: Screen_height-Status_bar,
                color: Colors.grey.shade900,
                child: Column(
                  children: [
                    Container(
                      margin: EdgeInsets.all(20),
                      height: 300,
                      width: 300,
                      // color: Colors.grey.shade700,
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),color: Colors.grey.shade800),
                      child: IconButton(onPressed: () {

                      }, icon: Icon(Icons.music_note_sharp,size: 200,color: Colors.grey.shade900,)),
                    ),

                    // Slider(min: 0,value: 10,max: 20,activeColor: Colors.red,inactiveColor: Colors.grey.shade800, onChanged: (value) {
                    //   // b=value;
                    // },),

                    SliderTheme(data: SliderTheme.of(context).copyWith(
                      // activeTrackColor: Colors.red,
                      // activeTickMarkColor: Colors.red,
                      trackHeight: 2,
                    ), child: Obx(() => Slider(min: 0,
                      max: c.song_list.value.length>0?c.song_list.value[c.cur_ind.value].duration!.toDouble():0,
                      activeColor: Colors.red,
                      inactiveColor: Colors.black,


                      value: c.duration.value, onChanged: (value) {


                        // SliderThemeData.fromPrimaryColors(primaryColor: Colors.red, primaryColorDark: Colors.red,primaryColorLight: Colors.red,
                        //   valueIndicatorTextStyle: TextStyle(color: Colors.red),);

                      },))),
                    Center(child: Obx(() => Text("${c.song_list.value[c.cur_ind.value].title}",style: TextStyle(fontSize: 10,color: Colors.white),))),
                    Center(child: Text("Unknown artist",style: TextStyle(fontSize: 5,color: Colors.grey),)),
                    Center(child: Text(" ",style: TextStyle(fontSize: 20,color: Colors.grey),)),

                    SizedBox(height: 50,),
                    Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [

                        IconButton(onPressed: () {
                          if(c.cur_ind>0)
                          {
                            c.cur_ind--;
                            c.isplay.value=true;
                            controller.player.play(
                                DeviceFileSource(c.song_list.value[c.cur_ind.value].data));
                          }
                        }, icon:Icon(Icons.skip_previous_sharp,size: 50,color: Colors.red,)),
                        // Icon(Icons.play_circle,size: 70,color: Colors.red,),
                        Obx(() => c.isplay.value?IconButton(onPressed: () {


                          controller.player.pause();
                          c.isplay.value=!c.isplay.value;
                        }, icon:Icon(Icons.pause,size:50,color: Colors.red,)):IconButton(onPressed: () {
                          c.isplay.value=!c.isplay.value;
                          controller.player.play(
                              DeviceFileSource(c.song_list.value[c.cur_ind.value].data));
                        }, icon:Icon(Icons.play_circle,size:50,color: Colors.red,),)),
                        IconButton(onPressed: () {
                          if(c.cur_ind<c.song_list.length-1)
                          {
                            c.cur_ind++;
                            c.isplay.value=true;
                            controller.player.play(
                                DeviceFileSource(c.song_list.value[c.cur_ind.value].data));
                          }
                        }, icon:Icon(Icons.skip_next_sharp,size: 50,color: Colors.red,)),                        ],
                    ),
                    // Row(),
                    Container(child: Text(""),),
                    Container(child: Text(""),),


                    // Expanded(flex:1,child: Text("")),
                    SizedBox(height: 90,),

                    Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [

                        Icon(Icons.list,size: 25,color: Colors.white,),
                        Obx(() => c.fav.value?IconButton(onPressed: () async {
                          bool deleteFromResult = await OnAudioRoom().deleteFrom(
                            RoomType.FAVORITES,
                            c.song_list.value[c.cur_ind.value].id,
                            //playlistKey,
                          );
                          c.get_check();
                        }, icon: Icon(Icons.favorite),color: Colors.red,):

                        IconButton(onPressed: () async {
                          int? addToResult = await OnAudioRoom().addTo(
                            RoomType.FAVORITES,
                            c.song_list.value[c.cur_ind.value].getMap.toFavoritesEntity(),
                          );
                          c.get_check();

                        }, icon: Icon(Icons.favorite_border,color: Colors.red,))),
                        Icon(Icons.loop,size: 25,color: Colors.white,),
                        Icon(Icons.more_horiz,size: 25,color: Colors.white,),

                      ],
                    ),
                    Container(child: Text(""),),

                  ],
                ),
              );

            },);
          },
            child: ListTile(
              title: Obx(() => c.song_list.value.isNotEmpty?Text("${c.song_list.value[c.cur_ind.value].title}",style: TextStyle(color: Colors.black),):Text("data")),
              trailing: Obx(() => c.isplay.value?IconButton(onPressed: () {
                controller.player.pause();
                c.isplay.value=!c.isplay.value;
              }, icon:Icon(Icons.pause)):IconButton(onPressed: () {
                c.isplay.value=!c.isplay.value;
                controller.player.play(
                    DeviceFileSource(c.song_list.value[c.cur_ind.value].data));
              }, icon: Icon(Icons.play_arrow))),
            ),
          )
        ],
      ),
      body: FutureBuilder(future: c.get_fav(),builder:(context, snapshot) {
    if(snapshot.connectionState==ConnectionState.done) {
      List<FavoritesEntity>list = snapshot.data as List<FavoritesEntity>;
      return ListView.builder(itemCount: list.length,
        itemBuilder: (context, index) {
        return ListTile(
        // onTap: () {
        //   for(int i=0;i<c.song_list.value.length;i++)
        //   {
        //     if(c.song_list.value[i].id==l[index].id)
        //     {
        //       if(i==c.cur_ind.value)
        //       {
        //
        //       }
        //       else
        //       {
        //         c.cur_ind.value=i;
        //         controller.player.play(
        //             DeviceFileSource(c.song_list.value[c.cur_ind.value].data)
        //         );
        //       }
        //     }
        //   }
        // },
          title: Text("${list[index].title}"),
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
