// Dart imports:
import 'dart:ui';

// Flutter imports:
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

// Package imports:
import 'package:phosphor_flutter/phosphor_flutter.dart';

// Project imports:
import 'package:streamskit_mobile/core/app/colors/app_color.dart';
import 'package:streamskit_mobile/core/util/SharedPreferencesUtil.dart';
import 'package:streamskit_mobile/core/util/common/touchable_opacity.dart';
import 'package:streamskit_mobile/core/util/sizer_custom/sizer.dart';
import 'package:streamskit_mobile/features/chat/presentation/screens/chat_screen.dart';
import 'package:streamskit_mobile/features/home/data/model/user_model.dart';
import 'package:streamskit_mobile/features/home/presentation/screens/home_screen.dart';
import 'package:streamskit_mobile/features/profile/presentation/screens/profile_screen.dart';
import 'package:streamskit_mobile/features/search/presentation/screens/search_screen.dart';
import 'package:streamskit_mobile/features/stream/presentation/screens/stream_screen.dart';

import '../core/util/firestore/firestore_user.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  UserModel? _user;

  final List<Widget> _tabs = [
    const HomeScreen(),
    const SearchScreen(),
    const StreamScreen(),
    const ChatScreen(),
    const ProfileScreen(),
  ];
  int _currentIndex = 0;

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    _loadUserId();
    super.initState();
  }

  Future<void> _loadUserId() async {
    String? userId = await SharedPreferencesUtil.getString('userId');
    debugPrint('User Id on Init : $userId');
    _loadUserData(userId);
  }

  Future<void> _loadUserData(String? userId) async {
    try {
      FirebaseFirestore firestore = FirebaseFirestore.instance;
      FireStoreUser fireStoreUser = FireStoreUserImpl(firestore);
      UserModel? _userData = await fireStoreUser.getUserById(userId!);
      if (_userData != null) {
        setState(() {
          _user = _userData;
        });
        debugPrint('User Data : $_user');
      }
    } catch (e) {
      debugPrint('Error while loading user : $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          _tabs[_currentIndex], // Ensure _tabs is defined
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              margin: EdgeInsets.only(bottom: 30.sp),
              child: ClipRRect(
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(100.sp),
                ),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 5, sigmaY: 10),
                  child: Container(
                    padding: EdgeInsets.all(8.sp),
                    margin: EdgeInsets.all(8.sp),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.black.withOpacity(0.3),
                    ),
                    child: SizedBox(
                      height: 30.sp,
                      width: 30.sp,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: ClipRRect(
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(20.sp),
              ),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 5, sigmaY: 10),
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 16.sp),
                  height: 70.sp,
                  color: Colors.black.withOpacity(0.3),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _buildItemBottomBar(
                        inActiveIcon: PhosphorIcons.houseLight,
                        activeIcon: PhosphorIcons.houseFill,
                        index: 0,
                      ),
                      _buildItemBottomBar(
                        inActiveIcon: PhosphorIcons.magnifyingGlassLight,
                        activeIcon: PhosphorIcons.magnifyingGlassBold,
                        index: 1,
                      ),
                      if (_user != null && _user!.isHost)
                        const Expanded(child: SizedBox()),
                      _buildItemBottomBar(
                        inActiveIcon: PhosphorIcons.chatTeardropDotsLight,
                        activeIcon: PhosphorIcons.chatTeardropDotsFill,
                        index: 3,
                      ),
                      _buildItemBottomBar(
                        inActiveIcon: PhosphorIcons.userCircleLight,
                        activeIcon: PhosphorIcons.userCircleFill,
                        index: 4,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          if (_user != null && _user!.isHost)
            Align(
              alignment: Alignment.bottomCenter,
              child: TouchableOpacity(
                onTap: () {},
                child: Container(
                  padding: EdgeInsets.all(13.sp),
                  margin: EdgeInsets.only(bottom: 38.sp),
                  decoration: BoxDecoration(
                    color: colorPink,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    PhosphorIcons.plusBold,
                    size: 20.sp,
                    color: mCL,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildItemBottomBar({
    required IconData inActiveIcon,
    required IconData activeIcon,
    required int index,
  }) {
    return Expanded(
      child: TouchableOpacity(
        onTap: () {
          setState(() {
            _currentIndex = index;
          });
        },
        child: Container(
          color: Colors.transparent,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(15.sp),
                ),
                child: Icon(
                  index == _currentIndex ? activeIcon : inActiveIcon,
                  size: 21.sp,
                  color: index == _currentIndex ? mCL : fCL,
                ),
              ),
              SizedBox(height: 4.sp),
              Container(
                height: 3.sp,
                width: 3.sp,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: index == _currentIndex ? mCH : Colors.transparent,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
