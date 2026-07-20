package enemy.spider
{
   import flash.geom.Rectangle;
   
   public class SpiderAAHD
   {
      
      public var baba:*;
      
      public var img:*;
      
      public var define:*;
      
      public function SpiderAAHD(_baba:*, _img:*, _define:*)
      {
         super();
         this.baba = _baba;
         this.img = _img;
         this.define = _define;
      }
      
      public function get hurtRectArr() : Array
      {
         var n:* = undefined;
         var hr:Rectangle = null;
         var hr_arr:Array = [];
         for(n in this.define.hurtRectArr)
         {
            hr = this.define.hurtRectArr[n].clone();
            hr.x += this.img.x;
            hr.y += this.img.y;
            hr_arr[hr_arr.length] = hr;
         }
         return hr_arr;
      }
   }
}

