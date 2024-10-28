import 'package:firebase_core/firebase_core.dart';
import 'package:untitled11/data/network/failure.dart';
import 'package:sqflite/sqflite.dart';

class ErrorHandler implements Exception{
late Failure failure;
ErrorHandler.handle(dynamic error){
   if(error is DatabaseException ){
     print(error.toString());
    failure=_handleErrorSql(error);
  }else if(error is FormatException){
     print(error.toString());
    failure=Failure(0, error.message);
  }else if(error is FirebaseException){
     print(error.toString());
    print("Firebase Error: ${error.message}");
    failure = _handleFirebaseError(error);
  }
  else{
    print(error);
    // default error
    failure=DataSource.DEFAULT.getFailure();
  }
}
}
 Failure _handleFirebaseError(FirebaseException error) {
if (error.code == 'permission-denied') {
return DataSource.PERMISSION_DENIED.getFailure();
} else if (error.code == 'not-found') {
return DataSource.NOT_FOUND.getFailure();
} else if (error.code == 'already-exists') {
return DataSource.ALREADY_EXISTS.getFailure();
} else if (error.code == 'unavailable') {
return DataSource.SERVICE_UNAVAILABLE.getFailure();
} else if (error.code == 'invalid-argument') {
return DataSource.INVALID_ARGUMENT.getFailure();
} else if (error.code == 'deadline-exceeded') {
return DataSource.TIMEOUT.getFailure();
} else {
// Default Firebase error
return DataSource.DEFAULT.getFailure();
}
}

Failure _handleErrorSql(DatabaseException error) {
  String errorMessage = error.result.toString();
  if (errorMessage.contains("no such table")) {
    return DataSource.TABLE_NOT_FOUND.getFailure();
  } else if (errorMessage.contains("syntax error")) {
    return DataSource.SYNTAX_ERROR.getFailure();
  } else if (errorMessage.contains("constraint failed")) {
    return DataSource.CONSTRAINT_VIOLATION.getFailure();
  } else if (errorMessage.contains("database is locked")) {
    return DataSource.DB_LOCKED.getFailure();
  } else if (errorMessage.contains("readonly database")) {
    return DataSource.READ_ONLY.getFailure();
  } else {
    return DataSource.DEFAULT.getFailure();
  }
}


enum DataSource {
  TIMEOUT,
  ALREADY_EXISTS,
  INVALID_ARGUMENT,
  SERVICE_UNAVAILABLE,
  PERMISSION_DENIED,
  TABLE_NOT_FOUND,
  SYNTAX_ERROR,
  CONSTRAINT_VIOLATION,
  DB_LOCKED,
  READ_ONLY,
  SUCCESS,
  NO_CONTENT,
  BAD_REQUEST,
  FORBIDDEN,
  UNAUTORISED,
  NOT_FOUND,
  INTERNAL_SERVER_ERROR,
//  Unprocessable_Content,

  CONNECT_TIOMOUT,
  CANCEL,
  RECIEVE_TIMEOUT,
  SEND_TIMOUT,
  CACHE_ERROR,

  NO_INTERNET_CONNECTION,
  DEFAULT,
}

extension DataSouceExtension on DataSource{
Failure  getFailure(){
   switch(this){
     case DataSource.SUCCESS:
       return Failure(ResponseCode.SUCCESS, ResponseMassage.SUCCESS);
     case DataSource.NO_CONTENT:
       return Failure(ResponseCode.NO_CONTENT, ResponseMassage.NO_CONTENT);

     case DataSource.BAD_REQUEST:
       return Failure(ResponseCode.BAD_REQUEST, ResponseMassage.BAD_REQUEST);

     case DataSource.FORBIDDEN:
       return Failure(ResponseCode.FORBIDDEN, ResponseMassage.FORBIDDEN);

     case DataSource.UNAUTORISED:
       return Failure(ResponseCode.UNAUTORISED, ResponseMassage.UNAUTORISED);

     case DataSource.NOT_FOUND:
       return Failure(ResponseCode.NOT_FOUND, ResponseMassage.NOT_FOUND);

     case DataSource.INTERNAL_SERVER_ERROR:
       return Failure(ResponseCode.INTERNAL_SERVER_ERROR, ResponseMassage.INTERNAL_SERVER_ERROR);

     case DataSource.CONNECT_TIOMOUT:
       return Failure(ResponseCode.CONNECT_TIOMOUT, ResponseMassage.CONNECT_TIOMOUT);

     case DataSource.CANCEL:
       return Failure(ResponseCode.CANCEL, ResponseMassage.CANCEL);

     case DataSource.RECIEVE_TIMEOUT:
       return Failure(ResponseCode.RECIEVE_TIMEOUT, ResponseMassage.RECIEVE_TIMEOUT);

     case DataSource.SEND_TIMOUT:
       return Failure(ResponseCode.SEND_TIMOUT, ResponseMassage.SEND_TIMOUT);

     case DataSource.CACHE_ERROR:
       return Failure(ResponseCode.CACHE_ERROR, ResponseMassage.CACHE_ERROR);

     case DataSource.NO_INTERNET_CONNECTION:
       return Failure(ResponseCode.NO_INTERNET_CONNECTION, ResponseMassage.NO_INTERNET_CONNECTION);
     case DataSource.DEFAULT:
       return Failure(ResponseCode.DEFAULT, ResponseMassage.DEFAULT);


     case DataSource.TABLE_NOT_FOUND:
       return Failure(ResponseCode.TABLE_NOT_FOUND, ResponseMassage.TABLE_NOT_FOUND);
     case DataSource.SYNTAX_ERROR:
       return Failure(ResponseCode.SYNTAX_ERROR, ResponseMassage.SYNTAX_ERROR);
     case DataSource.CONSTRAINT_VIOLATION:
       return Failure(ResponseCode.CONSTRAINT_VIOLATION, ResponseMassage.CONSTRAINT_VIOLATION);
     case DataSource.DB_LOCKED:
       return Failure(ResponseCode.DB_LOCKED, ResponseMassage.DB_LOCKED);
     case DataSource.READ_ONLY:
       return Failure(ResponseCode.READ_ONLY, ResponseMassage.READ_ONLY);
     case DataSource.TIMEOUT:
       return Failure(ResponseCode.TIMEOUT, ResponseMassage.TIMEOUT);
     case DataSource.INVALID_ARGUMENT:
       return Failure(ResponseCode.INVALID_ARGUMENT, ResponseMassage.INVALID_ARGUMENT);
     case DataSource.SERVICE_UNAVAILABLE:
       return Failure(ResponseCode.SERVICE_UNAVAILABLE, ResponseMassage.SERVICE_UNAVAILABLE);
     case DataSource.PERMISSION_DENIED:
       return Failure(ResponseCode.PERMISSION_DENIED, ResponseMassage.PERMISSION_DENIED);
     case DataSource.ALREADY_EXISTS:
       return Failure(ResponseCode.ALREADY_EXISTS, ResponseMassage.ALREADY_EXISTS);
   }
  }
}
class ResponseCode{
  static const int ALREADY_EXISTS =-13;//success with data
  static const int SERVICE_UNAVAILABLE =-16;//success with data
  static const int INVALID_ARGUMENT =-17;//success with data

