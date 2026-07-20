package enemy.falconFighter
{
   import enemy.AI.Enemy_AI;
   
   public class FalconFighter_AI extends Enemy_AI
   {
      
      private var levelUpB:Boolean = false;
      
      public var changeB:Boolean = true;
      
      public var bombingModel:Boolean = false;
      
      public var attackNum:int = 0;
      
      public function FalconFighter_AI(_baba:*)
      {
         super(_baba);
      }
      
      override protected function followToPoint(x0:Number, y0:Number) : *
      {
         baba.mot.followPoint(x0,y0);
         if(follow_t % 4 == 0)
         {
            followFilp();
         }
      }
      
      override protected function attackOver() : *
      {
         var ran:Number = NaN;
         var bilv:Number = NaN;
         var xx0:int = 0;
         var yy0:int = 0;
         if(this.changeB)
         {
            ran = Math.random();
            bilv = 0.5;
            if(ran >= bilv)
            {
               baba.armsDefine.inData("FalconFighter",0);
               baba.define.rectLevel = 0;
               baba.flesh_byDefine();
            }
            else
            {
               baba.armsDefine.inData("FalconFighter_2",0);
               baba.define.rectLevel = 1;
               baba.flesh_byDefine();
            }
         }
         if(this.bombingModel)
         {
            ++this.attackNum;
            trace("attackNum:" + this.attackNum);
            if(this.attackNum >= 2)
            {
               targetBody = null;
               state = "noing";
               this.ClearAllFun();
               baba.mot.toStop();
               xx0 = int(baba.img.x);
               yy0 = baba.img.y - 300;
               if(Boolean(baba.img.rightB))
               {
                  xx0 -= 3000;
               }
               else
               {
                  xx0 += 3000;
               }
               enabled = false;
               this.followToPoint(xx0,yy0);
               trace("停止攻击，飞出屏幕外，x0:" + xx0 + ",y0:" + yy0);
            }
         }
         super.attackOver();
      }
      
      public function setToBomb() : *
      {
         baba.define.rectLevel = 1;
         baba.flesh_byDefine();
         this.bombingModel = true;
         this.changeB = false;
         baba.mot.vxmax *= 2;
         baba.mot.vymax *= 2;
         baba.hitHurtB = 1;
         baba.define.lifeBar.visible = false;
         baba.armsDefine.inData("FalconFighter_2",1);
      }
      
      public function bombingTimer() : *
      {
         if(this.attackNum >= 2)
         {
            trace("baba.mot.mx：" + baba.mot.mx);
            if(baba.mot.getGap() < 100)
            {
               trace("无声死亡^^^^^^^^^^^^^");
               baba.toDie(false);
            }
         }
      }
      
      override public function aiTimer() : *
      {
         super.aiTimer();
         this.bombingTimer();
      }
   }
}

