package ctrl4399.proxy
{
   import ctrl4399.strconst.AllConst;
   import flash.events.Event;
   import frame4399.simplePureMvc.core.Facade;
   import unit4399.road.loader.LoaderManager;
   
   public class LogData
   {
      
      private static const URL:String = "https://stat.api.4399.com/archive_status/log.js?";
      
      public static const API_SECONDARY:String = "secondary";
      
      public static const API_SCORE:String = "score";
      
      public static const API_SAVE:String = "save";
      
      public static const API_RECOMMEND:String = "recommend";
      
      public static const API_MALL:String = "mall";
      
      public static const API_SHOP:String = "shop";
      
      public static const API_RANK_LIST:String = "rankList";
      
      public static const API_UNION:String = "union";
      
      public static const API_OTHER:String = "other";
      
      private static const TIMEOUT:Number = 5 * 1000;
      
      private static const ERROR_TIME_OUT:String = "0";
      
      private static const ERROR_IO:String = "900";
      
      private static const ERROR_SECURITY:String = "901";
      
      private var _gameId:String;
      
      private var _userId:String;
      
      private var _startTime:Date;
      
      private var _endTime:Date;
      
      private var _apiName:String;
      
      private var _method:String;
      
      private var _exception:String = "";
      
      private var _code:String = "999";
      
      private var _isSubmit:Boolean = false;
      
      public function LogData(param1:String, param2:String)
      {
         super();
         var _loc3_:MainProxy = Facade.getInstance().retrieveProxy(AllConst.PROXY_NAME_MAIN) as MainProxy;
         this._gameId = _loc3_.gameID;
         this._userId = _loc3_.userID;
         this._startTime = new Date();
         this._apiName = param1;
         this._method = param2;
         this._isSubmit = false;
      }
      
      public function submit(param1:Boolean = false) : void
      {
         this._isSubmit = true;
         this._endTime = new Date();
         if(param1)
         {
            if(this._endTime.getTime() - this._startTime.getTime() <= TIMEOUT)
            {
               return;
            }
            this._exception = "error timeout!";
            this._code = ERROR_TIME_OUT;
         }
         LoaderManager.loadBytes(this.url,this.submitComplete,null,"GET");
      }
      
      public function clear() : void
      {
         this._exception = "";
         this._code = "999";
      }
      
      private function submitComplete(param1:Event) : void
      {
         trace("log data submitComplete:" + param1.toString());
         this.clear();
      }
      
      public function get url() : String
      {
         var _loc1_:String = URL;
         _loc1_ += "code=" + this._code;
         _loc1_ += "&count_time=" + (this._endTime.getTime() - this._startTime.getTime()).toString();
         _loc1_ += "&api=" + this._apiName;
         _loc1_ += "&method=" + this._method;
         _loc1_ += "&game_id=" + this._gameId;
         _loc1_ += "&uid=" + this._userId;
         _loc1_ += "&start_time=" + this._startTime.getTime().toString();
         _loc1_ += "&end_time=" + this._endTime.getTime().toString();
         return _loc1_ + ("&exception=" + this._exception);
      }
      
      public function set exception(param1:String) : void
      {
         this._exception = escape(param1);
         if(this._exception.indexOf("IOErrorEvent") != -1 || this._exception.indexOf("IOError") != -1)
         {
            this.code = ERROR_IO;
         }
         else if(this._exception.indexOf("SecurityErrorEvent") != -1 || this._exception.indexOf("SecurityError") != -1)
         {
            this.code = ERROR_SECURITY;
         }
      }
      
      public function set code(param1:String) : void
      {
         this._code = param1;
      }
      
      public function get isSubmit() : Boolean
      {
         return this._isSubmit;
      }
   }
}

