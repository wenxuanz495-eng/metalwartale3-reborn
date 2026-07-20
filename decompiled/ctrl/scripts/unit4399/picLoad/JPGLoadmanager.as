package unit4399.picLoad
{
   import flash.system.LoaderContext;
   import flash.utils.Dictionary;
   
   public class JPGLoadmanager
   {
      
      private static var THREAD_COUNT:Number = 1;
      
      private static var _count:int = 0;
      
      private static var _current:Dictionary = new Dictionary();
      
      private static var _list:Array = new Array();
      
      public function JPGLoadmanager()
      {
         super();
      }
      
      public static function get list() : Array
      {
         return _list;
      }
      
      public static function canStart(param1:IJPGLoader) : Boolean
      {
         return _current[param1] == true;
      }
      
      public static function loadJPG(param1:String, param2:Function = null, param3:Object = null, param4:LoaderContext = null, param5:int = 2) : JPGLoader
      {
         var _loc6_:JPGLoader = new JPGLoader(param1,param2,param3,param4,param5);
         manageLoader(_loc6_);
         return _loc6_;
      }
      
      public static function manageLoader(param1:IJPGLoader) : void
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
      
      public static function BeginLoader(param1:IJPGLoader) : void
      {
         _current[param1] = true;
         ++_count;
         param1.loadSync();
      }
      
      public static function EndLoader(param1:IJPGLoader) : void
      {
         if(_current[param1])
         {
            delete _current[param1];
            --_count;
            tryStartNext();
         }
      }
      
      public static function CancelLoader(param1:IJPGLoader) : void
      {
         var _loc2_:int = 0;
         while(_loc2_ < _list.length)
         {
            if(_list[_loc2_] == param1)
            {
               _list.splice(_loc2_,1);
            }
            _loc2_++;
         }
         if(param1.isStarted())
         {
            EndLoader(param1);
         }
      }
   }
}

