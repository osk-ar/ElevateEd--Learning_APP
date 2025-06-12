import 'package:ElevatED/config/themes/theme_colors.dart';
import 'package:ElevatED/core/constants/app_colors.dart';
import 'package:ElevatED/features/presentation/under_shit/comment_section.dart';
import 'package:ElevatED/features/presentation/under_shit/course_video_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CourseVideoScreen extends StatelessWidget {
  const CourseVideoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CourseVideoCubit(),
      child: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: MyTheme.onSurfaceColor,
            leading: IconButton(
              onPressed: () {},
              icon: const Icon(Icons.arrow_back),
            ),
          ),
          body: Column(
            children: [
              Container(
                height: 200,
                color: Colors.amber.shade100,
                child: const Center(child: Icon(Icons.video_library, size: 50)),
              ),
              Container(
                color: const Color(0xff664950),
                child: BlocBuilder<CourseVideoCubit, CourseVideoState>(
                  builder: (context, state) {
                    final cubit = context.read<CourseVideoCubit>();
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          onPressed: cubit.togglePlayPause,
                          icon: Icon(
                            state.isPaused
                                ? Icons.play_arrow
                                : Icons.pause_rounded,
                            color: AppColors.primaryColor,
                          ),
                        ),
                        IconButton(
                          onPressed: cubit.toggleMute,
                          icon: Icon(
                            state.isMuted ? Icons.volume_off : Icons.volume_up,
                            color: MyTheme.primaryColor,
                          ),
                        ),
                        Slider(
                          value: state.sliderValue,
                          onChanged: cubit.updateSlider,
                        ),
                        IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.list,
                            color: MyTheme.primaryColor,
                          ),
                        ),
                        IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.fullscreen,
                            color: MyTheme.primaryColor,
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("Zeiad Mohammed"),
                    SizedBox(height: 12.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: 110.w,
                          child: ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)),
                            ),
                            child: const Text(
                              "Previous",
                              style: TextStyle(color: Colors.black),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 110.w,
                          child: ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xff00D9BD),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            child: const Text(
                              "Next",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                color: const Color(0xff664950),
                child: const TabBar(
                  tabs: [
                    Tab(text: "Description"),
                    Tab(text: "Comments"),
                  ],
                ),
              ),
              SizedBox(height: 12.h),
              const Expanded(
                child: TabBarView(
                  children: [
                    Text(
                        "Hello I’m Using ElevatED! Hello I’m Using ElevatED! Hello I’m Using ElevatED! "),
                    CommentSection(),
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
