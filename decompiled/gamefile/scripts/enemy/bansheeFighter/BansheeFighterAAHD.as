package enemy.bansheeFighter
{
   import body.attack.AttackAndHurtData;
   
   public class BansheeFighterAAHD extends AttackAndHurtData
   {
      
      public function BansheeFighterAAHD(_baba:*, _img:*, _armsDefine:*, _define:*)
      {
         super(_baba,_img,_armsDefine,_define);
      }
      
      override public function imgAttackOnce() : *
      {
         img.goOnce_ToLoop(armsDefine.unitImgLabel,"fly");
      }
   }
}

