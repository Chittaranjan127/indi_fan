import 'package:cloud_firestore/cloud_firestore.dart';
import '../model/live_stream_model.dart';

class FireStoreLiveStream {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Stream<List<LiveStreamModel>> getLiveStreams() {
    return _firestore
        .collection('liveStreams')
        .where('isLiveStreamEnded', isEqualTo: false)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) {
        return LiveStreamModel.fromMap(doc.data() as Map<String, dynamic>);
      }).toList();
    });
  }
}
