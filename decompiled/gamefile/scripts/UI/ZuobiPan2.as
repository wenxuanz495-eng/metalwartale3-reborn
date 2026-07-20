package UI
{
   import gameAll.data.GoodsItemsData;
   
   public class ZuobiPan2
   {
      
      private var arr:Array = [];
      
      private var lastM:int = 0;
      
      public function ZuobiPan2()
      {
         super();
      }
      
      public function pan() : Boolean
      {
         return false;
      }
      
      private function check() : Boolean
      {
         var gid:GoodsItemsData = null;
         var mn:MNum = null;
         var mm:MNum = null;
         var j:int = 0;
         var tmn:MNum = null;
         var nowM:int = Game.gameData.MCoin;
         var tempArr:Array = [];
         var marr:Array = Game.gameData.materialsItems.arr;
         var mlen:int = int(marr.length);
         var hasd:Boolean = false;
         for(var i:int = 0; i < mlen; i++)
         {
            gid = marr[i];
            for(j = 0; j < tempArr.length; j++)
            {
               mn = tempArr[j] as MNum;
               if(mn.Id == gid.id)
               {
                  mn.Num += gid.nowNum;
                  hasd = true;
               }
            }
            if(hasd == false)
            {
               mm = new MNum();
               mm.Id = gid.id;
               mm.Num = gid.nowNum;
               tempArr.push(mm);
            }
            hasd = false;
         }
         marr = Game.gameData.propsItems.arr;
         mlen = int(marr.length);
         hasd = false;
         for(i = 0; i < mlen; i++)
         {
            gid = marr[i];
            for(j = 0; j < tempArr.length; j++)
            {
               mn = tempArr[j] as MNum;
               if(mn.Id == gid.id)
               {
                  mn.Num += gid.nowNum;
                  hasd = true;
               }
            }
            if(hasd == false)
            {
               mm = new MNum();
               mm.Id = gid.id;
               mm.Num = gid.nowNum;
               tempArr.push(mm);
            }
            hasd = false;
         }
         for(i = 0; i < tempArr.length; i++)
         {
            tmn = tempArr[i];
            for(j = 0; j < this.arr.length; j++)
            {
               mn = this.arr[j];
               if(mn.Id == tmn.Id)
               {
                  if(tmn.Num - mn.Num > 19888 && nowM - this.lastM == 0)
                  {
                     return true;
                  }
               }
            }
         }
         this.arr = tempArr;
         return false;
      }
   }
}

class MNum
{
   
   public var Id:String = "";
   
   public var Num:int = 0;
   
   public function MNum()
   {
      super();
   }
}
