package UI.research
{
   import body.define.OneArmsDefine;
   import gameAll.data.ArmsItemsData;
   import gameAll.data.ArmsItemsDataGroup;
   
   public class ArmsDataFilter
   {
      
      public function ArmsDataFilter()
      {
         super();
      }
      
      public function getOneList(type0:String, dg0:ArmsItemsDataGroup) : Array
      {
         var n:* = undefined;
         var d0:OneArmsDefine = null;
         var da0:ArmsItemsData = null;
         var arr2:Array = Game.defineGroup.getAll(type0);
         var arr0:Array = [];
         for(n in arr2)
         {
            d0 = arr2[n][0];
            da0 = dg0.getItemsByBase(d0.id,false);
            if(Boolean(da0))
            {
               arr0.push(da0);
            }
            else if(d0.index < 50)
            {
               arr0.push(d0);
            }
         }
         return arr0;
      }
   }
}

