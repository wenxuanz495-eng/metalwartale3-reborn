package net
{
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.events.IOErrorEvent;
   import flash.events.ProgressEvent;
   
   public class TextLoaderManager extends EventDispatcher
   {
      
      public static var IsLocal:Boolean = false;
      
      private var _embedXml:EmbedXml = null;
      
      private var waiting_arr:Array = new Array();
      
      private var nowLoader:TextLoader = null;
      
      private var loader_arr:Array = new Array();
      
      public var baifenText:String = "";
      
      public var baifenNum:Number = 0;
      
      public function TextLoaderManager()
      {
         super();
      }
      
      public function SWFLoaderManager() : *
      {
      }
      
      public function addTextLoader(url0:String, label0:String) : *
      {
         var sl:TextLoader = new TextLoader();
         sl.url = url0;
         sl.label = label0;
         this.waiting_arr.push(sl);
      }
      
      public function startLoad() : *
      {
         if(this.waiting_arr.length > 0)
         {
            this.nowLoader = this.waiting_arr[0];
            trace("开始加载：" + this.nowLoader.url);
            this.nowLoader.loadMe();
            this.nowLoader.addEventListener(Event.COMPLETE,this.loadCompleteHandler);
            this.nowLoader.addEventListener(ProgressEvent.PROGRESS,this.loadProcessHandler);
            this.nowLoader.addEventListener(IOErrorEvent.IO_ERROR,this.loadErrorHandler);
         }
         else
         {
            trace("列表中没有swf可以加载了");
         }
      }
      
      public function stopLoad() : *
      {
         if(this.nowLoader != null)
         {
            this.nowLoader.close();
            this.nowLoader.removeEventListener(Event.COMPLETE,this.loadCompleteHandler);
            this.nowLoader.removeEventListener(ProgressEvent.PROGRESS,this.loadProcessHandler);
            this.nowLoader.removeEventListener(IOErrorEvent.IO_ERROR,this.loadErrorHandler);
            this.waiting_arr.length = 0;
         }
      }
      
      public function getResource(name_label:String) : *
      {
         var sl:TextLoader = null;
         var n:* = undefined;
         var sl0:TextLoader = null;
         if(IsLocal)
         {
            for(n in this.loader_arr)
            {
               sl0 = this.loader_arr[n];
               if(sl0.label == name_label)
               {
                  sl = sl0;
                  break;
               }
            }
            return sl;
         }
         if(this._embedXml == null)
         {
            this._embedXml = new EmbedXml();
         }
         return this._embedXml.SearchXml(name_label);
      }
      
      public function getEnemyXML(label0:String) : XML
      {
         var xml0:XML = null;
         var xmlL:* = undefined;
         var n:* = undefined;
         if(IsLocal)
         {
            xml0 = XML(this.getResource("enemy").data);
            xmlL = xml0.enemy;
            for(n in xmlL)
            {
               if(xmlL[n].@id == label0)
               {
                  return xmlL[n];
               }
            }
            return null;
         }
         if(this._embedXml == null)
         {
            this._embedXml = new EmbedXml();
         }
         xml0 = this._embedXml.SearchXml("enemy");
         xmlL = xml0.data.enemy;
         for(n in xmlL)
         {
            if(xmlL[n].@id == label0)
            {
               return xmlL[n];
            }
         }
         return null;
      }
      
      private function loadCompleteHandler(event:Event) : *
      {
         var completeEvent:Event = null;
         this.nowLoader.removeEventListener(Event.COMPLETE,this.loadCompleteHandler);
         this.nowLoader.removeEventListener(ProgressEvent.PROGRESS,this.loadProcessHandler);
         this.nowLoader.removeEventListener(IOErrorEvent.IO_ERROR,this.loadErrorHandler);
         this.waiting_arr.shift();
         this.loader_arr.unshift(this.nowLoader);
         trace("加载完毕：" + this.nowLoader.url);
         this.nowLoader = null;
         if(this.waiting_arr.length > 0)
         {
            this.startLoad();
         }
         else
         {
            completeEvent = new Event(Event.COMPLETE);
            trace("全部加载完毕");
            dispatchEvent(completeEvent);
         }
      }
      
      private function loadProcessHandler(event:ProgressEvent) : *
      {
         var wnum:int = int(this.waiting_arr.length);
         var lnum:int = this.loader_arr.length + 1;
         this.baifenNum = 1 / (wnum + lnum) * (event.bytesLoaded / event.bytesTotal + lnum - 1);
      }
      
      private function loadErrorHandler(event:IOErrorEvent) : *
      {
         trace("加载swf错误: " + event);
      }
      
      public function delResource() : *
      {
      }
   }
}

