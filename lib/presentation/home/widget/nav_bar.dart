import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled11/presentation/home/bloc/home_bloc.dart';
import 'package:untitled11/presentation/home/pages/home_page.dart';
import 'package:untitled11/presentation/profile/page/profile_page.dart';
import 'package:untitled11/presentation/resources/color_manager.dart';
import 'package:untitled11/presentation/search/page/search_page.dart';
import 'package:untitled11/presentation/stroy/bloc/story_bloc.dart';

class NavPage extends StatelessWidget {
  final List<Widget> bodyList = [  HomePage(),ProfilePage(),SearchPage()];
  final List<String> label = [  "Home","Profile","Search"];

  NavPage({super.key});
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            extendBody: true,
            bottomNavigationBar: _buildBottomNavBar(context),
            body: BlocListener<HomeBloc, HomeState>(
                listener: (context, state) {},
                child: bodyList[context.watch<HomeBloc>().index])));
  }
  Widget _buildBottomNavBar(BuildContext context) {
    return  ClipRRect(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
        child: BottomNavigationBar(
          iconSize: 30,
          type: BottomNavigationBarType.fixed,
          currentIndex: context.read<HomeBloc>().index,
          selectedItemColor: ColorManager.black,
          unselectedItemColor: Colors.grey,
          showUnselectedLabels: false,
          showSelectedLabels: false,

          items:
          <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon:
              context.watch<HomeBloc>().index==0?
              Icon(Icons.home_sharp,color:ColorManager.black,weight: 15):
              const Icon(Icons.home_outlined,color: Colors.grey,weight: 15),
              label: label[0]
            ),
            BottomNavigationBarItem(
              icon:context.read<HomeBloc>().index==1?
              Icon(Icons.search,color: ColorManager.black,weight: 15):
              Icon(Icons.search_outlined,color: Colors.grey,weight: 15),
                label: label[1]
            ),
            BottomNavigationBarItem(
              icon:
              context.watch<HomeBloc>().index==2?
              Icon(Icons.person,color:ColorManager.black,weight: 15):
              const Icon(Icons.person_outline,color: Colors.grey,weight: 15),
                label: label[2]
            ),
          ],
          onTap: (index) {
            BlocProvider.of<HomeBloc>(context).add(ChangeTapNav(index: index));
         //   if(index ==0){
         //     BlocProvider.of<HomeBloc>(context).add(PostsEvent());
          //    BlocProvider.of<StoryBloc>(context).add(StoriesEvent());
          //  }
          },
          //animationCurve: Curves.linear,
        )
    );
  }
}
/*
 BottomNavyBar(
          backgroundColor: whiteColor,
          curve: Curves.easeIn,
          itemCornerRadius: 100,
          iconSize: 20,
          showElevation: true,
          selectedIndex: context.read<HomeBloc>().index,
          onItemSelected: (index) {
            BlocProvider.of<HomeBloc>(context).add(ChangeTapNav(index: index));
            print(index);

            //setState(() => _selectedIndex = index);
          },
          items: <BottomNavyBarItem>[
            BottomNavyBarItem(
              activeColor: primaryColor,
              inactiveColor: secondaryColor,
              title: Text(
                LocaleKeys.home_page.tr(),
                style: TextStyle(color: secondaryColor),
              ),
              icon: Icon(Icons.home_outlined, color: primaryColor),
              textAlign: TextAlign.center,
            ),
            BottomNavyBarItem(
              activeColor: primaryColor,
              inactiveColor: primaryColor,
              title: Text(
                LocaleKeys.profile_page.tr(),
                style: TextStyle(color: secondaryColor),
              ),
              icon: Icon(Icons.person, color: primaryColor),
              textAlign: TextAlign.center,
            ),
            BottomNavyBarItem(
              activeColor: primaryColor,
              inactiveColor: primaryColor,
              title: Text(
                LocaleKeys.setting_page.tr(),
                style: TextStyle(color: secondaryColor),
              ),
              icon: Icon(Icons.settings, color: primaryColor),
              textAlign: TextAlign.center,
            ),
          ],
        )
 */
