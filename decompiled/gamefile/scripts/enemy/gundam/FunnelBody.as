package enemy.gundam
{
   import body.define.EnemyDefine;
   import body.image.MultipleImage;
   
   public class FunnelBody
   {
      
      public var img:MultipleImage = new MultipleImage();
      
      public var define:EnemyDefine = new EnemyDefine();
      
      public var AAHD:FunnelAAHD;
      
      public var die:int = 0;
      
      public var hitHurtB:int = 1;
      
      public var camp:String = "enemy";
      
      public function FunnelBody()
      {
         super();
         this.AAHD = new FunnelAAHD(this.img);
      }
      
      public function inData_byXML(xml0:XML) : *
      {
         this.define.inData_byXML(xml0);
      }
      
      public function attack() : *
      {
         this.img.goPlayOnce("missile");
      }
      
      public function set x(value:Number) : *
      {
         this.img.x = int(value);
      }
      
      public function set y(value:Number) : *
      {
         this.img.y = int(value);
      }
      
      public function bodyTimer() : *
      {
         this.img.imageTimer();
         var dieB:Boolean = this.img.endFrameB;
         if(dieB)
         {
            this.die = 2;
         }
      }
   }
}

