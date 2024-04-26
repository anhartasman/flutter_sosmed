import 'package:flutter/material.dart';
import 'package:fluttersosmed/architectures/domain/entities/UserFeed.dart';
import 'package:fluttersosmed/helpers/extensions/ext_string.dart';
import 'package:fluttersosmed/screens/profile/profile_feed_page.dart';
import 'package:fluttersosmed/theme/colors/Warna.dart';
import 'package:fluttersosmed/theme/styles/text/poppins_style_text.dart';
import 'package:fluttersosmed/widgets/button/LikeButton.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class UserFeedItem extends StatelessWidget {
  final UserFeed userFeed;
  const UserFeedItem({
    super.key,
    required this.userFeed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.all(Radius.circular(8.0)),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            offset: Offset(0.0, 2.0), //(x,y)
            blurRadius: 12.0,
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.horizontal(
          left: Radius.circular(8.0),
          right: Radius.circular(8.0),
        ),
        child: Container(
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.white,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              InkWell(
                onTap: () => Get.to(profile_feed_page(
                  userId: userFeed.userId,
                )),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(right: 8.0),
                      child: CircleAvatar(
                        radius: 18.0,
                        backgroundImage: NetworkImage(userFeed.pict),
                      ),
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(bottom: 4.0),
                            child: Text(
                              userFeed.name,
                              style: PoppinsSemiBold11.copyWith(
                                color: Warna.warnaUtama,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 13.0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(right: 8.0),
                                  child: FaIcon(
                                    FontAwesomeIcons.clock,
                                    size: 15,
                                    color: Warna.abuRecord,
                                  ),
                                ),
                                Expanded(
                                  child: Text(
                                    userFeed.created
                                        .toTanggal("EEE, dd/MM/yyyy"),
                                    style: PoppinsMedium11.copyWith(),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 13.0),
                child: Text(
                  userFeed.feedContent,
                  style: PoppinsMedium13.copyWith(),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 13.0),
                child: Divider(
                  color: Colors.black12,
                  height: 2.0,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 13.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(right: 16.0),
                      child: LikeButton(userFeed),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 13.0),
                child: Row(
                    children: List.generate(
                        userFeed.tags.length,
                        (index) => Container(
                              decoration: BoxDecoration(
                                color: Warna.unguTua,
                                shape: BoxShape.rectangle,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(8.0)),
                              ),
                              padding: EdgeInsets.symmetric(
                                horizontal: 13,
                                vertical: 4,
                              ),
                              margin: EdgeInsets.only(right: 4),
                              child: Text(
                                userFeed.tags[index],
                                style: PoppinsSemiBold10.copyWith(
                                    color: Colors.white),
                              ),
                            ))),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