  static const int SUCCESS =200;//success with data
  static const int NO_CONTENT =201;//success with no data (no content)
  static const int BAD_REQUEST =400;//failure ,Api rejected request
  static const int UNAUTORISED =401;//failure,user is not authorised
  static const int FORBIDDEN =403;//failure ,Api rejected request
  static const int NOT_FOUND=404;
 // static const int Unprocessable_Content =422;//success with no data (no content)

  static const int INTERNAL_SERVER_ERROR =500;//failure,crash in server side
//local status code

  static const int CONNECT_TIOMOUT =-1;//
  static const int CANCEL =-2;//
  static const int RECIEVE_TIMEOUT =-3;//
  static const int SEND_TIMOUT =-4;//
  static const int CACHE_ERROR =-5;//
  static const int NO_INTERNET_CONNECTION =-6;//
  static const int SYNTAX_ERROR =-7;//
  static const int READ_ONLY =-8;//
  static const int DB_LOCKED =-9;//
  static const int TABLE_NOT_FOUND =-10;//
  static const int CONSTRAINT_VIOLATION =-11;//
  static const int TIMEOUT =-12;//
  static const int DEFAULT=-13;
  static const int PERMISSION_DENIED=-14;

}
class ResponseMassage{
  static const String PERMISSION_DENIED ="PERMISSION_DENIED";//success with data
  static const String ALREADY_EXISTS ="ALREADY_EXISTS";//success with data
  static const String SERVICE_UNAVAILABLE ="SERVICE_UNAVAILABLE";//success with data
  static const String INVALID_ARGUMENT ="INVALID_ARGUMENT";//success with data

  static const String TABLE_NOT_FOUND ="TABLE_NOT_FOUND";//success with data
  static const String DB_LOCKED ="DB_LOCKED";//success with data
  static const String READ_ONLY ="READ_ONLY";//success with data
  static const String SYNTAX_ERROR ="SYNTAX_ERROR";//success with data
  static const String CONSTRAINT_VIOLATION ="CONSTRAINT_VIOLATION";//success with data
  static const String TIMEOUT ="time out error";//success with data

  static const String SUCCESS ="success";//success with data
  static const String NO_CONTENT ="success";//success with no data (no content)
  static const String BAD_REQUEST ="Bad request ,Try again later";//failure ,Api rejected request
  static const String UNAUTORISED ="User is unauthorised,Try again later";//failure,user is not authorised
  static const String FORBIDDEN ="Forbidden request ,Try again later";//failure ,Api rejected request
  static const String INTERNAL_SERVER_ERROR ="حدث خطأ, يرجى اعادة المحاولة";//failure,crash in server side
  static const String NOT_FOUND="Forbidden request ,Try again later";
 // static const String Unprocessable_Content ="Unprocessable Content";//success with no data (no content)

//local status code

  static const String CONNECT_TIOMOUT ="Time out error,Try again later";
  static const String CANCEL ="Request was cancelled ,Try again later";
  static const String RECIEVE_TIMEOUT ="Time out error ,Try again later";
  static const String SEND_TIMOUT ="Time out error ,Try again later";
  static const String CACHE_ERROR ="Cache error ,Try again later";
  static const String NO_INTERNET_CONNECTION ="Please check your internet connection";
  static const String DEFAULT ="حدث خطأ, يرجى اعادة المحاولة";

}
class ApiInternalStatus{
  static const int SUCCESS =200;
  static const int FAILURE=0;
}