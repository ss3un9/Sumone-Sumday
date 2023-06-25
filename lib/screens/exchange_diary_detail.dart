import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sumday/models/comment_model.dart';
import 'package:sumday/providers/exchange_diary_list_provider.dart';
import 'package:sumday/providers/loginProvider.dart';
import 'package:sumday/utils/variables.dart';
import 'package:sumday/widgets/appbar.dart';
import 'package:sumday/widgets/comment_widget.dart';

class ExchangeDiaryDetail extends StatelessWidget {
  final int idx;
  final String diaryId;
  final String content;
  final List<dynamic> comments;
  final List<dynamic> tags;
  final String location;
  final DateTime date;
  final String writer;
  final String photo;
  const ExchangeDiaryDetail({
    super.key,
    required this.idx,
    required this.diaryId,
    required this.content,
    required this.comments,
    required this.tags,
    required this.location,
    required this.date,
    required this.writer,
    required this.photo,
  });

  @override
  Widget build(BuildContext context) {
    const weekDayName = ["월", "화", "수", "목", "금", "토", "일"];
    final dateString =
        "${date.year}년 ${date.month}월 ${date.day}일 (${weekDayName[date.weekday - 1]})";
    final commentController = TextEditingController();
    final userData = Provider.of<LoginProvider>(context);
    final user = userData.userInformation;

    // 코멘트 카드 렌더링하는 코드
    final items = List.generate(comments.length, (index) {
      return CommentWidget(
        photo: comments[index]["ownerPhoto"],
        ownerId: comments[index]["ownerId"],
        ownerName: comments[index]["ownerName"],
        content: comments[index]["content"],
        createdAt: comments[index]["createdAt"].toDate(),
      );
    });

    return Scaffold(
      appBar: MyAppBar(
        title: "${writer.substring(0, 5)}님의 일기",
        appBar: AppBar(),
      ),
      body: Container(
        decoration: BoxDecoration(
          color: AppColors.exchangeBackGroudColor(),
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: AppColors.backgroundGreyColor(),
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(15),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                const Icon(
                                  Icons.place_outlined,
                                  size: 32,
                                ),
                                Text(
                                  location,
                                  style: const TextStyle(
                                    fontSize: 20,
                                  ),
                                ),
                              ],
                            ),
                            IconButton(
                              onPressed: () {},
                              icon: const Icon(
                                Icons.favorite_border,
                                color: Colors.red,
                                size: 32,
                              ),
                            ),
                          ],
                        ),
                        ClipRRect(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(10)),
                          child: Image.asset(
                            "assets/$photo",
                            width: double.maxFinite,
                            height: 185,
                            fit: BoxFit.fitWidth,
                            alignment: Alignment.center,
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          // 향후 스타일 추가하겠음
                          children: [
                            for (String tag in tags)
                              Text(
                                "#$tag  ",
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              dateString,
                              style: TextStyle(
                                fontSize: 16,
                                color: AppColors.fontDarkGreyColor(),
                              ),
                            ),
                            Text(
                              "by. ${writer.substring(0, 5)}",
                              style: TextStyle(
                                  fontSize: 16,
                                  color: AppColors.fontSecondaryColor()),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  width: double.maxFinite,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: AppColors.backgroundGreyColor(),
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 20,
                      horizontal: 10,
                    ),
                    child: Text(content),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                // 댓글 섹션
                Flexible(
                  fit: FlexFit.loose,
                  child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: items.length,
                      itemBuilder: (context, index) {
                        return items[index];
                      }),
                ),
                Row(
                  children: [
                    SizedBox(
                      width: 250,
                      height: 40,
                      child: TextField(
                        controller: commentController,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          contentPadding: EdgeInsets.symmetric(vertical: 5),
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        String commentText = commentController.text;
                        CommentModel comment = CommentModel(
                          ownerId: user!.uid,
                          ownerName: user.uid.substring(0, 5),
                          // 임시로 하드코딩 했습니다.
                          ownerPhoto: "sorry.png",
                          content: commentText,
                          createdAt: Timestamp.now(),
                        );

                        Provider.of<ExchangeDiaryListProvider>(context,
                                listen: false)
                            .addComments(diaryId, idx, comment);
                        FocusScopeNode currentFocus = FocusScope.of(context);

                        if (!currentFocus.hasPrimaryFocus) {
                          currentFocus.unfocus();
                        }
                      },
                      icon: Icon(
                        Icons.send,
                        color: AppColors.fontGreyColor(),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
