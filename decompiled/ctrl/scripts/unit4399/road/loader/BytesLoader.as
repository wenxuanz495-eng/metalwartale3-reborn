package unit4399.road.loader
{
   import flash.events.ErrorEvent;
   import flash.events.Event;
   import flash.events.IOErrorEvent;
   import flash.events.SecurityErrorEvent;
   import flash.net.URLLoader;
   import flash.net.URLLoaderDataFormat;
   import flash.net.URLRequest;
   import flash.net.URLVariables;
   
   public class BytesLoader extends URLLoader implements ILoader
   {
      
      protected var _starting:Boolean;
      
      protected var _func:Function;
      
      protected var _tryTime:int;
      
      protected var _hadTryTime:int;
      
      protected var _url:URLRequest;
      
      public var isSuccess:Boolean;
      
      private var _managed:Boolean;
      
      public function BytesLoader(param1:String, param2:Function, param3:URLVariables = null, param4:String = "POST", param5:Boolean = true)
      {
         super();
         dataFormat = URLLoaderDataFormat.BINARY;
         this._url = new URLRequest(param1);
         this._url.data = param3;
         this._url.method = param4;
         this._managed = param5;
         this._func = param2;
         this.addEventListener(Event.COMPLETE,this.__completed);
         this.addEventListener(IOErrorEvent.IO_ERROR,this.__error);
         this.addEventListener(SecurityErrorEvent.SECURITY_ERROR,this.__error);
         this._hadTryTime = 1;
      }
      
      public function cancel() : void
      {
         LoaderManager.CancelLoader(this);
         if(this._starting)
         {
            this.close();
         }
         this.onCanceled();
      }
      
      protected function onError(param1:Event) : void
      {
         if(this._func != null)
         {
            this._func(param1);
         }
      }
      
      protected function onCanceled() : void
      {
      }
      
      public function loadAtOnce() : void
      {
         LoaderManager.CancelLoader(this);
         this.load(this._url);
      }
      
      public function get hadTryTime() : int
      {
         return this._hadTryTime;
      }
      
      public function loadSync(param1:Function = null, param2:int = 1) : void
      {
         if(param1 != null)
         {
            this._func = param1;
            this._tryTime = param2;
         }
         if(!this._starting)
         {
            if(LoaderManager.canStart(this))
            {
               this.load(this._url);
            }
            else
            {
               LoaderManager.manageLoader(this);
            }
         }
      }
      
      override public function load(param1:URLRequest) : void
      {
         var urlRequest:URLRequest = param1;
         this._starting = true;
         ++this._tryTime;
         try
         {
            super.load(urlRequest);
         }
         catch(e:Error)
         {
            tryAdd(new ErrorEvent(ErrorEvent.ERROR));
         }
      }
      
      private function __completed(param1:Event) : void
      {
         this._starting = false;
         this.isSuccess = true;
         LoaderManager.EndLoader(this);
         this.onCompleted(param1);
      }
      
      protected function onCompleted(param1:Event) : void
      {
         if(this._func != null)
         {
            this._func(param1);
         }
      }
      
      private function __error(param1:Event) : void
      {
         var e:Event = param1;
         try
         {
            if(this.tryAdd(e))
            {
               this.load(this._url);
            }
         }
         catch(err:Error)
         {
            tryAdd(e);
         }
      }
      
      private function tryAdd(param1:Event) : Boolean
      {
         if(this._tryTime >= this._hadTryTime)
         {
            this._starting = false;
            LoaderManager.EndLoader(this);
            this.onError(param1);
            return false;
         }
         return true;
      }
      
      public function isStarted() : Boolean
      {
         return this._starting;
      }
      
      override public function close() : void
      {
         this._starting = false;
         super.close();
      }
   }
}

