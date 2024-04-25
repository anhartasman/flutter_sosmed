import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:fluttersosmed/architectures/domain/entities/FeedSearch.dart';
import 'package:fluttersosmed/architectures/domain/entities/UserFeed.dart';
import 'package:fluttersosmed/bloc/userfeed_search/bloc.dart';
import 'package:fluttersosmed/injection_container.dart' as di;
import 'package:fluttersosmed/theme/colors/Warna.dart';
import 'package:fluttersosmed/theme/styles/text/metropolis_style_text.dart';
import 'package:fluttersosmed/theme/styles/text/poppins_style_text.dart';
import 'package:fluttersosmed/widgets/ListShimmer.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';
import 'package:fluttersosmed/widgets/item/UserFeedItem.dart';

class home_feed_page extends StatefulWidget {
  const home_feed_page({super.key});

  @override
  State<home_feed_page> createState() => _home_feed_pageState();
}

class _home_feed_pageState extends State<home_feed_page> {
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
        body: SmartRefresher(
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
                .add(UserFeedSearchBlocRetrieve(FeedSearch(page: pageNom)));
          },
          child: ListView.builder(
            padding: EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 8,
            ),
            itemCount: feedList.length,
            shrinkWrap: true,
            itemBuilder: (_, idx) {
              return Padding(
                padding: EdgeInsets.only(
                  bottom: 25.0,
                  top: idx == 0 ? 16 : 0,
                ),
                child: UserFeedItem(userFeed: feedList[idx]),
              );
            },
          ),
        ));
  }
}
