package image
{
   import data.INIT;
   
   public class ShakeMotion
   {
      
      public var x:Number = 0;
      
      public var y:Number = 0;
      
      private var range1:Number = 0;
      
      private var range2:Number = 0;
      
      private var number:int = 0;
      
      private var way:String = "random";
      
      private var ra:Number = 0;
      
      public var time:int = 1;
      
      public var now_t:int = 0;
      
      private var attenuate:Number = 0;
      
      public var enabled:Boolean = false;
      
      public function ShakeMotion()
      {
         super();
      }
      
      public function startShake(_number:int, _time:Number, _ra:Number, _range1:Number, _range2:Number, _attenuate:Number = 0, _way:String = "cos") : *
      {
         this.init();
         this.number = _number;
         this.time = int(_time * INIT.FPS);
         if(this.time == 0)
         {
            this.time = 1;
         }
         this.ra = _ra;
         this.range1 = _range1;
         this.range2 = _range2;
         this.attenuate = _attenuate;
         this.way = _way;
         this.enabled = true;
         this.now_t = 0;
      }
      
      public function init() : *
      {
         this.x = 0;
         this.y = 0;
         this.range1 = 0;
         this.range2 = 0;
         this.number = 0;
         this.ra = 0;
         this.time = 1;
         this.now_t = 0;
         this.attenuate = 0;
         this.enabled = false;
      }
      
      private function getData() : *
      {
         var av2:Number = NaN;
         var av:Number = (this.time - this.now_t) / this.time * (1 - this.attenuate) + this.attenuate;
         if(this.way == "random")
         {
            this.x = (Math.random() * (this.range2 - this.range1) + this.range1) * Math.cos(this.ra) * av;
            this.y = (Math.random() * (this.range2 - this.range1) + this.range1) * Math.sin(this.ra) * av;
         }
         else if(this.way == "cos")
         {
            av2 = (Math.cos(this.now_t / this.time * Math.PI * this.number) + 1) / 2;
            this.x = (av2 * (this.range2 - this.range1) + this.range1) * Math.cos(this.ra) * av;
            this.y = (av2 * (this.range2 - this.range1) + this.range1) * Math.sin(this.ra) * av;
         }
      }
      
      public function shakeTimer() : *
      {
         if(this.enabled)
         {
            if(this.now_t < this.time)
            {
               ++this.now_t;
               this.getData();
            }
            else
            {
               this.x = 0;
               this.y = 0;
               this.enabled = false;
            }
         }
      }
   }
}

