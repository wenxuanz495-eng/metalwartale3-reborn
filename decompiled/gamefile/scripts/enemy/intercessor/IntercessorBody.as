package enemy.intercessor
{
   import body.attack.ArmsAttack;
   import body.define.EnemyDefine;
   import body.hero.ArmsDefine;
   import body.image.MultipleImage;
   import body.motion.GroundMotion;
   import enemy.rolling.RollingAAHD;
   import flash.geom.Rectangle;
   import image.ShakeMotion;
   
   public class IntercessorBody
   {
      
      public var define:EnemyDefine = new EnemyDefine();
      
      public var img:MultipleImage = new MultipleImage();
      
      public var mot:GroundMotion = new GroundMotion();
      
      public var shake:ShakeMotion = new ShakeMotion();
      
      public var armsDefine:ArmsDefine = new ArmsDefine("enemyArms");
      
      public var animation:IntercessorAnimation;
      
      public var AAHD:RollingAAHD;
      
      public var ai:Intercessor_AI;
      
      public var attack:ArmsAttack;
      
      public var _die:int = 0;
      
      public var hitHurtB:int = 0;
      
      public var camp:String = "enemy";
      
      public var type:String = "soldier";
      
      public var state:String = "intercessor";
      
      public var changeB:Boolean = false;
      
      public function IntercessorBody()
      {
         super();
         this.animation = new IntercessorAnimation(this.mot,this.img);
         this.AAHD = new RollingAAHD(this,this.img,this.armsDefine,this.define);
         this.ai = new Intercessor_AI(this);
         this.attack = new ArmsAttack(this,this.AAHD,this.armsDefine);
      }
      
      public function addSuper() : *
      {
         if(this.ai.skill.arr.length == 0)
         {
            if(!this.changeB)
            {
               this.ai.skill.setSkillArr(["Skill_Laser","Energy_Boom"]);
            }
            else
            {
               this.ai.skill.setSkillArr(["Skill_Laser","Energy_Boom","Clear_Energy"]);
            }
         }
      }
      
      public function changeState(str0:String) : *
      {
         if(str0 != this.state)
         {
            this.state = str0;
            if(this.state != "intercessor")
            {
               if(this.state == "adjudicator")
               {
                  this.attack.stopAttack();
                  this.ai.reStartAttack();
                  this.ai.state = "attackStop";
                  this.mot.F_G = 1.5;
                  this.img.goOnce_ToLoop("__stand2","stand2");
                  this.define.hurtRectArr = [new Rectangle(-35,-166,59,76),new Rectangle(-33,-87,26,56),new Rectangle(-31,-97,25,91)];
                  this.define.name = "判决者";
                  Game.uiGroup.gamingUI.bossBarTarget = this;
               }
            }
            this.animation.state = str0;
            this.ai.heroState = str0;
         }
      }
      
      public function inData_byXML(xml0:XML) : *
      {
         this.define.inData_byXML(xml0);
         this.flesh_byDefine();
      }
      
      public function flesh_byDefine() : *
      {
         this.mot.inData(this.define.vx,this.define.vy,this.define.tweenValue,this.define.jumpHeight,this.define.jumpNum);
         this.mot.delayTime = this.define.jumpDelay;
         this.ai.inData(this.define.grapRect,this.define.attackDelay,this.define.affterAttack,this.define.nextAttackTime,this.define.hoverRect);
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
      
      public function setLevel(num:int) : *
      {
         this.define.setLevel(num);
         this.img.setLevel(num);
      }
      
      public function toDie() : *
      {
         this._die = 1;
         if(this.state == "intercessor")
         {
            this.img.goPlayOnce("die");
         }
         else if(this.state == "adjudicator")
         {
            this.img.goPlayOnce("die2");
         }
         this.hitHurtB = 1;
         this.animation.enabled = false;
         this.attack.stopAttack();
         this.ai.state = "noing";
         this.ai.enabled = false;
         Game.oneScene.shake.startShake(8,1,Math.random() * 10,-10,10,0,"cos");
      }
      
      public function playStand() : *
      {
         if(this.state == "intercessor")
         {
            this.img.goPlayLoop_break("stand");
         }
         else if(this.state == "adjudicator")
         {
            this.img.goPlayLoop_break("stand2");
         }
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
         this.img.x = int(value);
      }
      
      public function set y(value:Number) : *
      {
         this.mot.y0 = value;
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
         return this.mot.y0 + rect0.y + rect0.height / 2;
      }
      
      public function bodyTimer() : *
      {
         this.attack.attackTimer();
         this.ai.aiTimer();
         this.shake.shakeTimer();
         this.animation.animationTimer();
         this.img.imageTimer();
         this.mot.motionTimer();
         this.img.x = int(this.mot.x0) + this.shake.x;
         this.img.y = int(this.mot.y0) + this.shake.y;
         if(this.img.nowLabel == "shoot_attack")
         {
            if(this.img.nowMC.currentFrame == 25)
            {
               Game.oneScene.shake.startShake(6,0.7,Math.PI / 2,-10,50,0,"random");
            }
         }
         else if(this.img.nowLabel == "die2")
         {
            if(this.img.nowMC.currentFrame == 37)
            {
               Game.oneScene.shake.startShake(10,0.7,Math.PI / 2,-20,20,0,"cos");
            }
         }
         else if(this.img.nowLabel == "shoot_4")
         {
            if(this.img.nowMC.currentFrame == 9)
            {
               Game.oneScene.showScreenEffect(1,1.1,4294927376);
            }
         }
      }
   }
}

