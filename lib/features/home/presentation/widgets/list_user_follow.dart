import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../data/datasources/remote_live_stream_source.dart';
import '../../data/model/live_stream_model.dart';
import 'live_stream_card.dart';  // Adjust the import path

class ListHostsLive extends StatefulWidget {
  @override
  _ListHostsLiveState createState() => _ListHostsLiveState();
}

class _ListHostsLiveState extends State<ListHostsLive> {
  final FireStoreLiveStream _fireStoreLiveStream = FireStoreLiveStream();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<LiveStreamModel>>(
      stream: _fireStoreLiveStream.getLiveStreams(),
      builder: (BuildContext context, AsyncSnapshot<List<LiveStreamModel>> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }
        if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Center(child: Text('No hosts are currently live.'));
        }

        var liveStreams = snapshot.data!.where((stream) => !stream.isLiveStreamEnded).toList();
        return ListView.builder(
          itemCount: liveStreams.length,
          itemBuilder: (context, index) {
            var liveStream = liveStreams[index];
            return LiveStreamCard(liveStream: liveStream);  // Adjust according to your LiveStreamCard implementation
          },
        );
      },
    );
  }
}
