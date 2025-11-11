import 'package:flutter/material.dart';
import 'package:meal_roulette/configs/common_widgets/gradient_text.dart';
import 'package:meal_roulette/configs/resources/resources.dart';
import 'package:meal_roulette/configs/resources/sizing.dart';
import 'package:meal_roulette/modules/details/data/models/details_models.dart';
import 'package:meal_roulette/modules/details/presentation/widgets/feature_row.dart';
import 'package:meal_roulette/modules/details/presentation/widgets/header_image.dart';
import 'package:meal_roulette/modules/details/presentation/widgets/info_card.dart';
import 'package:meal_roulette/configs/common_widgets/tag_chip.dart';
import 'package:meal_roulette/modules/mensa/data/models/mensa_models.dart';

/// Canteen detail screen: Sliver-based, responsive, adaptive, and animated.
/// Single-screen, ready to be wired into your app.
class DetailsView extends StatefulWidget {
  final MensaModel mensa;
  const DetailsView({super.key, required this.mensa});

  @override
  State<DetailsView> createState() => _DetailsViewState();
}

class _DetailsViewState extends State<DetailsView> {
  // In a real app, this would come from ViewModel / provider
  final DetailsModel canteen = demoCanteen;
  bool _showMoreDescription = false;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isWide = screenWidth >= 900;
    final horizontalPadding = isWide ? 30.w : 16.w;

