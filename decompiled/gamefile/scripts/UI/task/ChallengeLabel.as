package UI.task
{
   public class ChallengeLabel extends TaskLabel
   {
      
      public function ChallengeLabel()
      {
         super();
         star_mc.visible = false;
      }
      
      override public function setNowState(str0:String) : *
      {
         state_mc.gotoAndStop(str0);
      }
   }
}

