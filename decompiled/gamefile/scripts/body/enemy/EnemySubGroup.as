package body.enemy
{
   import body.hero.SubBody;
   import bodyGroup.BodyGroup;
   import flash.geom.Point;
   
   public class EnemySubGroup
   {
      
      public var arr:Array = new Array();
      
      public var pointArr:Array = [];
      
      public var heroX:int = 0;
      
      public var heroY:int = 0;
      
      public var baba:*;
      
      public function EnemySubGroup()
      {
         super();
         this.pointArr = Game.gameDefine.pointArr;
      }
      
      public function fleshByArr(arr0:Array) : *
      {
         var n:* = undefined;
         var name0:String = null;
         var sub0:SubBody = null;
         this.clearSub();
         for(n in arr0)
         {
            name0 = arr0[n];
            if(name0 != "")
            {
               sub0 = Game.BG.addEnemySubBody();
               sub0.changeArms(name0);
               this.addSub(sub0,n);
            }
         }
      }
      
      public function clearSub() : *
      {
         var n:* = undefined;
         var BG:BodyGroup = Game.BG;
         this.stopAll();
         for(n in this.arr)
         {
            BG.delBody_inArr(BG.enemySub_arr,this.arr[n]);
         }
         this.arr.length = 0;
      }
      
      public function addSub(sub0:SubBody, site0:int = 0, positionBreakB:Boolean = true) : *
      {
         sub0.father = this.baba;
         this.arr.push(sub0);
         var p0:Point = this.pointArr[site0];
         sub0.subPoint = p0;
         sub0.img.beforeP = p0;
         sub0.index = site0;
         var mpx:int = p0.x + this.heroX;
         var mpy:int = p0.y + this.heroY;
         if(positionBreakB)
         {
            sub0.mot.setX(mpx);
            sub0.mot.setY(mpy);
            sub0.img.x = mpx;
            sub0.img.y = mpy;
         }
         else
         {
            sub0.mot.followPoint(mpx,mpy);
         }
         sub0.img.car.play();
      }
      
      public function fleshAllPosition() : *
      {
         var n:* = undefined;
         var sub0:SubBody = null;
         var p0:Point = null;
         var mpx:int = 0;
         var mpy:int = 0;
         for(n in this.arr)
         {
            sub0 = this.arr[n];
            p0 = this.pointArr[sub0.index];
            mpx = p0.x + this.heroX;
            mpy = p0.y + this.heroY;
            sub0.mot.setX(mpx);
            sub0.mot.setY(mpy);
            sub0.img.x = mpx;
            sub0.img.y = mpy;
         }
      }
      
      public function inPozision(rightB:Boolean, x0:Number, y0:Number) : *
      {
         var n:* = undefined;
         var sub0:SubBody = null;
         var x1:Number = NaN;
         var y1:Number = NaN;
         this.heroX = x0;
         this.heroY = y0;
         for(n in this.arr)
         {
            sub0 = this.arr[n];
            if(rightB)
            {
               x1 = x0 - sub0.subPoint.x;
               y1 = y0 + sub0.subPoint.y;
            }
            else
            {
               x1 = x0 + sub0.subPoint.x;
               y1 = y0 + sub0.subPoint.y;
            }
            if(sub0.index >= 2)
            {
               sub0.mot.setMX(x1);
            }
            else
            {
               if(rightB)
               {
                  sub0.moveToLeft();
               }
               else
               {
                  sub0.moveToRight();
               }
               sub0.mot.followPoint(x1,y1);
            }
         }
      }
      
      public function inMouseXY(_x0:Number, _y0:Number) : *
      {
         var n:* = undefined;
         var sub0:SubBody = null;
         for(n in this.arr)
         {
            sub0 = this.arr[n];
            if(sub0.index >= 2)
            {
               sub0.mot.setMY(_y0 + sub0.subPoint.y + 113);
               if(_x0 - sub0.mot.x0 > 0)
               {
                  sub0.img.flipToLeft();
               }
               else
               {
                  sub0.img.flipToRight();
               }
            }
         }
      }
      
      public function attackAll() : *
      {
         var n:* = undefined;
         var sub0:SubBody = null;
         for(n in this.arr)
         {
            sub0 = this.arr[n];
            sub0.attack.startAttack();
         }
      }
      
      public function stopAll() : *
      {
         var n:* = undefined;
         var sub0:SubBody = null;
         for(n in this.arr)
         {
            sub0 = this.arr[n];
            sub0.attack.stopLoop();
         }
      }
      
      public function stopAllImage() : *
      {
         var n:* = undefined;
         var sub0:SubBody = null;
         for(n in this.arr)
         {
            sub0 = this.arr[n];
            sub0.img.stopAll();
         }
      }
      
      public function FTimer() : *
      {
      }
   }
}

