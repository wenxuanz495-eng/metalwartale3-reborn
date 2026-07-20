package gameAll.level
{
   import body.enemy.EnemyHeroBody;
   
   public class Level_2_11 extends Levels
   {
      
      public var tt0:Number = 0;
      
      public var tt1:Number = 0;
      
      internal var dulang:EnemyHeroBody;
      
      internal var dulang_toB:Boolean = false;
      
      public function Level_2_11()
      {
         super();
      }
      
      override public function startLevel() : *
      {
         super.startLevel();
         nowBoss = null;
         this.dulang_toB = false;
         this.tt0 = 0;
         Game.LG.doOrder_byID("we0");
         hero.toStop();
         hero.key.enabled = false;
      }
      
      override public function closeLevel() : *
      {
         super.closeLevel();
         this.dulang = null;
      }
      
      public function skillTimer() : *
      {
         if(nowBoss != null)
         {
            if(nowBoss.die != 0)
            {
               nowBoss = null;
               return;
            }
            this.tt0 += 1 / 6;
            if(this.tt0 >= 30)
            {
               this.tt0 = 0;
               trace("发兵蓝色坦克");
               Game.LG.doOrder_byID("enemy_4");
            }
         }
      }
      
      override public function firstDialogueOver(b0:*) : *
      {
         if(b0 is EnemyHeroBody && !this.dulang_toB)
         {
            this.dulang_toB = true;
            b0.ai.stopAttack();
            b0.ai.enabled = false;
            b0.hitHurtB = 1;
            this.dulang = b0;
            this.dulang.moveToRight();
            this.dulang.img.flipToRight();
            this.dulang.speedUpGap(2000);
            addOnceFun(this.disappear_2,2 / 5);
         }
      }
      
      public function disappear_2() : *
      {
         this.dulang.hitHurtB = 1;
         this.dulang.img.visible = false;
         this.dulang.die = 1;
         BG.clearArr(BG.enemyHero_arr);
         this.dulang = null;
         hero.key.enabled = true;
      }
      
      override public function bodyAdd(b0:*) : *
      {
         var str0:String = null;
         super.bodyAdd(b0);
         if(b0.type == "boss")
         {
            this.tt0 = 25;
            nowBoss = b0;
            b0.ai.skill.setSkillArr(["UnableAttack_Missile"]);
         }
         if(b0 is EnemyHeroBody)
         {
            b0.ai.stopAttack();
            b0.ai.state = "noing";
            b0.define.lifeBar.visible = false;
         }
         if(b0.define.name == "攻城坦克" && b0.type == "champion")
         {
            trace("蓝色攻城坦克：" + b0.img.x + "," + b0.img.y);
            if(nowBoss != null)
            {
               b0.define.maxLife = nowBoss.define.maxLife / 2;
               b0.define.mulLife();
            }
         }
      }
      
      override public function levelTimer() : *
      {
         if(enabled)
         {
            super.levelTimer();
            this.skillTimer();
         }
      }
   }
}

