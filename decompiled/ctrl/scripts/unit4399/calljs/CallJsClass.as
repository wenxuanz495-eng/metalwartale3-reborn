package unit4399.calljs
{
   import flash.external.ExternalInterface;
   
   public class CallJsClass
   {
      
      private static var _callBackObj:Object;
      
      private static var _callBackFunc:String;
      
      public function CallJsClass()
      {
         super();
      }
      
      public static function asCallJsFun(param1:String) : String
      {
         var str:String = null;
         var func:String = param1;
         if(func == null)
         {
            return null;
         }
         if(ExternalInterface.available)
         {
            try
            {
               str = ExternalInterface.call(func);
            }
            catch(e:Error)
            {
               trace("调用js出错");
            }
         }
         return str;
      }
      
      public static function jsCallAsFun(param1:String, param2:Object, param3:String) : void
      {
         var func:String = param1;
         var callBackObj:Object = param2;
         var callBackFunc:String = param3;
         if(func == null || callBackObj == null || callBackFunc == null)
         {
            return;
         }
         _callBackObj = callBackObj;
         _callBackFunc = callBackFunc;
         if(ExternalInterface.available)
         {
            try
            {
               ExternalInterface.addCallback(func,_callBackObj[_callBackFunc]);
            }
            catch(e:Error)
            {
               trace("调用js出错");
            }
         }
      }
   }
}

