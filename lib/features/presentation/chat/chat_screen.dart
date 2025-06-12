import 'package:ElevatED/features/presentation/0_common/default_appbar.dart';
import 'package:ElevatED/features/presentation/0_common/input_field.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:intl/intl.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../config/themes/theme_colors.dart';
import '../../../core/constants/app_colors.dart';
import '../../../config/themes/text_styles.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final List<_Message> _messages = [
    _Message(
      text: 'Can you send me the homework for tomorrow please?',
      date: DateTime(2023, 6, 16, 8, 5),
      isSentByMe: false,
      user: 'Michael Jackson',
    ),
    _Message(
      text: 'Hi?',
      date: DateTime(2023, 6, 16, 8, 9),
      isSentByMe: false,
      user: 'Remon',
    ),
    _Message(
      text: 'I dont understand the math questions :(',
      date: DateTime(2023, 6, 16, 8, 7),
      isSentByMe: false,
      user: 'Michael Jackson',
    ),
    _Message(
      text: 'Yeah sure I have send them per mail',
      date: DateTime(2023, 6, 16, 8, 7),
      isSentByMe: true,
      user: 'Me',
    ),
    _Message(
      text: 'Hello how are you?',
      date: DateTime(2023, 6, 16, 8, 8),
      isSentByMe: false,
      user: 'Michael Jackson',
    ),
    _Message(
      text: 'Fine and what about you?',
      date: DateTime(2023, 6, 16, 8, 18),
      isSentByMe: true,
      user: 'Me',
    ),
    _Message(
      text: 'I am fine too',
      date: DateTime(2023, 6, 16, 8, 28),
      isSentByMe: false,
      user: 'Michael Jackson',
    ),
    _Message(
      text: 'Hey you do you wanna go to the cinema?',
      date: DateTime(2023, 6, 16, 8, 38),
      isSentByMe: true,
      user: 'Me',
    ),
    _Message(
      text: 'Hello how are you?',
      date: DateTime(2023, 6, 17, 8, 8),
      isSentByMe: false,
      user: 'Michael Jackson',
    ),
    _Message(
      text: 'Fine and what about you?',
      date: DateTime(2023, 6, 17, 8, 18),
      isSentByMe: true,
      user: 'Me',
    ),
    _Message(
      text: 'I am fine too',
      date: DateTime(2023, 6, 17, 8, 28),
      isSentByMe: false,
      user: 'Michael Jackson',
    ),
    _Message(
      text: 'Hey you do you wanna go to the cinema?',
      date: DateTime(2023, 6, 17, 8, 38),
      isSentByMe: true,
      user: 'Me',
    ),
    _Message(
      text: 'Hello how are you?',
      date: DateTime(2023, 6, 17, 8, 8),
      isSentByMe: false,
      user: 'Michael Jackson',
    ),
    _Message(
      text: 'Fine and what about you?',
      date: DateTime(2023, 6, 17, 8, 18),
      isSentByMe: true,
      user: 'Me',
    ),
    _Message(
      text: 'I am fine too',
      date: DateTime(2023, 6, 17, 8, 28),
      isSentByMe: false,
      user: 'Michael Jackson',
    ),
    _Message(
      text: 'Hey you do you wanna go to the cinema?',
      date: DateTime(2023, 6, 17, 8, 38),
      isSentByMe: true,
      user: 'Me',
    ),
  ];

  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: defaultAppbar("XYZ Community"),
      backgroundColor: ThemeColors.backgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: GroupedListView<_Message, DateTime>(
                elements: _messages,
                floatingHeader: true,
                order: GroupedListOrder.ASC,
                useStickyGroupSeparators: false,
                groupBy: (msg) =>
                    DateTime(msg.date.year, msg.date.month, msg.date.day),
                groupSeparatorBuilder: (DateTime date) => Align(
                  alignment: Alignment.topCenter,
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 8.h),
                    child: Container(
                      decoration: BoxDecoration(
                        color: AppColors.surfaceColor,
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      padding:
                          EdgeInsets.symmetric(horizontal: 12.w, vertical: 4.h),
                      child: Text(
                        DateFormat('MMM dd, yyyy').format(date),
                        style: getBoldStyle(
                            fontSize: 13.sp, color: AppColors.whiteColor),
                      ),
                    ),
                  ),
                ),
                itemBuilder: (context, msg) => Align(
                  alignment: msg.isSentByMe
                      ? Alignment.centerRight
                      : Alignment.centerLeft,
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 8.w, vertical: 2.h),
                    child: Row(
                      mainAxisAlignment: msg.isSentByMe
                          ? MainAxisAlignment.end
                          : MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        if (!msg.isSentByMe)
                          CircleAvatar(
                            radius: 16.r,
                            backgroundColor: AppColors.primaryGradientColor_2,
                            child: Icon(Icons.person,
                                color: AppColors.whiteColor, size: 18.sp),
                          ),
                        if (!msg.isSentByMe) SizedBox(width: 8.w),
                        Flexible(
                          child: Column(
                            crossAxisAlignment: msg.isSentByMe
                                ? CrossAxisAlignment.end
                                : CrossAxisAlignment.start,
                            children: [
                              if (!msg.isSentByMe)
                                Text(
                                  msg.user,
                                  style: getSemiBoldStyle(
                                      fontSize: 13.sp,
                                      color: AppColors.primaryColor),
                                ),
                              Container(
                                decoration: BoxDecoration(
                                  color: msg.isSentByMe
                                      ? AppColors.primaryColor
                                      : AppColors.whiteColor,
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(18.r),
                                    topRight: Radius.circular(18.r),
                                    bottomLeft: Radius.circular(
                                        msg.isSentByMe ? 18.r : 4.r),
                                    bottomRight: Radius.circular(
                                        msg.isSentByMe ? 4.r : 18.r),
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withAlpha(16),
                                      blurRadius: 4.r,
                                      offset: Offset(0, 2.h),
                                    ),
                                  ],
                                ),
                                padding: EdgeInsets.symmetric(
                                    horizontal: 16.w, vertical: 10.h),
                                child: Text(
                                  msg.text,
                                  style: getRegularStyle(
                                    fontSize: 15.sp,
                                    color: msg.isSentByMe
                                        ? AppColors.whiteColor
                                        : AppColors.blackColor,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                    top: 2.h, left: 4.w, right: 4.w),
                                child: Text(
                                  DateFormat('HH:mm').format(msg.date),
                                  style: getLightStyle(
                                      fontSize: 11.sp,
                                      color: AppColors.darkSubColor),
                                ),
                              ),
                            ],
                          ),
                        ),
                        if (msg.isSentByMe) SizedBox(width: 8.w),
                        if (msg.isSentByMe)
                          CircleAvatar(
                            radius: 16.r,
                            backgroundColor: AppColors.primaryColor,
                            child: Icon(Icons.person,
                                color: AppColors.whiteColor, size: 18.sp),
                          ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
              decoration: const BoxDecoration(
                color: ThemeColors.lightSurfaceToDarkSecondary,
              ),
              child: Row(
                children: [
                  Expanded(
                    child: InputField(
                      title: "Type your message...",
                      controller: _controller,
                      minLines: 1,
                      maxLines: 4,
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.send, color: AppColors.primaryColor),
                    onPressed: () {
                      if (_controller.text.trim().isNotEmpty) {
                        setState(() {
                          _messages.add(_Message(
                            text: _controller.text.trim(),
                            date: DateTime.now(),
                            isSentByMe: true,
                            user: 'Me',
                          ));
                          _controller.clear();
                        });
                      }
                    },
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

class _Message {
  final String text;
  final DateTime date;
  final bool isSentByMe;
  final String user;
  _Message(
      {required this.text,
      required this.date,
      required this.isSentByMe,
      required this.user});
}
