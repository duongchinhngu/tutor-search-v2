import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:tutor_search_system/commons/colors.dart';
import 'package:tutor_search_system/commons/styles.dart';
import 'package:tutor_search_system/models/feedback.dart';

class FeedbackCard extends StatelessWidget {
  final Feedbacks feedbacks;

  const FeedbackCard({Key key, @required this.feedbacks}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 10,
        ),
        //
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //avatar
            Expanded(
              flex: 2,
              child: CircleAvatar(
                backgroundImage: NetworkImage(feedbacks.tuteeAvatarUrl),
                radius: 30,
              ),
            ),
            //
            Expanded(
              flex: 5,
              child: Container(
                padding: EdgeInsets.only(top: 10, left: 5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //name tutee
                    Text(
                      feedbacks.tuteeName,
                      style: headerStyle,
                    ),
                    //studied
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          'studied ',
                          style: TextStyle(
                              fontSize: textFontSize, color: textGreyColor),
                        ),
                        Text(
                          feedbacks.subjectName + ' ' + feedbacks.className,
                          style: TextStyle(
                              fontSize: headerFontSize-2, color: textGreyColor),
                        ),
                      ],
                    ),
                    //rate star
                    Container(
                      child: RatingBar.builder(
                        ignoreGestures: true,
                        initialRating: feedbacks.rate,
                        minRating: 1,
                        direction: Axis.horizontal,
                        allowHalfRating: false,
                        itemCount: 5,
                        itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                        itemBuilder: (context, _) => Icon(
                          Icons.star,
                          color: Colors.amber,
                        ),
                        itemSize: 20,
                        onRatingUpdate: (double value) {},
                      ),
                    ),
                    //content
                    Container(
                      padding: EdgeInsets.symmetric(vertical: 10),
                      child: Text(feedbacks.comment),
                    )
                  ],
                ),
              ),
            ),
            //createdDate
            Expanded(
              flex: 2,
              child: Container(
                  padding: EdgeInsets.only(top: 15),
                  child: Text(
                    feedbacks.createdDate.substring(0, 10),
                    style: textStyle,
                  )),
            )
          ],
        ),
        //
        Divider(
          indent: 20,
          endIndent: 30,
        )
      ],
    );
  }
}
