package body.attack
{
   import flash.geom.Point;
   import flash.geom.Rectangle;
   
   public class AttackAndHurtData
   {
      
      public var baba:*;
      
      public var img:*;
      
      public var armsDefine:*;
      
      public var define:*;
      
      public function AttackAndHurtData(_baba:*, _img:*, _armsDefine:*, _define:*)
      {
         super();
         this.baba = _baba;
         this.img = _img;
         this.armsDefine = _armsDefine;
         this.define = _define;
      }
      
      public function imgAttackOnce() : *
      {
         this.img.goOnce_ToLoop("shoot","fly");
      }
      
      public function get shootPoint() : Point
      {
         var p0:Point = new Point();
         if(Boolean(this.img.rightB))
         {
            p0.x = -this.armsDefine.shootPoint.x + this.img.x;
            p0.y = this.armsDefine.shootPoint.y + this.img.y;
         }
         else
         {
            p0.x = this.armsDefine.shootPoint.x + this.img.x;
            p0.y = this.armsDefine.shootPoint.y + this.img.y;
         }
         return p0;
      }
      
      public function get imgFather() : String
      {
         return this.img.getNowMC().father;
      }
      
      public function get hurtRectArr() : Array
      {
         var n:* = undefined;
         var hr:Rectangle = null;
         var hr_arr:Array = [];
         for(n in this.define.hurtRectArr)
         {
            hr = this.define.hurtRectArr[n].clone();
            if(Boolean(this.img.rightB))
            {
               hr.x = -(hr.x + hr.width);
            }
            hr.x += this.img.x;
            hr.y += this.img.y;
            hr_arr[hr_arr.length] = hr;
         }
         return hr_arr;
      }
      
      public function get shootRa() : Number
      {
         if(this.armsDefine.bulletAngle >= 0)
         {
            if(Boolean(this.img.rightB))
            {
               return (-this.armsDefine.bulletAngle - 180) / 180 * Math.PI;
            }
            return this.armsDefine.bulletAngle / 180 * Math.PI;
         }
         if(Boolean(this.img.hasOwnProperty("shootRa")))
         {
            return this.img.shootRa;
         }
         return 0;
      }
      
      public function get bulletAngle() : Number
      {
         return this.armsDefine.bulletAngle;
      }
   }
}

