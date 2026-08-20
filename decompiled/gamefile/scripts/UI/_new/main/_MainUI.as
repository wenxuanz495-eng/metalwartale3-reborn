package UI._new.main
{
   import UI.main.MainUI;
   import flash.display.DisplayObject;
   import flash.display.DisplayObjectContainer;
   import flash.display.Loader;
   import flash.display.SimpleButton;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.IOErrorEvent;
   import flash.events.MouseEvent;
   import flash.net.URLRequest;
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

      private var growNewBadge:DisplayObject;

      private var autoRestartButton:Sprite;

      private var autoNextButton:Sprite;
      
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
         this.growNewBadge = this.findGrowNewBadge();
         if(this.growNewBadge != null)
         {
            this.growNewBadge.visible = false;
         }
         this.replaceButtonText(this.firstPayGift_btn,["首充礼包"],"新手礼包");
         this.replaceButtonText(this.giftExchange_btn,["礼包兑换"],"感谢赞助");
         this.replaceDisplayText(this,["礼包兑换"],"感谢赞助");
         // The visible label is a sibling timeline TextField, not a child of allGift_btn.
         this.replaceDisplayText(this,["累计充值值奖励","累计充值值礼包","累计充值奖励","累计充值礼包","累计MB礼包"],"累计MB奖励");
         this.createAutoLevelControls();
      }

      private function createAutoLevelControls() : *
      {
         this.autoRestartButton = this.makeAutoLevelButton("自动重新挑战","autoRestartLevel",24,350);
         this.autoNextButton = this.makeAutoLevelButton("自动进入下一关","autoNextLevel",24,388);
         addChild(this.autoRestartButton);
         addChild(this.autoNextButton);
         this.refreshAutoLevelControls();
      }

      private function makeAutoLevelButton(label0:String, key0:String, x0:Number, y0:Number) : Sprite
      {
         var button0:Sprite = new Sprite();
         var text0:TextField = new TextField();
         button0.name = key0;
         button0.x = x0;
         button0.y = y0;
         button0.buttonMode = true;
         button0.mouseChildren = false;
         button0.graphics.beginFill(0,0);
         button0.graphics.drawRect(0,0,114,36);
         button0.graphics.endFill();
         this.addAutoLevelImage(button0,"ui/auto-level/button-normal.png","normal");
         this.addAutoLevelImage(button0,"ui/auto-level/button-selected.png","selected");
         text0.defaultTextFormat = new flash.text.TextFormat("_sans",14,16777215,true,null,null,null,null,"center");
         text0.width = 114;
         text0.height = 24;
         text0.y = 7;
         text0.text = label0;
         text0.mouseEnabled = false;
         button0.addChild(text0);
         button0.addEventListener(MouseEvent.CLICK,this.autoLevelButtonClick);
         return button0;
      }

      private function addAutoLevelImage(target0:Sprite, path0:String, role0:String) : *
      {
         var loader0:Loader = new Loader();
         loader0.name = role0;
         loader0.mouseEnabled = false;
         loader0.contentLoaderInfo.addEventListener(Event.COMPLETE,this.autoLevelImageComplete);
         loader0.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR,this.autoLevelImageError);
         target0.addChild(loader0);
         loader0.load(new URLRequest(path0));
      }

      private function autoLevelImageComplete(e:Event) : *
      {
         var loader0:Loader = e.target.loader as Loader;
         loader0.content.width = 114;
         loader0.content.height = 36;
         this.refreshAutoLevelControls();
      }

      private function autoLevelImageError(e:IOErrorEvent) : *
      {
      }

      private function autoLevelButtonClick(e:MouseEvent) : *
      {
         if(e.currentTarget == this.autoRestartButton)
         {
            Game.gameData.autoRestartLevel = !Game.gameData.autoRestartLevel;
            if(Game.gameData.autoRestartLevel)
            {
               Game.gameData.autoNextLevel = false;
            }
         }
         else
         {
            Game.gameData.autoNextLevel = !Game.gameData.autoNextLevel;
            if(Game.gameData.autoNextLevel)
            {
               Game.gameData.autoRestartLevel = false;
            }
         }
         this.refreshAutoLevelControls();
         Game.uiGroup.saveDataNoUI();
      }

      private function refreshAutoLevelControls() : *
      {
         this.setAutoLevelButtonState(this.autoRestartButton,Game.gameData.autoRestartLevel);
         this.setAutoLevelButtonState(this.autoNextButton,Game.gameData.autoNextLevel);
      }

      private function setAutoLevelButtonState(button0:Sprite, selected0:Boolean) : *
      {
         var child0:DisplayObject = null;
         var i0:int = 0;
         if(button0 == null)
         {
            return;
         }
         while(i0 < button0.numChildren)
         {
            child0 = button0.getChildAt(i0);
            if(child0.name == "normal") child0.visible = !selected0;
            if(child0.name == "selected") child0.visible = selected0;
            i0++;
         }
      }

      private function findGrowNewBadge() : DisplayObject
      {
         var child:DisplayObject = null;
         var i:int = 0;
         while(i < this.numChildren)
         {
            child = this.getChildAt(i);
            if(Math.abs(child.x - 553.4) < 1 && Math.abs(child.y - 168.95) < 1 && child.width >= 30 && child.width <= 34 && child.height >= 30 && child.height <= 34)
            {
               return child;
            }
            i++;
         }
         return null;
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
         this.refreshAutoLevelControls();
      }
      
      public function fleshBtn() : *
      {
         // Keep the constellation-weapon entry visible after the player has
         // claimed all (or some) of the 12 weapons.  The claim screen still
         // disables individual claimed entries, but the navigation button is
         // intentionally persistent.
         this.conChoose_btn.visible = true;
         this.firstPayGift_btn.y = this.firstGift_y;
         this.conChoose_btn.y = this.conArms_y;
         if(!this.firstPayGift_btn.visible && this.conChoose_btn.visible)
         {
            this.conChoose_btn.y = this.firstGift_y;
         }
      }
      
      public function startSaveDelay() : *
      {
         this.saveData_t = -1000;
         this.saveData_btn.alpha = 1;
         this.saveData_btn.mouseEnabled = true;
         this.saveDelay_txt.visible = false;
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
         this.saveData_btn.alpha = 1;
         this.saveData_btn.mouseEnabled = true;
         this.saveDelay_txt.visible = false;
      }
   }
}

