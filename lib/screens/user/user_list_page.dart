import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttersosmed/architectures/domain/entities/UserProfile.dart';
import 'package:fluttersosmed/architectures/domain/entities/UserSearch.dart';
import 'package:fluttersosmed/bloc/alluser/bloc.dart';
import 'package:fluttersosmed/injection_container.dart' as di;
import 'package:fluttersosmed/theme/colors/Warna.dart';
import 'package:fluttersosmed/theme/styles/text/metropolis_style_text.dart';
import 'package:fluttersosmed/widgets/ListShimmer.dart';
import 'package:fluttersosmed/widgets/item/UserListItem.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';

class user_list_page extends StatelessWidget {
  const user_list_page({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      systemNavigationBarColor: Colors.transparent,
      systemNavigationBarIconBrightness: Brightness.dark,
    ));
    // FetchPixels();
    // final authService = Get.find<AuthService>();

    // var statusBarHeight = MediaQuery.of(context).viewPadding.top;
    return BlocProvider<AllUserBloc>(
      create: (BuildContext context) =>
          di.sl<AllUserBloc>()..add(AllUserBlocRetrieve(UserSearch(page: 0))),
      child: _user_list(),
    );
  }
}

class _user_list extends StatefulWidget {
  const _user_list({super.key});

  @override
  State<_user_list> createState() => __user_listState();
}

class __user_listState extends State<_user_list> {
  List<UserProfile> userList = [];
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
              return BlocConsumer<AllUserBloc, AllUserBlocState>(
                listener: (context, state) {
                  if (state is AllUserBlocStateOnSuccess) {
                    if (mounted) {
                      pageNom += 1;
                      setState(() {
                        userList.addAll(state.userList);
                      });
                    }
                    _refreshController.loadComplete();
                  }
                },
                builder: (BuildContext context, state) {
                  if (state is AllUserBlocStateOnStarted) {
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
            BlocProvider.of<AllUserBloc>(context)
                .add(AllUserBlocRetrieve(UserSearch(page: pageNom)));
          },
          child: pageNom == 0
              ? ListShimmer()
              : ListView.builder(
                  padding: EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  itemCount: userList.length,
                  shrinkWrap: true,
                  itemBuilder: (_, idx) {
                    return Padding(
                      padding: EdgeInsets.only(
                        bottom: 25.0,
                        top: idx == 0 ? 16 : 0,
                      ),
                      child: UserListItem(theProfile: userList[idx]),
                    );
                  },
                ),
        ));
  }
}
