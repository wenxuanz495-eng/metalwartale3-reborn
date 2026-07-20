package UI.exchange
{
   import com.adobe.crypto.MD5;
   import flash.events.Event;
   import flash.events.IOErrorEvent;
   import flash.net.URLLoader;
   import flash.net.URLRequest;
   import flash.net.URLRequestMethod;
   import flash.net.URLVariables;
   
   public class Douwa_Exchange_API
   {
      
      public var yesFun:Function;
      
      public var noFun:Function;
      
      internal var loader:URLLoader = new URLLoader();
      
      internal var url:URLRequest = new URLRequest("http://my.4399.com/jifen/activation");
      
      public var gid0:String = "30";
      
      public var privateKey0:String = "a5d07e17b01d0a2fcd7a4adb442e8c56";
      
      public function Douwa_Exchange_API()
      {
         super();
         this.loader.addEventListener(IOErrorEvent.IO_ERROR,this.errorHandler);
         this.loader.addEventListener(Event.COMPLETE,this.loaderCompleteHandler);
      }
      
      public function startExchange(uid0:int, activation0:String, _yesFun:Function = null, _noFun:Function = null) : *
      {
         var n:* = undefined;
         this.yesFun = _yesFun;
         this.noFun = _noFun;
         var token0:String = MD5.hash(activation0 + "-" + uid0 + "-" + this.gid0 + "-" + this.privateKey0);
         var data0:URLVariables = new URLVariables();
         data0.uid = int(uid0);
         data0.activation = activation0;
         data0.uniqueId = this.gid0;
         data0.token = token0;
         this.url.data = data0;
         this.url.method = URLRequestMethod.POST;
         this.loader.load(this.url);
         Game.testText.addTestText("privateKey：" + this.privateKey0);
         var arr0:Array = ["uniqueId","uid","activation","token"];
         for(n in arr0)
         {
            Game.testText.addTestText(arr0[n] + "：" + this.url.data[arr0[n]]);
         }
      }
      
      internal function loaderCompleteHandler(e:*) : *
      {
         if(this.yesFun is Function)
         {
            this.yesFun(this.loader.data);
         }
         Game.testText.addTestText("豆娃激活码：" + this.loader.data);
      }
      
      internal function errorHandler(e:*) : *
      {
         if(this.noFun is Function)
         {
            this.noFun();
         }
         Game.testText.addTestText("豆娃激活码错误");
      }
   }
}

