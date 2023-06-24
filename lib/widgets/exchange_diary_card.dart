import 'package:flutter/material.dart';
import 'package:sumday/screens/exchange_diary_detail.dart';
import 'package:sumday/utils/variables.dart';

class ExchangeDiaryCard extends StatelessWidget {
  final int idx;
  final String diaryId;
  final List<dynamic> tags;
  final DateTime date;
  final String writer;
  final String photo;

  const ExchangeDiaryCard({
    super.key,
    required this.idx,
    required this.diaryId,
    required this.tags,
    required this.date,
    required this.writer,
    required this.photo,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push(context,
          MaterialPageRoute(builder: (context) => const ExchangeDiaryDetail())),
      child: Container(
        height: 300,
        margin: const EdgeInsets.only(bottom: 15),
        decoration: BoxDecoration(
          color: AppColors.backgroundGreyColor(),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.asset(
                  "assets/$photo",
                  width: double.maxFinite,
                  height: 185,
                  fit: BoxFit.fitWidth,
                  alignment: Alignment.center,
                ),
                // child: const Image(
                //   image: AssetImage('assets/images/test/test_image_000.jpg'),
                //   width: double.maxFinite,
                //   height: 185,
                //   fit: BoxFit.fitWidth,
                //   alignment: Alignment.center,
                // ),
              ),
              const SizedBox(
                height: 10,
              ),
              // 추후에 리스트로 하나하나 불러와야 할 듯
              Row(
                children: [
                  for (String tag in tags)
                    Text(
                      "#$tag",
                      style: const TextStyle(fontWeight: FontWeight.w600),
                    ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "${date.year}년 ${date.month}월 ${date.day}일",
                    style: TextStyle(
                      color: AppColors.fontGreyColor(),
                    ),
                  ),
                  Text(
                    "by. ${writer.substring(0, 6)}",
                    style: TextStyle(color: AppColors.fontSecondaryColor()),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
