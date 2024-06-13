import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:streamskit_mobile/features/home/data/model/user_model.dart';
import 'package:streamskit_mobile/features/home/presentation/widgets/user_widget.dart';
import 'package:streamskit_mobile/features/stream/presentation/screens/join_stream_screen.dart';
import '../../data/datasources/remote_live_stream_source.dart';
import '../../data/model/live_stream_model.dart';

class ListHostsLive extends StatefulWidget {
  final UserModel? user;

  const ListHostsLive({Key? key, this.user}) : super(key: key);

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
        return SizedBox(
          height: 100,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: liveStreams.length,
            itemBuilder: (context, index) {
              LiveStreamModel liveStream = liveStreams[index];
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: UserWidget(liveStreamModel: liveStream, onClick: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => JoinStreamScreen(
                        user: widget.user,
                        streamId: liveStream.streamId,
                      ),
                    ),
                  );
                },),
              );
            },
          ),
        );
      },
    );
  }
}
