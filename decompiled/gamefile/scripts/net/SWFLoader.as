package net
{
   import flash.display.Loader;
   import flash.net.URLRequest;
   
   public class SWFLoader extends Loader
   {
      
      public var loadcount:int = 8;
      
      public var url:String;
      
      public var label:String;
      
      public var info:String = "敌人";

      public var retryToken:int = 0;
      
      public function SWFLoader()
      {
         super();
      }
      
      public function loadMe() : *
      {
         var requestUrl:String = this.url;
         if(this.retryToken > 0)
         {
            requestUrl += (requestUrl.indexOf("?") >= 0 ? "&" : "?") + "swfretry=" + this.retryToken + "_" + new Date().time;
         }
         load(new URLRequest(requestUrl));
      }
   }
}

