package gameAll.level
{
   import enemy.bansheeFighter.BansheeFighterBody;
   import enemy.gundam.GundamBody;
   import flash.geom.Point;
   import gameAll.data.GameData;
   
   public class Level_3 extends Levels
   {
      
      private var gundam:GundamBody;
      
      private var gundamFun:Function;
      
      public var gundamSayLabel:String = "";
      
      public var state:String = "";
      
      public var banshee:BansheeFighterBody;
      
      public function Level_3()
      {
         super();
      }
      
      override protected function hitAreaEvent(id0:String, isEventOrderDefineGroupB:Boolean = true) : *
      {
         var str0:String = null;
         super.hitAreaEvent(id0,isEventOrderDefineGroupB);
         if(id0 == "enemy2")
         {
            this.gundamShow();
         }
         else if(id0 == "banshee")
         {
            str0 = Game.gameDefine.dialogue.text["d1_3_5"];
            Game.dialogboxGroup.showDialog(this.banshee,str0,null,3);
            addOnceFun(Game.eventGroup.gameWin,4 / 5);
         }
      }
      
      override public function bodyAdd(b0:*) : *
      {
         super.bodyAdd(b0);
         if(b0.type == "boss")
         {
            this.gundamSayLabel = "d1_3_2";
            addOnceFun(this.gundamSay,2 / 5);
            addOnceFun(this.gundamChange,4 / 5);
            addOnceFun(this.gundamLeave,1.5 / 5);
            addOnceFun(this.delGundam,5 / 5);
         }
      }
      
      override public function bodyDie(b0:*) : *
      {
         var minY:int = 0;
         var GD0:GameData = null;
         super.bodyDie(b0);
         if(b0.type == "boss")
         {
            minY = Game.BGHit.getMinY(4800);
            this.banshee = BG.addBansheeFighter("2");
            this.banshee.x = 4800;
            this.banshee.y = minY - 100;
            this.banshee.mot.followPoint(4800,minY - 100);
            this.banshee.ai.enabled = false;
            GD0 = Game.gameData;
            if(GD0.level < 4)
            {
               GD0.addExp(GD0.maxExp - GD0.nowExp + 200);
            }
         }
      }
      
      private function gundamShow() : *
      {
         this.gundam = BG.addGundam();
         this.gundam.setLevel(1000);
         this.gundam.hitHurtB = 1;
         this.gundam.changeState("fly");
         this.gundam.ai.enabled = false;
         this.gundam.mot.x0 = hero.img.x + 800;
         this.gundam.mot.y0 = hero.img.y - 200;
         this.gundam.img.flipToRight();
         var p0:Point = Game.oneScene.getPositionMiddle();
         var minY:int = Game.BGHit.getMinY(p0.x);
         this.gundam.mot.followPoint(p0.x + Game.stageWidth / 2,minY - 180);
         addFun(this.gundamGoto);
         this.gundamFun = this.gundamSay;
         this.gundamSayLabel = "d1_3_1";
      }
      
      private function gundamGoto() : *
      {
         if(this.gundam.mot.getGap() < 30)
         {
            addOnceFun(this.gundamFun,1 / 5);
            removeFun(this.gundamGoto);
         }
      }
      
      private function gundamSay() : *
      {
         var str0:String = Game.gameDefine.dialogue.text[this.gundamSayLabel];
         Game.dialogboxGroup.showDialog(this.gundam,str0,null,4);
      }
      
      private function gundamChange() : *
      {
         this.gundam.changeState("plane");
      }
      
      private function gundamLeave() : *
      {
         this.gundam.changeState("plane");
         this.gundam.mot.followPoint(-2800,-1300);
         this.gundam.img.flipToRight();
         this.gundam.speedUp(0.6);
         this.gundam.hitHurtB = 1;
      }
      
      private function delGundam() : *
      {
         BG.clearArr(BG.Gundam_arr);
         this.gundam = null;
      }
   }
}

