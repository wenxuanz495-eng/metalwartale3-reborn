package enemy.gundam
{
   import body.define.EnemyDefine;
   import body.hero.ArmsDefine;
   import body.image.MultipleImage;
   import body.motion.GroundMotion;
   import body.motion.SuspendGroundMotion;
   import body.skill.SpeedUpSkill;
   import enemy._normal.Normal_ExtraSkill;
   import flash.geom.Rectangle;
   import image.ShakeMotion;
   import other.FunGroup;
   
   public class GundamBody2 extends FunGroup
   {
      
      public var define:EnemyDefine = new EnemyDefine();
      
      public var img:MultipleImage = new MultipleImage();
      
      public var shake:ShakeMotion = new ShakeMotion();
      
      public var armsDefine:ArmsDefine = new ArmsDefine("enemyArms");
      
      public var mot1:GroundMotion = new GroundMotion();
      
      public var mot2:SuspendGroundMotion = new SuspendGroundMotion();
      
      public var mot:* = this.mot2;
      
      public var AAHD:GundamAAHD;
      
      public var ai:Gundam2_AI;
      
      public var extraSkill:Normal_ExtraSkill;
      
      public var animation:GundamAnimation2;
      
      public var speedUpSkill:SpeedUpSkill;
      
      public var hitRect1:Rectangle = new Rectangle(-29,-124,58,124);
      
      public var hitRect2:Rectangle = new Rectangle(5,-137,53,96);
      
      public var hitRect_shoot2_1:Rectangle = new Rectangle(118,-124,58,124);
      
      public var _die:int = 0;
      
      public var hitHurtB:int = 0;
      
      public var camp:String = "enemy";
      
      public var type:String = "boss";
      
      public var state:String = "land";
      
      public function GundamBody2()
      {
         super();
         this.animation = new GundamAnimation2(this);
         this.AAHD = new GundamAAHD(this,this.img,this.armsDefine,this.define);
         this.ai = new Gundam2_AI(this);
         this.changeState("fly");
         this.speedUpSkill = new SpeedUpSkill(this);
         this.speedUpSkill.maxSpeed *= 2;
         this.extraSkill = new Normal_ExtraSkill(this);
      }
      
      public function setLevel(num:int) : *
      {
         this.define.setLevel(num);
         this.armsDefine.level = num;
      }
      
      public function upData_AILevel(level0:int = -1) : *
      {
         var l0:int = level0;
         if(l0 == -1)
         {
            l0 = this.define.aiLevel + 1;
         }
         this.define.aiLevel = l0;
         this.flesh_byDefine();
      }
      
      public function inData_byXML(xml0:XML) : *
      {
         this.define.inData_byXML(xml0);
         this.flesh_byDefine();
         this.fleshMotion();
      }
      
      public function flesh_byDefine() : *
      {
         this.mot1.inData(this.define.vx,this.define.vy,this.define.tweenValue / 4,this.define.jumpHeight,this.define.jumpNum);
         this.mot2.inData(this.define.vx * 2,this.define.vy,this.define.tweenValue,this.define.jumpHeight,this.define.jumpNum);
         this.ai.inData(this.define.grapRect,this.define.attackDelay,this.define.affterAttack,this.define.nextAttackTime);
      }
      
      public function changeState(str0:String) : *
      {
         if(str0 != this.state)
         {
            if(this.state == "land")
            {
               this.state = str0;
               this.animation.state = this.state;
               this.ai.heroState = this.state;
               this.ai.reStartAttack();
               this.fleshMotion();
            }
            else
            {
               this.state = str0;
               this.animation.state = this.state;
               this.ai.heroState = this.state;
               this.ai.reStartAttack();
               this.fleshMotion();
            }
         }
      }
      
      private function fleshMotion() : *
      {
         if(this.state == "fly")
         {
            this.mot2.inData_byOther(this.mot1);
            this.mot = this.mot2;
            this.define.hitRect = this.hitRect2;
         }
         else if(this.state == "land")
         {
            this.mot1.inData_byOther(this.mot2);
            this.mot = this.mot1;
            this.define.hitRect = this.hitRect1;
         }
         this.define.hurtRectArr = [this.define.hitRect];
         ClearAllFun();
      }
      
      public function toDie() : *
      {
         this._die = 1;
         this.img.goPlayOnce("die");
         this.extraSkill.clear();
         this.hitHurtB = 1;
         this.animation.enabled = false;
         this.ai.state = "noing";
         this.ai.enabled = false;
         this.img.visible = true;
         if(Boolean(this.define.lifeBar))
         {
            this.define.lifeBar.visible = true;
         }
         Game.oneScene.shake.startShake(10,0.6,Math.random() * 10,-4,4,0,"cos");
      }
      
      public function get die() : int
      {
         if(this._die > 0)
         {
            if(this.img.dieB && this.img.lastFrameB)
            {
               return 2;
            }
            return 1;
         }
         return 0;
      }
      
      public function getSpeedUpB() : Boolean
      {
         return this.speedUpSkill.getSpeedUpB();
      }
      
      public function playStand() : *
      {
         if(this.state == "fly")
         {
            this.img.goPlayLoop_break("fly");
            this.define.hurtRectArr = [this.hitRect2];
            this.define.hitRect = this.hitRect2;
         }
         else
         {
            this.img.goPlayLoop_break("stand");
            this.define.hurtRectArr = [this.hitRect1];
            this.define.hitRect = this.hitRect1;
         }
      }
      
      public function speedUp(_time:Number = 0.2, direction:* = "no") : *
      {
         if(this.speedUpSkill.speedUpTime == -1)
         {
            this.speedUpSkill.speedUp(_time,direction);
         }
      }
      
      public function get hitRect() : Rectangle
      {
         var rect0:Rectangle = this.define.hitRect.clone();
         rect0.x += this.mot.x0;
         rect0.y += this.mot.y0;
         return rect0;
      }
      
      public function set x(value:Number) : *
      {
         this.mot.x0 = value;
         this.mot.mx = value;
         this.img.x = int(value);
      }
      
      public function set y(value:Number) : *
      {
         this.mot.y0 = value;
         this.mot.my = value;
         this.img.y = int(value);
      }
      
      public function get MX() : Number
      {
         var rect0:Rectangle = this.define.hitRect;
         return this.mot.x0 + rect0.x + rect0.width / 2;
      }
      
      public function get MY() : Number
      {
         var rect0:Rectangle = this.define.hitRect;
         return this.mot.y0 + rect0.y + rect0.height / 2 / 2;
      }
      
      public function bodyTimer() : *
      {
         super.FTimer();
         this.ai.aiTimer();
         this.extraSkill.FTimer();
         this.animation.animationTimer();
         this.img.imageTimer();
         this.mot.motionTimer();
         this.shake.shakeTimer();
         this.img.x = int(this.mot.x0);
         this.img.y = int(this.mot.y0);
         this.speedUpSkill.speedUpTimer();
         if(this.img.nowLabel == "die")
         {
            if(this.img.nowMC.currentFrame == 21)
            {
               Game.oneScene.shake.startShake(6,1,Math.random() * 10,-10,10,0,"cos");
            }
         }
         else if(this.img.nowLabel == "shoot_2")
         {
            if(this.img.nowMC.currentFrame >= 11 && this.img.nowMC.currentFrame < 52)
            {
               this.define.hurtRectArr = [this.hitRect_shoot2_1];
               this.define.hitRect = this.hitRect_shoot2_1;
            }
            else if(this.state == "land")
            {
               this.define.hurtRectArr = [this.hitRect1];
               this.define.hitRect = this.hitRect1;
            }
            else
            {
               this.define.hurtRectArr = [this.hitRect2];
               this.define.hitRect = this.hitRect2;
            }
         }
         else if(this.state == "land")
         {
            this.define.hurtRectArr = [this.hitRect1];
            this.define.hitRect = this.hitRect1;
         }
         else
         {
            this.define.hurtRectArr = [this.hitRect2];
            this.define.hitRect = this.hitRect2;
         }
      }
   }
}

