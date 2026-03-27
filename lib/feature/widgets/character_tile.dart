import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../models/character.dart';
import '../controllers/character_controller.dart';
import '../screen/detail_page.dart';

class CharacterTile extends StatelessWidget {
  final Character character;
  const CharacterTile({super.key, required this.character});

  @override
  Widget build(BuildContext context) {
    Get.find<CharacterController>();
    return InkWell(
      onTap: () => Get.to(() => DetailPage(id: character.id)),
      child: Container(
        width: 110.w,
        height: 150.h,
        margin: EdgeInsets.all(2.w),
        decoration: BoxDecoration(
          color: Colors.black,
          border: Border.all(color: Colors.grey[800]!, width: 1),
          borderRadius: BorderRadius.circular(8.r),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.vertical(top: Radius.circular(8.r)),
              child: character.image.isNotEmpty
                  ? CachedNetworkImage(
                      imageUrl: character.image,
                      fit: BoxFit.cover,
                      height: 90.w,
                      width: 110.w,
                      placeholder: (c, _) => Container(color: Colors.grey[900]),
                      errorWidget: (c, _, __) => Container(color: Colors.grey[900]),
                    )
                  : Container(height: 90.w, width: 110.w, color: Colors.grey[900]),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 4.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    character.name,
                    style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.bold, color: Colors.white),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 2.h),
                  Text(
                    character.status,
                    style: TextStyle(fontSize: 10.sp, color: Colors.grey[400]),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
