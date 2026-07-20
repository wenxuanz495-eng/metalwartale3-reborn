package body.lieutenant
{
   import body.skill.OneSkill;
   
   public class Lieutenant_AI
   {
      
      internal var BB:LieutenantBody;
      
      public var followBody:*;
      
      public var attackBody:*;
      
      public var state:String = "noing";
      
      public var nextTime:Number = 0;
      
      public var next_t:Number = 0;
      
      public var followTime:Number = 0;
      
      public var follow_t:Number = 0;
      
      public var choose_t:int = 0;
      
      public var skill_t:int = 0;
      
      public var change_t:int = 0;
      
      public var jumpNum:int = 2;
      
      public var plasmaNum:int = 2;
      
      public var speedUpNum:int = 2;
      
      public var followB:Boolean = true;
      
      public var shootB:Boolean = true;
      
      public var enabled:Boolean = true;
      
      public function Lieutenant_AI(_BB:*)
      {
         super();
         this.BB = _BB;
      }
      
      public function aiPan() : *
      {
         if(this.state != "noing")
         {
            if(this.state != "order")
            {
               if(this.state != "nextDelaying")
               {
                  if(this.state == "no")
                  {
                  }
               }
            }
         }
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
            x1 = Number(this.followBody.mot.x0);
            cx = x1 - x0;
            if(cx > max2)
            {
               this.BB.moveToRight();
               this.speedUp();
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
               this.speedUp();
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
               this.BB.img.inMouseXY(this.attackBody.MX,this.attackBody.MY);
               this.BB.attack.startAttack();
               this.BB.SG.attackAll();
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
               if(ran0 > 0.8)
               {
                  this.openPlasma();
               }
               else if(ran0 < 0.2)
               {
                  if(this.followB)
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
         var armsSite:Array = null;
         var index0:int = 0;
         var ran0:Number = Math.random();
         if(ran0 > 0.5)
         {
            armsSite = ["amplitude_lv3","microwave_lv3","schoolArms_lv3"];
            index0 = Math.random() * armsSite.length;
            this.BB.changeArms(armsSite[index0]);
         }
      }
      
      private function toJump() : *
      {
         var s0:OneSkill = null;
         var nowNum:int = 0;
         if(this.BB.mot.jumpNow == 0)
         {
            this.BB.key.toJump();
         }
         else
         {
            s0 = this.BB.skill.getSkill("jump");
            nowNum = s0.nowNum;
            if(nowNum >= this.jumpNum)
            {
               this.BB.key.toJump();
               s0.useSkill();
            }
         }
      }
      
      private function openPlasma() : *
      {
         var s0:OneSkill = this.BB.skill.getSkill("plasma");
         var nowNum:int = s0.nowNum;
         if(nowNum >= this.plasmaNum)
         {
            this.BB.key.openPlasma();
            s0.useSkill();
            this.plasmaNum = 1 + 4 * Math.random();
         }
      }
      
      private function speedUp() : *
      {
         var s0:OneSkill = this.BB.skill.getSkill("rocket");
         var nowNum:int = s0.nowNum;
         if(nowNum >= this.speedUpNum)
         {
            this.BB.key.speedUp();
            s0.useSkill();
            this.speedUpNum = 1 + 4 * Math.random();
         }
      }
      
      public function aiTimer() : *
      {
         if(this.enabled)
         {
            if(this.followB)
            {
               this.followTarget();
            }
            if(this.shootB)
            {
               this.swingShoot();
            }
         }
      }
   }
}

