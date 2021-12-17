import 'package:Modda_shop/models/api_base_response.dart';
import 'package:Modda_shop/models/user.dart';

class BaseApiObjectResponse<T> extends ApiBaseResponse{
 // late T object;
 late   T data;

   BaseApiObjectResponse.fromJson(Map<String , dynamic> json):super.fromJson(json){
  if(json.containsKey('data')){
        if(T == User){
          data = User.fromJson(json['data']) as T;
        }
  }
  if(json.containsKey('object')){

  }
   }
}