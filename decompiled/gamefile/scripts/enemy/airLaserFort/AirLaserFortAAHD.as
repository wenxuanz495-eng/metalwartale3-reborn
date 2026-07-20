package enemy.airLaserFort
{
   import body.attack.AttackAndHurtData;
   
   public class AirLaserFortAAHD extends AttackAndHurtData
   {
      
      public function AirLaserFortAAHD(_baba:*, _img:*, _armsDefine:*, _define:*)
      {
         super(_baba,_img,_armsDefine,_define);
      }
      
      override public function imgAttackOnce() : *
      {
         img.goOnce_ToLoop("shoot","fly");
      }
   }
}

