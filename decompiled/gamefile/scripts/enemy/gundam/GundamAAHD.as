package enemy.gundam
{
   import body.attack.AttackAndHurtData;
   import body.attack.AttackHitData;
   
   public class GundamAAHD extends AttackAndHurtData
   {
      
      public function GundamAAHD(_baba:*, _img:*, _armsDefine:*, _define:*)
      {
         super(_baba,_img,_armsDefine,_define);
      }
      
      override public function imgAttackOnce() : *
      {
         var imgLabel0:String = baba.state;
         if(imgLabel0 == "land")
         {
            imgLabel0 = "stand";
         }
         img.goOnce_ToLoop(armsDefine.unitImgLabel,imgLabel0);
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

