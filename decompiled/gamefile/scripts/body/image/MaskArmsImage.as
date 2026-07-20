package body.image
{
   import body.hero.ArmsImage;
   import data.Maths;
   import flash.display.Shape;
   import flash.geom.Point;
   
   public class MaskArmsImage extends ArmsImage
   {
      
      public var maskSp:Shape;
      
      public var smc:SingleMovieclip;
      
      private var lastLength:int = 0;
      
      private var basePointLen:int = 0;
      
      public function MaskArmsImage()
      {
         super();
      }
      
      override protected function adjustPosition(label0:String) : *
      {
         var index0:int = getIndex_byLabel(label0);
         var mc0:SingleMovieclip = mc_arr[index0];
         var p0:Point = mc0.basePoint;
         mc0.mc.x = -p0.x;
         mc0.mc.y = -p0.y;
      }
      
      override public function showMC(label0:String) : *
      {
         super.showMC(label0);
         this.showMask();
      }
      
      public function useMask() : *
      {
         this.maskSp = new Shape();
         this.maskSp.graphics.beginFill(16777215);
         this.maskSp.graphics.drawRect(0,-30,1000,60);
         this.maskSp.x = -30;
         addChild(this.maskSp);
      }
      
      public function showMask() : *
      {
         var mc:* = getNowMC();
         if(mc is SingleMovieclip)
         {
            this.basePointLen = Maths.Long(mc.shootPoint.x - mc.basePoint.x,mc.shootPoint.y - mc.basePoint.y);
            this.maskSp.visible = true;
            mc.mc.mask = this.maskSp;
         }
      }
      
      public function delMask() : *
      {
         this.maskSp.visible = false;
         var mc:* = getNowMC();
         if(mc is SingleMovieclip)
         {
            mc.mc.mask = null;
         }
      }
      
      public function set length(value:int) : *
      {
         if(value >= 1000)
         {
            if(this.lastLength < 1000)
            {
               this.delMask();
            }
         }
         else
         {
            if(this.lastLength >= 1000)
            {
               this.showMask();
            }
            this.maskSp.width = value + 30 + this.basePointLen;
            this.maskSp.x = -30;
         }
         this.lastLength = value;
      }
      
      public function get length() : int
      {
         return this.lastLength;
      }
      
      override public function imageTimer() : *
      {
         super.imageTimer();
         if(nowMC is SingleMovieclip)
         {
            if(nowMC.currentFrame == 1)
            {
               this.length = 1000;
            }
         }
      }
   }
}

