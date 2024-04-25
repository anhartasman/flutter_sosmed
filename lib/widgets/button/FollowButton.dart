import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttersosmed/architectures/domain/entities/UserProfile.dart';
import 'package:fluttersosmed/bloc/toggle_follow/bloc.dart';
import 'package:fluttersosmed/injection_container.dart' as di;
import 'package:fluttersosmed/theme/colors/Warna.dart';
import 'package:fluttersosmed/theme/styles/text/poppins_style_text.dart';

class FollowButton extends StatelessWidget {
  final UserProfile theProfile;
  const FollowButton(
    this.theProfile, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ToggleFollowBloc>(
      create: (BuildContext context) => di.sl<ToggleFollowBloc>()
        ..add(ToggleFollowBlocSetStatus(theProfile.id, theProfile.followed)),
      child: BlocConsumer<ToggleFollowBloc, ToggleFollowBlocState>(
          listener: (context, state) {},
          builder: (BuildContext context, state) {
            if (state.onLoading) {
              return Center(
                child: SpinKitWave(
                  color: Warna.warnaUtama,
                  size: 50.0,
                ),
              );
            }
            return InkWell(
              onTap: () {
                BlocProvider.of<ToggleFollowBloc>(context)
                    .add(ToggleFollowBlocStart());
              },
              child: Container(
                decoration: BoxDecoration(
                  color: state.isFollowed ? Colors.grey : Warna.warnaUtama,
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.all(Radius.circular(8.0)),
                ),
                padding: EdgeInsets.symmetric(
                  horizontal: 13,
                  vertical: 8,
                ),
                child: Text(
                  state.isFollowed ? "Unfriend" : "Add Friend",
                  style: PoppinsSemiBold12.copyWith(
                      color: state.isFollowed ? Colors.black : Colors.white),
                ),
              ),
            );
          }),
    );
  }
}
