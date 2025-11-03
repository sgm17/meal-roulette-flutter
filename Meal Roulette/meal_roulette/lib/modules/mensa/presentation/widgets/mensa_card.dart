import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:meal_roulette/configs/resources/resources.dart';
import 'package:meal_roulette/configs/resources/sizing.dart';
import 'package:meal_roulette/modules/mensa/data/models/mensa_models.dart';
import 'package:meal_roulette/routes/app_routes_constants.dart';

class MensaCard extends StatelessWidget {
  final MensaModel mensaModel;
  const MensaCard({super.key, required this.mensaModel});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Card(
      color: R.colors.white,
      elevation: 1,
      margin: EdgeInsets.symmetric(vertical: 4.h),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: () {
          context.goNamed(AppRouteConstants.details);
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Hero(
              tag: mensaModel.name,
              child: CachedNetworkImage(
                height: 135.h,
                width: double.infinity,
                imageUrl: mensaModel.imageUrl,
                fit: BoxFit.cover,
                placeholder: (context, url) => Container(color: R.colors.dividerColor, child: Icon(Icons.downloading)),
                errorWidget: (context, url, error) => Container(color: R.colors.dividerBorderColor, child: Icon(Icons.error)),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 8.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(mensaModel.name, style: R.textStyles.font14B, maxLines: 2, overflow: TextOverflow.ellipsis,),
                  SizedBox(height: 2.h),
                  Text(mensaModel.tags, style: R.textStyles.font10R.copyWith(color: R.colors.textGrey), maxLines: 1, softWrap: true,
                    overflow: TextOverflow.ellipsis,),
                  SizedBox(height: 16.h),
                  Row(
                    children: [
                      Icon(Icons.location_on_outlined, size: 14.sp, color: R.colors.textGrey,),
                      SizedBox(width: 4.w),
                      Flexible(child: Text(mensaModel.location , style: R.textStyles.font10R.copyWith(color: R.colors.textGrey), maxLines: 1, softWrap: true, overflow: TextOverflow.ellipsis,)),
                    ],
                  ),
                  SizedBox(height: 4.h),
                  Row(
                    children: [
                      Icon(Icons.access_time, size: 14.sp, color: R.colors.textGrey,),
                      SizedBox(width: 4.h),
                      Flexible(child: Text(mensaModel.time, style: R.textStyles.font10R.copyWith(color: R.colors.textGrey), maxLines: 1, softWrap: true, overflow: TextOverflow.ellipsis,)),
                    ],
                  ),
                  SizedBox(height: 4.h),
                  Row(
                    children: [
                      Icon(Icons.people_outline, size: 14.sp, color: R.colors.textGrey,),
                      SizedBox(width: 4.h),
                      Flexible(child: Text('Capacity: ${mensaModel.capacity} students', style: R.textStyles.font10R.copyWith(color: R.colors.textGrey), softWrap: true, maxLines: 1, overflow: TextOverflow.ellipsis,)),
                    ],
                  ),
                  SizedBox(height: 8.h),
                  FilledButton.icon(
                    onPressed: () {
                      context.goNamed(AppRouteConstants.matches);
                    },
                    icon: Icon(Icons.local_dining_outlined, color: R.colors.white,),
                    label: Text('Find Lunch Buddy', style: R.textStyles.font11M.copyWith(color: R.colors.white), maxLines: 1, softWrap: true, overflow: TextOverflow.ellipsis,),
                    style: FilledButton.styleFrom(
                      minimumSize: Size.fromHeight(40.h),
                      backgroundColor: R.colors.primaryColor,
                      foregroundColor: theme.colorScheme.onPrimaryContainer,
                    ),
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