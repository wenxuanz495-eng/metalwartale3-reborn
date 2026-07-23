package effect
{
   import body.image.SingleMovieclip;
   
   public class EffectSMC extends SingleMovieclip
   {
      
      public var die:int = 0;
      
      public function EffectSMC(mc0:*, label0:String, father0:String = "")
      {
         super(mc0,label0,father0);
      }

      override public function gotoAndPlay(num:int) : *
      {
         super.gotoAndPlay(num);
         if(this.label == "electric_effect" && num == 1)
         {
            Game.SG.playDeathElectric();
         }
      }
   }
}

