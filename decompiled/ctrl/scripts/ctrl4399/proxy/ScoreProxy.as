package ctrl4399.proxy
{
   import com.adobe.crypto.MD5;
   import ctrl4399.proxy.scoreApi.*;
   import ctrl4399.strconst.AllConst;
   import flash.utils.Dictionary;
   import frame4399.simplePureMvc.core.Facade;
   import frame4399.simplePureMvc.interfaces.IProxy;
   import frame4399.simplePureMvc.proxy.Proxy;
   
   public class ScoreProxy extends Proxy implements IProxy
   {
      
      public var score:int = 0;
      
      private var mainProxy:MainProxy;
      
      private var _sortProxy:SortProxy;
      
      private var _facade:Facade = Facade.getInstance();
      
      private var scoreReturn:Array;
      
      private var _userName:String;
      
      private var _oldScore:int;
      
      private var _scoreData:Array;
      
      private var client:DevScoreImpl;
      
      private var logSubmitScore:LogData;
      
      public function ScoreProxy(param1:String = null)
      {
         super(param1);
         this._userName = "";
         this._oldScore = 0;
         this.mainProxy = this._facade.retrieveProxy(AllConst.PROXY_NAME_MAIN) as MainProxy;
         this.client = new DevScoreImpl(ThriftClient.createClient(AllConst.URL_SCORE));
      }
      
      private function get sortProxy() : SortProxy
      {
         return this._facade.retrieveProxy(AllConst.PROXY_NAME_SORT) as SortProxy;
      }
      
      private function getIntegraKey() : String
      {
         return MD5.hash(MD5.hash(this.mainProxy.gameID + "LPislKLodlLKKOSNlSDOAADLKADJAOADALAklsd" + this.mainProxy.gameID)).substr(4,16);
      }
      
      public function referScore(param1:int) : void
      {
         this.score = param1;
         if(this.mainProxy.userName == this._userName)
         {
            if(this.score == this._oldScore)
            {
               sendNotification(AllConst.MVC_SCORE_RETURN,this._scoreData);
               return;
            }
         }
         this._userName = this.mainProxy.userName;
         this._oldScore = this.score;
         var _loc2_:String = this.getIntegraKey();
         var _loc3_:String = MD5.hash(MD5.hash(MD5.hash("SDALPlsldlnSLWPElsdslSE" + _loc2_ + this.score + this.mainProxy.gameID + "PKslsO")));
         this.logSubmitScore = new LogData(LogData.API_SCORE,"submitScore");
         this.client.submitScore(int(this.mainProxy.gameID),this.mainProxy.userID,this.score,_loc2_,_loc3_,0,1,this.onSubmitError,this.onSubmitSuccess);
      }
      
      private function onSubmitError(param1:Error) : void
      {
         this.logSubmitScore.exception = param1.toString();
         this.logSubmitScore.submit();
         trace(param1.errorID,param1.message);
      }
      
      private function onSubmitSuccess(param1:ReturnSubmitScore) : void
      {
         var _loc5_:* = undefined;
         var _loc6_:OneScoreRank = null;
         this.logSubmitScore.submit(true);
         var _loc2_:String = String(param1.code);
         if(_loc2_ != "10000")
         {
            this._scoreData = null;
            trace(param1.message);
            if(_loc2_ == "10006")
            {
               sendNotification(AllConst.MVC_SCORE_TIP,"数值超过上下限！");
            }
            return;
         }
         var _loc3_:SubmitReturn = param1.data as SubmitReturn;
         this.scoreReturn = new Array();
         this.scoreReturn.push(String(_loc3_.score));
         this.scoreReturn.push(_loc3_.rank);
         this.scoreReturn.push(_loc3_.getMedal);
         this.scoreReturn.push(_loc3_.medal);
         this.scoreReturn.push(_loc3_.maxScore);
         this.scoreReturn.push(_loc3_.maxRank);
         this.scoreReturn.push(_loc3_.message);
         this.scoreReturn.push(_loc3_.rankingLength);
         var _loc4_:Dictionary = _loc3_.ranking;
         for(_loc5_ in _loc4_)
         {
            _loc6_ = _loc4_[_loc5_];
            this.scoreReturn.push(String(_loc6_.uId));
            this.scoreReturn.push(_loc6_.rank);
            this.scoreReturn.push(_loc6_.userName);
            this.scoreReturn.push(_loc6_.score);
         }
         this._scoreData = this.scoreReturn;
         sendNotification(AllConst.MVC_SCORE_RETURN,this.scoreReturn);
      }
      
      public function getScoreData() : Array
      {
         return this._scoreData;
      }
   }
}

