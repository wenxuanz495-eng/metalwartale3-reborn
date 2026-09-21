package
{
   import flash.display.Loader;
   import flash.display.LoaderInfo;
   import flash.display.Sprite;
   import flash.events.ErrorEvent;
   import flash.events.Event;
   import flash.events.IOErrorEvent;
   import flash.filesystem.File;
   import flash.filesystem.FileMode;
   import flash.filesystem.FileStream;
   import flash.system.ApplicationDomain;
   import flash.system.LoaderContext;
   import flash.text.TextField;
   import flash.text.TextFormat;
   import flash.utils.ByteArray;

   // 原生链(2b) AIR 入口: 与桌面 DesktopLoader 同构——先 loadBytes patch.swf(mxmlc 全量
   // 编译的 CONFIG::MOBILE=true 版)占据同名定义,再 loadBytes 基线 game.swf(只出资产与符号
   // 绑定,重复类定义被运行时丢弃)。从应用目录经 FileStream 读取,loadBytes+allowCodeImport
   // 是 AIR 应用沙箱加载含代码 SWF 的既证路径(20260922 adl 微测试)。
   public class AirLoader extends Sprite
   {
      private static const PATCH_PATH:String = "patch.swf";

      private static const BASELINE_PATH:String = "game.swf";

      private var status:TextField;

      private var queue:Array;

      private var index:int = 0;

      public function AirLoader()
      {
         this.queue = [AirLoader.PATCH_PATH,AirLoader.BASELINE_PATH];
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

      private function readAppFile(name:String) : ByteArray
      {
         var stream:FileStream = new FileStream();
         stream.open(File.applicationDirectory.resolvePath(name),FileMode.READ);
         var bytes:ByteArray = new ByteArray();
         stream.readBytes(bytes);
         stream.close();
         return bytes;
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
         context.allowCodeImport = true;
         loader.contentLoaderInfo.addEventListener(Event.COMPLETE,this.onItemComplete);
         loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR,this.onItemError);
         loader.loadBytes(this.readAppFile(name),context);
      }

      private function onItemComplete(event:Event) : void
      {
         var loader:Loader = (event.target as LoaderInfo).loader;
         this.index++;
         this.status.text = "native chain: " + loader.name + " ok";
         if(loader.name == AirLoader.BASELINE_PATH)
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
