package enemy.rolling
{
   import body.attack.AttackAndHurtData;
   import body.attack.AttackHitData;
   
   public class RollingAAHD extends AttackAndHurtData
   {
      
      public function RollingAAHD(_baba:*, _img:*, _armsDefine:*, _define:*)
      {
         super(_baba,_img,_armsDefine,_define);
      }
      
      override public function imgAttackOnce() : *
      {
         img.goOnce_ToLoop(armsDefine.unitImgLabel,"stand");
      }
      
      public function get attackData() : AttackHitData
      {
         var ad:AttackHitData = img.getAttackData();
         if(ad is AttackHitData)
         {
            return ad.clone(img.x,img.y,img.rightB);
         }
         return null;
      }
   }
}

