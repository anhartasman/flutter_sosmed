import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttersosmed/widgets/ShimmerDetail.dart';
import 'package:fluttersosmed/widgets/button/FollowButton.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:fluttersosmed/architectures/domain/entities/FeedSearch.dart';
import 'package:fluttersosmed/architectures/domain/entities/UserFeed.dart';
import 'package:fluttersosmed/bloc/userfeed_search/bloc.dart';
import 'package:fluttersosmed/bloc/userprofile/bloc.dart';
import 'package:fluttersosmed/injection_container.dart' as di;
import 'package:fluttersosmed/theme/colors/Warna.dart';
import 'package:fluttersosmed/theme/styles/text/metropolis_style_text.dart';
import 'package:fluttersosmed/theme/styles/text/poppins_style_text.dart';
import 'package:fluttersosmed/widgets/ListShimmer.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';
import 'package:fluttersosmed/widgets/item/UserFeedItem.dart';

class profile_feed_page extends StatelessWidget {
  final int userId;
  const profile_feed_page({
    super.key,
    required this.userId,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Gedebook',
              style: MetropolisExtraBold14.copyWith(
                color: Colors.white,
                fontSize: 16,
              ),
            ),
          ],
        ),
        backgroundColor: Warna.warnaUtama,
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: Colors.white,
          statusBarIconBrightness: Brightness.dark,
        ),
        elevation: 0,
      ),
      body: MultiBlocProvider(
        providers: [
          BlocProvider<UserProfileBloc>(
              create: (BuildContext context) => di.sl<UserProfileBloc>()
                ..add(UserProfileBlocRetrieve(userId))),
          BlocProvider<UserFeedSearchBloc>(
              create: (BuildContext context) => di.sl<UserFeedSearchBloc>()
                ..add(UserFeedSearchBlocRetrieve(FeedSearch(
                  page: 0,
                  userId: userId,
                )))),
        ],
        child: _profileFeed(userId),
      ),
    );
  }
}

class _profileFeed extends StatefulWidget {
  final int userId;
  const _profileFeed(this.userId, {super.key});

  @override
  State<_profileFeed> createState() => _profileFeedState();
}

class _profileFeedState extends State<_profileFeed> {
  List<UserFeed> feedList = [];
  int pageNom = 0;
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  void _onRefresh() async {
    // monitor network fetch
    await Future.delayed(Duration(milliseconds: 1000));
    // if failed,use refreshFailed()
    _refreshController.refreshCompleted();
  }

  @override
  Widget build(BuildContext context) {
    return SmartRefresher(
      enablePullDown: false,
      enablePullUp: true,
      header: WaterDropHeader(),
      footer: CustomFooter(
        builder: (BuildContext context, LoadStatus? mode) {
          final Widget body;
          if (mode == LoadStatus.idle) {
            body = Text("pull up load");
          } else if (mode == LoadStatus.loading) {
            body = CupertinoActivityIndicator();
          } else if (mode == LoadStatus.failed) {
            body = Text("Load Failed!Click retry!");
          } else if (mode == LoadStatus.canLoading) {
            body = Text("release to load more");
          } else {
            body = Text("No more Data");
          }
          return BlocConsumer<UserFeedSearchBloc, UserFeedSearchBlocState>(
            listener: (context, state) {
              if (state is UserFeedSearchBlocStateOnSuccess) {
                if (mounted) {
                  pageNom += 1;
                  setState(() {
                    feedList.addAll(state.feedList);
                  });
                }
                _refreshController.loadComplete();
              }
            },
            builder: (BuildContext context, state) {
              if (state is UserFeedSearchBlocStateOnStarted) {
                return Center(
                  child: SpinKitWave(
                    color: Warna.warnaUtama,
                    size: 50.0,
                  ),
                );
              }

              return Container(
                height: 55.0,
              );
            },
          );
        },
      ),
      controller: _refreshController,
      onRefresh: _onRefresh,
      onLoading: () {
        BlocProvider.of<UserFeedSearchBloc>(context)
            .add(UserFeedSearchBlocRetrieve(FeedSearch(
          page: pageNom,
          userId: widget.userId,
        )));
      },
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 16.0),
            child: _profileDetail(),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              children: List.generate(
                  feedList.length,
                  (index) => Padding(
                        padding: EdgeInsets.only(
                          bottom: 25.0,
                          top: index == 0 ? 16 : 0,
                        ),
                        child: UserFeedItem(userFeed: feedList[index]),
                      )),
            ),
          ),
        ],
      ),
    );
  }
}

class _profileDetail extends StatelessWidget {
  const _profileDetail({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UserProfileBloc, UserProfileBlocState>(
      listener: (context, state) {},
      builder: (BuildContext context, state) {
        if (state is UserProfileBlocStateOnStarted) {
          return ShimmerDetail();
        }
        if (state is UserProfileBlocStateOnSuccess) {
          return Column(
            children: [
              Padding(
                padding: EdgeInsets.only(bottom: 12.0),
                child: Stack(
                  children: [
                    Container(
                      width: double.infinity,
                      height: 100,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                        image: NetworkImage(
                          state.userProfile.coverPict,
                        ),
                        fit: BoxFit.fill,
                      )),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 50.0),
                      child: Center(
                        child: CircleAvatar(
                          radius: 50.0,
                          backgroundImage:
                              NetworkImage(state.userProfile.profilePict),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: Text(
                  state.userProfile.name,
                  style: PoppinsSemiBold16.copyWith(),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 12.0),
                child: Text(
                  state.userProfile.job,
                  style: PoppinsSemiBold13.copyWith(
                    color: Warna.warnaUtama,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 12.0),
                child: FollowButton(state.userProfile),
              ),
              Divider(
                color: Colors.black12,
                height: 2.0,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 12, bottom: 4.0),
                child: Text(
                  "Posts",
                  style: PoppinsSemiBold14.copyWith(),
                ),
              ),
            ],
          );
        }
        return Column();
      },
    );
  }
}
