package unit4399.road.loader
{
   import flash.net.URLVariables;
   import flash.utils.ByteArray;
   import flash.utils.Dictionary;
   
   public class LoaderManager
   {
      
      private static var _version:String;
      
      private static var _cache:Dictionary;
      
      private static var _files:Object;
      
      private static var _changed:Boolean;
      
      private static var THREAD_COUNT:Number = 1;
      
      private static var _count:int = 0;
      
      private static var _current:Dictionary = new Dictionary();
      
      private static var _list:Array = new Array();
      
      private static var _retryCount:int = 0;
      
      private static var _cacheFile:Boolean = false;
      
      private static const LOCAL_FILE:String = "34399/files";
      
      private static const _reg1:RegExp = /http:\/\/[\w|.|:]+\//i;
      
      private static const _reg2:RegExp = /[:|.|\/]/g;
      
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
      
      public static function setup() : void
      {
         _cacheFile = false;
         _cache = new Dictionary();
         loadFilesInLocal();
      }
      
      private static function loadFilesInLocal() : void
      {
         try
         {
            if(_files == null)
            {
               _files = new Object();
               _version = "-1";
               _files["version"] = _version;
               _cacheFile = false;
            }
            else
            {
               _version = _files["version"];
               _cacheFile = true;
            }
         }
         catch(e:Error)
         {
         }
      }
      
      public static function clearCache() : void
      {
      }
      
      public static function set version(param1:String) : void
      {
         _version = param1;
         _files["version"] = param1;
      }
      
      public static function get version() : String
      {
         return _version;
      }
      
      public static function get cacheAble() : Boolean
      {
         return _cacheFile;
      }
      
      public static function set cacheAble(param1:Boolean) : void
      {
         _cacheFile = param1;
      }
      
      private static function getPath(param1:String) : String
      {
         var _loc2_:int = param1.indexOf("?");
         if(_loc2_ != -1)
         {
            param1 = param1.substring(0,_loc2_);
         }
         param1 = param1.replace(_reg1,"");
         return param1.replace(_reg2,"-");
      }
      
      public static function cacheFile(param1:String, param2:ByteArray, param3:Boolean) : void
      {
         var _loc4_:String = null;
         if(_files)
         {
            _loc4_ = getPath(param1);
            if(param3)
            {
               _cache[_loc4_] = param2;
               _files[_loc4_] = param2;
            }
            _changed = true;
         }
      }
      
      public static function cacheXML(param1:XML) : void
      {
         _files["ctrl_xml"] = param1;
      }
      
      public static function get ctrlXML() : XML
      {
         return _files["ctrl_xml"];
      }
      
      public static function loadCachedFile(param1:String, param2:Boolean) : ByteArray
      {
         return null;
      }
   }
}