    return Scaffold(
      backgroundColor: R.colors.white,
      body: SafeArea(
        child: CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [
            // Top app bar with back button
            SliverAppBar(
              pinned: false,
              automaticallyImplyLeading: true,
              leadingWidth: 50.w,
              leading: IconButton(
                onPressed: () => Navigator.of(context).maybePop(),
                icon: Icon(Icons.arrow_back_rounded, color: R.colors.textBlack, size: 16.sp),
              ),
              backgroundColor: R.colors.white,
              surfaceTintColor: R.colors.red,
              expandedHeight: 330.h,
              toolbarHeight: 56.h,
              flexibleSpace: FlexibleSpaceBar(
                background: Padding(
                  padding: EdgeInsets.fromLTRB(horizontalPadding, 16.w, horizontalPadding, 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Back button row (keeps toolbar height consistent)
                      Padding(
                        padding: EdgeInsets.fromLTRB(30.w, 3.h, 30.h, 12.h),
                        child: Text("Back to Canteens", style: R.textStyles.font10M.copyWith(color: R.colors.textBlack)),
                      ),
                      SizedBox(height: 6.h),
                      // Hero image
                      HeaderImage(imageUrl: widget.mensa.imageUrl, heroTag: 'canteen-${canteen.id}'),
                    ],
                  ),
                ),
              ),
            ),

            SliverPadding(
              padding: EdgeInsets.fromLTRB(horizontalPadding, 0, horizontalPadding,  18.h),
              sliver: SliverList(
                delegate: SliverChildListDelegate([
                  // Title row with rating
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: GradientText(
                          widget.mensa.name,
                          style: R.textStyles.font18B,
                          gradient: LinearGradient(colors: [R.colors.splashGrad1, R.colors.splashGrad2]),
                        ),
                      ),
                      Row(
                        children: [
                          Icon(Icons.star_rounded, color: R.colors.splashGrad2, size: 18.sp),
                          SizedBox(width: 6.w),
                          Text(canteen.rating.toStringAsFixed(1), style: R.textStyles.font12B),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 4.h),
                  Row(
                    children: [
                      Icon(Icons.location_on_outlined, size: 16.sp, color: R.colors.textGrey),
                      SizedBox(width: 4.w),
                      Expanded(
                        child: Text(widget.mensa.location, style: R.textStyles.font11R.copyWith(color: R.colors.textGrey)),
                      ),
                    ],
                  ),
                  SizedBox(height: 14.h),

                  // Description with "show more"
                  AnimatedSize(
                    duration: const Duration(milliseconds: 320),
                    curve: Curves.easeInOut,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          canteen.description,
                          maxLines: _showMoreDescription ? 20 : 3,
                          overflow: TextOverflow.fade,
                          style: R.textStyles.font11R.copyWith(color: R.colors.textGrey),
                        ),
                        SizedBox(height: 2.h),
                        InkWell(
                          onTap: () => setState(() => _showMoreDescription = !_showMoreDescription),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(_showMoreDescription ? 'Show less' : 'Read more', style: R.textStyles.font11R.copyWith(color: R.colors.textBlack)),
                              SizedBox(width: 6.w),
                              Icon(_showMoreDescription ? Icons.expand_less : Icons.expand_more, size: 18.sp, color: R.colors.textBlack),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 18.h),

                  // Two info cards (Operating Hours | Capacity & Pricing)
                  LayoutBuilder(
                    builder: (context, constraints) {
                      // If there is room side-by-side, show two columns, else vertically
                      final showSideBySide = constraints.maxWidth >= 320;
                      if (showSideBySide) {
                        return Row(
                          children: [
                            Expanded(
                              child: InfoCard(title: 'Operating Hours', subtitle: widget.mensa.time, peakHours: canteen.peakHours, icon: Icons.schedule),
                            ),
                            SizedBox(width: 8.w),
                            Expanded(
                              child: InfoCard(title: 'Capacity & Pricing', subtitle: widget.mensa.capacity.toString(), peakHours: canteen.priceRange, icon: Icons.people_outline),
                            ),
                          ],
                        );
                      }else {
                        return Column(
                          children: [
                            InfoCard(title: 'Operating Hours', subtitle: widget.mensa.time, peakHours: canteen.peakHours, icon: Icons.schedule),
                            SizedBox(height: 12.h),
                            InfoCard(title: 'Capacity & Pricing', subtitle: widget.mensa.capacity.toString(), peakHours: canteen.priceRange, icon: Icons.people_outline),
                          ],
                        );
                      }
                    },
                  ),
                  SizedBox(height: 18.h),

                  // Popular dishes section
                  Container(
                    padding:  EdgeInsets.all(12.h),
                    decoration: BoxDecoration(
                      color: R.colors.white,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: R.colors.textGrey.withValues(alpha: 0.2)),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(Icons.restaurant_menu_outlined, color: R.colors.textBlack, size: 18.sp,),
                            SizedBox(width: 8.w),
                            Text('Popular Dishes', style: R.textStyles.font12B),
                          ],
                        ),
                        SizedBox(height: 12.h),
                        Wrap(
                          children: canteen.popularDishes.map((d) => TagChip(label: d, color: R.colors.green, textColor: R.colors.white)).toList(),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 16.h),

                  // Cuisine types
                  Container(
                    padding:  EdgeInsets.all(12.h),
                    decoration: BoxDecoration(
                      color:  R.colors.white,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: R.colors.textGrey.withValues(alpha: 0.2)),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Cuisine Types', style: R.textStyles.font12B),
                        SizedBox(height: 12.h),
                        Wrap(
                          children: canteen.cuisineTypes.map((d) => TagChip(label: d, color: R.colors.red, textColor: R.colors.white)).toList(),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 16.h),

                  // Amenities & features (bullet row)
                  Container(
                    padding: EdgeInsets.all(12.h),
                    decoration: BoxDecoration(
                      color: R.colors.white,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: R.colors.textGrey.withValues(alpha: 0.2)),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Amenities & Features', style: R.textStyles.font12B),
                        SizedBox(height: 12.h),
                        Wrap(
                          children: canteen.amenities.map((d) => FeatureRow(d)).toList(),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 24.h),
                  // CTA area
                 /* FilledButton(
                    onPressed: () {
                      context.goNamed(AppRouteConstants.matches);
                    },
                    style: FilledButton.styleFrom(
                      minimumSize: Size.fromHeight(38.h),
                      backgroundColor: R.colors.primaryColor,
                      foregroundColor: R.colors.white,
                      padding: EdgeInsets.symmetric(horizontal: 0.w, vertical: 8.h), // ← internal padding
                      elevation: 2,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8), // <-- Reduced corner radius
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min, // Keeps button size compact
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.local_dining_outlined, color: R.colors.white, size: 16.sp,),
                        SizedBox(width: 4.w), // ← adjust this to control spacing (default ~8)
                        Flexible(
                          child: Text('Find Lunch Buddy', style: R.textStyles.font11M.copyWith(color: R.colors.white), maxLines: 1, softWrap: true, overflow: TextOverflow.ellipsis,),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 36),*/
                ]),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
