package unit4399.road.loader
{
   import flash.display.Loader;
   import flash.events.ErrorEvent;
   import flash.events.Event;
   import flash.events.IOErrorEvent;
   import flash.events.SecurityErrorEvent;
   import flash.net.URLLoader;
   import flash.net.URLRequest;
   import flash.system.ApplicationDomain;
   import flash.system.LoaderContext;
   import flash.utils.ByteArray;
   
   public class DisplayLoader extends Loader implements ILoader
   {
      
      protected var _url:URLRequest;
      
      public var isSuccess:Boolean;
      
      private var _bytesLoader:URLLoader;
      
      private var _func:Function;
      
      private var _tryTime:int;
      
      private var _starting:Boolean;
      
      private var _hadTryTime:int;
      
      public function DisplayLoader(param1:String, param2:Function = null)
      {
         super();
         this._url = new URLRequest(param1);
         this.contentLoaderInfo.addEventListener(Event.COMPLETE,this.__completed);
         this.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR,this.__error);
         this.contentLoaderInfo.addEventListener(SecurityErrorEvent.SECURITY_ERROR,this.__error);
         this.isSuccess = false;
         this._hadTryTime = 1;
         this._func = param2;
      }
      
      protected function onError(param1:Event) : void
      {
         if(this._func != null)
         {
            this._func(null,param1);
         }
      }
      
      public function dispose() : void
      {
         this.cancel();
         this.contentLoaderInfo.removeEventListener(Event.COMPLETE,this.__completed);
         this.contentLoaderInfo.removeEventListener(IOErrorEvent.IO_ERROR,this.__error);
         this.contentLoaderInfo.removeEventListener(SecurityErrorEvent.SECURITY_ERROR,this.__error);
         if(this._bytesLoader)
         {
            this._bytesLoader.removeEventListener(Event.COMPLETE,this.__bytesLoadComplete);
            this._bytesLoader.removeEventListener(IOErrorEvent.IO_ERROR,this.__error);
            this._bytesLoader.removeEventListener(SecurityErrorEvent.SECURITY_ERROR,this.__error);
         }
         this._func = null;
         unload();
      }
      
      public function isStarted() : Boolean
      {
         return this._starting;
      }
      
      protected function onCanceled() : void
      {
      }
      
      private function __bytesLoadError(param1:Event) : void
      {
         this.__error(param1);
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
      
      public function get callBack() : Function
      {
         return this._func;
      }
      
      public function get tryTime() : int
      {
         return this._tryTime;
      }
      
      private function __bytesLoadComplete(param1:Event) : void
      {
         loadBytes(this._bytesLoader.data as ByteArray);
         this._bytesLoader = null;
      }
      
      private function __completed(param1:Event) : void
      {
         var event:Event = param1;
         try
         {
            this._starting = false;
            LoaderManager.EndLoader(this);
            this.isSuccess = true;
            this.onCompleted(event);
         }
         catch(err:Error)
         {
            _starting = false;
            LoaderManager.EndLoader(this);
            isSuccess = false;
            onError(new ErrorEvent(ErrorEvent.ERROR));
         }
      }
      
      protected function onCompleted(param1:Event) : void
      {
         if(this._func != null)
         {
            this._func(this,param1);
         }
      }
      
      override public function load(param1:URLRequest, param2:LoaderContext = null) : void
      {
         param2 = new LoaderContext();
         param2.applicationDomain = ApplicationDomain.currentDomain;
         this._starting = true;
         ++this._tryTime;
         super.load(param1,param2);
      }
      
      private function __error(param1:Event) : void
      {
         var event:Event = param1;
         try
         {
            if(this.tryAdd(event))
            {
               this.load(this._url);
            }
         }
         catch(err:Error)
         {
            _starting = false;
            LoaderManager.EndLoader(this);
            isSuccess = false;
            onError(new ErrorEvent(ErrorEvent.ERROR));
         }
      }
      
      private function tryAdd(param1:Event) : Boolean
      {
         if(this._tryTime >= this._hadTryTime)
         {
            this._starting = false;
            LoaderManager.EndLoader(this);
            this.isSuccess = false;
            this.onError(param1);
            return false;
         }
         return true;
      }
      
      override public function close() : void
      {
         this._starting = false;
         if(this._bytesLoader)
         {
            this._bytesLoader.removeEventListener(Event.COMPLETE,this.__bytesLoadComplete);
            this._bytesLoader.removeEventListener(IOErrorEvent.IO_ERROR,this.__error);
            this._bytesLoader.removeEventListener(SecurityErrorEvent.SECURITY_ERROR,this.__error);
            this._bytesLoader.close();
         }
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
   }
}

