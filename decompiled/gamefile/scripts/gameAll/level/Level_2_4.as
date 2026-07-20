package gameAll.level
{
   import enemy.knowing.KnowingBody;
   import flash.geom.Point;
   
   public class Level_2_4 extends Levels
   {
      
      private var gundam:KnowingBody;
      
      private var gundamFun:Function;
      
      public var gundamSayLabel:String = "";
      
      public var state:String = "";
      
      public function Level_2_4()
      {
         super();
      }
      
      public function Level_6() : *
      {
      }
      
      override public function bodyAdd(b0:*) : *
      {
         super.bodyAdd(b0);
         if(b0.type == "boss")
         {
            this.gundam = b0;
            this.gundam.hitHurtB = 1;
            this.gundam.ai.enabled = false;
            addOnceFun(this.gundamLeave,8 / 5);
            addOnceFun(this.delGundam,5 / 5);
         }
      }
      
      private function gundamLeave() : *
      {
         var p0:Point = Game.oneScene.getPositionMiddle();
         this.gundam.mot.followPoint(p0.x + 20000,p0.y - 2000);
         Game.uiGroup.gamingUI.hideBossBar();
      }
      
      private function delGundam() : *
      {
         var n:* = undefined;
         var b0:* = undefined;
         for(n in BG.Rolling_arr)
         {
            b0 = BG.Rolling_arr[n];
            if(b0.define.lifeBar != null)
            {
               b0.define.lifeBar.visible = false;
            }
         }
         BG.clearArr(BG.Rolling_arr);
         this.gundam = null;
      }
   }
}

