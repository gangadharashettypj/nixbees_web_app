/*
 * @Author GS
 */
import 'package:flutter/material.dart';
import 'package:payment_gateway/common_widgets/button_widget.dart';
import 'package:payment_gateway/common_widgets/circular_progress_indicator.dart';
import 'package:payment_gateway/common_widgets/empty_app_bar.dart';
import 'package:payment_gateway/common_widgets/image_widget.dart';
import 'package:payment_gateway/common_widgets/label_widget.dart';
import 'package:payment_gateway/common_widgets/scaffold/scaffold_provider.dart';
import 'package:payment_gateway/resources/colors.dart';
import 'package:payment_gateway/resources/images.dart';
import 'package:payment_gateway/theme/sizes.dart';
import 'package:provider/provider.dart';

class MyScaffold extends StatefulWidget {
  final Widget body;
  final Function(BuildContext context) bodyBuilder;
  final bool showAppBar;
  final Widget appBar;
  final Widget bottomWidget;
  final Widget bottomNavigationBar;
  final Widget floatingActionButton;
  final Color backgroundColor;
  MyScaffold({
    this.body,
    this.bodyBuilder,
    this.showAppBar,
    this.appBar,
    this.bottomWidget,
    this.bottomNavigationBar,
    this.floatingActionButton,
    this.backgroundColor,
  });

  @override
  _MyScaffoldState createState() => _MyScaffoldState();
}

class _MyScaffoldState extends State<MyScaffold> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ScaffoldProvider>(
      create: (_) => ScaffoldProvider(context: context),
      child: Container(
        child: Scaffold(
          backgroundColor: widget.backgroundColor,
          appBar: EmptyAppBar(),
          floatingActionButton: widget.floatingActionButton,
          bottomNavigationBar: widget.bottomNavigationBar,
          bottomSheet: widget.bottomWidget == null
              ? null
              : Container(
                  color: MyColors.neuBackground,
                  child: widget.bottomWidget,
                ),
          body: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              if (widget.appBar != null) widget.appBar,
              Expanded(
                child: Stack(
                  children: [
                    widget.body ?? Container(),
                    Consumer<ScaffoldProvider>(
                        builder: (context, scaffoldProvider, __) {
                      return Visibility(
                        visible: scaffoldProvider.noInternetScreenEnabled,
                        child: Container(
                          child: Center(
                            child: Column(
                              children: [
                                ImageWidget(
                                  imageLocation: MyImages.noInternet,
                                  height:
                                      MediaQuery.of(context).size.height * 0.3,
                                ),
                                LabelWidget(
                                  'No Internet',
                                  size: TextSize.title,
                                ),
                                ButtonWidget(
                                  title: 'Retry',
                                  onPressed: scaffoldProvider.onRetry,
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    }),
                    Consumer<ScaffoldProvider>(
                        builder: (context, scaffoldProvider, __) {
                      return Visibility(
                        visible: scaffoldProvider.errorScreenEnabled,
                        child: Container(
                          child: Center(
                            child: Column(
                              children: [
                                ImageWidget(
                                  imageLocation: MyImages.error,
                                  height:
                                      MediaQuery.of(context).size.height * 0.3,
                                ),
                                LabelWidget(
                                  'Something went wrong, try again after sometime',
                                  size: TextSize.title,
                                ),
                                ButtonWidget(
                                  title: 'Retry',
                                  onPressed: scaffoldProvider.onRetry,
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    }),
                    Consumer<ScaffoldProvider>(
                        builder: (context, scaffoldProvider, __) {
                      return Visibility(
                        visible: scaffoldProvider.customErrorScreenEnabled,
                        child: scaffoldProvider.customErrorWidget ??
                            Container(
                              child: Center(
                                child: Column(
                                  children: [
                                    ImageWidget(
                                      imageLocation: MyImages.error,
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.3,
                                    ),
                                    LabelWidget(
                                      'Something went wrong, try again after sometime',
                                      size: TextSize.title,
                                    ),
                                    ButtonWidget(
                                      title: 'Retry',
                                      onPressed: scaffoldProvider.onRetry,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                      );
                    }),
                    Consumer<ScaffoldProvider>(
                        builder: (context, scaffoldProvider, __) {
                      return Visibility(
                        visible: scaffoldProvider.loaderEnabled,
                        child: Container(
                          color: scaffoldProvider.loaderEnabled
                              ? RawColors.blackTranslucent
                              : null,
                          child: Center(
                            child: CircularProgressIndicatorWidget(),
                          ),
                        ),
                      );
                    })
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
