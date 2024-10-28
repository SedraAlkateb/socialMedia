import 'package:flutter/material.dart';
import 'package:untitled11/presentation/resources/color_manager.dart';
import 'package:untitled11/presentation/resources/font_manager.dart';
import 'package:untitled11/presentation/resources/style_manage.dart';
import 'package:untitled11/presentation/resources/values_manager.dart';

//presentation
ThemeData getApplicationTheme() {
  return ThemeData(
    fontFamily: 'Cairo',
    scaffoldBackgroundColor: ColorManager.mainColor,
    tabBarTheme: TabBarTheme(
      labelColor: ColorManager.mainColor,
        unselectedLabelColor: ColorManager.white
    ),
    primaryColor: ColorManager.mainColor,
    brightness: Brightness.light,
    colorScheme: ColorScheme.light(
      primary: ColorManager.mainColor,
    ),
    cardTheme: CardTheme(
      shadowColor: ColorManager.shadowCard,
      elevation: AppSize.s4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppSize.s18),
      ),
    ),
    appBarTheme: AppBarTheme(
    //  color: ColorManager.mainColor,
      iconTheme: IconThemeData(
        color: ColorManager.white,
      ),
      toolbarHeight: 40,
      backgroundColor: ColorManager.mainColor,
    ),
    buttonTheme: ButtonThemeData(
      shape: const StadiumBorder(),
      disabledColor: ColorManager.grey1,
      buttonColor: ColorManager.white,
      splashColor: ColorManager.grey,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: AppPadding.p28, vertical: AppPadding.p5),
        textStyle: getMediumStyle(color: ColorManager.white, fontSize: FontSize.s20),
        shadowColor: ColorManager.grey,
        backgroundColor: ColorManager.mainColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSize.s20),
        ),
      ),
    ),


    inputDecorationTheme: InputDecorationTheme(
      contentPadding: const EdgeInsets.all(AppPadding.p12),
      hintStyle: getRegularStyle(color: ColorManager.hintGrey, fontSize: FontSize.s20),
      labelStyle: getMediumStyle(color: ColorManager.black, fontSize: FontSize.s22),

      errorStyle: getRegularStyle(color: ColorManager.error),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: ColorManager.black, width: AppSize.s1_5),
        borderRadius: const BorderRadius.all(Radius.circular(AppSize.s16)),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: ColorManager.primaryField, width: AppSize.s1_5),
        borderRadius: const BorderRadius.all(Radius.circular(AppSize.s16)),
      ),
      errorBorder: OutlineInputBorder(
        borderSide: BorderSide(color: ColorManager.error, width: AppSize.s0_5),
        borderRadius: const BorderRadius.all(Radius.circular(AppSize.s16)),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderSide: BorderSide(color: ColorManager.primaryField, width: AppSize.s1_5),
        borderRadius: const BorderRadius.all(Radius.circular(AppSize.s16)),
      ),
      fillColor: ColorManager.grey,
      filled: true
    ),
    textSelectionTheme: const TextSelectionThemeData(
      cursorColor: Colors.black, // تعيين لون المؤشر هنا
    ),
  );
}
