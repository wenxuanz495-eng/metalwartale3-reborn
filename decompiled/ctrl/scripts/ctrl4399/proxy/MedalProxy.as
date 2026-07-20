package ctrl4399.proxy
{
   import com.adobe.crypto.MD5;
   import ctrl4399.strconst.AllConst;
   import flash.display.Stage;
   import flash.events.DataEvent;
   import flash.events.Event;
   import flash.external.ExternalInterface;
   import flash.net.URLVariables;
   import frame4399.simplePureMvc.core.Facade;
   import frame4399.simplePureMvc.interfaces.IProxy;
   import frame4399.simplePureMvc.proxy.Proxy;
   import unit4399.events.MedalEvent;
   import unit4399.events.SaveEvent;
   import unit4399.road.loader.LoaderManager;
   
   public class MedalProxy extends Proxy implements IProxy
   {
      
      public var _realStage:Stage;
      
      private var _curScore:uint = 0;
      
      private var _totalScore:uint = 0;
      
      private var _submitType:String = "";
      
      private var mainProxy:MainProxy;
      
      private var _facade:Facade;
      
      private var GuserName:String = "";
      
      private var userID:String = "";
      
      private var gameID:String = "";
      
      private var isSubmitScore:Boolean = false;
      
      private const SUBMIT_TYPE_AUTO:String = "1";
      
      private const SUBMIT_TYPE_MANUL:String = "0";
      
      private const SUBMIT_RESULT_NET_ERROR:String = "-1";
      
      private const SUBMIT_RESULT_SUBMIT_ERROR:String = "0";
      
      private const SUBMIT_RESULT_MANUL_SUCC:String = "1";
      
      public function MedalProxy(param1:String = null)
      {
         var name:String = param1;
         this._facade = Facade.getInstance();
         super(name);
         this.mainProxy = this._facade.retrieveProxy(AllConst.PROXY_NAME_MAIN) as MainProxy;
         ExternalInterface.addCallback("restartGame",this.restartGame);
         if(ExternalInterface.available)
         {
            try
            {
               ExternalInterface.call("ctrlInitCompleted");
            }
            catch(e:Error)
            {
               trace("ctrlInitCompleted:" + e.toString());
            }
         }
         this.changeScore(0);
      }
      
      public function set realStage(param1:Stage) : void
      {
         this._realStage = param1;
         if(this._realStage == null)
         {
            return;
         }
         this._realStage.addEventListener("userLoginOut",this.onUserLoginOut);
         this._realStage.addEventListener(SaveEvent.LOG,this.onUserLogIn);
         this._realStage.addEventListener(AllConst.MVC_CLOSE_PANEL,this.closePanelHandler);
      }
      
      private function onUserLoginOut(param1:Event) : void
      {
         var evt:Event = param1;
         this.GuserName = "";
         this.userID = "";
         if(ExternalInterface.available)
         {
            try
            {
               ExternalInterface.call("logoutSuccess");
            }
            catch(e:Error)
            {
               trace("logoutSuccess:" + e.toString());
            }
         }
      }
      
      private function onUserLogIn(param1:SaveEvent) : void
      {
         var evt:SaveEvent = param1;
         if(ExternalInterface.available)
         {
            try
            {
               ExternalInterface.call("loginSuccess");
            }
            catch(e:Error)
            {
               trace("loginSuccess:" + e.toString());
            }
         }
         if(this.isSubmitScore)
         {
            this.isSubmitScore = false;
            this.submitScoreFromJs(this._submitType);
         }
      }
      
      private function closePanelHandler(param1:DataEvent) : void
      {
         if(param1.data == "1" && !this.mainProxy.isLog)
         {
            this.mainProxy._isMedalLog = false;
            if(this._submitType == this.SUBMIT_TYPE_AUTO)
            {
               this.submitScore(this._totalScore);
            }
         }
      }
      
      public function changeScore(param1:uint) : void
      {
         var curScore:uint = param1;
         this._curScore = curScore;
         if(ExternalInterface.available)
         {
            try
            {
               ExternalInterface.call("changeScore",curScore);
            }
            catch(e:Error)
            {
               trace("changeScore:" + e.toString());
            }
         }
      }
      
      public function submitScore(param1:uint) : void
      {
         var result:uint = param1;
         this._totalScore = result;
         if(ExternalInterface.available)
         {
            try
            {
               ExternalInterface.call("submitScore",result);
            }
            catch(e:Error)
            {
               trace("submitScore:" + e.toString());
            }
         }
      }
      
      private function restartGame(param1:Boolean = false) : void
      {
         this._curScore = 0;
         this._totalScore = 0;
         this._submitType = "";
         if(param1 && this.mainProxy.isLog)
         {
            this.mainProxy.loginOut(true);
         }
         else if(this._realStage)
         {
            this._realStage.dispatchEvent(new MedalEvent(MedalEvent.MEDAL_RESTARTGAME));
         }
      }
      
      private function submitScoreFromJs(param1:String) : void
      {
         this._submitType = param1;
         if(!this.mainProxy.isLog)
         {
            this.isSubmitScore = true;
            this.mainProxy._isMedalLog = true;
            this.mainProxy.getLogUser();
            return;
         }
         this.GuserName = this.mainProxy.userName;
         this.userID = this.mainProxy.userID;
         switch(this._submitType)
         {
            case this.SUBMIT_TYPE_AUTO:
               this.updateScroe(this._totalScore);
               break;
            case this.SUBMIT_TYPE_MANUL:
               this.updateScroe(this._curScore);
               break;
            default:
               trace("未知以何种方式提交");
         }
      }
      
      private function updateScroe(param1:uint) : void
      {
         var score:uint = param1;
         if(ExternalInterface.available && (this.gameID == "" || this.gameID == null))
         {
            try
            {
               this.gameID = ExternalInterface.call("get4399id");
            }
            catch(e:Error)
            {
               trace("get4399id:" + e.toString());
               callJsReturnListData(_submitType,SUBMIT_RESULT_SUBMIT_ERROR);
               return;
            }
         }
         if(this.gameID == "" || this.gameID == null)
         {
            this.callJsReturnListData(this._submitType,this.SUBMIT_RESULT_SUBMIT_ERROR);
            return;
         }
         LoaderManager.loadBytes(AllConst.URL_TOKEN,function(param1:Event):void
         {
            var tmp:String;
            var _tokenData:String;
            var md:Date;
            var ts:String;
            var temKey:String;
            var verify:String;
            var variables:URLVariables;
            var e:Event = param1;
            if(e.type != Event.COMPLETE)
            {
               callJsReturnListData(_submitType,SUBMIT_RESULT_SUBMIT_ERROR);
               return;
            }
            tmp = e.target.data;
            _tokenData = tmp.substring(7);
            md = new Date();
            ts = md.getTime().toString();
            temKey = MD5.hash(MD5.hash(gameID + "LPislKLodlLKKOSNlSDOAADLKADJAOADALAklsd" + gameID)).substr(4,16);
            verify = MD5.hash(MD5.hash(MD5.hash("SDALPlsldlnSLWPElsdslSE" + temKey + score + gameID + _tokenData + "PKslsO")));
            variables = new URLVariables();
            variables.game_key = temKey;
            variables.game_id = gameID;
            variables.token = _tokenData;
            variables.time = ts;
            variables.verify = verify;
            variables.uid = userID;
            variables.username = GuserName;
            variables.score = score;
            LoaderManager.loadBytes(AllConst.URL_MEDAL,function(param1:Event):void
            {
               if(param1.type != Event.COMPLETE)
               {
                  callJsReturnListData(_submitType,SUBMIT_RESULT_SUBMIT_ERROR);
                  return;
               }
               var _loc2_:String = param1.target.data;
               var _loc3_:String = _loc2_.substring(0,1);
               if(_loc3_ != "[")
               {
                  callJsReturnListData(_submitType,SUBMIT_RESULT_NET_ERROR);
                  return;
               }
               if(_submitType == SUBMIT_TYPE_AUTO)
               {
                  callJsReturnListData(_submitType,_loc2_);
               }
               else
               {
                  callJsReturnListData(_submitType,SUBMIT_RESULT_MANUL_SUCC);
               }
            },variables);
         });
      }
      
      private function callJsReturnListData(param1:String, param2:String) : void
      {
         var type:String = param1;
         var data:String = param2;
         if(ExternalInterface.available)
         {
            try
            {
               ExternalInterface.call("returnListData",type,data);
            }
            catch(e:Error)
            {
               trace("returnListData:" + e.toString());
            }
         }
      }
   }
}

