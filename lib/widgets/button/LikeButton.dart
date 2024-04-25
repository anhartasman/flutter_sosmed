import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttersosmed/architectures/domain/entities/UserFeed.dart';
import 'package:fluttersosmed/bloc/toggle_like/bloc.dart';
import 'package:fluttersosmed/injection_container.dart' as di;
import 'package:fluttersosmed/theme/colors/Warna.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class LikeButton extends StatelessWidget {
  final UserFeed theFeed;
  const LikeButton(
    this.theFeed, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ToggleLikeBloc>(
      create: (BuildContext context) => di.sl<ToggleLikeBloc>()
        ..add(ToggleLikeBlocSetStatus(theFeed.id, theFeed.isLiked)),
      child: BlocConsumer<ToggleLikeBloc, ToggleLikeBlocState>(
          listener: (context, state) {},
          builder: (BuildContext context, state) {
            if (state.onLoading) {
              return Center(
                child: SpinKitWave(
                  color: Warna.warnaUtama,
                  size: 10.0,
                ),
              );
            }
            return InkWell(
              onTap: () {
                BlocProvider.of<ToggleLikeBloc>(context)
                    .add(ToggleLikeBlocStart());
              },
              child: FaIcon(
                state.isLiked
                    ? FontAwesomeIcons.solidHeart
                    : FontAwesomeIcons.heart,
                size: 13,
                color: Warna.warnaUtama,
              ),
            );
          }),
    );
  }
}
