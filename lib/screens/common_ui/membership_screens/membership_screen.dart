import 'package:flutter/material.dart';
import 'package:tutor_search_system/commons/colors.dart';
import 'package:tutor_search_system/commons/global_variables.dart';
import 'package:tutor_search_system/commons/styles.dart';
import 'package:tutor_search_system/models/membership.dart';
import 'package:tutor_search_system/repositories/membership_repository.dart';
import 'package:tutor_search_system/screens/common_ui/waiting_indicator.dart';
import 'package:tutor_search_system/screens/tutee_screens/course_detail/course_detail_screen.dart';
import '../error_screen.dart';

class MembershipScreen extends StatefulWidget {
  final int currentMembershipId;

  const MembershipScreen({Key key,@required this.currentMembershipId}) : super(key: key);
  @override
  _MembershipScreenState createState() => _MembershipScreenState();
}

class _MembershipScreenState extends State<MembershipScreen>
    with TickerProviderStateMixin {
  TabController _tabController;
  @override
  void initState() {
    super.initState();
  }

  Future<List<Membership>> loadAllActiveMembership() async {
    List<Membership> memberships = await MembershipRepository()
        .fetchMembershipByStatus(StatusConstants.ACTIVE_STATUS);
    return Future.value(memberships);
  }

  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: mainColor,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: backgroundColor,
            size: 15,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        centerTitle: true,
        title: Text(
          'Membership',
        ),
      ),
      body: FutureBuilder(
        future: loadAllActiveMembership(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.hasError) {
            return ErrorScreen();
          } else {
            if (snapshot.hasData) {
              //
              for (var i = 0; i < snapshot.data.length; i++) {
                if( snapshot.data[i] is Membership && snapshot.data[i].id == widget.currentMembershipId){
                  selectedIndex = i;
                  break;
                }
              }
              //
              _tabController = new TabController(
                vsync: this,
                length: snapshot.data.length,
                initialIndex: selectedIndex,
              );
              //
              return Column(
                children: [
                  //
                  TabBar(
                    controller: _tabController,
                    onTap: (index) {},
                    isScrollable: true,
                    unselectedLabelColor: Colors.grey,
                    indicatorColor: mainColor,
                    indicatorSize: TabBarIndicatorSize.label,
                    tabs: List.generate(
                        snapshot.data.length,
                        (index) =>
                            MembershipTabBar(title: snapshot.data[index].name)),
                  ),
                  //
                  Container(
                    color: backgroundColor,
                    height: 500,
                    child: TabBarView(
                      physics: NeverScrollableScrollPhysics(),
                      controller: _tabController,
                      children: List.generate(
                        snapshot.data.length,
                        (index) => MembershipTabBarView(
                            membership: snapshot.data[index]),
                      ),
                    ),
                  )
                ],
              );
            } else {
              return buildLoadingIndicator();
            }
          }
        },
      ),
    );
  }
}

class MembershipTabBar extends StatelessWidget {
  final String title;

  const MembershipTabBar({Key key, @required this.title}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      alignment: Alignment.center,
      color: Colors.white,
      child: Text(
        title,
        style: titleStyle,
      ),
    );
  }
}

//body tab view
class MembershipTabBarView extends StatelessWidget {
  final Membership membership;

  const MembershipTabBarView({Key key, @required this.membership})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        //
        buildCourseInformationListTile(membership.pointRate.toString() + '\%',
            'Point rate', Icons.star_border),
        buildCourseInformationListTile(
            membership.pointAmount.toString() + ' point(s)',
            'Point amount',
            Icons.trending_up_outlined),
        buildCourseInformationListTile(
            membership.description, 'Description', Icons.description),
      ],
    ));
  }
}
