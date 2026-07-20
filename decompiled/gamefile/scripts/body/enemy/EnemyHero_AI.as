package body.enemy
{
   import enemy.AI.EnemySkill;
   import gameAll.define.WeekExtraOneDefine;
   import gameAll.high.HighArena_All;
   import other.OneTimer;
   
   public class EnemyHero_AI
   {
      
      internal var BB:EnemyHeroBody;
      
      public var targetBody:*;
      
      public var state:String = "stoping";
      
      public var enabled:Boolean = true;
      
      public var attackBodyAffterRebirthB:Boolean = true;
      
      public var skill:EnemySkill;
      
      public var maxLife:int = 180000;
      
      public var maxDefence:int = 120;
      
      public var skillNum:Array = [4,4,4];
      
      public var armsArr:Array = ["soya_lv2","charged_lv4","plasma_lv3"];
      
      public var armsIndex:int = 0;
      
      public var subArr:Array = ["lightningBall_lv4","cutter_lv3","chipped_lv3"];
      
      public var carLabel:String = "lambo";
      
      public var followTimer:OneTimer = new OneTimer(50);
      
      public var jumpTimer:OneTimer = new OneTimer(60);
      
      public var moreJumpTimer:OneTimer = new OneTimer(10);
      
      public var plasmaTimer:OneTimer = new OneTimer(100);
      
      public var rockerTimer:OneTimer = new OneTimer(100);
      
      public var changeArmsTimer:OneTimer = new OneTimer(90);
      
      public var nowMoveState:String = "stop";
      
      public function EnemyHero_AI(_BB:*)
      {
         super();
         this.BB = _BB;
         this.skill = new EnemySkill(this.BB);
         this.followTimer.fun = this.follow;
         this.jumpTimer.fun = this.jumpSkill;
         this.plasmaTimer.fun = this.plasmaSkill;
         this.rockerTimer.fun = this.rocketSkill;
         this.moreJumpTimer.fun = this.moreJumpSkill;
         this.changeArmsTimer.fun = this.changeArms;
      }
      
      public function attackBody(body0:*) : *
      {
         this.targetBody = body0;
         this.followTimer.enabled = true;
         this.jumpTimer.enabled = true;
         this.plasmaTimer.enabled = true;
         this.rockerTimer.enabled = true;
         this.changeArmsTimer.enabled = true;
      }
      
      public function stopAttack() : *
      {
         this.targetBody = null;
         this.state = "no";
         this.BB.SG.stopAll();
         this.BB.attack.stopAttack();
         this.followTimer.enabled = false;
         this.jumpTimer.enabled = false;
         this.plasmaTimer.enabled = false;
         this.rockerTimer.enabled = false;
         this.changeArmsTimer.enabled = false;
      }
      
      public function fleshData_byWeekExtraOneDefine(d0:WeekExtraOneDefine) : *
      {
         this.skillNum = d0.skillNum;
         this.armsArr = d0.armsArr;
         this.subArr = d0.subArr;
         this.carLabel = d0.carLabel;
         this.maxLife = d0.maxLife;
         this.fleshArms();
      }
      
      public function fleshData_byHighArena_All(d0:HighArena_All) : *
      {
         this.BB.define.level = d0.extra.lv;
         this.skillNum = d0.extra.skill;
         this.armsArr = d0.extra.arms;
         this.subArr = d0.extra.sub;
         this.carLabel = d0.extra.car;
         this.maxLife = d0.extra.life;
         this.maxDefence = d0.extra.defence;
         this.skillNum[2] = 0;
         this.fleshArms();
      }
      
      public function fleshArms() : *
      {
         this.BB.SG.fleshByArr(this.subArr);
         this.BB.changeArms(this.armsArr[this.armsIndex]);
         this.BB.skill.setSkillNum(this.skillNum);
         this.BB.changeRocket(this.skillNum[0]);
         this.BB.changePlasma(this.skillNum[2]);
         this.BB.changeCar(this.carLabel);
         this.BB.define.addLifePer(1);
         this.BB.headTitle.txt.text = this.BB.define.trueName;
      }
      
      public function follow() : *
      {
         var cx:int = 0;
         if(this.attackBody != null)
         {
            cx = this.BB.mot.x0 - this.targetBody.mot.x0;
            if(cx > 300)
            {
               this.nowMoveState = "left";
               this.movePan();
               this.rocketSkill();
            }
            else if(cx > 200)
            {
               this.randomMove();
            }
            else if(cx > 100)
            {
               this.BB.toStop();
            }
            else if(cx > 0)
            {
               if(this.moreJumpTimer.enabled)
               {
                  this.nowMoveState = "left";
               }
               else
               {
                  this.nowMoveState = "right";
               }
            }
            else if(cx > -100)
            {
               if(this.moreJumpTimer.enabled)
               {
                  this.nowMoveState = "right";
               }
               else
               {
                  this.nowMoveState = "left";
               }
            }
            else if(cx > -200)
            {
               this.BB.toStop();
            }
            else if(cx > -300)
            {
               this.randomMove();
            }
            else
            {
               this.nowMoveState = "right";
               this.movePan();
               this.rocketSkill();
            }
            this.followTimer.m = Math.random() * 30 + 15;
         }
         else
         {
            this.jumpTimer.enabled = false;
            this.plasmaTimer.enabled = false;
            this.rockerTimer.enabled = false;
            this.moreJumpTimer.enabled = false;
         }
      }
      
      public function randomMove() : *
      {
         var ran0:Number = Math.random();
         if(ran0 > 0.5)
         {
            this.nowMoveState = "left";
         }
         else
         {
            this.nowMoveState = "right";
         }
      }
      
      public function jumpSkill() : *
      {
         var ran0:Number = NaN;
         if(this.BB.skill.getSkill("jump").time_t >= 3)
         {
            ran0 = Math.random();
            if(ran0 > 0.5)
            {
               this.moreJumpTimer.enabled = true;
            }
         }
      }
      
      public function moreJumpSkill() : *
      {
         if(this.BB.skill.getSkill("jump").time_t <= 0)
         {
            this.moreJumpTimer.enabled = false;
         }
         else
         {
            this.BB.key.toJump();
         }
      }
      
      public function plasmaSkill() : *
      {
         var ran0:Number = Math.random();
         if(ran0 > 0.6)
         {
            this.BB.key.openPlasma();
         }
      }
      
      public function rocketSkill() : *
      {
         var ran0:Number = Math.random();
         if(ran0 > 0.5)
         {
            this.BB.key.speedUp();
         }
      }
      
      public function attackPan() : *
      {
         if(this.targetBody != null)
         {
            if(this.targetBody.die == 0)
            {
               this.BB.inMouseXY(this.targetBody.MX,this.targetBody.MY);
               this.BB.attack.startAttack();
               this.BB.SG.attackAll();
            }
         }
         else
         {
            this.BB.attack.stopAttack();
            this.BB.SG.stopAll();
         }
         if(this.BB.mot.getJumpConditionB())
         {
            this.BB.mot.toJump();
         }
      }
      
      public function changeArms() : *
      {
         var ran0:Number = Math.random();
         if(ran0 > 0.5)
         {
            this.armsIndex = int(Math.random() * this.armsArr.length);
            this.BB.changeArms(this.armsArr[this.armsIndex]);
            trace("叛军换武器：" + this.armsArr[this.armsIndex]);
            this.changeArmsTimer.random();
         }
      }
      
      public function movePan() : *
      {
         if(this.nowMoveState == "left")
         {
            this.BB.moveToLeft();
         }
         else if(this.nowMoveState == "right")
         {
            this.BB.moveToRight();
         }
         else if(this.nowMoveState == "stop")
         {
            this.BB.toStop();
         }
      }
      
      public function lifePan() : *
      {
         if(this.BB.define.getLifePer() < 0.07)
         {
            this.BB.key.openPlasma();
         }
      }
      
      public function aiTimer() : *
      {
         if(this.enabled)
         {
            this.movePan();
            this.attackPan();
            this.skill.skillTimer();
            this.lifePan();
            this.changeArmsTimer.FTimer();
            this.followTimer.FTimer();
            this.jumpTimer.FTimer();
            this.moreJumpTimer.FTimer();
            this.plasmaTimer.FTimer();
            this.moreJumpTimer.FTimer();
         }
      }
      
      public function toString() : String
      {
         return "armsArr:" + this.armsArr + "\n" + "subArr:" + this.subArr + "\n" + "carLabel:" + this.carLabel;
      }
   }
}

