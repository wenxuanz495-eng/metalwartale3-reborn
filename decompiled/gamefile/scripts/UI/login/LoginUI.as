package UI.login
{
   import UI.ClickEvent;
   import UI.button.PicButton;
   import UI.label.LabelBox;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   
   public class LoginUI extends Sprite
   {
      
      public var headLabel:LabelBox = new LabelBox();
      
      public var headLabel2:LabelBox = new LabelBox();
      
      public var headLabel3:LabelBox = new LabelBox();
      
      public var headArr:Array = ["s1","s2","s3"];
      
      public var headArr2:Array = ["s1","s2","s3","s4","s5","s6","s7"];
      
      public var headArr3:Array = ["s8","s9","s10","s11","s12","s13","s14"];
      
      public var carLabel:LabelBox = new LabelBox();
      
      public var carArr:Array = ["white","beetle","whiteSmart"];
      
      public var nameTxt:TextField;
      
      public var createRole_btn:PicButton;
      
      public var carTxt:TextField;
      
      public var carBack:Sprite;
      
      public var nowCar:String = "white";
      
      public var nowHead:String = "s1";
      
      public var inputTip_mc:MovieClip;
      
      public var inputB:Boolean = true;
      
      public var headUnlock:* = null;
      
      public var headUnlockIndex:int = 0;
      
      public var cancel_btn:PicButton;
      
      public function LoginUI()
      {
         super();
         this.headLabel.setLabelClass(HeadBtn);
         this.headLabel.addLabel(this.headArr,300);
         addChild(this.headLabel);
         this.headLabel.x = 285 + 40;
         this.headLabel.y = 141;
         this.headLabel.addEventListener(ClickEvent.ON_CLICK,this.headClick);
         this.headLabel2.setLabelClass(HeadBtn,false);
         this.headLabel2.addLabel(this.headArr2,614);
         addChild(this.headLabel2);
         this.headLabel2.x = 135 + 40;
         this.headLabel2.y = 141 + 15;
         this.headLabel2.addEventListener(ClickEvent.ON_CLICK,this.headClick2);
         this.headLabel3.setLabelClass(HeadBtn,false);
         this.headLabel3.addLabel(this.headArr3,614);
         addChild(this.headLabel3);
         this.headLabel3.x = 135 + 40;
         this.headLabel3.y = 250 + 15;
         this.headLabel3.addEventListener(ClickEvent.ON_CLICK,this.headClick2);
         this.carLabel.setLabelClass(CarChooseBtn);
         this.carLabel.addLabel(this.carArr,523);
         addChild(this.carLabel);
         this.carLabel.x = 178 + 40;
         this.carLabel.y = 256;
         this.carLabel.addEventListener(ClickEvent.ON_CLICK,this.carClick);
         this.nameTxt.addEventListener(MouseEvent.CLICK,this.textClick);
         this.createRole_btn.setText("createRole");
         this.cancel_btn.setText("cancel");
         this.createRole_btn.addEventListener(MouseEvent.CLICK,this.yesClick);
         this.cancel_btn.addEventListener(MouseEvent.CLICK,this.noClick);
         this.inputTip_mc.stop();
         this.clearAll();
         this.showBox("");
      }
      
      public function showBox(str:String = "") : *
      {
         this.carTxt.visible = true;
         this.carBack.visible = true;
         this.carLabel.visible = true;
         this.headLabel.visible = true;
         this.headLabel2.visible = false;
         this.headLabel3.visible = false;
         this.cancel_btn.visible = false;
         this.createRole_btn.x = Game.stageWidth / 2 + 5;
         this.headLabel.showState(0);
         this.carLabel.showState(0);
         this.createRole_btn.setText("createRole");
         if(str == "head")
         {
            this.inputB = true;
            this.carTxt.visible = false;
            this.carBack.visible = false;
            this.carLabel.visible = false;
            this.headLabel.visible = false;
            this.headLabel2.visible = true;
            this.headLabel3.visible = true;
            this.fleshHead();
            this.createRole_btn.setText("saveHead");
            this.createRole_btn.x = 398;
            this.cancel_btn.visible = true;
         }
      }
      
      public function headClick(event:ClickEvent) : *
      {
         this.nowHead = this.headLabel.nowLabel;
      }
      
      public function headClick2(event:ClickEvent) : *
      {
         var hbtn:HeadBtn = event.goal;
         if(hbtn.state == 3)
         {
            Game.uiGroup.checkTip.showMustCheck(Game.gameDefine.headMust,"是否要解锁这个头像？",this.unlockHead);
            this.headUnlock = event.target;
            this.headUnlockIndex = event.index;
         }
         else
         {
            event.target.showState(event.index);
            if(event.target == this.headLabel2)
            {
               this.headLabel3.clearState();
            }
            else
            {
               this.headLabel2.clearState();
            }
            this.nowHead = hbtn.text;
         }
      }
      
      public function unlockHead() : *
      {
         var gcoin0:int = int(Game.gameDefine.headMust.GCoin);
         if(Game.gameData.GCoin < gcoin0)
         {
            Game.uiGroup.checkTip.showCheck2("G币不足，需要 " + gcoin0 + " G币。",2);
            return;
         }
         Game.gameData.addCoin(-gcoin0);
         Game.gameData.unlockHead(this.headUnlock.arr[this.headUnlockIndex].text);
         this.affterUnlockHead();
         Game.uiGroup.saveDataNoUI("解锁头像");
      }
      
      public function affterUnlockHead() : *
      {
         this.fleshHead();
         this.headLabel2.clearState();
         this.headLabel3.clearState();
         this.headUnlock.showState(this.headUnlockIndex);
         this.nowHead = this.headUnlock.nowLabel;
      }
      
      public function fleshHead() : *
      {
         this.nowHead = Game.gameData.headLabel;
         this.nameTxt.text = Game.gameData.playerName;
         this.fleshHeadLocks(this.headLabel2);
         this.fleshHeadLocks(this.headLabel3);
         var in0:int = this.headLabel2.getIndex(this.nowHead);
         if(in0 >= 0)
         {
            this.headLabel2.showState(in0);
         }
         else
         {
            in0 = this.headLabel3.getIndex(this.nowHead);
            this.headLabel3.showState(in0);
         }
      }

      private function fleshHeadLocks(labelBox:LabelBox) : *
      {
         var states:Array = [];
         var i:int = 0;
         while(i < labelBox.arr.length)
         {
            states.push(Game.gameData.isHeadUnlocked(labelBox.arr[i].text) ? 0 : 3);
            i++;
         }
         labelBox.setLock(states);
      }
      
      public function carClick(event:ClickEvent) : *
      {
         this.nowCar = this.carLabel.nowLabel;
      }
      
      public function textClick(event:MouseEvent) : *
      {
         this.inputB = true;
         if(this.nameTxt.text == "4399小战士")
         {
            this.nameTxt.text = "";
            this.nameTxt.removeEventListener(MouseEvent.CLICK,this.textClick);
         }
      }
      
      public function clearAll() : *
      {
         this.headLabel.clearState();
         this.headLabel2.clearState();
         this.headLabel3.clearState();
         this.carLabel.clearState();
      }
      
      public function yesClick(event:MouseEvent) : *
      {
         if(this.nameTxt.text != "" && this.inputB)
         {
            if(this.headLabel2.visible)
            {
               this.affter_yesClick();
               this.visible = false;
            }
            else
            {
               this.affter_yesClick();
            }
         }
         else
         {
            this.inputTip_mc.gotoAndPlay(2);
         }
      }
      
      public function affter_yesClick() : *
      {
         Game.gameData.headLabel = this.nowHead;
         Game.gameData.playerName = Game.sensitiveWords.encode(this.nameTxt.text);
         if(this.headLabel2.visible)
         {
            this.visible = false;
         }
         else
         {
            Game.gameData.nowCarLabel = this.nowCar;
            Game.gameData.carItems.equArr.length = 0;
            Game.gameData.carItems.addItems(this.nowCar);
            Game.gameData.carItems.loadFirstEquip();
            Game.gameData.carItems.addItems("beetle",true,null);
            Game.eventGroup.fleshCar();
            Game.uiGroup.carShow.copyAll();
            Game.uiGroup.show("createRole");
         }
         Game.uiGroup.infoUI.fleshData();
         this.clearAll();
         this.visible = false;
      }
      
      public function noClick(event:MouseEvent) : *
      {
         this.visible = false;
      }
   }
}

