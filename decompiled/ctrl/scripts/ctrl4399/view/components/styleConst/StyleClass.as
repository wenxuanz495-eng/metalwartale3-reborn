package ctrl4399.view.components.styleConst
{
   import calista.utils.Base64;
   import com.hurlant.crypto.symmetric.DESKey;
   import com.hurlant.crypto.symmetric.ECBMode;
   import flash.external.ExternalInterface;
   import flash.text.StyleSheet;
   import flash.utils.ByteArray;
   
   public class StyleClass
   {
      
      public static const Res_Init_Name:String = "用户名为6-20个字母或数字";
      
      public static const Res_Init_Pwd:String = "长度为6-20个字符,区分大小写";
      
      public static const Res_Init_Mail:String = "请输入有效的邮箱地址或QQ";
      
      public static const Res_Init_Check:String = "请输入";
      
      public static const Res_Init_WX:String = "推荐您使用手机号或QQ号注册";
      
      public static const Res_Init_Pwd_2:String = "请再次输入相同的密码";
      
      public static const Res_Init_Mail_2:String = "没有邮箱的同学可以输入QQ号";
      
      public static const Res_Init_Check_2:String = "请输入验证码";
      
      public static const Res_Error_Pwd:String = "长度为6-20个字符";
      
      public static const Res_Error_Name:String = "用户名已存在";
      
      private static var dateRegExp:RegExp = /(([0-9]{3}[1-9]|[0-9]{2}[1-9][0-9]{1}|[0-9]{1}[1-9][0-9]{2}|[1-9][0-9]{3})-(((0[13578]|1[02])-(0[1-9]|[12][0-9]|3[01]))|((0[469]|11)-(0[1-9]|[12][0-9]|30))|(02-(0[1-9]|[1][0-9]|2[0-8]))))|((([0-9]{2})(0[48]|[2468][048]|[13579][26])|((0[48]|[2468][048]|[3579][26])00))-02-29)/;
      
      private static var timeRegExp:RegExp = /([01][0-9]|2[0-3]):[0-5][0-9]:[0-5][0-9]/;
      
      public function StyleClass()
      {
         super();
      }
      
      public static function checkspace(param1:String) : String
      {
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         var _loc2_:String = "";
         var _loc3_:String = param1;
         var _loc4_:int = 0;
         while(_loc4_ < _loc3_.length)
         {
            if(_loc3_.charAt(_loc4_) != " ")
            {
               break;
            }
            _loc6_ = _loc4_ + 1;
            while(_loc6_ < _loc3_.length)
            {
               _loc2_ += _loc3_.charAt(_loc6_);
               _loc6_++;
            }
            _loc3_ = _loc2_;
            _loc2_ = "";
            _loc4_ = -1;
            _loc4_++;
         }
         var _loc5_:* = int(_loc3_.length - 1);
         while(_loc5_ >= 0)
         {
            if(_loc3_.charAt(_loc5_) != " ")
            {
               break;
            }
            _loc7_ = 0;
            while(_loc7_ < _loc5_)
            {
               _loc2_ += _loc3_.charAt(_loc7_);
               _loc7_++;
            }
            _loc3_ = _loc2_;
            _loc2_ = "";
            _loc5_--;
         }
         return _loc3_;
      }
      
      public static function userNameLinkStyle() : StyleSheet
      {
         var _loc1_:StyleSheet = new StyleSheet();
         _loc1_.setStyle("a:hover",{"textDecoration":"underline"});
         return _loc1_;
      }
      
      public static function creatDateFun(param1:String) : String
      {
         var _loc2_:String = "error";
         param1 = checkspace(param1);
         var _loc3_:Array = param1.split("|");
         if(_loc3_.length != 2)
         {
            return _loc2_;
         }
         var _loc4_:String = checkspace(_loc3_[0]);
         var _loc5_:String = checkspace(_loc3_[1]);
         if(dateRegExp.test(_loc4_) && timeRegExp.test(_loc5_))
         {
            _loc2_ = _loc4_ + " " + _loc5_;
         }
         return _loc2_;
      }
      
      public static function checkDateTimeFun(param1:String, param2:String) : Boolean
      {
         var _loc11_:String = null;
         var _loc3_:Boolean = false;
         var _loc4_:Array = param1.split(" ");
         var _loc5_:Array = String(_loc4_[0]).split("-");
         var _loc6_:Array = String(_loc4_[1]).split(":");
         var _loc7_:Array = param2.split(" ");
         var _loc8_:Array = String(_loc7_[0]).split("-");
         var _loc9_:Array = String(_loc7_[1]).split(":");
         var _loc10_:String = compareFun(_loc5_,_loc8_);
         if(_loc10_ == "0")
         {
            _loc11_ = compareFun(_loc6_,_loc9_);
            if(_loc11_ == "1")
            {
               _loc3_ = true;
            }
            else
            {
               _loc3_ = false;
            }
         }
         else if(_loc10_ == "1")
         {
            _loc3_ = true;
         }
         else
         {
            _loc3_ = false;
         }
         return _loc3_;
      }
      
      private static function compareFun(param1:Array, param2:Array) : String
      {
         var _loc3_:String = "-1";
         if(param1 == null || param2 == null || param1.length != param2.length)
         {
            return _loc3_;
         }
         var _loc4_:int = int(param1.length);
         var _loc5_:int = 0;
         while(_loc5_ < _loc4_)
         {
            if(int(param1[_loc5_]) < int(param2[_loc5_]))
            {
               _loc3_ = "1";
               break;
            }
            if(int(param1[_loc5_]) != int(param2[_loc5_]))
            {
               _loc3_ = "-1";
               break;
            }
            if(_loc5_ == _loc4_ - 1)
            {
               _loc3_ = "0";
               break;
            }
            _loc5_++;
         }
         return _loc3_;
      }
      
      public static function getHref() : String
      {
         if(!ExternalInterface.available)
         {
            return null;
         }
         try
         {
            return ExternalInterface.call("eval","window.location.href");
         }
         catch(e:Error)
         {
            return null;
         }
      }
      
      public static function ecbDecrypt(param1:String) : String
      {
         var _loc2_:ByteArray = Base64.decodeToByteArray(param1);
         var _loc3_:String = "4399api_";
         var _loc4_:ByteArray = new ByteArray();
         _loc4_.writeUTFBytes(_loc3_);
         var _loc5_:DESKey = new DESKey(_loc4_);
         var _loc6_:ECBMode = new ECBMode(_loc5_);
         _loc6_.decrypt(_loc2_);
         return convertByteArrayToString(_loc2_);
      }
      
      private static function convertByteArrayToString(param1:ByteArray) : String
      {
         var _loc2_:String = null;
         if(param1)
         {
            param1.position = 0;
            _loc2_ = param1.readUTFBytes(param1.length);
         }
         return _loc2_;
      }
   }
}

