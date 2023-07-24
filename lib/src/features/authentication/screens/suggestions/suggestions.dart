import 'package:auth/src/features/authentication/screens/suggestions/services/api_services.dart';
import 'package:auth/src/features/authentication/screens/suggestions/video_screen.dart';
import 'package:flutter/material.dart';
import 'package:scaffold_gradient_background/scaffold_gradient_background.dart';

import '../../models/channel_model.dart';
import '../../models/video_model.dart';


class SuggHomeScreen extends StatefulWidget {
  @override
  _SuggHomeScreenState createState() => _SuggHomeScreenState();
}

class _SuggHomeScreenState extends State<SuggHomeScreen> {
  late Channel _channel;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _initChannel();
  }

  _initChannel() async {
    Channel channel = await APIService.instance
        .fetchChannel(channelId: 'UCN4vyryy6O4GlIXcXTIuZQQ');
    setState(() {
      _channel = channel;
    });
  }

  _buildProfileInfo() {
    return
      Container(
      margin: EdgeInsets.all(20.0),
      padding: EdgeInsets.all(20.0),
      height: 100.0,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            offset: Offset(0, 1),
            blurRadius: 6.0,
          ),
        ],
      ),
      child: Row(
        // children: <Widget>[
        //   CircleAvatar(
        //     backgroundColor: Colors.white,
        //     radius: 35.0,
        //     backgroundImage: NetworkImage(_channel.profilePictureUrl),
        //   ),
        //   SizedBox(width: 12.0),
        //   // Expanded(
        //   //   child: Column(
        //   //     mainAxisAlignment: MainAxisAlignment.center,
        //   //     crossAxisAlignment: CrossAxisAlignment.start,
        //   //     children: <Widget>[
        //   //       Text(
        //   //         _channel.title,
        //   //         style: TextStyle(
        //   //           color: Colors.black,
        //   //           fontSize: 20.0,
        //   //           fontWeight: FontWeight.w600,
        //   //         ),
        //   //         overflow: TextOverflow.ellipsis,
        //   //       ),
        //   //       Text(
        //   //         '${_channel.subscriberCount} subscribers',
        //   //         style: TextStyle(
        //   //           color: Colors.grey[600],
        //   //           fontSize: 16.0,
        //   //           fontWeight: FontWeight.w600,
        //   //         ),
        //   //         overflow: TextOverflow.ellipsis,
        //   //       ),
        //   //     ],
        //   //   ),
        //   // )
        // ],
      ),
    );
  }

  _buildVideo(Video video) {
    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => VideoScreen(id: video.id),
        ),
      ),
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 20.0, vertical: 5.0),
        padding: EdgeInsets.all(10.0),
        height: 140.0,
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              offset: Offset(0, 1),
              blurRadius: 6.0,
            ),
          ],
        ),
        child: Row(
          children: <Widget>[
            Image(
              width: 150.0,
              image: NetworkImage(video.thumbnailUrl),
            ),
            SizedBox(width: 10.0),
            Expanded(
              child: Text(
                video.title,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 18.0,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _loadMoreVideos() async {
    _isLoading = true;
    List moreVideos = await APIService.instance
        .fetchVideosFromPlaylist(playlistId: _channel.uploadPlaylistId);
    List<Video> allVideos = _channel.videos..addAll(moreVideos as Iterable<Video>);
    setState(() {
      _channel.videos = allVideos;
    });
    _isLoading = false;
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldGradientBackground(
      gradient: LinearGradient(colors: [
        Color(0xFF8EC5FC),
        Color(0xFFE0C3FC),
      ]),
      appBar: AppBar(
        title: Text('Mindful Recommendations'),
      ),
      body: _channel != null
          ? NotificationListener<ScrollNotification>(
        onNotification: (ScrollNotification scrollDetails) {
          if (!_isLoading &&
              _channel.videos.length != int.parse(_channel.videoCount) &&
              scrollDetails.metrics.pixels ==
                  scrollDetails.metrics.maxScrollExtent) {
            _loadMoreVideos();
          }
          return false;
        },
        child: ListView.builder(
          itemCount: 1 + _channel.videos.length,
          itemBuilder: (BuildContext context, int index) {
            if (index == 0) {
              return _buildProfileInfo();
            }
            Video video = _channel.videos[index - 1];
            return _buildVideo(video);
          },
        ),
      )
          : Center(
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(
            Theme.of(context).primaryColor, // Red
          ),
        ),
      ),
    );
  }
}
