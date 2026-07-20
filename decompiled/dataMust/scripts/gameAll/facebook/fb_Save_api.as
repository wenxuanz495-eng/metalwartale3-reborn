package gameAll.facebook
{
   import data.Base64;
   import flash.events.Event;
   import flash.events.IOErrorEvent;
   import flash.net.URLLoader;
   import flash.net.URLRequest;
   import flash.net.URLRequestMethod;
   import flash.net.URLVariables;
   import flash.utils.getTimer;
   
   public class fb_Save_api
   {
      
      public var yesFun:Function;
      
      public var noFun:Function;
      
      internal var loader:URLLoader = new URLLoader();
      
      internal var url:URLRequest = new URLRequest("http://121.14.168.186/3.php");
      
      internal var nowState:String = "get";
      
      public function fb_Save_api()
      {
         super();
         this.loader.addEventListener(IOErrorEvent.IO_ERROR,this.errorHandler);
         this.loader.addEventListener(Event.COMPLETE,this.loaderCompleteHandler);
      }
      
      public function save(param1:Object) : *
      {
         this.nowState = "save";
         trace("开始facebook存档--------------");
         var _loc2_:int = getTimer();
      }
      
      public function getSave() : *
      {
         this.nowState = "get";
         var _loc1_:URLVariables = new URLVariables();
         _loc1_.ac = "get";
         this.url.data = _loc1_;
         this.url.method = URLRequestMethod.POST;
         this.loader.load(this.url);
      }
      
      internal function loaderCompleteHandler(param1:*) : *
      {
         if(this.yesFun is Function)
         {
            this.yesFun(this.loader.data);
         }
         trace("获得数据：----------------\n" + Base64.decode(this.loader.data) + "\n-----------------------------");
         if(this.nowState == "save")
         {
         }
      }
      
      internal function errorHandler(param1:*) : *
      {
         if(this.noFun is Function)
         {
            this.noFun();
         }
         trace("错误!");
      }
   }
}

