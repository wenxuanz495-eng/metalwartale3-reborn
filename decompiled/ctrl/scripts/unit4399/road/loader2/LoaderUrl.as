package unit4399.road.loader2
{
   import flash.events.Event;
   import flash.events.IOErrorEvent;
   import flash.events.SecurityErrorEvent;
   import flash.net.URLLoader;
   import flash.net.URLRequest;
   import flash.net.URLVariables;
   import unit4399.road.loader.LoaderManager;
   
   public class LoaderUrl extends URLLoader
   {
      
      private var _urlRequest:URLRequest;
      
      private var _completeCallback:Function;
      
      public function LoaderUrl(param1:String, param2:Function = null, param3:URLVariables = null, param4:Boolean = false, param5:String = "POST")
      {
         super();
         if(param4)
         {
            LoaderManager.loadBytes(param1,param2,param3,param5);
         }
         else
         {
            this._urlRequest = new URLRequest(param1);
            this._urlRequest.method = param5;
            this._urlRequest.data = param3;
            this._completeCallback = param2;
            addEventListener(Event.COMPLETE,this.onComplete);
            addEventListener(IOErrorEvent.IO_ERROR,this.onError);
            addEventListener(SecurityErrorEvent.SECURITY_ERROR,this.onError);
            load(this._urlRequest);
         }
      }
      
      private function onError(param1:Event) : void
      {
         if(this._completeCallback != null)
         {
            this._completeCallback(param1);
         }
         this.clear();
      }
      
      private function onComplete(param1:Event) : void
      {
         if(this._completeCallback != null)
         {
            this._completeCallback(param1);
         }
         this.clear();
      }
      
      private function clear() : void
      {
         removeEventListener(Event.COMPLETE,this.onComplete);
         removeEventListener(IOErrorEvent.IO_ERROR,this.onError);
         removeEventListener(SecurityErrorEvent.SECURITY_ERROR,this.onError);
         super.close();
      }
   }
}

