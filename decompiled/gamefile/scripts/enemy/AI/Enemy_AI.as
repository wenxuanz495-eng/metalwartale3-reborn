package enemy.AI
{
   import data.Maths;
   import flash.geom.Rectangle;
   import other.FunGroup;
   
   public class Enemy_AI extends FunGroup
   {
      
      protected var baba:*;
      
      public var plasmaB:Boolean = false;
      
      public var attackBodyAffterRebirthB:Boolean = true;
      
      public var skill:EnemySkill;
      
      public var state:String = "stoping";
      
      public var randomValue:Number = Math.random();
      
      public var randomValue2:Number = Math.random();
      
      protected var grapRect:Rectangle;
      
      protected var attackX:Number = 0;
      
      protected var attackY:Number = 0;
      
      protected var beforeX:Number = 0;
      
      protected var beforeY:Number = 0;
      
      public var attackDelay:Number = 0.8;
      
      public var affterAttack:String = "return";
      
      protected var nextAttackTime:Number = 1;
      
      protected var followGap:int = 0;
      
      protected var randomfollowGap:int = 15;
      
      protected var follow_t:int = 0;
      
      protected var hrect:Rectangle = new Rectangle(-304,-255,180,97);
      
      protected var hoverTime:int = 30;
      
      protected var randomHoverTime:int = 30;
      
      protected var hover_t:int = 15000;
      
      protected var beforeMaxVX:Number = 0;
      
      public var targetBody:*;
      
      public var hoverBody:* = null;
      
      public var bilvArr:Array = [];
      
      public var armsName:String = "";
      
      public var armsNum:int = 1;
      
      public var attackRectArr:Array = [];
      
      public var attackTurnArr:Array = [];
      
      public var nowAttackIndex:int = 0;
      
      public var attackHurtArr:Array = [];
      
      public var noHurtType:String = "";
      
      public function Enemy_AI(_baba:*)
      {
         super();
         this.baba = _baba;
         this.skill = new EnemySkill(this.baba);
      }
      
      public function inData(_grapRect:Rectangle, _attackDelay:Number = 0, _affterAttack:String = "return", _nextAttackTime:Number = 0, _hrect:Rectangle = null) : *
      {
         this.grapRect = _grapRect;
         this.attackDelay = _attackDelay;
         this.affterAttack = _affterAttack;
         this.nextAttackTime = _nextAttackTime;
         if(_hrect != null)
         {
            this.hrect = _hrect;
         }
      }
      
      public function getBilv(index0:int) : Number
      {
         var max0:Number = NaN;
         var now0:Number = NaN;
         var n:* = undefined;
         if(index0 > this.bilvArr.length)
         {
            return 1;
         }
         max0 = 0;
         now0 = 0;
         for(n in this.bilvArr)
         {
            max0 += this.bilvArr[n];
            if(n <= index0)
            {
               now0 += this.bilvArr[n];
            }
         }
         return now0 / max0;
      }
      
      public function attackPoint(x0:Number, y0:Number) : *
      {
         this.attackX = x0;
         this.attackY = y0;
         this.beforeX = this.baba.mot.x0;
         this.beforeY = this.baba.mot.y0;
         this.state = "follow";
      }
      
      public function attackBody(body0:*) : *
      {
         this.targetBody = body0;
         this.beforeX = this.baba.mot.x0;
         this.beforeY = this.baba.mot.y0;
         this.state = "follow";
      }
      
      public function stopAttack() : *
      {
         this.attackOver();
         this.targetBody = null;
         this.state = "no";
         this.ClearAllFun();
         this.baba.mot.toStop();
      }
      
      public function reStartAttack() : *
      {
         this.state = "no";
         this.ClearAllFun();
         if(this.targetBody != null)
         {
            this.attackBody(this.targetBody);
         }
      }
      
      public function attackAI() : *
      {
         var bb:Boolean = false;
         if(this.state != "noing")
         {
            if(this.targetBody != null && this.targetBody.die > 0)
            {
               this.stopAttack();
            }
            if(this.state == "follow")
            {
               this.state = "following";
            }
            else if(this.state == "following")
            {
               bb = this.followTarget();
               if(bb)
               {
                  this.reachTarget();
                  ClearAllFun();
                  addOnceFun(this.attackFun,this.attackDelay);
                  this.state = "attackDelaying";
               }
            }
            else if(this.state != "attackDelaying")
            {
               if(this.state == "attack")
               {
                  this.attackOrder();
                  this.state = "attacking";
               }
               else if(this.state == "attacking")
               {
                  if(this.getAttackEndB())
                  {
                     this.state = "attackStop";
                  }
               }
               else if(this.state == "attackStop")
               {
                  this.attackOver();
                  if(this.affterAttack == "return")
                  {
                     this.followToPoint(this.beforeX,this.beforeY);
                     this.state = "no";
                  }
                  else if(this.affterAttack != "return")
                  {
                     ClearAllFun();
                     addOnceFun(this.nextAttackFun,this.nextAttackTime);
                     this.state = "nextAttacking";
                  }
               }
               else if(this.state == "nextAttacking")
               {
                  if(this.affterAttack == "followAndAttack")
                  {
                     this.followTarget();
                  }
                  else if(this.affterAttack == "hoverAndAttack")
                  {
                     this.hoverTarget();
                  }
               }
               else if(this.state == "no")
               {
                  this.stopAttack();
               }
            }
         }
      }
      
      public function hoverTarget() : *
      {
         var gr0:Rectangle = null;
         var mx0:Number = NaN;
         var my0:Number = NaN;
         var x0:Number = NaN;
         var y0:Number = NaN;
         if(this.hover_t >= this.randomHoverTime)
         {
            this.hover_t = 0;
            this.randomHoverTime = this.hoverTime * (0.5 + Math.random());
            if(this.targetBody != null)
            {
               this.attackX = this.targetBody.img.x;
               this.attackY = this.targetBody.img.y;
            }
            if(this.hoverBody != null)
            {
               this.attackX = this.hoverBody.img.x;
               this.attackY = this.hoverBody.img.y;
            }
            gr0 = this.hrect.clone();
            if(Math.random() > 0.5)
            {
               gr0.x = -(gr0.x + gr0.width);
            }
            gr0.x += this.attackX;
            gr0.y += this.attackY;
            mx0 = gr0.x + Math.random() * gr0.width;
            my0 = gr0.y + Math.random() * gr0.height;
            this.beforeX = mx0;
            this.beforeY = my0;
         }
         else
         {
            ++this.hover_t;
            x0 = Number(this.baba.mot.x0);
            y0 = Number(this.baba.mot.y0);
            this.followToPoint(this.beforeX,this.beforeY);
            if(Maths.Long(x0 - this.beforeX,y0 - this.beforeY) < 20)
            {
               this.hover_t = 15000;
            }
         }
      }
      
      protected function followTarget() : Boolean
      {
         var x0:Number = Number(this.baba.mot.x0);
         var y0:Number = Number(this.baba.mot.y0);
         if(this.targetBody != null)
         {
            this.attackX = this.targetBody.img.x;
            this.attackY = this.targetBody.img.y;
         }
         var gr0:Rectangle = this.grapRect.clone();
         if(x0 > this.attackX)
         {
            gr0.x = -(gr0.x + gr0.width);
         }
         gr0.x += this.attackX;
         gr0.y += this.attackY;
         var mx0:Number = gr0.x + gr0.width / 5 + this.randomValue * 3 * gr0.width / 5;
         var my0:Number = gr0.y + gr0.height / 5 + this.randomValue2 * 3 * gr0.height / 5;
         var rxB:Boolean = false;
         var ryB:Boolean = false;
         if(x0 > gr0.x && x0 < gr0.right)
         {
            rxB = true;
         }
         if(y0 > gr0.y && y0 < gr0.bottom)
         {
            ryB = true;
         }
         if(rxB && ryB)
         {
            return true;
         }
         if(!ryB)
         {
            if(this.baba.mot.type == "land" && Math.abs(x0 - this.attackX) > Math.abs(this.attackX - mx0) - 100)
            {
               mx0 = this.attackX;
               my0 = this.attackY;
               this.followToPoint(mx0,my0);
               return false;
            }
         }
         if(this.follow_t <= 0)
         {
            this.followToPoint(mx0,my0);
            this.follow_t = 20;
         }
         else
         {
            --this.follow_t;
         }
         return false;
      }
      
      private function attackFun() : *
      {
         this.state = "attack";
      }
      
      private function nextAttackFun() : *
      {
         this.state = "follow";
      }
      
      public function weFollowFilp() : *
      {
         this.followFilp();
      }
      
      protected function followFilp() : *
      {
         if(this.baba.mot.x0 < this.attackX - 10)
         {
            this.baba.img.flipToLeft();
         }
         else if(this.baba.mot.x0 > this.attackX + 10)
         {
            this.baba.img.flipToRight();
         }
      }
      
      protected function tooHigh() : *
      {
      }
      
      protected function reachTarget() : *
      {
      }
      
      protected function attackOrder() : *
      {
         this.baba.attack.startAttackOnce_break();
      }
      
      protected function followToPoint(x0:Number, y0:Number) : *
      {
         this.baba.mot.followPoint(x0,y0);
      }
      
      protected function getAttackEndB() : Boolean
      {
         return this.baba.attack.state == "over";
      }
      
      protected function attackOver() : *
      {
         this.randomValue = Math.random();
         this.randomValue2 = Math.random();
      }
      
      public function waiAttackOver() : *
      {
         this.attackOver();
      }
      
      public function chooseAttack(e_arr0:Array = null) : int
      {
         var hurt00:Number = NaN;
         var index0:int = Math.random() * this.armsNum;
         if(this.attackTurnArr.length > 0)
         {
            this.nowAttackIndex = (this.nowAttackIndex + 1) % this.attackTurnArr.length;
            index0 = this.attackTurnArr[this.nowAttackIndex] - 1;
         }
         if(e_arr0 is Array)
         {
            index0 = int(e_arr0[int(e_arr0.length * Math.random())]);
         }
         this.baba.armsDefine.inData(this.armsName,index0);
         if(this.attackHurtArr.length > 0)
         {
            hurt00 = Number(this.attackHurtArr[index0]);
            this.baba.armsDefine.hurtArr = [hurt00];
            this.baba.armsDefine.hurt_0_B = false;
            this.baba.img.setHurt_byLabel(this.baba.armsDefine.unitImgLabel,hurt00,false);
         }
         if(this.attackRectArr.length > 0)
         {
            this.baba.define.rectLevel = int(this.attackRectArr[index0 % this.attackRectArr.length]);
            this.baba.flesh_byDefine();
         }
         else if(this.baba.armsDefine.grapRectIndex >= 0)
         {
            trace("选择的grapRect编号：" + this.baba.armsDefine.grapRectIndex);
            this.baba.define.rectLevel = this.baba.armsDefine.grapRectIndex;
            this.baba.flesh_byDefine();
         }
         return index0;
      }
      
      public function acceptHurt(value0:Number, attackType:String, defenceType:String) : Number
      {
         if(this.noHurtType == "")
         {
            return value0;
         }
         if(attackType == this.noHurtType)
         {
            return 0;
         }
         return value0;
      }
      
      public function aiTimer() : *
      {
         if(enabled)
         {
            this.attackAI();
            this.skill.skillTimer();
            super.FTimer();
         }
      }
   }
}

