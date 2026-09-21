package
{
   import flash.display.Loader;
   import flash.display.LoaderInfo;
   import flash.display.Sprite;
   import flash.events.ErrorEvent;
   import flash.events.Event;
   import flash.events.IOErrorEvent;
   import flash.events.SecurityErrorEvent;
   import flash.net.URLRequest;
   import flash.system.ApplicationDomain;
   import flash.system.LoaderContext;
   import flash.text.TextField;
   import flash.text.TextFormat;

   // 原生链桌面入口(2b): 先加载 patch.swf(mxmlc 全量编译的 668 类)占据同名定义,
   // 再加载 game-baseline.swf(纯基线,只出资产与符号绑定,其重复类定义被运行时丢弃).
   // 机制依据 20260922 adl 微测试: 同 ApplicationDomain 内先加载者胜,后到重名静默丢弃.
   public class DesktopLoader extends Sprite
   {
      private static const PATCH_PATH:String = "patch.swf";

      private static const BASELINE_PATH:String = "game-baseline.swf";

      private var status:TextField;

      private var queue:Array;

      private var index:int = 0;

      public function DesktopLoader()
      {
         this.queue = [DesktopLoader.PATCH_PATH,DesktopLoader.BASELINE_PATH];
         this.status = new TextField();
         this.status.defaultTextFormat = new TextFormat("_sans",14,16777215);
         this.status.background = true;
         this.status.backgroundColor = 0;
         this.status.width = 800;
         this.status.height = 24;
         this.status.text = "native chain: loading...";
         addChild(this.status);
         this.loadNext();
      }

      private function loadNext() : void
      {
         if(this.index >= this.queue.length)
         {
            this.status.visible = false;
            return;
         }
         var name:String = this.queue[this.index] as String;
         var loader:Loader = new Loader();
         loader.name = name;
         var context:LoaderContext = new LoaderContext(false,ApplicationDomain.currentDomain);
         loader.contentLoaderInfo.addEventListener(Event.COMPLETE,this.onItemComplete);
         loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR,this.onItemError);
         loader.contentLoaderInfo.addEventListener(SecurityErrorEvent.SECURITY_ERROR,this.onItemError);
         loader.load(new URLRequest(name),context);
      }

      private function onItemComplete(event:Event) : void
      {
         var loader:Loader = (event.target as LoaderInfo).loader;
         var name:String = loader.name;
         this.index++;
         this.status.text = "native chain: " + name + " ok";
         if(name == DesktopLoader.BASELINE_PATH)
         {
            addChildAt(loader,0);
         }
         this.loadNext();
      }

      private function onItemError(event:ErrorEvent) : void
      {
         this.status.text = "native chain FAILED: " + event.type + " " + event.text;
      }
   }
}
