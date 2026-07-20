package UI.calendar
{
   public class CalendarDefine
   {
      
      public function CalendarDefine()
      {
         super();
      }
      
      public static function getDateName(year0:Number, month0:int) : int
      {
         var date0:Date = new Date(year0,month0 - 1,28);
         for(var i:int = 29; i <= 31; i++)
         {
            date0.setDate(i);
            if(date0.month != month0 - 1)
            {
               return i - 1;
            }
         }
         return 31;
      }
   }
}

