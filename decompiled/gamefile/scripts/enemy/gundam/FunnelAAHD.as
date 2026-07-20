package enemy.gundam
{
   import body.attack.AttackHitData;
   import body.image.MultipleImage;
   
   public class FunnelAAHD
   {
      
      public var img:MultipleImage;
      
      public function FunnelAAHD(_img:*)
      {
         super();
         this.img = _img;
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
   }
}

