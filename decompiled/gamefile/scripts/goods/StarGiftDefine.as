package goods
{
   public class StarGiftDefine
   {
      
      private var unionshopArr:Array = [];
      
      public function StarGiftDefine()
      {
         super();
      }
      
      public function inData_byXML(xmlData:XML) : void
      {
         var usd:StarGiftData = null;
         var gstr:String = null;
         var adddstr:String = null;
         var rootList:XMLList = xmlData.child("data");
         var subElement:XMLList = xmlData.child("Gift");
         for(var i:int = 0; i < subElement.length(); i++)
         {
            usd = new StarGiftData();
            if(subElement[i].@Id.length() > 0)
            {
               usd.Id = int(subElement[i].@Id);
            }
            if(subElement[i].@Name.length() > 0)
            {
               usd.Name = String(subElement[i].@Name);
            }
            if(subElement[i].@NeedNum.length() > 0)
            {
               usd.NeedNum = int(subElement[i].@NeedNum);
            }
            if(subElement[i].@GiftArr.length() > 0)
            {
               gstr = String(subElement[i].@GiftArr);
               usd.GiftArr = gstr.split("|");
            }
            if(subElement[i].@GiftDesc.length() > 0)
            {
               usd.GiftDesc = String(subElement[i].@GiftDesc);
            }
            if(subElement[i].@Icon.length() > 0)
            {
               usd.Icon = String(subElement[i].@Icon);
            }
            if(subElement[i].@AddArr.length() > 0)
            {
               adddstr = String(subElement[i].@AddArr);
               usd.AddArr = adddstr.split("|");
            }
            this.unionshopArr.push(usd);
         }
         this.unionshopArr.sortOn("NeedNum",Array.NUMERIC);
      }
      
      public function GetStarGiftArr() : Array
      {
         return this.unionshopArr;
      }
      
      public function GetOneGift(id:int) : StarGiftData
      {
         var obj:StarGiftData = null;
         for(var i:int = 0; i < this.unionshopArr.length; i++)
         {
            obj = this.unionshopArr[i] as StarGiftData;
            if(obj.Id == id)
            {
               return obj;
            }
         }
         return null;
      }
   }
}

