package body.motion
{
   public class BodyDof
   {
      
      public var num:int = 0;
      
      public var QU:int = 0;
      
      public var type:int = 0;
      
      public var back:Number = 0;
      
      public var long:Number = 0;
      
      public var first:Number = 0;
      
      public var vx:Number = 0;
      
      public var vy:Number = 0;
      
      private var bb:Boolean = true;
      
      public function BodyDof(_qu:int)
      {
         super();
         this.QU = _qu;
      }
      
      public function init() : *
      {
         this.type = 0;
         this.back = 0;
         this.long = 0;
         this.first = 0;
         this.vy = 0;
         this.vx = 0;
      }
      
      public function setDof(dof:BodyDof) : *
      {
         this.type = dof.type;
         this.back = dof.back;
         this.long = dof.long;
         this.first = dof.first;
         this.vx = dof.vx;
         this.vy = dof.vy;
      }
      
      public function inDof(dof:BodyDof) : *
      {
         var l0:Number = NaN;
         var l1:Number = NaN;
         if(dof.type > 0)
         {
            ++this.num;
            this.back = dof.back;
            this.vx = dof.vx;
            this.vy = dof.vy;
            if(this.type < dof.type)
            {
               this.type = dof.type;
            }
            if(this.first > dof.first || this.bb)
            {
               this.bb = false;
               this.first = dof.first;
            }
            l0 = this.last;
            l1 = dof.last;
            if(l0 < l1)
            {
               this.long = l1 - this.first;
            }
         }
      }
      
      public function get last() : Number
      {
         return this.long + this.first;
      }
      
      public function toString() : String
      {
         return String(this.type);
      }
   }
}

