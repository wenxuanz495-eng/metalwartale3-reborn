package body.hero
{
   import data.Maths;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   
   public class HeroCarAAHD
   {
      
      public var baba:*;
      
      public function HeroCarAAHD(_baba:*)
      {
         super();
         this.baba = _baba;
      }
      
      public function imgAttackOnce() : *
      {
         this.baba.img.arms.playOnce();
      }
      
      public function imgAttackLoop(_loopTime:Number) : *
      {
         this.baba.img.arms.playLoop(2,_loopTime);
      }
      
      public function imgAttackStop() : *
      {
         this.baba.img.arms.gotoAndStop(1);
      }
      
      public function get shootPoint() : Point
      {
         return this.baba.img.shootPoint;
      }

      public function get laserPoint() : Point
      {
         if(!(this.baba.img is HeroCarImage))
         {
            return this.shootPoint;
         }
         return this.baba.img.laserPoint;
      }
      
      public function get imgFather() : String
      {
         return this.baba.armsDefine.father;
      }
      
      public function get shootRa() : Number
      {
         var ba0:Number = Number(this.baba.armsDefine.bulletAngle);
         if(ba0 >= 0)
         {
            if(Boolean(this.baba.img.rightB))
            {
               return Maths.flipRa_Y(ba0 / 180 * Math.PI);
            }
            return ba0 / 180 * Math.PI;
         }
         return this.baba.img.shootRa;
      }
      
      public function get bulletAngle() : Number
      {
         return this.baba.armsDefine.bulletAngle;
      }
      
      public function get hurtRectArr() : Array
      {
         var n:* = undefined;
         var hr:Rectangle = null;
         var hr_arr:Array = [];
         for(n in this.baba.carDefine.hurtRectArr)
         {
            hr = this.baba.carDefine.hurtRectArr[n].clone();
            if(Boolean(this.baba.img.rightB))
            {
               hr.x = -(hr.x + hr.width);
            }
            hr.x += this.baba.mot.x0;
            hr.y += this.baba.mot.y0;
            hr_arr[hr_arr.length] = hr;
         }
         return hr_arr;
      }
   }
}

