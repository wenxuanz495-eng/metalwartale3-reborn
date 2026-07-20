package gameAll.level.extra
{
   import gameAll.level.Levels;
   
   public class SpecialExtraLevel_8 extends Levels
   {
      
      public var expMul0:Number = 1;
      
      public function SpecialExtraLevel_8()
      {
         super();
      }
      
      override public function startLevel() : *
      {
         this.expMul0 = 1;
         super.startLevel();
         if(this.name == "僵尸狂潮")
         {
            return;
         }
         addOnceFun(this.affter05,0.5 / 6);
      }
      
      public function affter05() : *
      {
         Game.eventGroup.pauseGame();
         Game.uiGroup.checkTip.showCheck2("是否要花费 20M币 获得额外的双倍经验？",1,this.fun1,this.fun2);
      }
      
      private function fun1() : *
      {
         if(Game.gameData.MCoin < 20)
         {
            Game.uiGroup.checkTip.showCheck2("M币不足！",2,this.fun2);
         }
         else
         {
            Game.payController.decMCoin(20,this.fun3,this.fun2);
         }
      }
      
      private function fun2() : *
      {
         this.expMul0 = 1;
         Game.eventGroup.resumeGame();
      }
      
      private function fun3() : *
      {
         this.expMul0 = 2;
         Game.eventGroup.resumeGame();
      }
      
      override public function bodyAdd(b0:*) : *
      {
         super.bodyAdd(b0);
         b0.define.exp = 100000;
      }
      
      override public function bodyDie(b0:*) : *
      {
         super.bodyDie(b0);
         var exp0:int = b0.define.exp * this.expMul0 * (1 + Game.gameData.rankAdd.expMul);
         if(this.name == "僵尸狂潮")
         {
            exp0 = 10000;
         }
         Game.gameData.addExp(exp0);
         Game.textGroup.addText("经验值+" + exp0,hero.MX,hero.MY - 70,16711935,1);
      }
   }
}

