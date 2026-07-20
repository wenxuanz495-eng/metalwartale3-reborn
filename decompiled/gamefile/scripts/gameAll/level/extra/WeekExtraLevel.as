package gameAll.level.extra
{
   import body.enemy.EnemyHeroBody;
   import gameAll.data.weekExtra.WeekExtraData;
   import gameAll.data.weekExtra.WeekExtraOneData;
   import gameAll.level.Levels;
   
   public class WeekExtraLevel extends Levels
   {
      
      public var nowExtraBoss:EnemyHeroBody = null;
      
      public var wed:WeekExtraData;
      
      public var bossNowLife:Number = 0;
      
      public function WeekExtraLevel()
      {
         super();
      }
      
      override public function bodyAdd(b0:*) : *
      {
         var nowLife_00:Number = NaN;
         var maxLife_00:Number = NaN;
         super.bodyAdd(b0);
         var ed0:WeekExtraOneData = Game.gameData.weekExtraData.getNowData();
         if(b0.type == "boss")
         {
            this.nowExtraBoss = b0;
            this.nowExtraBoss.ai.fleshData_byWeekExtraOneDefine(ed0.define);
            nowLife_00 = ed0.nowLife;
            maxLife_00 = ed0.define.maxLife;
            b0.define.maxLife = maxLife_00;
            b0.define.mulLife();
            b0.define.nowLife = nowLife_00;
            this.bossNowLife = nowLife_00;
         }
      }
      
      override public function clear() : *
      {
         this.fleshBossLife();
         this.nowExtraBoss = null;
         super.clear();
      }
      
      public function fleshBossLife() : *
      {
         var ed0:WeekExtraOneData = null;
         if(this.nowExtraBoss != null)
         {
            this.bossNowLife = this.nowExtraBoss.define.nowLife;
         }
         else
         {
            ed0 = Game.gameData.weekExtraData.getNowData();
            this.bossNowLife = ed0.define.maxLife;
         }
      }
      
      override public function closeLevel() : *
      {
         this.saveLife();
         super.closeLevel();
      }
      
      public function saveLife() : *
      {
         this.fleshBossLife();
         Game.gameData.weekExtraData.getNowData().nowLife = this.bossNowLife;
      }
   }
}

