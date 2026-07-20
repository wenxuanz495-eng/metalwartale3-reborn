package enemy.satellite
{
   import body.attack.ArmsAttack;
   import body.hero.ArmsDefine;
   import body.image.MultipleImage;
   import body.motion.GroundMotion;
   import body.motion.SuspendMotion;
   import enemy._normal.Normal_AAHD;
   import enemy.spider.SpiderDefine;
   import flash.geom.Rectangle;
   import image.ShakeMotion;
   
   public class SmallSatelliteBody
   {
      
      public var mot:*;
      
      public var img:MultipleImage = new MultipleImage();
      
      public var define:SpiderDefine = new SpiderDefine();
      
      public var shake:ShakeMotion = new ShakeMotion();
      
      public var armsDefine:ArmsDefine = new ArmsDefine("enemyArms");
      
      public var attack:ArmsAttack;
      
      public var AAHD:Normal_AAHD;
      
      public var ai:*;
      
      public var _die:int = 0;
      
      public var hitHurtB:int = 0;
      
      public var camp:String = "enemy";
      
      public var type:String = "soldier";
      
      public function SmallSatelliteBody()
      {
         super();
         this.AAHD = new Normal_AAHD(this,this.img,this.armsDefine,this.define);
         this.attack = new ArmsAttack(this,this.AAHD,this.armsDefine);
      }
      
      public function setAiClass(_aiClass:Class, _lastLabel:String = "stand", _motionClassType:String = "land") : *
      {
         if(_motionClassType == "land")
         {
            this.mot = new GroundMotion();
         }
         else
         {
            this.mot = new SuspendMotion();
         }
         this.AAHD.lastLabel = _lastLabel;
         this.ai = new _aiClass(this);
      }
      
      public function playStand() : *
      {
         this.img.goPlayLoop_break(this.AAHD.lastLabel);
      }
      
      public function inData_byXML(xml0:XML) : *
      {
         this.define.inData_byXML(xml0);
         this.flesh_byDefine();
      }
      
      public function flesh_byDefine() : *
      {
         this.mot.inData(this.define.vx,this.define.vy,this.define.tweenValue,this.define.jumpHeight,this.define.jumpNum);
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
         this.armsDefine.level = num;
         this.define.setLevel(num);
      }
      
      public function toDie() : *
      {
         this._die = 1;
         this.mot.toStop();
         this.img.goPlayOnce("die");
         this.hitHurtB = 1;
         this.attack.stopAttack();
         this.ai.state = "noing";
         this.ai.enabled = false;
         Game.oneScene.shake.startShake(4,0.8,Math.random() * 10,-8,8,0,"cos");
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
         if(this.mot is SuspendMotion)
         {
            this.mot.setX(value);
         }
         else
         {
            this.mot.x0 = value;
         }
         this.img.x = int(value);
      }
      
      public function set y(value:Number) : *
      {
         if(this.mot is SuspendMotion)
         {
            this.mot.setY(value);
         }
         else
         {
            this.mot.y0 = value;
         }
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
         this.img.imageTimer();
         this.mot.motionTimer();
         this.shake.shakeTimer();
         this.img.x = int(this.mot.x0) + this.shake.x;
         this.img.y = int(this.mot.y0) + this.shake.y;
      }
   }
}

