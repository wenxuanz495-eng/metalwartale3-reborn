package UI.extra
{
   import UI.level.LevelBox;
   
   public class ExtraBtnBox extends LevelBox
   {
      
      public function ExtraBtnBox()
      {
         super();
      }
      
      public function setAllState2(arr0:Array) : *
      {
         var n:* = undefined;
         for(n in arr)
         {
            arr[n].setState2_byNum(arr0[n]);
         }
      }
      
      override public function setName(arr0:Array) : *
      {
         var n:* = undefined;
         var lb0:* = undefined;
         for(n in arr)
         {
            lb0 = arr[n];
            if(n < arr0.length)
            {
               lb0.setText2(arr0[n]);
            }
            else
            {
               lb0.setText2("未开放");
            }
         }
      }
      
      public function setNumArr(arr0:Array) : *
      {
         var n:* = undefined;
         for(n in arr)
         {
            arr[n].setNum(arr0[n]);
         }
      }
      
      public function hideAllNum() : *
      {
         var n:* = undefined;
         for(n in arr)
         {
            arr[n].setNum(0);
         }
      }
   }
}

