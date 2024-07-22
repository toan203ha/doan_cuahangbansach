import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'YouTube App Link Demo',
      home: YouTubeLinkScreen(),
    );
  }
}

class YouTubeLinkScreen extends StatelessWidget {
  final String videoId = 'PmUmHvK1L9M';
  final String appurl = 'vnd.youtube:PmUmHvK1L9M';
  final String weburl = 'https://www.youtube.com/watch?v=ol329Fch6i4';

  void _launchYouTubeApp() async {
    if (await canLaunch(appurl)) {
      await launch(appurl);
    } else if (await canLaunch(weburl)) {
      await launch(weburl);
    } else {
      throw 'Lỗi';
    }
  }

  @override
  Widget build(BuildContext context) {
    return  
       Center(
        child: TextButton(
          onPressed: () => _launchYouTubeApp( ),
          child: Text('Link YouTube'),
        ),
      );
     
  }
}
