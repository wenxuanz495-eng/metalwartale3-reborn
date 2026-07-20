package enemy.electricSaw
{
   import body.attack.AttackHitData;
   import flash.geom.Rectangle;
   
   public class ElectricSawAAHD
   {
      
      public var baba:*;
      
      public var define:*;
      
      public var img:*;
      
      public function ElectricSawAAHD(_baba:*, _define:*, _img:*)
      {
         super();
         this.baba = _baba;
         this.define = _define;
         this.img = _img;
      }
      
      public function imgAttackOnce() : *
      {
         this.img.goOnce_ToLoop("attack","stand");
      }
      
      public function get attackData() : AttackHitData
      {
         var ad:AttackHitData = this.img.getAttackData();
         if(ad is AttackHitData)
         {
            return ad.clone(this.img.x,this.img.y,this.img.rightB);
         }
         return null;
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
      
      public function get imgFather() : String
      {
         return this.img.getNowMC().father;
      }
   }
}

