package enemy.atomicTower
{
   import enemy.charger.ChargerAAHD;
   
   public class AtomicTowerAAHD extends ChargerAAHD
   {
      
      public function AtomicTowerAAHD(_baba:*, _img:*, _armsDefine:*, _define:*)
      {
         super(_baba,_img,_armsDefine,_define);
      }
      
      override public function imgAttackOnce() : *
      {
         img.goOnce_ToLoop(armsDefine.unitImgLabel,"stand");
      }
   }
}

