package unit4399.road.loader
{
   import flash.net.URLVariables;
   import flash.utils.Dictionary;
   
   public class LoaderManager
   {
      
      private static var THREAD_COUNT:Number = 1;
      
      private static var _count:int = 0;
      
      private static var _current:Dictionary = new Dictionary();
      
      private static var _list:Array = new Array();
      
      public function LoaderManager()
      {
         super();
      }
      
      public static function get list() : Array
      {
         return _list;
      }
      
      public static function canStart(param1:ILoader) : Boolean
      {
         return _current[param1] == true;
      }
      
      public static function loadDisplay(param1:String, param2:Function = null) : DisplayLoader
      {
         var _loc3_:* = new DisplayLoader(param1,param2);
         manageLoader(_loc3_);
         return _loc3_;
      }
      
      public static function loadBytes(param1:String, param2:Function, param3:URLVariables = null, param4:String = "POST") : BytesLoader
      {
         var _loc5_:BytesLoader = new BytesLoader(param1,param2,param3,param4);
         manageLoader(_loc5_);
         return _loc5_;
      }
      
      public static function manageLoader(param1:ILoader) : void
      {
         var _loc2_:int = 0;
         while(_loc2_ < _list.length)
         {
            if(_list[_loc2_] == param1)
            {
               return;
            }
            _loc2_++;
         }
         _list.push(param1);
         tryStartNext();
      }
      
      private static function tryStartNext() : void
      {
         if(_list.length <= 0)
         {
            return;
         }
         if(_count < THREAD_COUNT)
         {
            BeginLoader(_list.shift());
         }
      }
      
      public static function BeginLoader(param1:ILoader) : void
      {
         _current[param1] = true;
         ++_count;
         param1.loadSync();
      }
      
      public static function EndLoader(param1:ILoader) : void
      {
         if(_current[param1])
         {
            delete _current[param1];
            --_count;
            tryStartNext();
         }
      }
      
      public static function CancelLoader(param1:ILoader) : void
      {
         var _loc2_:int = 0;
         if(param1.isStarted())
         {
            EndLoader(param1);
         }
         else
         {
            _loc2_ = 0;
            while(_loc2_ < _list.length)
            {
               if(_list[_loc2_] == param1)
               {
                  _list.splice(_loc2_,1);
               }
               _loc2_++;
            }
         }
      }
   }
}

