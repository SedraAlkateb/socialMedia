import 'package:untitled11/presentation/common/state_renderer/state_renderer.dart';
import 'package:untitled11/presentation/common/state_renderer/state_renderer_imp.dart';
import 'package:flutter/cupertino.dart';

void loading(BuildContext context)
{
  LoadingState(
      stateRendererType:
      StateRendererType.popupLoadingState)
      .showPopup(
      context,
      StateRendererType.popupLoadingState,
      "loading");
}
void loadingFullScreen(BuildContext context)
{
  LoadingState(
      stateRendererType:
      StateRendererType.fullScreenLoadingState)
      .showPopup(
      context,
      StateRendererType.fullScreenLoadingState,
      "");
}
void error(BuildContext context,String massage,int code)
{
  ErrorState ( StateRendererType.popupErrorState,
      massage )
      .dismissDialog(context);
  ErrorState(StateRendererType.popupErrorState,
      massage)
      .showPopup(
      context,
      StateRendererType.popupErrorState,
      massage);


}
Widget fullScreenError(BuildContext context,String massage){
 return StateRenderer(stateRendererType: StateRendererType.fullScreenErrorState,
     message: massage, retryActionFunction: (){});
}
void success(BuildContext context){
  ContentState().dismissDialog(context);
}