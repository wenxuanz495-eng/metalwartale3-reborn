package UI.level
{
   import UI.ClickEvent;
   import UI.label.LabelCtrl;
   import UI.main.InfoTipBox;
   import UI.page.PageBox;
   import flash.display.SimpleButton;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import gameAll.data.GameData;
   import gameAll.data.level.NewLevelData;
   import gameAll.data.level.OnePackData;
   
   public class LevelChooseUI extends Sprite
   {
      
      public var GD:GameData;
      
      public var nData:NewLevelData;
      
      public var light_sp:Sprite;
      
      public var p1_btn:SimpleButton;
      
      public var p2_btn:SimpleButton;
      
      public var labelCtrl:LabelCtrl = new LabelCtrl();
      
      public var txt_nowStar:TextField;
      
      public var pageBox:PageBox;
      
      public var levelBox:LevelBox = new LevelBox();
      
      public var difficultBox:DifficultBox;
      
      public var btn_star:SimpleButton;
      
      public var tipBox:InfoTipBox;
      
      public var nowMousePointer:int = 0;
      
      public function LevelChooseUI()
      {
         super();
         this.GD = Game.gameData;
         this.nData = this.GD.newLevelData;
         this.labelCtrl.inData([this.p1_btn,this.p2_btn],this.light_sp);
         this.labelCtrl.addEventListener(ClickEvent.ON_CLICK,this.labelClick);
         this.btn_star.addEventListener(MouseEvent.CLICK,this.StarGiftClick);
         this.levelBox.setLabelClass(LevelButton);
         this.levelBox.setNum(6,3,918,340);
         this.levelBox.x = 22;
         this.levelBox.y = 118;
         addChild(this.levelBox);
         this.difficultBox.addEventListener(ClickEvent.ON_CLICK,this.difficultClick);
         this.levelBox.addEventListener(ClickEvent.ON_CLICK,this.levelClick);
         this.levelBox.addEventListener(ClickEvent.ON_OVER,this.levelOver);
         this.levelBox.addEventListener(ClickEvent.ON_OUT,this.levelOut);
         this.levelBox.addEventListener(ClickEvent.ON_MOVE,this.levelMove);
         this.tipBox = new InfoTipBox();
         addChild(this.tipBox);
         this.tipBox.hide();
      }
      
      protected function StarGiftClick(event:Event) : void
      {
         Game.uiGroup.show("starGift");
      }
      
      public function fleshData() : *
      {
         this.showLabel(this.nData.levelPack);
         this.fleshLock();
         this.fleshDifficultBox();
         var nowMax:int = Game.gameData.newLevelData.plusAllStar();
         var allMax:int = Game.gameData.newLevelData.getAllStar();
         this.txt_nowStar.text = nowMax + "/" + allMax;
      }
      
      public function fleshPack() : *
      {
         var p0:OnePackData = this.nData.nowPack;
         this.levelBox.clear();
         if(p0.levelsMax != 0)
         {
            this.levelBox.setTotalNum(p0.levelsMax);
            this.levelBox.setPicFirst(this.nData.levelPack);
            this.levelBox.setName(Game.LG.getNormalNameArr(this.nData.levelPack));
         }
         this.pageBox.table = this.levelBox;
         this.pageBox.fleshByTable();
         this.fleshLock();
         this.fleshStar();
      }
      
      public function fleshLock() : *
      {
         var llevel:int = 0;
         var p0:OnePackData = this.nData.nowPack;
         if(this.nData.levelPack == "p1")
         {
            this.levelBox.setLock(p0.lockNum,p0.lockNum > 1);
         }
         else
         {
            if(p0.lockNum == 0)
            {
               llevel = this.nData.p1.lockNum;
               if(llevel >= 67)
               {
                  p0.lockNum = 1;
               }
            }
            if(p0.lockNum > 0)
            {
               this.levelBox.setLock(p0.lockNum,false);
            }
            else
            {
               this.levelBox.setLock(p0.lockNum);
            }
         }
      }
      
      private function fleshStar() : *
      {
         var star0:int = 0;
         var diff0:int = this.GD.nowDifficult;
         var levelPack0:String = this.nData.levelPack;
         var max0:int = this.nData.nowPack.levelsMax;
         var arr0:Array = [];
         for(var i:int = 0; i < max0; i++)
         {
            star0 = Game.gameDefine.getPassGradeIndex(this.GD.newLevelData.getScore(i,diff0,levelPack0));
            arr0.push(star0);
         }
         if(levelPack0 == "p1")
         {
            this.levelBox.setStar(arr0,true);
         }
         else
         {
            this.levelBox.setStar(arr0);
         }
      }
      
      private function labelClick(e:*) : *
      {
         this.showLabel(this.labelCtrl.nowLabel);
      }
      
      public function showLabel(str0:String) : *
      {
         if(this.nData.levelPack != str0 || this.levelBox.arr.length == 0)
         {
            this.nData.levelPack = str0;
            this.fleshPack();
         }
         this.nData.levelPack = str0;
         this.labelCtrl.setChoose_byLabel(str0);
      }
      
      private function difficultClick(event:ClickEvent) : *
      {
         var num:int = int(event.goal.nowDifficult);
         this.GD.nowDifficult = num;
         this.fleshDifficultBox();
      }
      
      private function fleshDifficultBox() : *
      {
         this.difficultBox.setState(this.GD.nowDifficult);
         this.fleshStar();
      }
      
      public function setNowStar(num0:int) : *
      {
         this.GD.newLevelData.setScore(num0,this.nowMousePointer,this.GD.nowDifficult,this.nData.levelPack);
      }
      
      private function levelClick(event:ClickEvent) : *
      {
         var index0:int = int(event.goal.index);
         Game.eventGroup.chosenLevel(index0,"normal",this.nData.levelPack);
      }
      
      private function levelOver(event:ClickEvent) : *
      {
         this.nowMousePointer = event.index;
         var lv0:int = Game.LG.filter.getEnemyLv(event.index,this.nData.levelPack);
         var str0:String = "";
         var grade0:String = Game.gameDefine.getPassGrade(this.GD.newLevelData.getScore(event.index,this.GD.nowDifficult,this.nData.levelPack));
         str0 += "<font color=\'#00FF00\'>过关评级：" + grade0 + "</font>";
         str0 += "\n推荐等级：" + (lv0 + 1) + "级";
         str0 += "\n" + "<font color=\'#FFFF00\'>可能掉落物品：</font>" + "\n" + Game.gameDefine.dropString_byLevel(lv0);
         this.tipBox.showText(str0);
         this.followToMouse();
      }
      
      private function levelMove(event:ClickEvent) : *
      {
         this.followToMouse();
      }
      
      private function levelOut(event:ClickEvent) : *
      {
         this.tipBox.hide();
      }
      
      private function followToMouse() : *
      {
         this.tipBox.x = mouseX - this.tipBox.width;
         this.tipBox.y = mouseY + 20;
         if(this.tipBox.height + this.tipBox.y + 20 > Game.stageHeight - 30)
         {
            this.tipBox.y = Game.stageHeight - 40 - 20 - this.tipBox.height;
         }
         if(this.tipBox.x < 10)
         {
            this.tipBox.x = 10;
         }
      }
      
      public function gotoLevel(lp0:String, diff0:int, lv0:int, fleshB:Boolean = true) : *
      {
         Game.gameData.nowDifficult = diff0;
         Game.eventGroup.chosenLevel(lv0,"normal",lp0);
         if(fleshB)
         {
            this.fleshData();
         }
      }
   }
}

