package enemy.charger
{
   import body.attack.AttackAndHurtData;
   import body.attack.AttackHitData;
   
   public class ChargerAAHD extends AttackAndHurtData
   {
      
      public function ChargerAAHD(_baba:*, _img:*, _armsDefine:*, _define:*)
      {
         super(_baba,_img,_armsDefine,_define);
      }
      
      override public function imgAttackOnce() : *
      {
         img.goPlayLoop(armsDefine.unitImgLabel);
      }
      
      public function imgAttackLoop(_loopTime:Number) : *
      {
         img.playLoop(2,_loopTime);
      }
      
      override public function get shootRa() : Number
      {
         if(Boolean(img.rightB))
         {
            return (-armsDefine.bulletAngle - 180) / 180 * Math.PI;
         }
         return armsDefine.bulletAngle / 180 * Math.PI;
      }
      
      public function get attackData() : AttackHitData
      {
         var ad0:* = undefined;
         var ad:AttackHitData = img.getAttackData();
         if(ad is AttackHitData)
         {
            return ad.clone(img.x,img.y,img.rightB);
         }
         return null;
      }
   }
}

