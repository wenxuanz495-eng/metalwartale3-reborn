package body.hero
{
   import gameAll.data.ArmsItemsData;
   
   public class HeroArena_AI
   {
      
      public var BB:HeroCarBody;
      
      public var enabled:Boolean = false;
      
      public var followTime:Number = 0;
      
      public var follow_t:Number = 0;
      
      public var choose_t:int = 0;
      
      public var skill_t:int = 0;
      
      public var change_t:int = 0;
      
      public var nowFollow_x:int = 0;
      
      public var jumpNum:int = 2;
      
      public var plasmaNum:int = 2;
      
      public var speedUpNum:int = 2;
      
      public var followB:Boolean = true;
      
      public var shootB:Boolean = true;
      
      public var attackBody:*;
      
      public function HeroArena_AI(_BB:*)
      {
         super();
         this.BB = _BB;
      }
      
      public function startAI() : *
      {
         this.enabled = true;
         this.shootB = true;
         var x0:int = Game.oneScene.viewRangeRect2.x + Game.oneScene.viewRangeRect2.width / 2;
         this.nowFollow_x = x0;
      }
      
      public function stopAI() : *
      {
         this.enabled = false;
      }
      
      private function followTarget() : *
      {
         var max2:Number = NaN;
         var max0:Number = NaN;
         var min0:Number = NaN;
         var x0:Number = NaN;
         var x1:Number = NaN;
         var cx:Number = NaN;
         var ran0:Number = NaN;
         var ran1:Number = NaN;
         this.BB.mot.F_F = 0.2 + 0.2 * Math.random();
         if(this.follow_t >= this.followTime)
         {
            max2 = 400;
            max0 = 250;
            min0 = 100;
            x0 = this.BB.mot.x0;
            x1 = this.nowFollow_x;
            cx = x1 - x0;
            if(cx > max2)
            {
               this.BB.moveToRight();
            }
            else if(cx <= max2 && cx > max0)
            {
               this.BB.moveToRight();
            }
            else if(cx <= max0 && cx > min0)
            {
               ran0 = Math.random();
               if(ran0 > 0.6)
               {
                  this.BB.toStop();
               }
               else if(ran0 <= 0.6 && ran0 > 0.15)
               {
                  this.viewPan();
               }
               else
               {
                  this.speedUp();
               }
            }
            else if(cx <= min0 && cx > 0)
            {
               this.BB.moveToLeft();
            }
            else if(cx <= 0 && cx > -min0)
            {
               this.BB.moveToRight();
            }
            else if(cx <= -min0 && cx > -max0)
            {
               ran1 = Math.random();
               if(ran0 > 0.6)
               {
                  this.BB.toStop();
               }
               else if(ran0 <= 0.6 && ran0 > 0.15)
               {
                  this.viewPan();
               }
               else
               {
                  this.speedUp();
               }
            }
            else if(cx <= -max0 && cx > -max2)
            {
               this.BB.moveToLeft();
            }
            else if(cx <= -max2)
            {
               this.BB.moveToLeft();
            }
            this.follow_t = 0;
            this.followTime = 10 + 20 * Math.random();
         }
         else
         {
            ++this.follow_t;
         }
      }
      
      private function viewPan() : *
      {
         var cx:Number = this.BB.img.x - Game.oneScene.getPositionMiddle().x;
         if(cx > 0)
         {
            this.BB.moveToLeft();
         }
         else
         {
            this.BB.moveToRight();
         }
      }
      
      private function swingShoot() : *
      {
         var ran1:Number = NaN;
         var ran0:Number = NaN;
         var earr:Array = null;
         var num0:int = 0;
         if(this.choose_t > 3)
         {
            this.choose_t = 0;
         }
         else
         {
            ++this.choose_t;
         }
         if(this.skill_t > 7)
         {
            this.skill_t = 0;
         }
         else
         {
            ++this.skill_t;
         }
         if(this.change_t > 100)
         {
            this.change_t = 0;
         }
         else
         {
            ++this.change_t;
         }
         var chooseB:Boolean = false;
         if(this.choose_t == 0)
         {
            if(this.attackBody == null)
            {
               chooseB = true;
            }
            else
            {
               this.BB.inMouseXY(this.attackBody.MX,this.attackBody.MY);
               if(this.BB.noAttack_t == -1)
               {
                  this.BB.attackAll();
               }
               if(this.attackBody.die > 0)
               {
                  this.attackBody = null;
                  this.BB.attack.stopLoop();
                  this.BB.SG.stopAll();
                  chooseB = true;
               }
               else
               {
                  ran0 = Math.random();
                  if(ran0 > 0.8)
                  {
                     chooseB = true;
                  }
               }
               ran1 = Math.random();
               if(ran0 <= 0.8)
               {
                  if(ran0 < 0.2)
                  {
                     this.toJump();
                  }
               }
            }
         }
         if(this.attackBody != null)
         {
            if(this.change_t == 0)
            {
               this.changeArms();
            }
         }
         else if(this.change_t == 0)
         {
            this.BB.inMouseXY(this.BB.mot.x0 + Math.random() * 1000 - 500,this.BB.mot.y0 + Math.random() * 1000 - 500);
         }
         if(chooseB)
         {
            earr = Game.BG.getLiveEnemy();
            if(earr.length > 0)
            {
               num0 = earr.length * Math.random();
               this.attackBody = earr[num0];
            }
            else
            {
               this.attackBody = null;
               this.BB.attack.stopLoop();
               this.BB.SG.stopAll();
            }
         }
      }
      
      private function changeArms() : *
      {
         var arr0:Array = null;
         var aid0:ArmsItemsData = null;
         var ran0:Number = Math.random();
         if(ran0 > 0.5)
         {
            arr0 = Game.gameData.armsItems.equArr;
            aid0 = arr0[int(arr0.length * Math.random())];
            Game.eventGroup.changArms(aid0.site);
         }
      }
      
      private function toJump() : *
      {
         this.BB.key.useSkillName("jump");
      }
      
      private function openPlasma() : *
      {
         if(this.BB.key.useSkillName("plasma"))
         {
            this.plasmaNum = 1 + 4 * Math.random();
         }
      }
      
      private function speedUp() : *
      {
         if(this.BB.key.useSkillName("rocket"))
         {
            this.speedUpNum = 1 + 4 * Math.random();
         }
      }
      
      public function aiTimer() : *
      {
         if(this.enabled)
         {
            this.followTarget();
            if(this.shootB)
            {
               this.swingShoot();
            }
         }
      }
   }
}

