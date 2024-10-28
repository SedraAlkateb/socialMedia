import 'package:untitled11/app/constants.dart';
import 'package:untitled11/presentation/common/state_renderer/state_renderer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

abstract class FlowState{
  StateRendererType getStateRendererType();
  String getMessage();
}
//loading state (popup , full screen)
class LoadingState extends FlowState{
  StateRendererType stateRendererType;
   String? message ;
  LoadingState(
      {
        required this.stateRendererType,
        this.message
      }
      );
    @override
  String getMessage() =>message ?? "loading";

  @override
  StateRendererType getStateRendererType() =>stateRendererType;

}
class ErrorState extends FlowState{
  StateRendererType stateRendererType;
  String message ;
  ErrorState(

         this.stateRendererType,
        this.message

      );
  @override
  String getMessage() => message;

  @override
  StateRendererType getStateRendererType() =>stateRendererType;

}
class ContentState extends FlowState{

  ContentState();
  @override
  String getMessage() => Constants.empty;

  @override
  StateRendererType getStateRendererType() =>StateRendererType.contentState;

}
class EmptyState extends FlowState{
  String message ;
  EmptyState(
      this.message
      );
  @override
  String getMessage() =>message ;

  @override
  StateRendererType getStateRendererType() =>
      StateRendererType.fullScreenEmptyState;

}
class SuccessState extends FlowState{
  String message ;
  SuccessState(
      this.message
      );
  @override
  String getMessage() =>message ;

  @override
  StateRendererType getStateRendererType() =>
      StateRendererType.popupSuccess;

}
extension FlowStateExtension on FlowState{
  Widget getScreenWidget(BuildContext context,Widget contentScreenWidget,Function retryActionFunction){
    switch(runtimeType){
      case LoadingState:{
        if(getStateRendererType()==StateRendererType.popupLoadingState){
          //show popup loading
          showPopup(context, getStateRendererType(), getMessage());
          //show content ui of the screen
          return contentScreenWidget;
        }else{
          //full screen state loading
         return StateRenderer(
            message: getMessage(),
              stateRendererType: getStateRendererType(),
              retryActionFunction: retryActionFunction
          );
        }
      }
      case ErrorState :{
        dismissDialog(context);
        if(getStateRendererType()==StateRendererType.popupErrorState){
          //show popup loading
          showPopup(context, getStateRendererType(), getMessage());
          //show content ui of the screen
          return contentScreenWidget;
        }else{
          //full screen state loading
        return  StateRenderer(
              message: getMessage(),
              stateRendererType: getStateRendererType(),
              retryActionFunction: retryActionFunction
          );
        }

      }
      case EmptyState :{
       return StateRenderer(
          stateRendererType: getStateRendererType(),
         message: getMessage(),
         retryActionFunction: (){},
        );
      }
      case SuccessState:{
        dismissDialog(context);
        showPopup(context, StateRendererType.popupSuccess, getMessage()
        ,title:"success"
        );
        //show content ui of the screen
        return contentScreenWidget;

      }
      case ContentState :{
        dismissDialog(context);
        return contentScreenWidget;
      }
      default:{
        dismissDialog(context);
        return contentScreenWidget;
      }
    }

  }
  _isCurrentDialogShowing(BuildContext context)=>ModalRoute.of(context)?.isCurrent != true;
  dismissDialog(BuildContext context){
    if(_isCurrentDialogShowing(context)){
      Navigator.of(context,rootNavigator: true).pop(true);
    }
  }
  showPopup(BuildContext context,StateRendererType stateRendererType,String message,{String title =Constants.empty}){
    WidgetsBinding.instance.addPostFrameCallback((_) =>
    showDialog(
        context: context,
        builder: (BuildContext context)=>
    StateRenderer(
        stateRendererType: stateRendererType,
        message: message,
        retryActionFunction: (){}
    )
    )
    );

  }
}