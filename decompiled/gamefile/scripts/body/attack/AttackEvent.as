package body.attack
{
   import flash.events.Event;
   
   public class AttackEvent extends Event
   {
      
      public static const ACTION:String = "Attack";
      
      public var bullet:*;
      
      public var x0:Number = 0;
      
      public var y0:Number = 0;
      
      public var v0:Number = 0;
      
      public var ra:Number = 0;
      
      public var vmax:Number = 0;
      
      public var va:Number = 0;
      
      public var attackBody:*;
      
      public var targetBody:*;
      
      public function AttackEvent()
      {
         super(ACTION);
      }
      
      override public function clone() : Event
      {
         var newEvent:AttackEvent = new AttackEvent();
         newEvent.bullet = this.bullet;
         newEvent.x0 = this.x0;
         newEvent.y0 = this.y0;
         newEvent.v0 = this.v0;
         newEvent.ra = this.ra;
         newEvent.vmax = this.vmax;
         newEvent.va = this.va;
         newEvent.attackBody = this.attackBody;
         newEvent.targetBody = this.targetBody;
         return newEvent;
      }
   }
}

