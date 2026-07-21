package UI._new.main
{
   import UI.main.MainUI;
   import flash.display.DisplayObject;
   import flash.display.DisplayObjectContainer;
   import flash.display.SimpleButton;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import gameAll.data.GameData;
   
   public class _MainUI extends Sprite
   {
      
      public var GD:GameData;
      
      public var payEntityGift_btn:SimpleButton;
      
      public var levelGift_btn:SimpleButton;
      
      public var turntable_btn:SimpleButton;
      
      public var payActivity_btn:SimpleButton;
      
      public var allGift_btn:SimpleButton;
      
      public var giftExchange_btn:SimpleButton;
      
      public var xuehuaExchange_btn:SimpleButton;
      
      public var btn_51:SimpleButton;
      
      public var grow_btn:SimpleButton;
      
      public var firstPayGift_btn:SimpleButton;
      
      public var conChoose_btn:SimpleButton;
      
      public var saveData_btn:SimpleButton;
      
      public var dailySign_btn:SimpleButton;
      
      public var rankGift_btn:SimpleButton;
      
      public var liveness_btn:SimpleButton;
      
      public var helper_btn:SimpleButton;
      
      public var notice_btn:SimpleButton;
      
      public var bbs_btn:SimpleButton;
      
      private var firstGift_y:int = 0;
      
      private var conArms_y:int = 0;
      
      public var chooseLevel_btn:SimpleButton;
      
      public var task_btn:SimpleButton;
      
      public var arena_btn:SimpleButton;
      
      public var extra_btn:SimpleButton;
      
      public var vip_btn:SimpleButton;
      
      public var bigBtn_arr:Array;
      
      public var sever_txt:TextField;
      
      public var saveDelay_txt:TextField;
      
      public var SAVEDATA_TIME:int = 60;
      
      public var saveData_t:Number;
      
      public function _MainUI()
      {
         var n:* = undefined;
         this.bigBtn_arr = [];
         this.saveData_t = this.SAVEDATA_TIME;
         super();
         this.GD = Game.gameData;
         this.mouseEnabled = false;
         this.bigBtn_arr = [this.chooseLevel_btn,this.task_btn,this.arena_btn,this.extra_btn,this.vip_btn];
         for(n in this.bigBtn_arr)
         {
            this.bigBtn_arr[n].addEventListener(MouseEvent.CLICK,this.bigBtnClick);
         }
         this.startSaveDelay();
         this.firstGift_y = this.firstPayGift_btn.y;
         this.conArms_y = this.conChoose_btn.y;
         this.replaceButtonText(this.firstPayGift_btn,["首充礼包"],"新手礼包");
         this.replaceButtonText(this.allGift_btn,["累计充值值奖励","累计充值值礼包","累计充值奖励","累计充值奖励","累计充值礼包"],"累计MB礼包");
      }

      private function replaceButtonText(button:SimpleButton, oldValues:Array, newValue:String) : void
      {
         this.replaceDisplayText(button.upState,oldValues,newValue);
         this.replaceDisplayText(button.overState,oldValues,newValue);
         this.replaceDisplayText(button.downState,oldValues,newValue);
         this.replaceDisplayText(button.hitTestState,oldValues,newValue);
      }

      private function replaceDisplayText(display:DisplayObject, oldValues:Array, newValue:String) : void
      {
         var field:TextField = display as TextField;
         var container:DisplayObjectContainer = null;
         var oldValue:String = null;
         var i:int = 0;
         if(field != null)
         {
            for each(oldValue in oldValues)
            {
               if(field.text.indexOf(oldValue) >= 0)
               {
                  field.text = field.text.replace(oldValue,newValue);
               }
            }
            return;
         }
         container = display as DisplayObjectContainer;
         if(container != null)
         {
            while(i < container.numChildren)
            {
               this.replaceDisplayText(container.getChildAt(i),oldValues,newValue);
               i++;
            }
         }
      }
      
      public function initEvent(mainUI:MainUI) : *
      {
         this.saveData_btn.addEventListener(MouseEvent.CLICK,Game.uiGroup.saveData);
         this.payActivity_btn.addEventListener(MouseEvent.CLICK,mainUI.showPayActivityUI);
         this.payEntityGift_btn.addEventListener(MouseEvent.CLICK,mainUI.showPayEntityGiftUI);
         this.levelGift_btn.addEventListener(MouseEvent.CLICK,mainUI.showLevelGiftUI);
         this.turntable_btn.addEventListener(MouseEvent.CLICK,mainUI.showTurnTableUI);
         this.allGift_btn.addEventListener(MouseEvent.CLICK,mainUI.showAllGift);
         this.giftExchange_btn.addEventListener(MouseEvent.CLICK,mainUI.showGiftExchange);
         this.btn_51.addEventListener(MouseEvent.CLICK,mainUI.showGift_51);
         this.grow_btn.addEventListener(MouseEvent.CLICK,mainUI.showGrow);
         this.conChoose_btn.addEventListener(MouseEvent.CLICK,mainUI.showConChooseUI);
         this.dailySign_btn.addEventListener(MouseEvent.CLICK,mainUI.showDailySign);
         this.rankGift_btn.addEventListener(MouseEvent.CLICK,mainUI.rankGiftPan);
         this.liveness_btn.addEventListener(MouseEvent.CLICK,mainUI.showLivenessUI);
         this.helper_btn.addEventListener(MouseEvent.CLICK,mainUI.showHelper);
         this.notice_btn.addEventListener(MouseEvent.CLICK,mainUI.showNotice);
         this.bbs_btn.addEventListener(MouseEvent.CLICK,mainUI.gotoBBS);
         this.firstPayGift_btn.addEventListener(MouseEvent.CLICK,mainUI.firstPayUI.show);
      }
      
      public function fleshData() : *
      {
         this.fleshBtn();
      }
      
      public function fleshBtn() : *
      {
         this.conChoose_btn.visible = !Game.gameData.giftData.haveConB;
         this.firstPayGift_btn.y = this.firstGift_y;
         this.conChoose_btn.y = this.conArms_y;
         if(!this.firstPayGift_btn.visible && this.conChoose_btn.visible)
         {
            this.conChoose_btn.y = this.firstGift_y;
         }
      }
      
      public function startSaveDelay() : *
      {
         this.saveData_btn.alpha = 0.3;
         this.saveData_btn.mouseEnabled = false;
         this.saveDelay_txt.visible = true;
         this.saveData_t = this.SAVEDATA_TIME;
         this.saveDelay_txt.text = "" + int(this.saveData_t);
      }
      
      private function bigBtnClick(e:*) : *
      {
         var name0:String = e.target.name.split("_btn")[0];
         Game.uiGroup.show(name0);
      }
      
      public function FTimer1s() : *
      {
         var exp_str0:String = this.GD.rankAdd.getExpTime();
         var expMul:int = this.GD.rankAdd.expMul;
         if(expMul == 0)
         {
            exp_str0 = "";
         }
         var sname:Array = ["双线二区","双线三区","双线一区"];
         this.sever_txt.text = "当前版本号：" + Game.versionNumber + "\n" + exp_str0;
         Game.uiGroup.gamingUI.expTime_txt.text = exp_str0;
         if(this.saveData_t <= 0 && this.saveData_t > -1000)
         {
            this.saveData_t = -1000;
            this.saveData_btn.alpha = 1;
            this.saveData_btn.mouseEnabled = true;
            this.saveDelay_txt.visible = false;
         }
         else if(this.saveData_t != -1000)
         {
            this.saveData_t -= 1;
         }
         this.saveDelay_txt.text = int(this.saveData_t) + "";
      }
   }
}

