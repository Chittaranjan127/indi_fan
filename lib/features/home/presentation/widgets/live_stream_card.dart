import 'package:flutter/material.dart';

import '../../data/model/live_stream_model.dart';  // Adjust the import path

class LiveStreamCard extends StatelessWidget {
  final LiveStreamModel liveStream;

  LiveStreamCard({required this.liveStream});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: CircleAvatar(
          backgroundImage: NetworkImage(liveStream.hostImageUrl),
        ),
        title: Text(liveStream.hostName),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Started at: ${liveStream.startTime}'),
            Text('Views: ${liveStream.views}'),
            Text('Audience: ${liveStream.audienceCount}'),
            Text('Watch Hours: ${liveStream.watchHours}'),
            Text('Revenue: \$${liveStream.totalRevenue}'),
          ],
        ),
      ),
    );
  }
}
