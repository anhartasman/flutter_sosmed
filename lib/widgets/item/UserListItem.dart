import 'package:flutter/material.dart';
import 'package:fluttersosmed/architectures/domain/entities/UserProfile.dart';
import 'package:fluttersosmed/screens/profile/profile_feed_page.dart';
import 'package:fluttersosmed/theme/colors/Warna.dart';
import 'package:fluttersosmed/theme/styles/text/poppins_style_text.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class UserListItem extends StatelessWidget {
  final UserProfile theProfile;
  const UserListItem({
    super.key,
    required this.theProfile,
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
                  userId: theProfile.id,
                )),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(right: 8.0),
                      child: CircleAvatar(
                        radius: 18.0,
                        backgroundImage: NetworkImage(theProfile.profilePict),
                      ),
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(bottom: 4.0),
                            child: Text(
                              theProfile.name,
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
                                    FontAwesomeIcons.briefcase,
                                    size: 15,
                                    color: Warna.abuRecord,
                                  ),
                                ),
                                Expanded(
                                  child: Text(
                                    theProfile.job,
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
            ],
          ),
        ),
      ),
    );
  }
}
