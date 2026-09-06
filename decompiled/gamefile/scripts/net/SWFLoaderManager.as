package net
{
   import body.image.SingleMovieclip;
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.events.IOErrorEvent;
   import flash.events.ProgressEvent;
   import flash.events.SecurityErrorEvent;
   import flash.geom.Point;
   import flash.utils.setTimeout;
   
   public class SWFLoaderManager extends EventDispatcher
   {
      public static const CRITICAL_LOAD_FAILED:String = "criticalLoadFailed";
      
      private var waiting_arr:Array = new Array();
      
      private var loader_arr:Array = new Array();
      
      public var nowMax:int = 1;
      
      public var beforeMax:int = 1;
      
      public var stateText:String = "敌人";
      
      public var baifenText:String = "";
      
      public var numText:String = "";
      
      public var baifen:Number = 0;
      
      private const MAXLOADING:int = 5;
      
      private var _nowLoadingArr:Array = [];

      private var failedCritical:Boolean = false;

      private var criticalFailureText:String = "";

      private var pendingRetryCount:int = 0;

      private var loadSession:int = 0;
      
      public function SWFLoaderManager()
      {
         super();
      }
      
      public function addSWFLoader(url0:String, label0:String, info0:String = "") : *
      {
         var sl:SWFLoader = null;
         var bb:Boolean = this.findSWF_URL(url0);
         if(bb)
         {
            trace("地址已经加载过了：" + url0);
         }
         else
         {
            sl = new SWFLoader();
            sl.url = url0;
            sl.label = label0;
            sl.info = info0;
            this.waiting_arr.push(sl);
         }
      }
      
      public function startLoad() : *
      {
         ++this.loadSession;
         this.pendingRetryCount = 0;
         this.failedCritical = false;
         this.criticalFailureText = "";
         this.nowMax = this.waiting_arr.length;
         this.beforeMax = this.loader_arr.length;
         this._startLoad();
      }
      
      public function stopLoad() : *
      {
         var nowLoader:SWFLoader = null;
         ++this.loadSession;
         this.pendingRetryCount = 0;
         while(this._nowLoadingArr.length > 0)
         {
            nowLoader = this._nowLoadingArr.shift();
            if(nowLoader != null)
            {
               nowLoader.contentLoaderInfo.removeEventListener(Event.COMPLETE,this.loadCompleteHandler);
               nowLoader.contentLoaderInfo.removeEventListener(ProgressEvent.PROGRESS,this.loadProcessHandler);
               nowLoader.contentLoaderInfo.removeEventListener(IOErrorEvent.IO_ERROR,this.loadErrorHandler);
               nowLoader.contentLoaderInfo.removeEventListener(SecurityErrorEvent.SECURITY_ERROR,this.loadErrorHandler);
               try{ nowLoader.close(); }catch(eClose:*){}
               try{ nowLoader.unloadAndStop(); }catch(eUnload:*){}
            }
         }
         this.waiting_arr = [];
      }
      
      public function addSWFList_byURL(url1:String, arr0:Array, info0:String = "") : *
      {
         var n:* = undefined;
         var label0:String = null;
         for(n in arr0)
         {
            label0 = arr0[n];
            this.addSWFLoader(url1 + label0 + ".swf",label0,info0);
         }
      }
      
      internal function _startLoad() : *
      {
         var nowLoader:SWFLoader = null;
         var loaded:int = 0;
         var completeEvent:Event = null;
         var nlen:int = int(this._nowLoadingArr.length);
         for(var i:int = this.MAXLOADING; i > nlen; i--)
         {
            if(this.waiting_arr.length > 0)
            {
               nowLoader = this.waiting_arr.shift();
               trace("列表中有" + (this.waiting_arr.length + 1) + "个，开始加载：" + nowLoader.url);
               loaded = this.loader_arr.length - this.beforeMax + 1;
               if(loaded > this.nowMax)
               {
                  loaded = this.nowMax;
               }
               this.numText = "(" + loaded + "/" + this.nowMax + ")";
               this.stateText = nowLoader.info;
               nowLoader.loadMe();
               this._nowLoadingArr.push(nowLoader);
               nowLoader.contentLoaderInfo.addEventListener(Event.COMPLETE,this.loadCompleteHandler);
               nowLoader.contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS,this.loadProcessHandler);
               nowLoader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR,this.loadErrorHandler);
               nowLoader.contentLoaderInfo.addEventListener(SecurityErrorEvent.SECURITY_ERROR,this.loadErrorHandler);
            }
         }
         if(this._nowLoadingArr.length == 0 && this.waiting_arr.length == 0 && this.pendingRetryCount == 0 && !this.failedCritical)
         {
            trace("列表中没有swf可以加载了");
            completeEvent = new Event(Event.COMPLETE);
            trace("swf全部加载完成");
            this._nowLoadingArr = [];
            dispatchEvent(completeEvent);
         }
         else if(this._nowLoadingArr.length == 0 && this.waiting_arr.length == 0 && this.pendingRetryCount == 0 && this.failedCritical)
         {
            this.stateText = "关键资源";
            this.baifenText = this.criticalFailureText;
         }
      }
      
      public function findSWF_URL(url0:String) : *
      {
         var n:* = undefined;
         var m:* = undefined;
         var sl0:SWFLoader = null;
         var sl1:SWFLoader = null;
         for(n in this.loader_arr)
         {
            sl0 = this.loader_arr[n];
            if(url0 == sl0.url)
            {
               return true;
            }
         }
         for(m in this.waiting_arr)
         {
            sl1 = this.waiting_arr[m];
            if(url0 == sl1.url)
            {
               return true;
            }
         }
         return false;
      }
      
      public function getResource(swf_label:String, name_label:String) : *
      {
         var n:* = undefined;
         var obj:* = undefined;
         var sl0:SWFLoader = null;
         var bb:Boolean = false;
         var newClass:Class = null;
         var la_arr:Array = name_label.split("/");
         if(la_arr.length == 2)
         {
            swf_label = la_arr[0];
            name_label = la_arr[1];
         }
         var sl:SWFLoader = null;
         for(n in this.loader_arr)
         {
            sl0 = this.loader_arr[n];
            if(sl0.label == swf_label)
            {
               sl = sl0;
               break;
            }
         }
         obj = null;
         if(sl is SWFLoader)
         {
            bb = sl.contentLoaderInfo.applicationDomain.hasDefinition(name_label);
            if(bb)
            {
               newClass = sl.contentLoaderInfo.applicationDomain.getDefinition(name_label) as Class;
               obj = new newClass();
            }
            else
            {
               trace("getResource在【" + swf_label + "】中没找到指定swf内的类：" + name_label);
            }
         }
         else
         {
            trace("getResource没找到指定swf：" + swf_label);
         }
         return obj;
      }
      
      public function getSingleMovieclip(swf_label:String, name_label:String, pointB:Boolean = false) : SingleMovieclip
      {
         var sm0:SingleMovieclip = null;
         var del_arr:Array = null;
         var n:int = 0;
         var pmc:DisplayObject = null;
         var pname:String = null;
         var f0:int = 0;
         var f1:int = 0;
         var f2:int = 0;
         var f3:int = 0;
         var f4:int = 0;
         var f5:int = 0;
         var la_arr:Array = name_label.split("/");
         if(la_arr.length == 2)
         {
            swf_label = la_arr[0];
            name_label = la_arr[1];
         }
         var mc0:MovieClip = this.getResource(swf_label,name_label);
         if(mc0 is MovieClip)
         {
            sm0 = new SingleMovieclip(mc0,name_label,swf_label);
            if(pointB)
            {
               del_arr = new Array();
               for(n = 0; n <= mc0.numChildren - 1; n++)
               {
                  pmc = mc0.getChildAt(n);
                  pname = pmc.name;
                  f0 = pname.indexOf("armsPoint");
                  f1 = pname.indexOf("rocketPoint");
                  f2 = pname.indexOf("basePoint");
                  f3 = pname.indexOf("shootPoint");
                  f4 = pname.indexOf("plasmaPoint");
                  f5 = pname.indexOf("laserPoint");
                  if(f0 >= 0)
                  {
                     sm0.armsPoint = new Point(pmc.x,pmc.y);
                     pmc.visible = false;
                     pmc.scaleX = 0.1;
                     pmc.scaleY = 0.1;
                  }
                  else if(f1 >= 0)
                  {
                     sm0.rocketPoint = new Point(pmc.x,pmc.y);
                     pmc.visible = false;
                     pmc.scaleX = 0.1;
                     pmc.scaleY = 0.1;
                  }
                  else if(f2 >= 0)
                  {
                     sm0.basePoint = new Point(pmc.x,pmc.y);
                     pmc.visible = false;
                     pmc.scaleX = 0.1;
                     pmc.scaleY = 0.1;
                  }
                  else if(f3 >= 0)
                  {
                     sm0.shootPoint = new Point(pmc.x,pmc.y);
                     pmc.visible = false;
                     pmc.scaleX = 0.1;
                     pmc.scaleY = 0.1;
                  }
                  else if(f4 >= 0)
                  {
                     sm0.plasmaPoint = new Point(pmc.x,pmc.y);
                     pmc.visible = false;
                     pmc.scaleX = 0.1;
                     pmc.scaleY = 0.1;
                  }
                  else if(f5 >= 0)
                  {
                     sm0.laserPoint = new Point(pmc.x,pmc.y);
                     pmc.visible = false;
                     pmc.scaleX = 0.1;
                     pmc.scaleY = 0.1;
                  }
               }
            }
            sm0.rect = mc0.getRect(mc0);
            sm0.currentLabels = mc0.currentLabels;
            return sm0;
         }
         trace("getSingleMovieclip在【" + swf_label + "】中没找到指定Movieclip：" + name_label);
         return null;
      }
      
      private function loadCompleteHandler(event:Event) : *
      {
         var sl:SWFLoader = null;
         event.target.removeEventListener(Event.COMPLETE,this.loadCompleteHandler);
         event.target.removeEventListener(ProgressEvent.PROGRESS,this.loadProcessHandler);
         event.target.removeEventListener(IOErrorEvent.IO_ERROR,this.loadErrorHandler);
         event.target.removeEventListener(SecurityErrorEvent.SECURITY_ERROR,this.loadErrorHandler);
         for(var i:int = 0; i < this._nowLoadingArr.length; i++)
         {
            sl = this._nowLoadingArr[i];
            if(sl.contentLoaderInfo == event.target)
            {
               this.loader_arr.unshift(sl);
               this._nowLoadingArr.splice(i,1);
               break;
            }
         }
         var loaded:int = this.loader_arr.length - this.beforeMax + 1;
         if(loaded > this.nowMax)
         {
            loaded = this.nowMax;
         }
         this.numText = "(" + loaded + "/" + this.nowMax + ")";
         trace("列表中有" + this.waiting_arr.length + "个，加载完毕：" + sl.url);
         this._startLoad();
      }
      
      private function loadProcessHandler(event:ProgressEvent) : *
      {
         this.baifen = event.bytesLoaded / event.bytesTotal;
         this.baifenText = int(this.baifen * 100) + "%";
      }
      
      private function loadErrorHandler(event:*) : *
      {
         var sl:SWFLoader = null;
         var errorText:String = event.text == null ? "" : event.text;
         for(var i:int = 0; i < this._nowLoadingArr.length; i++)
         {
            sl = this._nowLoadingArr[i];
            if(sl.contentLoaderInfo == event.target)
            {
               this._nowLoadingArr.splice(i,1);
               event.target.removeEventListener(Event.COMPLETE,this.loadCompleteHandler);
               event.target.removeEventListener(ProgressEvent.PROGRESS,this.loadProcessHandler);
               event.target.removeEventListener(IOErrorEvent.IO_ERROR,this.loadErrorHandler);
               event.target.removeEventListener(SecurityErrorEvent.SECURITY_ERROR,this.loadErrorHandler);
               try{ sl.close(); }catch(eClose:*){}
               try{ sl.unloadAndStop(); }catch(eUnload:*){}
               this.baifenText = "加载swf错误，正在重试：" + sl.url;
               trace("加载swf错误: " + sl.url + " " + errorText);
               if(sl.loadcount <= 0)
               {
                  if(sl.info != "音效" && sl.info != "音乐")
                  {
                     this.failedCritical = true;
                     ++this.loadSession;
                     this.pendingRetryCount = 0;
                     this.waiting_arr = [];
                     this.stateText = "关键资源";
                     this.criticalFailureText = "加载失败，请关闭游戏后重新启动：" + sl.url;
                     this.baifenText = this.criticalFailureText;
                     trace("关键swf加载失败，停止进入游戏: " + sl.url);
                     try{ Game.reportClientError("swf-load","critical load failed: " + sl.url + " | " + errorText,"",sl.info); }catch(eCritical:*){}
                     dispatchEvent(new Event(CRITICAL_LOAD_FAILED));
                     this._startLoad();
                     break;
                  }
                  this.baifenText = "加载swf失败，已跳过：" + sl.url;
                  trace("非关键swf加载失败并跳过: " + sl.url);
                  try{ Game.reportClientError("swf-load","load failed: " + sl.url + " | " + errorText,"",sl.info); }catch(eLog:*){}
                  this._startLoad();
                  break;
               }
               --sl.loadcount;
               this.scheduleRetry(sl);
               this._startLoad();
               break;
            }
         }
      }

      private function scheduleRetry(failedLoader:SWFLoader) : void
      {
         var retryLoader:SWFLoader = new SWFLoader();
         var session0:int = this.loadSession;
         retryLoader.url = failedLoader.url;
         retryLoader.label = failedLoader.label;
         retryLoader.info = failedLoader.info;
         retryLoader.loadcount = failedLoader.loadcount;
         retryLoader.retryToken = failedLoader.retryToken + 1;
         ++this.pendingRetryCount;
         setTimeout(function() : void
         {
            if(session0 != loadSession)
            {
               return;
            }
            --pendingRetryCount;
            if(!failedCritical)
            {
               waiting_arr.push(retryLoader);
            }
            _startLoad();
         },150);
      }
      
      public function delResource() : *
      {
      }

      public function removeResourcesByLabels(labels:Array) : *
      {
         var i:int = 0;
         var loader0:SWFLoader = null;
         for(i = this.loader_arr.length - 1; i >= 0; i--)
         {
            loader0 = this.loader_arr[i];
            if(labels.indexOf(loader0.label) >= 0)
            {
               this.loader_arr.splice(i,1);
               try{ loader0.unloadAndStop(); }catch(eUnload:*){}
            }
         }
         for(i = this.waiting_arr.length - 1; i >= 0; i--)
         {
            loader0 = this.waiting_arr[i];
            if(labels.indexOf(loader0.label) >= 0)
            {
               this.waiting_arr.splice(i,1);
            }
         }
      }
   }
}

