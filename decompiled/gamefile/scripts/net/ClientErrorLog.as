package net
{
   import flash.events.Event;
   import flash.events.IOErrorEvent;
   import flash.events.SecurityErrorEvent;
   import flash.net.URLLoader;
   import flash.net.URLRequest;
   import flash.net.URLRequestMethod;
   import flash.utils.getTimer;
   
   public class ClientErrorLog
   {
      
      private static var lastMessage:String = "";
      
      private static var lastAt:int = 0;
      
      public function ClientErrorLog()
      {
         super();
      }
      
      public static function report(kind:String, message:String, stack:String = "", extra:String = "") : *
      {
         var now:int = 0;
         var req:URLRequest = null;
         var loader:URLLoader = null;
         var body:String = null;
         try
         {
            if(message == null)
            {
               message = "";
            }
            if(stack == null)
            {
               stack = "";
            }
            if(kind == null || kind == "")
            {
               kind = "error";
            }
            now = getTimer();
            if(message == lastMessage && now - lastAt < 1500)
            {
               return;
            }
            lastMessage = message;
            lastAt = now;
            body = "{\"kind\":\"" + escapeJson(kind) + "\",\"message\":\"" + escapeJson(message) + "\",\"stack\":\"" + escapeJson(stack) + "\",\"extra\":\"" + escapeJson(extra) + "\",\"time\":" + now + "}";
            req = new URLRequest("api/client-log");
            req.method = URLRequestMethod.POST;
            req.contentType = "application/json; charset=utf-8";
            req.data = body;
            loader = new URLLoader();
            loader.addEventListener(IOErrorEvent.IO_ERROR,ignore);
            loader.addEventListener(SecurityErrorEvent.SECURITY_ERROR,ignore);
            loader.addEventListener(Event.COMPLETE,ignore);
            loader.load(req);
         }
         catch(e:*)
         {
         }
      }
      
      private static function escapeJson(value:String) : String
      {
         if(value == null)
         {
            return "";
         }
         value = value.split("\\").join("\\\\");
         value = value.split("\"").join("\\\"");
         value = value.split("\r").join("\\r");
         value = value.split("\n").join("\\n");
         value = value.split("\t").join("\\t");
         if(value.length > 4000)
         {
            value = value.substr(0,4000);
         }
         return value;
      }
      
      private static function ignore(e:Event = null) : *
      {
      }
   }
}
