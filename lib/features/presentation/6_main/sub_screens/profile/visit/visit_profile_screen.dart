import 'package:ElevatED/config/extensions.dart';
import 'package:ElevatED/config/themes/theme_colors.dart';
import 'package:ElevatED/core/constants/app_colors.dart';
import 'package:ElevatED/config/themes/text_styles.dart';
import 'package:ElevatED/core/constants/app_assets.dart';
import 'package:ElevatED/core/constants/app_icons.dart';
import 'package:ElevatED/core/constants/app_strings.dart';
import 'package:ElevatED/features/presentation/0_common/cta_icon_button.dart';
import 'package:ElevatED/features/presentation/0_common/default_appbar.dart';
import 'package:ElevatED/features/presentation/0_common/double_circular_avatar.dart';
import 'package:ElevatED/features/presentation/0_common/expandable_text.dart';
import 'package:ElevatED/features/presentation/0_common/course_card.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ElevatED/features/presentation/6_main/cubits/visit_profile_cubit.dart';
import 'package:ElevatED/features/data/models/user_data.dart';

class VisitProfileScreen extends StatefulWidget {
  final int userId;
  const VisitProfileScreen({super.key, required this.userId});

  @override
  State<VisitProfileScreen> createState() => _VisitProfileScreenState();
}

class _VisitProfileScreenState extends State<VisitProfileScreen> {
  @override
  void initState() {
    super.initState();
    context.read<VisitProfileCubit>().loadProfile(widget.userId);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: ThemeColors.backgroundColor,
        body: BlocBuilder<VisitProfileCubit, VisitProfileState>(
          builder: (context, state) {
            if (state is VisitProfileLoading || state is VisitProfileInitial) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is VisitProfileError) {
              return Center(child: Text(state.message));
            } else if (state is VisitProfileLoaded) {
              final profile = state.profile;
              return CustomScrollView(slivers: [
                defaultSliverAppbar(
                    "visit_profile_title".tr(args: [profile.name])),
                SliverToBoxAdapter(
                  child: Stack(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Image.asset(
                            ImageAssets.default_cover,
                            height: 202.5.h,
                            fit: BoxFit.cover,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              SizedBox(
                                width: 110.w,
                                height: 36.h,
                              ),
                              SizedBox(
                                width: 150.w,
                                child: Text(
                                  profile.name,
                                  overflow: TextOverflow.ellipsis,
                                  style: getMediumStyle(
                                      fontSize: 16.sp,
                                      color: ThemeColors.textColor),
                                ),
                              ),
                              const Spacer()
                            ],
                          ),
                          if (profile is InstructorUserData)
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 10.w, vertical: 24.h),
                              child: Text(
                                profile.professionalTitle,
                                style: getMediumStyle(
                                    fontSize: 16.sp,
                                    color: AppColors.inversePrimaryColor),
                              ),
                            ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 10.w),
                            child: ExpandableText(text: profile.description),
                          ),
                          if (profile is InstructorUserData)
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(height: 16.h),
                                Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 16.w),
                                  child: Text(
                                    'my_courses'.tr(),
                                    overflow: TextOverflow.ellipsis,
                                    style: getMediumStyle(
                                        fontSize: 16.sp,
                                        color: ThemeColors.textColor),
                                  ),
                                ),
                                SizedBox(height: 8.h),
                                SizedBox(
                                  height: 381.h,
                                  child: PageView.builder(
                                    scrollDirection: Axis.horizontal,
                                    itemCount: profile.createdCourses.length,
                                    itemBuilder: (_, index) {
                                      final course =
                                          profile.createdCourses[index];
                                      return Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 16.w),
                                        child: CourseCard(course: course),
                                      );
                                    },
                                  ),
                                ),
                              ],
                            ),
                          SizedBox(height: 24.h),
                        ],
                      ),
                      Positioned(
                        top: 153.h,
                        left: context.locale != const Locale('ar') ? 5.w : null,
                        right:
                            context.locale == const Locale('ar') ? 5.w : null,
                        child: DoubleCircularAvatar(
                          outerRadius: 50.r,
                          innerRadius: 45.r,
                          imageURL: profile.profilePictureUrl,
                        ),
                      ),
                      Positioned(
                        top: 210.h,
                        left: context.locale == const Locale('ar') ? 5.w : null,
                        right:
                            context.locale != const Locale('ar') ? 5.w : null,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Column(
                              children: [
                                CTAIconButton(
                                  icon: AppIcons.portfolio,
                                  onPressed: () {
                                    if (profile is InstructorUserData &&
                                        profile.personalLinks.isNotEmpty) {
                                      context
                                          .read<VisitProfileCubit>()
                                          .launchSocialLink(
                                              profile.personalLinks[0]);
                                      return;
                                    }
                                    context.message(
                                        message: AppStrings.noPortfolioUrl);
                                  },
                                ),
                                SizedBox(height: 8.h),
                                CTAIconButton(
                                  icon: AppIcons.github,
                                  onPressed: () {
                                    if (profile is InstructorUserData &&
                                        profile.personalLinks.length > 1) {
                                      context
                                          .read<VisitProfileCubit>()
                                          .launchSocialLink(
                                              profile.personalLinks[1]);
                                      return;
                                    }
                                    context.message(
                                        message: AppStrings.noGithubUrl);
                                  },
                                ),
                              ],
                            ),
                            SizedBox(width: 8.w),
                            Column(
                              children: [
                                CTAIconButton(
                                  icon: AppIcons.linkedin,
                                  onPressed: () {
                                    if (profile is InstructorUserData &&
                                        profile.personalLinks.length > 2) {
                                      context
                                          .read<VisitProfileCubit>()
                                          .launchSocialLink(
                                              profile.personalLinks[2]);
                                      return;
                                    }
                                    context.message(
                                        message: AppStrings.noLinkedinUrl);
                                  },
                                ),
                                SizedBox(height: 8.h),
                                CTAIconButton(
                                  icon: AppIcons.facebook,
                                  onPressed: () {
                                    if (profile is InstructorUserData &&
                                        profile.personalLinks.length > 3) {
                                      context
                                          .read<VisitProfileCubit>()
                                          .launchSocialLink(
                                              profile.personalLinks[3]);
                                      return;
                                    }
                                    context.message(
                                        message: AppStrings.noFacebookUrl);
                                  },
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                )
              ]);
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
