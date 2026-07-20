package gameAll.api.save
{
   import data.SuperSkillTimer;
   import flash.events.DataEvent;
   import flash.events.Event;
   import unit4399.events.SaveEvent;
   
   public class Save4399
   {
      
      public var serviceHold:*;
      
      private var _iscover:Boolean;
      
      public var nowIndex:int = 0;
      
      public var nowTitle:String = "超合金3.0";
      
      public var loginDelay:SuperSkillTimer = new SuperSkillTimer();
      
      public var yes_save_fun:Function = null;
      
      public var no_save_fun:Function = null;
      
      public var yes_read_fun:Function = null;
      
      public var no_read_fun:Function = null;
      
      public var yes_readlist_fun:Function = null;
      
      public var yes_fun:Function = null;
      
      public var no_fun:Function = null;
      
      public var yes_outLogin_fun:Function = null;
      
      public var yes_closePanel_fun:Function = null;
      
      public var yes_login_fun:Function = null;
      
      public function Save4399()
      {
         super();
      }
      
      public function addListener(stage0:*) : *
      {
         stage0.addEventListener(SaveEvent.SAVE_GET,this.saveProcess);
         stage0.addEventListener(SaveEvent.SAVE_SET,this.saveProcess);
         stage0.addEventListener(SaveEvent.SAVE_LIST,this.saveProcess);
         stage0.addEventListener("logreturn",this.saveProcess);
         stage0.addEventListener("userLoginOut",this.onUserLogOutHandler,false,0,true);
         stage0.addEventListener("MVC_CLOSE_PANEL",this.closePanelHandler);
         stage0.addEventListener("serverTimeEvent",this.onGetServerTimeHandler);
         stage0.addEventListener("saveBackIndex",this.saveProcess);
         stage0.addEventListener("netSaveError",this.netSaveErrorHandler,false,0,true);
         stage0.addEventListener("netGetError",this.netGetErrorHandler,false,0,true);
      }
      
      public function showLogPanel(_yesFun:Function = null) : *
      {
         this.yes_fun = _yesFun;
         this.loginDelay.overFun = this.yes_showLogPanel;
         this.loginDelay.t = 0.5;
      }
      
      private function yes_showLogPanel() : *
      {
         this.serviceHold.showLogPanel();
         if(this.yes_fun is Function)
         {
            this.yes_fun();
         }
      }
      
      public function userLogOut() : *
      {
         this.serviceHold.userLogOut();
      }
      
      public function isLogin() : Boolean
      {
         var logInfo:Object = null;
         if(Boolean(this.serviceHold))
         {
            logInfo = this.serviceHold.isLog;
            return !!logInfo;
         }
         return true;
      }
      
      public function getServerTime(_yesFun:Function, _noFun:Function = null) : *
      {
         this.yes_fun = _yesFun;
         this.no_fun = _noFun;
         this.serviceHold.getServerTime();
      }
      
      public function save(obj0:Object, _yesFun:Function, _noFun:Function) : *
      {
         this.yes_save_fun = _yesFun;
         this.no_save_fun = _noFun;
         this.nowTitle = Game.gameData.playerName + "_" + Game.gameData.level;
         this.serviceHold.saveData(this.nowTitle,obj0,false,this.nowIndex);
      }
      
      public function read(_yesFun:Function, _noFun:Function, iscover:Boolean) : *
      {
         this.yes_read_fun = _yesFun;
         this.no_read_fun = _noFun;
         this._iscover = iscover;
         this.serviceHold.getData(false,this.nowIndex);
      }
      
      public function readlist(yeslist:Function, nofun:Function) : *
      {
         this.yes_readlist_fun = yeslist;
         this.no_read_fun = nofun;
         this.serviceHold.getList();
      }
      
      private function saveProcess(e:SaveEvent) : void
      {
         var data:Array = null;
         switch(e.type)
         {
            case "logreturn":
               if(this.yes_login_fun is Function)
               {
                  this.yes_login_fun(e.ret);
               }
               break;
            case SaveEvent.SAVE_GET:
               if(!e.ret)
               {
                  this.yes_read_fun(null);
               }
               else if(this._iscover)
               {
                  this.yes_read_fun(null);
               }
               else
               {
                  this.yes_read_fun(e.ret);
               }
               break;
            case SaveEvent.SAVE_SET:
               if(e.ret as Boolean == true)
               {
                  this.yes_save_fun();
               }
               else
               {
                  this.no_save_fun();
               }
               break;
            case SaveEvent.SAVE_LIST:
               data = e.ret as Array;
               if(Boolean(this.yes_readlist_fun))
               {
                  this.yes_readlist_fun(data);
               }
         }
      }
      
      private function onUserLogOutHandler(evt:Event) : void
      {
         if(this.yes_outLogin_fun is Function)
         {
            this.yes_outLogin_fun();
         }
      }
      
      private function closePanelHandler(e:Event) : void
      {
         if(this.yes_closePanel_fun is Function)
         {
            this.yes_closePanel_fun();
         }
      }
      
      private function netSaveErrorHandler(evt:Event) : void
      {
         this.no_save_fun();
      }
      
      private function netGetErrorHandler(evt:DataEvent) : void
      {
         var tmpStr:String = "网络取" + evt.data + "档失败了！";
         this.no_read_fun(tmpStr);
      }
      
      private function onGetServerTimeHandler(evt:DataEvent) : void
      {
         if(evt.data == "")
         {
            if(this.no_fun is Function)
            {
               this.no_fun();
            }
         }
         else if(this.yes_fun is Function)
         {
            this.yes_fun(evt.data);
         }
      }
   }
}

