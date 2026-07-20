package gameAll.api.save
{
   import flash.events.Event;
   import flash.events.IOErrorEvent;
   import flash.events.SecurityErrorEvent;
   import flash.net.URLLoader;
   import flash.net.URLLoaderDataFormat;
   import flash.net.URLRequest;
   import flash.net.URLRequestMethod;
   import flash.utils.ByteArray;
   import flash.utils.getTimer;
   
   public class LocalSave
   {
      
      private var saveURL:String = "api/game-save";

      private var readLoader:URLLoader;

      private var writeLoader:URLLoader;

      private var writeBusy:Boolean = false;

      private var readYes:Function;

      private var readNo:Function;

      private var currentWriteData:*;

      private var currentWriteYes:Array = [];

      private var currentWriteNo:Array = [];

      private var queuedWriteData:*;

      private var queuedWriteYes:Array = [];

      private var queuedWriteNo:Array = [];
      
      public function LocalSave()
      {
         super();
      }
      
      public function WriteServer(gd:*, _yesFun:Function = null, _noFun:Function = null) : *
      {
         if(this.writeBusy)
         {
            this.queuedWriteData = gd;
            if(_yesFun is Function)
            {
               this.queuedWriteYes.push(_yesFun);
            }
            if(_noFun is Function)
            {
               this.queuedWriteNo.push(_noFun);
            }
            return;
         }
         var yesArr:Array = [];
         var noArr:Array = [];
         if(_yesFun is Function)
         {
            yesArr.push(_yesFun);
         }
         if(_noFun is Function)
         {
            noArr.push(_noFun);
         }
         this.startWriteServer(gd,yesArr,noArr);
      }

      private function startWriteServer(gd:*, yesArr:Array, noArr:Array) : *
      {
         var bytes:ByteArray = new ByteArray();
         bytes.writeObject(gd);
         bytes.deflate();
         bytes.position = 0;
         this.writeBusy = true;
         this.currentWriteData = gd;
         this.currentWriteYes = yesArr;
         this.currentWriteNo = noArr;
         var request:URLRequest = new URLRequest(this.saveURL);
         request.method = URLRequestMethod.POST;
         request.contentType = "application/octet-stream";
         request.data = bytes;
         this.writeLoader = new URLLoader();
         this.writeLoader.dataFormat = URLLoaderDataFormat.TEXT;
         this.writeLoader.addEventListener(Event.COMPLETE,this.writeServerComplete);
         this.writeLoader.addEventListener(IOErrorEvent.IO_ERROR,this.writeServerError);
         this.writeLoader.addEventListener(SecurityErrorEvent.SECURITY_ERROR,this.writeServerError);
         this.writeLoader.load(request);
      }

      private function writeServerComplete(e:Event) : *
      {
         this.clearWriteLoader();
         for each(var yesFun:Function in this.currentWriteYes)
         {
            yesFun();
         }
         this.finishWriteServer();
      }

      private function writeServerError(e:Event) : *
      {
         this.clearWriteLoader();
         for each(var noFun:Function in this.currentWriteNo)
         {
            noFun("本地存档服务写入失败");
         }
         this.finishWriteServer();
      }

      private function clearWriteLoader() : *
      {
         if(this.writeLoader != null)
         {
            this.writeLoader.removeEventListener(Event.COMPLETE,this.writeServerComplete);
            this.writeLoader.removeEventListener(IOErrorEvent.IO_ERROR,this.writeServerError);
            this.writeLoader.removeEventListener(SecurityErrorEvent.SECURITY_ERROR,this.writeServerError);
         }
         this.writeLoader = null;
      }

      private function finishWriteServer() : *
      {
         this.currentWriteData = null;
         this.currentWriteYes = [];
         this.currentWriteNo = [];
         this.writeBusy = false;
         if(this.queuedWriteData != null)
         {
            var nextData:* = this.queuedWriteData;
            var nextYes:Array = this.queuedWriteYes;
            var nextNo:Array = this.queuedWriteNo;
            this.queuedWriteData = null;
            this.queuedWriteYes = [];
            this.queuedWriteNo = [];
            this.startWriteServer(nextData,nextYes,nextNo);
         }
      }
      
      public function ReadServer(_yesFun:Function, _noFun:Function = null) : *
      {
         this.readYes = _yesFun;
         this.readNo = _noFun;
         var request:URLRequest = new URLRequest(this.saveURL + "?t=" + getTimer());
         request.method = URLRequestMethod.GET;
         this.readLoader = new URLLoader();
         this.readLoader.dataFormat = URLLoaderDataFormat.BINARY;
         this.readLoader.addEventListener(Event.COMPLETE,this.readServerComplete);
         this.readLoader.addEventListener(IOErrorEvent.IO_ERROR,this.readServerFallback);
         this.readLoader.addEventListener(SecurityErrorEvent.SECURITY_ERROR,this.readServerFallback);
         this.readLoader.load(request);
      }

      private function readServerComplete(e:Event) : *
      {
         var bytes:ByteArray = this.readLoader.data as ByteArray;
         this.clearReadLoader();
         try
         {
            bytes.position = 0;
            bytes.inflate();
            bytes.position = 0;
            var obj:Object = bytes.readObject();
            this.readYes(obj);
         }
         catch(error:Error)
         {
            this.readServerFallback(e);
         }
      }

      private function readServerFallback(e:Event) : *
      {
         this.clearReadLoader();
         if(this.readYes is Function)
         {
            this.readYes(null);
         }
         else if(this.readNo is Function)
         {
            this.readNo("本地存档服务读取失败");
         }
      }

      private function clearReadLoader() : *
      {
         if(this.readLoader != null)
         {
            this.readLoader.removeEventListener(Event.COMPLETE,this.readServerComplete);
            this.readLoader.removeEventListener(IOErrorEvent.IO_ERROR,this.readServerFallback);
            this.readLoader.removeEventListener(SecurityErrorEvent.SECURITY_ERROR,this.readServerFallback);
         }
         this.readLoader = null;
      }
      
   }
}

