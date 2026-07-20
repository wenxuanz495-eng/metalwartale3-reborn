package enemy.AI
{
   import body.define.EnemyDefine;
   import flash.geom.Point;
   
   public class ExtraSkill
   {
      
      public var baba:*;
      
      public var enabled:Boolean = false;
      
      public var nowIndex:int = 1;
      
      public var nowEnemyOrder:int = 0;
      
      public var tt:Number = 0;
      
      public var skill:EnemySkill;
      
      public var define:EnemyDefine;
      
      public function ExtraSkill(_baba:*)
      {
         super();
         this.baba = _baba;
         this.skill = this.baba.ai.skill;
         this.define = this.baba.define;
      }
      
      public function init() : *
      {
         this.enabled = true;
         this.skill.showSkillB = false;
         Game.dialogboxGroup.showGameTip("f-1-4-1",2);
      }
      
      public function FTimer() : *
      {
         var str0:String = null;
         if(this.enabled)
         {
            str0 = "phase_" + this.nowIndex;
            if(this.hasOwnProperty(str0))
            {
               this[str0]();
            }
         }
      }
      
      public function gotoScreenMiddle() : *
      {
         var x0:int = Game.oneScene.viewRangeRect2.x + Game.oneScene.viewRangeRect2.width / 2;
         var y0:int = Game.BGHit.getMinY(x0) - 50;
         this.baba.mot.followPoint(x0,y0);
      }
      
      public function gotoScreenMiddle_point(_mx:int = 0, _my:int = 0) : *
      {
         var x0:int = Game.oneScene.viewRangeRect2.x + Game.oneScene.viewRangeRect2.width / 2 + _mx;
         var y0:int = Game.BGHit.getMinY(x0) + _my;
         this.baba.mot.followPoint(x0,y0);
      }
      
      public function getScreenMiddle_point() : Point
      {
         var x0:int = Game.oneScene.viewRangeRect2.x + Game.oneScene.viewRangeRect2.width / 2;
         var y0:int = Game.BGHit.getMinY(x0);
         return new Point(this.baba.img.x - x0,this.baba.img.y - y0);
      }
      
      public function bodyAdd(b0:*) : *
      {
      }
      
      public function bodyDie(b0:*) : *
      {
      }
      
      public function clear() : *
      {
         if(this.enabled)
         {
            if(Game.oneScene.lockB)
            {
               Game.LG.level.unlockView();
            }
         }
         this.enabled = false;
      }
   }
}

