import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class UploadItemWidget extends StatelessWidget {
  const UploadItemWidget({super.key, required this.properities});
  final UplaodItemProperities properities;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60.h,
      child: Card(
        shape: BeveledRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(8.r))),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            ConstrainedBox(
              constraints: BoxConstraints(minWidth: 220.w, maxWidth: 220.w),
              child: Text(
                properities.title + properities.index.toString(),
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
            ),
            Text(
              "${properities.progress.toStringAsFixed(2)}%",
            ),
            properities.status == UploadStatus.loading
                ? CircularProgressIndicator(
                    constraints: BoxConstraints(
                        minHeight: 20.r,
                        minWidth: 20.r,
                        maxHeight: 20.r,
                        maxWidth: 20.r),
                  )
                : properities.status == UploadStatus.waiting
                    ? const Icon(Icons.hourglass_empty_rounded)
                    : const Icon(Icons.check_rounded)
          ],
        ),
      ),
    );
  }
}

class UplaodItemProperities {
  final String title;
  final int index;
  UploadStatus status;
  double progress;

  UplaodItemProperities(this.title, this.index,
      {this.status = UploadStatus.waiting, this.progress = 0});
}

enum UploadStatus { waiting, loading, finished }
