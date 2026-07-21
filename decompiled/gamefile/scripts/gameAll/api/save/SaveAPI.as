package gameAll.api.save
{
   import UI.LoadingUI;
   import data.StringDate;
   
   public class SaveAPI
   {
      
      public var localSave:LocalSave = new LocalSave();
      
      public var s4399:Save4399 = new Save4399();
      
      public var loadUI:LoadingUI;
      
      private var localReadIndex:int = 2;
      
      private var localCreateRequested:Boolean = false;
      
      private var returnBusy:Boolean = false;
      
      public function SaveAPI()
      {
         super();
         this.s4399.yes_closePanel_fun = this.closePanel;
         this.s4399.yes_outLogin_fun = this.outLogin;
         this.s4399.yes_login_fun = this.login;
      }
      
      public function init() : *
      {
         this.s4399.serviceHold = Game.serviceHold;
         this.s4399.addListener(Game.ME.stage);
         this.loadUI = Game.loadingUI;
      }
      
      public function game_init() : *
      {
         if(this.isLocal())
         {
            var localTime:String = Game.getNowLocalTime();
            Game.timeDate.getSaveDate.inData_byStr(localTime);
            Game.severTime.nowTime.inData_byStr(localTime);
            Game.gameData.username = "本地玩家";
            Game.gameData.uid = 1;
            this.loadUI.hide();
            Game.uiGroup.serverUI.show(this.readlist,this.read);
         }
         else
         {
            Game.severTime.getTime(this.next_game_init,this.next_game_init);
         }
      }
      
      private function next_game_init(time0:String) : *
      {
         Game.timeDate.getSaveDate.inData_byStr(time0);
         if(this.isLocal())
         {
            this.read();
         }
         else
         {
            this.showLogPanel();
         }
      }
      
      public function showLogPanel() : *
      {
         if(!this.s4399.isLogin())
         {
            Game.testText.addTestText("显示登陆框……");
            this.loadUI.show();
            this.s4399.showLogPanel();
         }
      }
      
      private function login(obj0:Object) : *
      {
         Game.testText.addTestText("登录成功：" + obj0.name);
         Game.gameData.username = obj0.name;
         Game.gameData.uid = int(obj0.uid);
         this.loadUI.hide();
         Game.uiGroup.serverUI.show(this.readlist,this.read);
      }
      
      private function outLogin() : *
      {
         this.returnToMainMenu();
      }
      
      public function returnToMainMenu() : *
      {
         if(this.returnBusy)
         {
            return;
         }
         this.returnBusy = true;
         Game.testText.addTestText("返回本地主菜单。");
         if(this.isLocal() && Game.saveExistB)
         {
            this.loadUI.show();
            this.localSave.WriteServer(Game.gameData.copyObj(),this.returnToLocalMenu,this.returnToLocalMenu);
            return;
         }
         this.returnToLocalMenu();
      }
      
      private function returnToLocalMenu(str0:String = "") : *
      {
         this.returnBusy = false;
         this.loadUI.hide();
         Game.ME.closeLevel();
         Game.uiGroup.mainUI.levelGift.hide(true);
         Game.uiGroup.shopUI.clearAll();
         Game.uiGroup.unionUI.clearAll();
         Game.eventGroup.clearAllCtrl();
         Game.uiGroup.mainUI.hideAll();
         Game.payController.init();
         Game.payController2.init();
         Game.gameState = "no";
         Game.uiGroup.show("fase");
         Game.uiGroup.serverUI.InitSever();
         Game.uiGroup.checkTip.hide();
         Game.uiGroup.serverUI.show(this.readlist,this.read);
      }
      
      private function closePanel() : *
      {
         Game.testText.addTestText("关闭登陆框！");
         if(!this.s4399.isLogin())
         {
            this.loadUI.show();
            this.showLogPanel();
         }
      }
      
      public function save(showLoading:Boolean = true) : *
      {
         Game.testText.addTestText("开始存档……");
         var obj0:Object = Game.gameData.copyObj();
         if(this.isLocal())
         {
            this.localSave.WriteServer(obj0,this.yes_save,this.no_save);
         }
         else
         {
            if(showLoading)
            {
               this.loadUI.show();
            }
            this.s4399.save(obj0,this.yes_save,this.no_save);
         }
      }
      
      private function yes_save(str0:String = "") : *
      {
         Game.testText.addTestText("存档成功");
         this.loadUI.hide();
         if(Game.uiGroup.showSaveReturn)
         {
            Game.uiGroup.checkTip.showTip("存档成功！",1);
            Game.SG.playSound("upgradeArms");
            Game.uiGroup.showSaveReturn = false;
         }
      }
      
      private function no_save(str0:String = "") : *
      {
         Game.testText.addTestText("存档失败……");
         this.loadUI.hide();
         if(Game.uiGroup.showSaveReturn)
         {
            Game.uiGroup.checkTip.showTip("存档失败！",2);
            Game.SG.playSound("failureItems");
            Game.uiGroup.showSaveReturn = false;
            Game.payController.getStoreState();
         }
      }
      
      private function readlist() : void
      {
         this.loadUI.show();
         if(this.isLocal())
         {
            this.localSave.ReadList(this.yes_readlist,this.no_read);
         }
         else
         {
            this.s4399.readlist(this.yes_readlist,this.no_read);
         }
      }
      
      private function read(iscover:Boolean = false) : *
      {
         var obj0:Object = null;
         var obj2:Object = null;
         Game.testText.addTestText("开始读档……");
         this.loadUI.show();
         if(this.isLocal())
         {
            this.localReadIndex = Game.gameData.nowSaveIndex;
            this.localCreateRequested = iscover;
            if(iscover)
            {
               this.yes_read_local(null);
            }
            else
            {
               this.localSave.ReadServer(this.yes_read_local,this.no_read);
            }
         }
         else
         {
            this.s4399.nowIndex = Game.gameData.nowSaveIndex;
            this.s4399.read(this.yes_read,this.no_read,iscover);
         }
      }
      
      private function yes_read_local(obj0:Object) : *
      {
         var obj2:Object = {};
         if(obj0 == null && !this.localCreateRequested)
         {
            this.loadUI.hide();
            Game.uiGroup.serverUI.show(this.readlist,this.read);
            return;
         }
         this.localCreateRequested = false;
         obj2.data = obj0;
         obj2.title = "本地主存档";
         obj2.index = this.localReadIndex;
         obj2.datetime = Game.getNowLocalTime();
         this.yes_read(obj2);
      }
      
      private function yes_readlist(obj:Array) : void
      {
         Game.uiGroup.serverUI.SetSave(obj);
         Game.loadingUI.hide();
      }
      
      private function yes_read(obj0:Object) : *
      {
         Game.testText.addTestText("读档成功，合并数据。");
         Game.testText.addTestText("===================");
         var useObj:Object = null;
         Game.timeDate.nowSaveDate = new StringDate();
         if(Boolean(obj0))
         {
            if(obj0.hasOwnProperty("data"))
            {
               useObj = obj0.data;
               Game.testText.addTestText("--------title: " + obj0.title);
               Game.testText.addTestText("--------index: " + obj0.index);
               Game.testText.addTestText("--------datetime: " + obj0.datetime);
               Game.timeDate.nowSaveDate.inData_byStr(obj0.datetime);
            }
         }
         Game.replaceGameData(useObj);
         if(this.isLocal() && obj0 != null && obj0.hasOwnProperty("index"))
         {
            Game.gameData.nowSaveIndex = int(obj0.index);
         }
         if(Game.timeDate.lastLoginToGet() >= 1)
         {
            Game.testText.addTestText("新的一天上线，清空经验卡使用和任务更新！！！！！！！");
            Game.gameData.newDayCtrl();
         }
         Game.ME.faseBtnShow();
         Game.gameData.rankAdd.lastLoginTime.inData_byObj(Game.severTime.nowTime);
         Game.zuobiTest();
         if(Game.gameData.isZuobi)
         {
            Game.uiGroup.showZuobile("存档中 isZuobi=true；" + Game.gameData.zuobiStr);
         }
         else
         {
            Game.testText.addTestText("此账号没有作弊标记。");
         }
         Game.uiGroup.mainUI.isSended = false;
         Game.uiGroup.mainUI.isSendInt = 0;
         Game.uiGroup.mainUI.isSendInt2 = 0;
         Game.uiGroup.mainUI.sendGiftOldPlayer();
      }
      
      private function no_read(str0:String = "") : *
      {
         Game.testText.addTestText("读档失败：" + str0);
         Game.uiGroup.checkTip.showCheck2("读档失败！");
         this.loadUI.hide();
      }
      
      public function isLocal() : Boolean
      {
         return true;
      }
   }
}

