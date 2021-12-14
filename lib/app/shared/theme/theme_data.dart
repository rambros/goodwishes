import 'package:flutter/material.dart';

ThemeData basicDarkTheme() {

  final base = ThemeData.dark();

  TextTheme _basicTextTheme(TextTheme base) {
    return base.copyWith(
        headline5: base.headline5!.copyWith(
          fontSize: 24.0,
        ),
        headline6: base.headline6!.copyWith(
          fontSize: 16.0,
        ),
        caption: base.caption!.copyWith(
        ),
        bodyText1: base.bodyText1!.copyWith(
          fontSize: 14.0,
          ) 
    ).apply(
      fontFamily: 'Raleway',
    );
  }

  return base.copyWith(
    textTheme: _basicTextTheme(base.textTheme),
    colorScheme: base.colorScheme.copyWith(
      primary: Color( 0xff633692 ),
      //onPrimary: Color(0xff442C2E),
      secondary: Color( 0xff7e45ba ),
      //onSecondary: Color(0xff442C2E),
      error: Color(0xffC5032B),
    ),
    brightness: Brightness.dark,
    toggleableActiveColor: Color(0xFFE79677),
  );
}


///*** Light Theme ***

ThemeData basicLightTheme() {
  TextTheme _basicTextTheme(TextTheme base) {
    return base.copyWith(
        headline5: base.headline5!.copyWith(
          fontSize: 24.0,
          color: Colors.black,
        ),
        headline6: base.headline6!.copyWith(
          fontSize: 16.0,
          color: Colors.black,
        ),
        headline1: base.headline1!.copyWith(
          fontSize: 16.0,
          color: Colors.green
        ),
        headline2: base.headline2!.copyWith(
          fontSize: 16.0,
          color: Colors.green
        ),
        caption: base.caption!.copyWith(
          fontSize: 12.0,
         // color: Color(0xFFCCC5AF),
        ),
        bodyText1: base.bodyText1!.copyWith(
          fontSize: 14.0,
          color: Color(0xFF807A6B)
          ),
        bodyText2: base.bodyText2!.copyWith(
          fontSize: 14.0,
          color: Colors.black,
          ),
    ).apply(
      fontFamily: 'Raleway',
    );
  }

  final base = ThemeData.light();
    return base.copyWith(
      
      textTheme: _basicTextTheme(base.textTheme),
      colorScheme: base.colorScheme.copyWith(
        primary: Color( 0xff633692 ),
        //onPrimary: Color(0xff442C2E),
        secondary: Color( 0xff7e45ba ),
        //onSecondary: Color(0xff442C2E),
        error: Color(0xffC5032B),
      ),
      primaryColorDark: Color( 0xfff57c00 ),

      buttonTheme: base.buttonTheme.copyWith(
          buttonColor: Color( 0xff633692 ),

      ),

      appBarTheme: AppBarTheme(
        color: Color( 0xff633692 ),

        iconTheme: IconThemeData( color: Colors.white,), //Colors.black87,
      )
    );
  
}