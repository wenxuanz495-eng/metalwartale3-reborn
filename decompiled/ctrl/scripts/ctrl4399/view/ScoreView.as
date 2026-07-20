package ctrl4399.view
{
   import ctrl4399.proxy.MainProxy;
   import ctrl4399.proxy.ScoreProxy;
   import ctrl4399.proxy.SortProxy;
   import ctrl4399.strconst.AllConst;
   import ctrl4399.view.components.CWinLogScore;
   import ctrl4399.view.components.CWinScore;
   import ctrl4399.view.components.CWinSort;
   import ctrl4399.view.components.ComponentEvent;
   import flash.display.DisplayObject;
   import flash.events.Event;
   import frame4399.simplePureMvc.core.Facade;
   import frame4399.simplePureMvc.core.Notification;
   import frame4399.simplePureMvc.interfaces.IMediator;
   import frame4399.simplePureMvc.mediator.Mediator;
   
   public class ScoreView extends Mediator implements IMediator
   {
      
      private var main:*;
      
      private var _facade:Facade = Facade.getInstance();
      
      private var scoreProxy:ScoreProxy;
      
      private var mainProxy:MainProxy;
      
      private var _scoreWin:CWinScore;
      
      private var _sortBox:CWinSort;
      
      private var boxLog:CWinLogScore;
      
      private var _score:int;
      
      private var _isChange:Boolean = false;
      
      private var isSortOut:Boolean = true;
      
      private var _sortProxy:SortProxy;
      
      public function ScoreView(param1:String, param2:Object)
      {
         super(param1);
         this.mainProxy = this._facade.retrieveProxy(AllConst.PROXY_NAME_MAIN) as MainProxy;
         this.scoreProxy = this._facade.retrieveProxy(AllConst.PROXY_NAME_SCORE) as ScoreProxy;
      }
      
      override public function listNotificationInterests() : Array
      {
         return [AllConst.MVC_LOG_SUCCESS,AllConst.MVC_SHOW_SCORE,AllConst.MVC_SCORE_RETURN,AllConst.MVC_LOGOUT,AllConst.OPEN_SCORE_LOG_WIN,AllConst.MVC_SORT_RETURN,AllConst.MVC_SORT_REQUEST,AllConst.UPDATA_SORT_PIC,AllConst.MVC_LOGOUT,AllConst.LOAD_SORT_DATA_ERROR,AllConst.UP_DATA_SCORE,AllConst.MVC_COLSE_NOLOGWIN,AllConst.MVC_SCORE_TIP];
      }
      
      override public function handleNotification(param1:Notification) : void
      {
         var _loc3_:Boolean = false;
         var _loc2_:* = param1.getBody();
         switch(param1.getName())
         {
            case AllConst.MVC_SHOW_SCORE:
               this._score = _loc2_[0];
               this.openScoreWin(_loc2_[0]);
               break;
            case AllConst.MVC_SCORE_RETURN:
            case AllConst.OPEN_SCORE_LOG_WIN:
               this.isSortOut = false;
               this.openScoreLogWin(param1.getBody() as Array);
               break;
            case AllConst.MVC_SCORE_TIP:
               this.openScoreLogWin(null);
               this.openScoreLogWinTip(param1.getBody() as String);
               break;
            case AllConst.MVC_LOGOUT:
               this.closeScoreLogWin();
               if(this._isChange && !this.isSortOut)
               {
                  break;
               }
               this.closeSortWin();
               break;
            case AllConst.MVC_SORT_RETURN:
               this.upDataList(param1.getBody().data as Array,param1.getBody().type);
               break;
            case AllConst.MVC_SORT_REQUEST:
               if(_loc2_ == null)
               {
                  _loc3_ = false;
               }
               else
               {
                  _loc3_ = true;
               }
               if(this._isChange != _loc3_)
               {
                  this.closeSortWin();
                  this._isChange = _loc3_;
               }
               this.openSortWin();
               break;
            case AllConst.UPDATA_SORT_PIC:
               this.updataPicHandler(param1.getBody());
               break;
            case AllConst.LOAD_SORT_DATA_ERROR:
               this.showError(param1.getBody() as String);
               break;
            case AllConst.UP_DATA_SCORE:
               this.closeScoreWin();
               this.scoreProxy.referScore(_loc2_[0]);
               break;
            case AllConst.MVC_COLSE_NOLOGWIN:
               this.closeScoreWin();
         }
      }
      
      private function openScoreLogWinTip(param1:String) : void
      {
         this.boxLog.showTip(param1);
      }
      
      private function openScoreWin(param1:int) : void
      {
         if(this._scoreWin == null && this.boxLog == null)
         {
            this._scoreWin = new CWinScore();
            this._scoreWin.showScore(param1);
            this._scoreWin.addEventListener("openLogWin",this.openLogWin,false,0,true);
            this._scoreWin.addEventListener("openRegWin",this.openRegWin,false,0,true);
            this._scoreWin.addEventListener(AllConst.CLOSE_BTN_CLICK,this.closeScoreWin,false,0,true);
         }
      }
      
      private function openLogWin(param1:Event) : void
      {
         this.mainProxy.addNeedFunc("openIntegralWin",[this._score]);
         sendNotification(AllConst.MVC_SHOW_LOGBOX);
      }
      
      private function openRegWin(param1:Event) : void
      {
         this.mainProxy.addNeedFunc("openIntegralWin",[this._score]);
         sendNotification(AllConst.MVC_SHOW_REGBOX);
      }
      
      private function closeScoreWin(param1:Event = null) : void
      {
         if(this._scoreWin == null)
         {
            return;
         }
         this._scoreWin.removeEventListener("openLogWin",this.openLogWin);
         this._scoreWin.removeEventListener("openRegWin",this.openRegWin);
         this._scoreWin.removeEventListener(AllConst.CLOSE_BTN_CLICK,this.closeScoreWin);
         if(param1 == null)
         {
            this._scoreWin.disPose();
         }
         this._scoreWin = null;
         sendNotification(AllConst.MVC_CLOSE_PANEL,AllConst.CLOSE_SCORE_WIN);
      }
      
      private function openScoreLogWin(param1:Array) : void
      {
         if(this.boxLog == null)
         {
            this.boxLog = new CWinLogScore();
            this.boxLog.showUserInfo(param1);
            this.boxLog.addEventListener(AllConst.CLOSE_BTN_CLICK,this.closeScoreLogWin,false,0,true);
         }
      }
      
      private function closeScoreLogWin(param1:Event = null) : void
      {
         if(this.boxLog == null)
         {
            return;
         }
         this.boxLog.removeEventListener(AllConst.CLOSE_BTN_CLICK,this.closeScoreLogWin);
         if(param1 == null)
         {
            this.boxLog.disPose();
         }
         sendNotification(AllConst.MVC_CLOSE_PANEL,AllConst.CLOSE_LOG_SCORE_WIN);
         this.boxLog = null;
      }
      
      private function showError(param1:String) : void
      {
         if(this._sortBox != null)
         {
            this._sortBox.showError(param1);
         }
      }
      
      private function openSortWin() : void
      {
         if(this._sortBox != null)
         {
            return;
         }
         this._sortBox = new CWinSort();
         this._sortBox.isSortAPi = this._isChange;
         this._sortBox.addEventListener(AllConst.CHANGE_SORT_TYPE,this.loadSortDataHandler,false,0,true);
         this._sortBox.addEventListener(AllConst.SORT_WIN_BAKC,this.sortBackHandler,false,0,true);
         this._sortBox.addEventListener(AllConst.CLOSE_BTN_CLICK,this.closeSortWin,false,0,true);
         this._sortBox.start();
      }
      
      private function loadSortDataHandler(param1:ComponentEvent) : void
      {
         if(this._sortProxy == null)
         {
            this._sortProxy = Facade.getInstance().retrieveProxy(AllConst.PROXY_NAME_SORT) as SortProxy;
         }
         this._sortProxy.loadSortData(param1.data as String);
      }
      
      private function sortBackHandler(param1:Event) : void
      {
         this.closeSortWin();
         var _loc2_:ScoreProxy = Facade.getInstance().retrieveProxy(AllConst.PROXY_NAME_SCORE) as ScoreProxy;
         var _loc3_:Array = _loc2_.getScoreData();
         sendNotification(AllConst.OPEN_SCORE_LOG_WIN,_loc3_);
      }
      
      private function updataPicHandler(param1:Object) : void
      {
         if(param1 == null || this._sortBox == null)
         {
            return;
         }
         trace("sortView.updataPicHandler");
         this._sortBox.updataPic(param1.pic as DisplayObject,param1.type,param1.uid);
      }
      
      private function closeSortWin(param1:Event = null) : void
      {
         if(param1 == null)
         {
            if(this._sortBox != null)
            {
               this._sortBox.disPose();
            }
         }
         if(this._sortBox != null)
         {
            this._sortBox.removeEventListener(AllConst.CHANGE_SORT_TYPE,this.loadSortDataHandler);
            this._sortBox.removeEventListener(AllConst.SORT_WIN_BAKC,this.sortBackHandler);
            this._sortBox.removeEventListener(AllConst.CLOSE_BTN_CLICK,this.closeSortWin);
            this._sortBox = null;
         }
         if(this._sortProxy == null)
         {
            this._sortProxy = Facade.getInstance().retrieveProxy(AllConst.PROXY_NAME_SORT) as SortProxy;
         }
         this._sortProxy.clearData();
         sendNotification(AllConst.MVC_CLOSE_PANEL,AllConst.CLOSE_SORT_WIN);
      }
      
      private function upDataList(param1:Array, param2:String) : void
      {
         if(this._sortBox == null)
         {
            return;
         }
         this._sortBox.upDataList(param1,param2);
      }
   }
}

