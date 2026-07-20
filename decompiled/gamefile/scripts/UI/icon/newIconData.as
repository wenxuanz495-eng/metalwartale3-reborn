package UI.icon
{
   public class newIconData
   {
      
      public var newB:Boolean = false;
      
      public var newLevel:int = -1;
      
      public var realLevel:int = -1;
      
      public function newIconData()
      {
         super();
      }
      
      public function add(new2:newIconData) : *
      {
         if(this.newB)
         {
            if(this.realLevel > this.newLevel)
            {
               this.newB = new2.newB;
            }
         }
      }
      
      public function hideNew() : *
      {
         this.newB = false;
         this.newLevel = this.realLevel;
      }
   }
}

