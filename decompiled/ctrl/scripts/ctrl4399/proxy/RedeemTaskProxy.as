package ctrl4399.proxy
{
   import com.adobe.crypto.MD5;
   import com.adobe.serialization.json.JSON;
   import ctrl4399.strconst.AllConst;
   import flash.events.Event;
   import flash.events.TimerEvent;
   import flash.net.URLVariables;
   import flash.utils.Timer;
   import frame4399.simplePureMvc.core.Facade;
   import frame4399.simplePureMvc.interfaces.IProxy;
   import frame4399.simplePureMvc.proxy.Proxy;
   import unit4399.road.loader.LoaderManager;
   
   public class RedeemTaskProxy extends Proxy implements IProxy
   {
      
      private var mainProxy:MainProxy;
      
      private var _facade:Facade = Facade.getInstance();
      
      private var timer:Timer;
      
      private var repCount:int = 0;
      
      private var _desc:String = "";
      
      public function RedeemTaskProxy(param1:String = null)
      {
         super(param1);
         this.mainProxy = this._facade.retrieveProxy(AllConst.PROXY_NAME_MAIN) as MainProxy;
      }
      
      private function startTimer(param1:int) : void
      {
         if(param1 <= 0)
         {
            this.delTimer();
            return;
         }
         if(this.timer == null)
         {
            this.timer = new Timer(param1 * 1000);
         }
         else
         {
            this.timer.reset();
         }
         this.timer.delay = param1 * 1000;
         this.timer.repeatCount = 1;
         if(!this.timer.hasEventListener(TimerEvent.TIMER_COMPLETE))
         {
            this.timer.addEventListener(TimerEvent.TIMER_COMPLETE,this.onTimerCompletedHandler);
         }
         this.timer.start();
      }
      
      private function onTimerCompletedHandler(param1:TimerEvent = null) : void
      {
         this.delTimer();
         this.submitToServer("30min");
      }
      
      public function submitToServer(param1:String) : void
      {
         if(this.mainProxy == null)
         {
            return;
         }
         this._desc = param1;
         var _loc2_:URLVariables = new URLVariables();
         _loc2_.desc = this._desc;
         _loc2_.gameId = int(this.mainProxy.gameID);
         _loc2_.time = int(new Date().getTime() / 1000);
         _loc2_.syn = MD5.hash(this._desc + "|" + this.mainProxy.gameID + "|" + _loc2_.time + "|/services/game-play|2d2dfa46e848c848b2357359d9548ce6");
         LoaderManager.loadBytes(AllConst.URL_REDEEM_TASK,this.activateTimerHandler,_loc2_);
      }
      
      private function activateTimerHandler(param1:Event) : void
      {
         if(param1.type != Event.COMPLETE)
         {
            if(this.repCount < 2)
            {
               ++this.repCount;
               this.submitToServer(this._desc);
            }
            else
            {
               this.repCount = 0;
            }
            return;
         }
         this.repCount = 0;
         var _loc2_:Object = com.adobe.serialization.json.JSON.decode(param1.target.data);
         if(String(_loc2_.code) == "1" && this.mainProxy.isLog)
         {
            if(Object(_loc2_.result).hasOwnProperty("time"))
            {
               this.startTimer(int(Object(_loc2_.result).time));
            }
            else
            {
               this.delTimer();
            }
         }
      }
      
      public function delTimer() : void
      {
         if(this.timer)
         {
            this.timer.stop();
            this.timer.removeEventListener(TimerEvent.TIMER_COMPLETE,this.onTimerCompletedHandler);
            this.timer = null;
         }
      }
   }
}

