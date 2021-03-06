import 'package:Yatadabaron/services/initialization-service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'blocs/search-session-bloc.dart';
import 'services/database-provider.dart';
import 'helpers/localization.dart';
import 'helpers/theming.dart';
import 'views/home/home.dart';
import 'views/shared-widgets/loading-widget.dart';
import 'views/splash/splash.dart';
// import 'package:wisebay_essentials/analytics/analytics_helper.dart';

void main() {
  runApp(App());
}

class App extends StatelessWidget {
  //returns a metrial app wrapper for the given widget using the given theme
  Widget materialApp({Widget widget, ThemeData theme}) {
    return MaterialApp(
      theme: theme,
      builder: (BuildContext context, child) {
        return Directionality(
          textDirection: TextDirection.rtl,
          child: child,
        );
      },
      title: Localization.APP_TITLE,
      home: widget,
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
      future: InitializationService.instance.initialize(),
      builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data) {
            return materialApp(
              widget: Provider(
                create: (BuildContext context) => SearchSessionBloc(),
                child: HomePage(),
              ),
              theme: Theming.darkTheme(),
            );
          } else {
            Widget errorWidget = Text(
              Localization.LOADING_ERROR,
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Colors.red, fontWeight: FontWeight.bold, fontSize: 12),
            );
            return materialApp(
              widget: Splash(errorWidget),
              theme: ThemeData.light(),
            );
          }
        } else {
          //Loading please wait
          return materialApp(
            widget: Splash(LoadingWidget()),
            theme: ThemeData.light(),
          );
        }
      },
    );
  }
}
