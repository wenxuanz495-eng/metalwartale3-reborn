package data
{
   import flash.display.MovieClip;
   import flash.events.Event;
   
   public class SuperSkillTimer extends SkillTimer
   {
      
      internal var time_mc:MovieClip = new MovieClip();
      
      public function SuperSkillTimer()
      {
         super();
         this.time_mc.addEventListener(Event.ENTER_FRAME,FTimer);
      }
   }
}

