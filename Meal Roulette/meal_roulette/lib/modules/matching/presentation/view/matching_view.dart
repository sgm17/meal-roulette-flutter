import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:meal_roulette/configs/common_widgets/gradient_text.dart';
import 'package:meal_roulette/configs/resources/resources.dart';
import 'package:meal_roulette/configs/resources/sizing.dart';
import 'package:meal_roulette/configs/common_widgets/tag_chip.dart';
import 'package:meal_roulette/modules/auth/data/models/user_model.dart';
import 'package:meal_roulette/modules/matching/data/models/match_model.dart';
import 'package:meal_roulette/modules/matching/presentation/provider/matching_provider.dart';
import 'package:meal_roulette/modules/matching/presentation/widgets/profile_detail_section.dart';
import 'package:meal_roulette/routes/app_routes_constants.dart';
import 'package:provider/provider.dart';

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
  int? expandedIndexTab3; // Track which card is expanded for Tab 3

  // Demo data
  late MatchingProvider provider;
  Map<String, UserModel?> userCache = {}; // Cache users

  @override
  void initState() {
    super.initState();
    provider = Provider.of<MatchingProvider>(context, listen: false);
    provider.fetchMatchesData();
  }

  Future<UserModel?> _getUserCached(String userID) async {
    if (userCache.containsKey(userID)) return userCache[userID];
    final user = await provider.getUserFromID(userID);
    userCache[userID] = user;
    return user;
  }

  @override
  Widget build(BuildContext context) {
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
      body: StreamBuilder<List<MatchModel>>(
        stream: provider.matchesStream,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No matches found.'));
          }

          final listToShow = provider.fetchMatchesListFromSnapshot(snapshot, selectedTab);

          return SafeArea(
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
                                child: Text('Offered', style: R.textStyles.font11M.copyWith(color: selectedTab == 0 ? R.colors.textBlack : R.colors.textGrey)),
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
                                child: Text('Active', style: R.textStyles.font11M.copyWith(color: selectedTab == 1 ? R.colors.textBlack : R.colors.textGrey)),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: GestureDetector(
                            onTap: () => setState(() => selectedTab = 2),
                            child: AnimatedContainer(
                              duration: Duration(milliseconds: selectedTab == 2 ? 260 : 0),
                              curve: Curves.easeOut,
                              decoration: BoxDecoration(color: selectedTab == 2 ? R.colors.white : Colors.transparent, borderRadius: BorderRadius.circular(10)),
                              child: Center(
                                child: Text('Past', style: R.textStyles.font11M.copyWith(color: selectedTab == 2 ? R.colors.textBlack : R.colors.textGrey)),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 14.h),

                  listToShow == null || listToShow.isEmpty
                      ? Expanded(child: const Center(child: Text('No matches found')))
                      : Expanded(
                          child: ListView.builder(
                            key: ValueKey<int>(selectedTab), // ensures AnimatedSwitcher recognizes change
                            physics: const BouncingScrollPhysics(),
                            itemCount: listToShow.length ,
                            itemBuilder: (context, index) {
                              final match = listToShow[index];
                              final userID = provider.fetchUserIdOfOtherUser(match );

                              int? openedIndex = selectedTab == 0
                                  ? expandedIndexTab1
                                  : selectedTab == 1
                                  ? expandedIndexTab2
                                  : expandedIndexTab3;
                              final isExpanded = openedIndex == index;

                              return FutureBuilder<UserModel?>(
                                future: _getUserCached(userID ?? ""),
                                builder: (context, userSnapshot) {
                                  if (userSnapshot.connectionState == ConnectionState.waiting) {
                                    return const Padding(
                                      padding: EdgeInsets.all(16),
                                      child: Center(child: CircularProgressIndicator()),
                                    );
                                  }

                                  if (!userSnapshot.hasData || userSnapshot.data == null) {
                                    return const SizedBox.shrink(); // or show placeholder
                                  }

                                  final user = userSnapshot.data!;

                                  return AnimatedSize(
                                    duration: const Duration(milliseconds: 300),
                                    curve: Curves.easeInOut,
                                    child: Container(
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
                                            selectedTab == 0
                                                ? expandedIndexTab1 = isExpanded ? null : index
                                                : selectedTab == 1
                                                ? expandedIndexTab2 = isExpanded ? null : index
                                                : expandedIndexTab3 = isExpanded ? null : index;
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
                                                  ClipOval(
                                                    child: GestureDetector(
                                                      child: Text(user.avatarUrl ?? '🧑', style: const TextStyle(fontSize: 36)),
                                                      onTap: () {
                                                        context.goNamed(AppRouteConstants.profile);
                                                      },
                                                    ),
                                                  ),
                                                  SizedBox(width: 12.h),
                                                  Expanded(
                                                    child: Column(
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [
                                                        Text(user.name, style: R.textStyles.font12M.copyWith(color: R.colors.textBlack)),
                                                        SizedBox(width: 2.h),
                                                        isExpanded
                                                            ? Text("Demo University", style: R.textStyles.font9R.copyWith(color: R.colors.textGrey))
                                                            : Row(
                                                                children: [
                                                                  Icon(Icons.calendar_today, size: 12.sp, color: R.colors.textGrey),
                                                                  SizedBox(width: 4.w),
                                                                  Text(provider.getDate(match.timestamp), style: R.textStyles.font9R.copyWith(color: R.colors.textGrey)),
                                                                ],
                                                              ),
                                                      ],
                                                    ),
                                                  ),
                                                  AnimatedRotation(
                                                    turns: isExpanded ? 0.5 : 0,
                                                    duration: const Duration(milliseconds: 300),
                                                    child: Icon(Icons.keyboard_arrow_down_rounded, size: 26.sp),
                                                  ),
                                                ],
                                              ),

                                              SizedBox(height: 12.h),
                                              if (isExpanded) ...[
                                                Row(
                                                  children: [
                                                    Expanded(
                                                      child: Text("Shared Interests", style: R.textStyles.font10R.copyWith(color: R.colors.textGrey)),
                                                    ),
                                                    if (selectedTab == 0) ...[
                                                      GestureDetector(
                                                          child: Text('💚 Accept', style: TextStyle(fontSize: 14.sp)),
                                                          onTap: () {
                                                            provider.completeMatch(match.mensaID, match.id, "active");
                                                          },
                                                        ),

                                                      SizedBox(width: 12.h),
                                                      GestureDetector(
                                                          child: Text('❌ Reject', style: TextStyle(fontSize: 14.sp)),
                                                          onTap: () {
                                                            provider.completeMatch(match.mensaID, match.id, "past");
                                                          },
                                                        ),

                                                    ],
                                                    if (selectedTab == 1) ...[
                                                      GestureDetector(
                                                          child: Text('✅ Complete', style: TextStyle(fontSize: 14.sp)),
                                                          onTap: () {
                                                            provider.completeMatch(match.mensaID, match.id, "complete");
                                                          },
                                                        ),

                                                    ],
                                                    if (selectedTab == 2) ...[
                                                      GestureDetector(
                                                          child: Text('❌ Delete', style: TextStyle(fontSize: 14.sp)),
                                                          onTap: () {
                                                            provider.deleteMatch(match.mensaID, match.id);
                                                          },
                                                        ),

                                                    ],
                                                  ],
                                                ),
                                                SizedBox(height: 8.h),
                                              ],
                                              // Interests chips (always visible)
                                              Wrap(
                                                spacing: 4,
                                                runSpacing: 4,
                                                children: ['Photography', 'Hiking', 'Coffee', 'Technology'].map((interest) => TagChip(label: interest, color: R.colors.green, textColor: R.colors.white)).toList(),
                                              ),

                                              // Expanded detail section
                                              AnimatedCrossFade(
                                                firstChild: const SizedBox.shrink(),
                                                secondChild: ProfileDetailSection(user: user, match: match),
                                                crossFadeState: isExpanded ? CrossFadeState.showSecond : CrossFadeState.showFirst,
                                                duration: const Duration(milliseconds: 400),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              );
                            },
                          ),
                        ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
