import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:meal_roulette/configs/common_widgets/gradient_text.dart';
import 'package:meal_roulette/configs/resources/resources.dart';
import 'package:meal_roulette/configs/resources/sizing.dart';
import 'package:meal_roulette/modules/matching/data/models/matching_models.dart';
import 'package:meal_roulette/modules/matching/presentation/widgets/profile_detail_section.dart';
import 'package:meal_roulette/routes/app_routes_constants.dart';

/// Main screen showing a list of matches with segmented tabs (Active / Past).
/// It demonstrates responsive layout: single column on narrow screens and two columns
/// on medium screens and above. Uses AnimatedSwitcher for smooth transitions between tabs.
class MatchingView extends StatefulWidget {
  const MatchingView({super.key});

  @override
  State<MatchingView> createState() => _MatchingViewState();
}

class _MatchingViewState extends State<MatchingView> {
  int selectedTab = 0; // 0 = Active, 1 = Past
  int? expandedIndexTab1; // Track which card is expanded
  int? expandedIndexTab2; // Track which card is expanded for Tab 2

  // Demo data
  late final List<MatchingModel> activeMatches;
  late final List<MatchingModel> pastMatches;

  @override
  void initState() {
    super.initState();
    activeMatches = [
      MatchingModel(name: 'Sophie Mueller', date: '26/10/2025', location: 'ETH Zurich', interests: ['Photography', 'Hiking', 'Coffee', 'Technology'], email: 'sophie.mueller@ethz.ch', phone: '+41 79 123 4567', lunchDate: 'Sunday, October 26, 2025', avatar: '👩🏽'),
      MatchingModel(name: 'Lucas Bianchi', date: '28/10/2025', location: 'University of Milan', interests: ['Gaming', 'Cooking', 'Music'], email: 'lucas.bianchi@unimi.it', phone: '+39 340 123 4567', lunchDate: 'Tuesday, October 28, 2025', avatar: '👨🏾'),
      MatchingModel(name: 'Emma Chen', date: '30/10/2025', location: 'NUS Singapore', interests: ['Art', 'Reading', 'Yoga'], email: 'emma.chen@nus.edu.sg', phone: '+65 9876 5432', lunchDate: 'Thursday, October 30, 2025', avatar: '👩🏻‍🎓'),
    ];

    pastMatches = [
      MatchingModel(name: 'Emma Chen', date: '30/10/2025', location: 'NUS Singapore', interests: ['Art', 'Reading', 'Yoga'], email: 'emma.chen@nus.edu.sg', phone: '+65 9876 5432', lunchDate: 'Thursday, October 30, 2025', avatar: '👩🏻‍🎓'),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final listToShow = selectedTab == 0 ? activeMatches : pastMatches;

    return Scaffold(
      backgroundColor: R.colors.white,
      appBar: AppBar(
        centerTitle: true,
        toolbarHeight: 70.h,
        automaticallyImplyLeading: false,
        title: Column(
          children: [
            GradientText(
              'Your Matches',
              style: R.textStyles.font24B,
              gradient: LinearGradient(colors: [R.colors.splashGrad1, R.colors.splashGrad2]),
            ),
            Container(
              alignment: Alignment.center,
              padding: EdgeInsets.only(bottom: 16.h),
              child: Text(
                'Connect with your lunch buddies',
                style: R.textStyles.font11R.copyWith(color: R.colors.textGrey),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
        elevation: 0,
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
          child: Column(
            children: [
              // Segmented control (Active / Past) built with AnimatedContainer for motion
              Container(
                height: 40.h,
                padding: EdgeInsets.all(4.h),
                decoration: BoxDecoration(color: R.colors.veryLightGrey, borderRadius: BorderRadius.circular(12)),
                child: Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () => setState(() => selectedTab = 0),
                        child: AnimatedContainer(
                          duration: Duration(milliseconds: selectedTab == 0 ? 260 : 0),
                          curve: Curves.easeOut,
                          decoration: BoxDecoration(color: selectedTab == 0 ? R.colors.white : Colors.transparent, borderRadius: BorderRadius.circular(10)),
                          child: Center(
                            child: Text('Active', style: R.textStyles.font11M.copyWith(color: selectedTab == 0 ? R.colors.textBlack : R.colors.textGrey)),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: GestureDetector(
                        onTap: () => setState(() => selectedTab = 1),
                        child: AnimatedContainer(
                          duration: Duration(milliseconds: selectedTab == 1 ? 260 : 0),
                          curve: Curves.easeOut,
                          decoration: BoxDecoration(color: selectedTab == 1 ? R.colors.white : Colors.transparent, borderRadius: BorderRadius.circular(10)),
                          child: Center(
                            child: Text('Past', style: R.textStyles.font11M.copyWith(color: selectedTab == 1 ? R.colors.textBlack : R.colors.textGrey)),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 14.h),

              Expanded(
                child: ListView.builder(
                  key: ValueKey<int>(selectedTab), // ensures AnimatedSwitcher recognizes change
                  physics: const BouncingScrollPhysics(),
                  itemCount: listToShow.length,
                  itemBuilder: (context, index) {
                    final match = listToShow[index];
                    int? openedIndex = selectedTab == 0 ? expandedIndexTab1 : expandedIndexTab2;
                    final isExpanded = openedIndex == index;

                    return AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                      margin: EdgeInsets.only(bottom: 12.h),
                      decoration: BoxDecoration(
                        color: R.colors.white,
                        borderRadius: BorderRadius.circular(20),
                        border: BoxBorder.all(width: 0.5, color: R.colors.dividerBorderColor),
                      ),
                      child: InkWell(
                        borderRadius: BorderRadius.circular(20),
                        onTap: () {
                          setState(() {
                            selectedTab == 0 ?
                            expandedIndexTab1 = isExpanded ? null : index
                            :
                            expandedIndexTab2 = isExpanded ? null : index
                            ;
                          });
                        },
                        child: Padding(
                          padding: EdgeInsets.all(16.h),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Compact summary header
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  ClipOval(child: GestureDetector( child: Text(match.avatar, style: const TextStyle(fontSize: 36)), onTap: (){
                                    context.goNamed(AppRouteConstants.profile);
                                  },)),
                                  SizedBox(width: 12.h),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(match.name, style: R.textStyles.font12M.copyWith(color: R.colors.textBlack)),
                                        SizedBox(width: 2.h),
                                        isExpanded ?
                                        Text(match.location, style: R.textStyles.font9R.copyWith(color: R.colors.textGrey))
                                        : Row(
                                          children: [
                                            Icon(Icons.calendar_today, size: 12.sp, color: R.colors.textGrey),
                                            SizedBox(width: 4.w),
                                            Text(match.date, style: R.textStyles.font9R.copyWith(color: R.colors.textGrey)),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  AnimatedRotation(turns: isExpanded ? 0.5 : 0, duration: const Duration(milliseconds: 300), child: Icon(Icons.keyboard_arrow_down_rounded, size: 26.sp)),
                                ],
                              ),

                              SizedBox(height: 12.h),
                              Text(
                                "Shared Interests",
                                style: R.textStyles.font10R.copyWith(color: R.colors.textGrey),
                              ),
                              SizedBox(height: 8.h),

                              // Interests chips (always visible)
                              Wrap(
                                spacing: 4,
                                runSpacing: 4,
                                children: match.interests
                                    .map(
                                      (interest) =>
                                          Container(
                                            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                                            decoration: BoxDecoration(
                                              color: R.colors.green,
                                              borderRadius: BorderRadius.circular(20),
                                            ),
                                            child: Text(
                                              interest,
                                              style: R.textStyles.font11R.copyWith(
                                                color: R.colors.white,
                                                height: 1.2, // tighter line height for a compact tag look
                                              ),
                                            ),
                                          ),
                                    )
                                    .toList(),
                              ),

                              // Expanded detail section
                              AnimatedCrossFade(
                                firstChild: const SizedBox.shrink(),
                                secondChild: ProfileDetailSection(match: match),
                                crossFadeState: isExpanded ? CrossFadeState.showSecond : CrossFadeState.showFirst,
                                duration: const Duration(milliseconds: 400),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
