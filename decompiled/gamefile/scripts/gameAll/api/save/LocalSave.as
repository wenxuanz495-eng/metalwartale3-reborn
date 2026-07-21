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
      
      private var slots:Array = new Array(8);
      
      private var readLoader:URLLoader;
      
      private var readMode:String = "";
      
      private var readYes:Function;
      
      private var readNo:Function;
      
      private var writeLoader:URLLoader;
      
      private var writeBusy:Boolean = false;
      
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
         var index:int = Game.gameData.nowSaveIndex;
         if(this.isGeneratedBlankData(gd))
         {
            if(_noFun is Function)
            {
               _noFun("默认空白角色不会被创建或保存");
            }
            return;
         }
         if(index < 0 || index > 7)
         {
            index = 2;
         }
         this.slots[index] = {
            "index":index,
            "title":Game.gameData.playerName + "_" + Game.gameData.level,
            "datetime":Game.getNowLocalTime(),
            "status":1,
            "data":gd
         };
         this.stripBlankSlotsFromMemory();
         var container:Object = {
            "localSaveVersion":2,
            "localSlots":this.slots
         };
         if(this.writeBusy)
         {
            this.queuedWriteData = container;
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
         this.startWriteServer(container,yesArr,noArr);
      }
      
      private function startWriteServer(data:*, yesArr:Array, noArr:Array) : *
      {
         var bytes:ByteArray = new ByteArray();
         bytes.writeObject(data);
         bytes.deflate();
         bytes.position = 0;
         this.writeBusy = true;
         this.currentWriteData = data;
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
         for each(var yesFun in this.currentWriteYes)
         {
            yesFun();
         }
         this.finishWriteServer();
      }
      
      private function writeServerError(e:Event) : *
      {
         this.clearWriteLoader();
         for each(var noFun in this.currentWriteNo)
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
      
      public function ReadList(_yesFun:Function, _noFun:Function = null) : *
      {
         this.startRead("list",_yesFun,_noFun);
      }
      
      public function ReadServer(_yesFun:Function, _noFun:Function = null) : *
      {
         this.startRead("slot",_yesFun,_noFun);
      }
      
      private function startRead(mode:String, _yesFun:Function, _noFun:Function) : *
      {
         this.clearReadLoader();
         this.readMode = mode;
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
         var root:Object = null;
         var bytes:ByteArray = this.readLoader.data as ByteArray;
         try
         {
            bytes.position = 0;
            bytes.inflate();
            bytes.position = 0;
            root = bytes.readObject();
         }
         catch(error:Error)
         {
            root = null;
         }
         this.clearReadLoader();
         this.loadRoot(root);
         this.finishRead();
      }
      
      private function finishRead() : *
      {
         if(this.readMode == "list")
         {
            this.readYes(this.makeList());
         }
         else
         {
            var index:int = Game.gameData.nowSaveIndex;
            var slot:Object = index >= 0 && index < 8 ? this.slots[index] : null;
            this.readYes(slot != null ? slot.data : null);
         }
      }
      
      private function loadRoot(root:Object) : *
      {
         var removedBlank:Boolean = false;
         this.slots = new Array(8);
         if(root != null && root.hasOwnProperty("localSlots") && root.localSlots is Array)
         {
            var source:Array = root.localSlots as Array;
            var i:int = 0;
            while(i < 8)
            {
               if(i < source.length && source[i] != null)
               {
                  if(source[i].data != null && !this.isGeneratedBlankData(source[i].data))
                  {
                     this.slots[i] = source[i];
                  }
                  else
                  {
                     removedBlank = true;
                  }
               }
               i++;
            }
         }
         else if(root != null && !this.isGeneratedBlankData(root))
         {
            this.slots[2] = {
               "index":2,
               "title":(root.hasOwnProperty("playerName") ? root.playerName : "本地存档") + "_" + (root.hasOwnProperty("level") ? root.level : 0),
               "datetime":"旧版本地存档",
               "status":1,
               "data":root
            };
         }
         else if(root != null)
         {
            removedBlank = true;
         }
         if(removedBlank)
         {
            var cleanContainer:Object = {
               "localSaveVersion":2,
               "localSlots":this.slots
            };
            if(this.writeBusy)
            {
               this.queuedWriteData = cleanContainer;
            }
            else
            {
               this.startWriteServer(cleanContainer,[],[]);
            }
         }
      }
      
      private function makeList() : Array
      {
         var result:Array = [];
         var i:int = 0;
         while(i < 8)
         {
            if(this.slots[i] != null)
            {
               result.push({
                  "index":i,
                  "title":this.slots[i].title,
                  "datetime":this.slots[i].datetime,
                  "status":1
               });
            }
            i++;
         }
         return result;
      }
      
      private function readServerFallback(e:Event) : *
      {
         this.clearReadLoader();
         this.slots = new Array(8);
         if(this.readYes is Function)
         {
            if(this.readMode == "list")
            {
               this.readYes([]);
            }
            else
            {
               this.readYes(null);
            }
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
      
      private function stripBlankSlotsFromMemory() : *
      {
         var i:int = 0;
         while(i < 8)
         {
            if(this.slots[i] != null)
            {
               if(this.slots[i].data == null || this.isGeneratedBlankData(this.slots[i].data))
               {
                  this.slots[i] = null;
               }
            }
            i++;
         }
      }
      
      private function isGeneratedBlankData(data:Object) : Boolean
      {
         if(data == null)
         {
            return true;
         }
         var level:int = data.hasOwnProperty("level") ? int(data.level) : 0;
         if(level > 1)
         {
            return false;
         }
         var noArms:Boolean = !data.hasOwnProperty("armsItems") || data.armsItems == null;
         if(!noArms && data.armsItems.hasOwnProperty("arr") && data.armsItems.arr is Array)
         {
            noArms = (data.armsItems.arr as Array).length == 0;
         }
         var noSubs:Boolean = !data.hasOwnProperty("subItems") || data.subItems == null;
         if(!noSubs && data.subItems.hasOwnProperty("arr") && data.subItems.arr is Array)
         {
            noSubs = (data.subItems.arr as Array).length == 0;
         }
         var noCars:Boolean = !data.hasOwnProperty("carItems") || data.carItems == null;
         if(!noCars && data.carItems.hasOwnProperty("arr") && data.carItems.arr is Array)
         {
            noCars = (data.carItems.arr as Array).length == 0;
         }
         return noArms && noSubs && noCars;
      }
   }
}

