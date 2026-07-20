package enemy._normal
{
   import body.attack.AttackAndHurtData;
   import body.attack.AttackHitData;
   
   public class Normal_AAHD extends AttackAndHurtData
   {
      
      public var lastLabel:String = "stand";
      
      public function Normal_AAHD(_baba:*, _img:*, _armsDefine:*, _define:*)
      {
         super(_baba,_img,_armsDefine,_define);
      }
      
      override public function imgAttackOnce() : *
      {
         img.goOnce_ToLoop(armsDefine.unitImgLabel,this.lastLabel);
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

