import 'dio_utils.dart';

class Api {
  static const String sendCode = 'common/sms/smsSend';
  static const String loginPwd = 'user/login';
  static const String loginCode = 'user/loginByCode';
  static const String checkCode = 'user/checkCode';
  static const String setPwd = 'user/findPassword';
  static const String editUserInfo = 'user/';
  static const String petTypeList = 'pet/petType/getPetTypeList';

  static const Map<String, Method> apiMethod = {
    sendCode: Method.post,
    loginPwd: Method.post,
    loginCode: Method.post,
    checkCode: Method.get,
    setPwd: Method.post,
    editUserInfo: Method.post,
    petTypeList:Method.get
  };
}
