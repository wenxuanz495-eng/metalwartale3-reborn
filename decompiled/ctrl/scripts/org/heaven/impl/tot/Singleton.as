package org.heaven.impl.tot
{
   public class Singleton
   {
      
      private static var classMap:Object = {};
      
      public function Singleton()
      {
         super();
      }
      
      public static function getClass(param1:String) : Class
      {
         return classMap[param1];
      }
      
      public static function registerClass(param1:String, param2:Class) : void
      {
         var _loc3_:* = undefined;
         _loc3_ = classMap[param1];
         if(!_loc3_)
         {
            classMap[param1] = param2;
         }
      }
   }
}

