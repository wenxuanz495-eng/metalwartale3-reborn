package unit4399.picLoad
{
   import flash.display.Loader;
   import flash.events.ErrorEvent;
   import flash.events.Event;
   import flash.events.IOErrorEvent;
   import flash.events.ProgressEvent;
   import flash.events.SecurityErrorEvent;
   import flash.net.URLRequest;
   import flash.system.LoaderContext;
   
   public class JPGLoader extends Loader implements IJPGLoader
   {
      
      protected var _url:URLRequest;
      
      private var _isSuccess:Boolean;
      
      private var _func:Function;
      
      private var _tryTime:int;
      
      private var _starting:Boolean;
      
      private var _hadTryTime:int;
      
      private var _loaderContext:LoaderContext;
      
      private var _param:Object;
      
      public function JPGLoader(param1:String, param2:Function = null, param3:Object = null, param4:LoaderContext = null, param5:int = 2)
      {
         super();
         this._url = new URLRequest(param1);
         this._param = param3;
         this._isSuccess = false;
         this._starting = false;
         this._hadTryTime = param5;
         this._func = param2;
         this._loaderContext = param4;
         this.addContentListener();
      }
      
      public function get isSuccess() : Boolean
      {
         return this._isSuccess;
      }
      
      protected function onError(param1:Event) : void
      {
         this.delContentListener();
         JPGLoadmanager.EndLoader(this);
         this.runFunc(param1);
      }
      
      private function runFunc(param1:Event) : void
      {
         if(this._func != null)
         {
            this._func(this,param1,this._param);
         }
      }
      
      public function cancel() : void
      {
         if(this._starting)
         {
            this.delContentListener();
            JPGLoadmanager.EndLoader(this);
         }
         this._starting = false;
         this._isSuccess = false;
         try
         {
            close();
         }
         catch(e:Error)
         {
         }
         unload();
      }
      
      public function isStarted() : Boolean
      {
         return this._starting;
      }
      
      public function loadSync(param1:Function = null, param2:int = 1) : void
      {
         this._starting = true;
         this.doLoad();
      }
      
      private function doLoad() : void
      {
         if(this._tryTime < this._hadTryTime)
         {
            ++this._tryTime;
            load(this._url,this._loaderContext);
         }
         else
         {
            this.onError(new ErrorEvent(ErrorEvent.ERROR));
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
      
      private function loadCompleteHandler(param1:Event) : void
      {
         this._isSuccess = true;
         this._starting = false;
         this.delContentListener();
         this.onCompleted(param1);
      }
      
      protected function onCompleted(param1:Event) : void
      {
         JPGLoadmanager.EndLoader(this);
         this.runFunc(param1);
      }
      
      private function loadErrorHandler(param1:Event) : void
      {
         this.doLoad();
      }
      
      private function loadProgressHandler(param1:ProgressEvent) : void
      {
         this.runFunc(param1);
      }
      
      private function addContentListener() : void
      {
         contentLoaderInfo.addEventListener(Event.COMPLETE,this.loadCompleteHandler);
         contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR,this.loadErrorHandler);
         contentLoaderInfo.addEventListener(SecurityErrorEvent.SECURITY_ERROR,this.loadErrorHandler);
         contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS,this.loadProgressHandler);
      }
      
      private function delContentListener() : void
      {
         contentLoaderInfo.removeEventListener(Event.COMPLETE,this.loadCompleteHandler);
         contentLoaderInfo.removeEventListener(IOErrorEvent.IO_ERROR,this.loadErrorHandler);
         contentLoaderInfo.removeEventListener(SecurityErrorEvent.SECURITY_ERROR,this.loadErrorHandler);
         contentLoaderInfo.removeEventListener(ProgressEvent.PROGRESS,this.loadProgressHandler);
      }
   }
}

