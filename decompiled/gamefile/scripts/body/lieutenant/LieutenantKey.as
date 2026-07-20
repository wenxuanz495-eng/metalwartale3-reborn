package body.lieutenant
{
   import body.skill.OneSkill;
   
   public class LieutenantKey
   {
      
      internal var BB:LieutenantBody;
      
      public function LieutenantKey(_BB:*)
      {
         super();
         this.BB = _BB;
      }
      
      public function toJump() : *
      {
         if(this.BB.mot.getFloorB())
         {
            this.BB.mot.toJump();
            Game.EG.addEffect("car","jet_effect",Game.gameSprite.effectL,this.BB.img.x,this.BB.img.y);
         }
         else if(this.BB.mot.jumpNow < 2)
         {
            this.BB.mot.toJump();
         }
      }
      
      public function openPlasma() : *
      {
         var s0:OneSkill = this.BB.skill.getSkill("plasma");
         var bb1:Boolean = s0.getUseB();
         if(bb1 && !this.BB.getPlasmaB())
         {
            s0.useSkill();
            this.BB.openPlasma(s0.time_t);
         }
      }
      
      public function speedUp() : *
      {
         var s0:OneSkill = this.BB.skill.getSkill("rocket");
         var bb2:Boolean = s0.getUseB();
         if(bb2)
         {
            s0.useSkill();
            this.BB.speedUp();
         }
      }
   }
}

