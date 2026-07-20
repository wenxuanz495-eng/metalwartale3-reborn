package enemy.gundam
{
   import UI.gaming.LifeBar2;
   import body.attack.ArmsAttack;
   import body.hero.ArmsDefine;
   import body.image.MultipleImage;
   import body.motion.GroundMotion;
   import body.motion.SuspendMotion;
   import body.skill.SpeedUpSkill;
   import enemy._normal.Normal_ExtraSkill;
   import flash.geom.Rectangle;
   import image.ShakeMotion;
   import other.FunGroup;
   
   public class GundamBody extends FunGroup
   {
      
      public var define:GundamDefine = new GundamDefine();
      
      public var img:MultipleImage = new MultipleImage();
      
      public var shake:ShakeMotion = new ShakeMotion();
      
      public var mot1:GroundMotion = new GroundMotion();
      
      public var mot2:SuspendMotion = new SuspendMotion();
      
      public var armsDefine:ArmsDefine = new ArmsDefine("enemyArms");
      
      public var attack:ArmsAttack;
      
      public var mot:* = this.mot2;
      
      public var animation:GundamAnimation;
      
      public var AAHD:GundamAAHD;
      
      public var ai:Gundam_AI;
      
      public var extraSkill:Normal_ExtraSkill;
      
      public var speedUpSkill:SpeedUpSkill;
      
      public var hitRect1:Rectangle = new Rectangle(-29,-124,58,124);
      
      public var hitRect2:Rectangle = new Rectangle(-75,-168,140,45);
      
      public var lifeBar:LifeBar2;
      
      public var _die:int = 0;
      
      public var hitHurtB:int = 0;
      
      public var camp:String = "enemy";
      
      public var type:String = "soldier";
      
      public var state:String = "fly";
      
      private var minGroundY:int = 300;
      
      public function GundamBody()
      {
         super();
         this.animation = new GundamAnimation(this);
         this.AAHD = new GundamAAHD(this,this.img,this.armsDefine,this.define);
         this.ai = new Gundam_AI(this);
         this.attack = new ArmsAttack(this,this.AAHD,this.armsDefine);
         this.extraSkill = new Normal_ExtraSkill(this);
         this.speedUpSkill = new SpeedUpSkill(this);
         this.speedUpSkill.maxSpeed *= 2;
      }
      
      public function playStand() : *
      {
         if(this.state == "fly")
         {
            this.img.goPlayLoop_break("fly");
         }
         else if(this.state == "plane")
         {
            this.img.goPlayLoop_break("plane");
         }
         else
         {
            this.img.goPlayLoop_break("stand");
         }
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
      
      public function firstToPlane() : *
      {
         this.state = "plane";
         this.mot = this.mot2;
         ClearAllFun();
         this.fleshMotion();
         this.animation.state = this.state;
         this.ai.heroState = this.state;
         this.img.goPlayLoop("plane");
         this.ai.nowAttackOrder = "Gundam_plane";
         this.define.rectLevel = 3;
         this.flesh_byDefine();
      }
      
      public function changeState(str0:String) : *
      {
         if(str0 != this.state)
         {
            if(str0 == "fly" || str0 == "plane")
            {
               if(this.state == "land")
               {
                  this.state = str0;
                  addOnceFun(this.fleshMotion,0.2);
               }
               else
               {
                  if(this.state == "fly")
                  {
                     this.img.goPlayLoop("stand");
                  }
                  this.mot1.inData_byOther(this.mot2);
                  ClearAllFun();
                  this.state = str0;
                  this.fleshMotion();
               }
               this.animation.state = str0;
               this.ai.heroState = str0;
            }
            else if(str0 == "land")
            {
               this.state = str0;
               ClearAllFun();
               this.minGroundY = Game.BGHit.getMinY(this.mot.x0) - 200;
               addFun(this.toLandPan);
            }
            this.ai.heroState = this.state;
            this.ai.reStartAttack();
         }
      }
      
      private function toLandPan() : *
      {
         this.ai.state = "noing";
         this.mot.followPoint(this.mot.x0,this.mot.y0 - 200);
         if(this.mot.y0 < this.minGroundY)
         {
            this.mot.stopFollow();
            removeFun(this.toLandPan);
            ClearAllFun();
            this.state = "land";
            this.animation.state = this.state;
            this.fleshMotion();
            this.ai.reStartAttack();
         }
      }
      
      private function fleshMotion() : *
      {
         if(this.state == "fly")
         {
            this.mot2.inData_byOther(this.mot1);
            this.mot = this.mot2;
            this.define.hitRect = this.hitRect1;
            this.armsDefine.inData("Gundam_fly_2",0);
         }
         else if(this.state == "land")
         {
            this.mot1.inData_byOther(this.mot2);
            this.mot = this.mot1;
            this.define.hitRect = this.hitRect1;
            this.armsDefine.inData("Gundam_land",0);
         }
         else if(this.state == "plane")
         {
            this.mot2.inData_byOther(this.mot1);
            this.mot = this.mot2;
            this.define.hitRect = this.hitRect2;
            this.armsDefine.inData("Gundam_plane",0);
         }
         this.define.hurtRectArr = [this.define.hitRect];
         ClearAllFun();
      }
      
      public function toDie() : *
      {
         this._die = 1;
         if(this.state == "land")
         {
            this.img.goPlayOnce("die");
         }
         else if(this.state == "plane")
         {
            this.img.goPlayOnce("die_plane");
         }
         else if(this.state == "fly")
         {
            this.img.goPlayOnce("die_fly");
         }
         this.extraSkill.clear();
         this.hitHurtB = 1;
         this.animation.enabled = false;
         this.attack.stopAttack();
         this.ai.state = "noing";
         this.ai.enabled = false;
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
         this.attack.attackTimer();
         this.ai.aiTimer();
         this.extraSkill.FTimer();
         this.animation.animationTimer();
         this.img.imageTimer();
         this.mot.motionTimer();
         this.shake.shakeTimer();
         this.img.x = int(this.mot.x0) + this.shake.x;
         this.img.y = int(this.mot.y0) + this.shake.y;
         this.speedUpSkill.speedUpTimer();
         if(this.img.nowLabel == "die")
         {
            if(this.img.getNowMC().currentFrame == 21)
            {
               Game.oneScene.shake.startShake(6,1,Math.random() * 10,-10,10,0,"cos");
            }
         }
      }
   }
}

