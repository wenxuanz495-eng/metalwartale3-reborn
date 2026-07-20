package body.hero
{
   import flash.geom.Rectangle;
   
   public class NewHeroCarAAHD extends HeroCarAAHD
   {
      
      public var flyHurtRect:Rectangle = new Rectangle(-26,-160,49,111);
      
      public var flyHitRect:Rectangle = new Rectangle(-35,-200,70,200);
      
      public function NewHeroCarAAHD(_baba:*)
      {
         super(_baba);
      }
      
      override public function imgAttackOnce() : *
      {
         var img0:HeroCarImage = baba.img;
         if(img0.bodyState == "fly")
         {
            img0.fly.playArms();
         }
         else
         {
            img0.arms.playOnce();
         }
      }
      
      override public function imgAttackLoop(_loopTime:Number) : *
      {
         var img0:HeroCarImage = baba.img;
         if(img0.bodyState == "stand")
         {
            img0.arms.playLoop(2,_loopTime);
         }
      }
      
      override public function imgAttackStop() : *
      {
         var img0:HeroCarImage = baba.img;
         img0.fly.stopArms();
         img0.arms.gotoAndStop(1);
      }
      
      override public function get hurtRectArr() : Array
      {
         var n:* = undefined;
         var hr:Rectangle = null;
         var img0:HeroCarImage = baba.img;
         var hr_arr:Array = [];
         var hurtRectArr:Array = [];
         if(img0.bodyState == "stand")
         {
            hurtRectArr = baba.carDefine.hurtRectArr;
         }
         else
         {
            hurtRectArr = [this.flyHurtRect];
         }
         for(n in hurtRectArr)
         {
            hr = hurtRectArr[n].clone();
            if(Boolean(baba.img.rightB))
            {
               hr.x = -(hr.x + hr.width);
            }
            hr.x += baba.mot.x0;
            hr.y += baba.mot.y0;
            hr_arr[hr_arr.length] = hr;
         }
         return hr_arr;
      }
   }
}

