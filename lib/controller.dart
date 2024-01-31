import 'package:audioplayers/audioplayers.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:musicplayer/Artist_list.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:on_audio_room/details/rooms/favorites/favorites_entity.dart';
import 'package:on_audio_room/on_audio_room.dart';

class controller extends GetxController
{
    // RxList<SongModel>song_list=RxList();
  RxList<SongModel>song_list=RxList();
  RxList<ArtistModel>artist_list=RxList();
  RxList<AlbumModel>albums_list=RxList();
  RxList<SongModel>getalbum=RxList();
  RxList<FavoritesEntity>fav_list=RxList();

  static OnAudioQuery _audioQuery=OnAudioQuery();
  static AudioPlayer player=AudioPlayer();
  RxBool isplay=false.obs;
  RxDouble duration=0.0.obs;
  RxBool fav=false.obs;

  RxInt cur_ind=0.obs;

  get_song()
  async {
    song_list.value=await _audioQuery.querySongs();
    print(song_list);
    return song_list;

  }
  get_artist()
  async {
    artist_list.value=await _audioQuery.queryArtists();
    print(artist_list);
    return artist_list;
  }
  getallsong(int albumid)
  async {
    getalbum.value=await _audioQuery.queryAudiosFrom(AudiosFromType.ALBUM_ID, albumid);
    // print(artist_list);
    return getalbum;
  }
  get_albums()
  async {
    albums_list.value=await _audioQuery.queryAlbums();
    print(albums_list);
    return albums_list;
  }

  get_fav()
  async {
    fav_list.value=await OnAudioRoom().queryFavorites();
    return fav_list;
  }
  get_check()
  async {
    fav.value=await OnAudioRoom().checkIn(RoomType.FAVORITES,song_list.value[cur_ind.value].id);

  }
  get_duration()
  {
    player.onPositionChanged.listen((Duration d){
      duration.value=d.inMilliseconds.toDouble();

    });
  }
}