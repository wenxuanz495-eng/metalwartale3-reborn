package goods
{
   public class UnionShopDefine
   {
      
      private var unionshopArr:Array = [];
      
      public function UnionShopDefine()
      {
         super();
      }
      
      public function inData_byXML(xmlData:XML) : void
      {
         var usd:UnionShopData = null;
         var rootList:XMLList = xmlData.child("Data");
         var subElement:XMLList = xmlData.child("EItem");
         for(var i:int = 0; i < subElement.length(); i++)
         {
            usd = new UnionShopData();
            if(subElement[i].@Id.length() > 0)
            {
               usd.Id = int(subElement[i].@Id);
            }
            if(subElement[i].@Price.length() > 0)
            {
               usd.Price = int(subElement[i].@Price);
            }
            if(subElement[i].@GoodsID.length() > 0)
            {
               usd.GoodsID = String(subElement[i].@GoodsID);
            }
            if(subElement[i].@BuyType.length() > 0)
            {
               usd.BuyType = String(subElement[i].@BuyType);
            }
            if(subElement[i].@DayCanTime.length() > 0)
            {
               usd.DayCanTime = int(subElement[i].@DayCanTime);
            }
            if(subElement[i].@Count.length() > 0)
            {
               usd.Count = int(subElement[i].@Count);
            }
            if(subElement[i].@Name.length() > 0)
            {
               usd.Name = String(subElement[i].@Name);
            }
            if(subElement[i].@ConditionUnion.length() > 0)
            {
               usd.ConditionUnion = int(subElement[i].@ConditionUnion);
            }
            if(subElement[i].@ConditionMember.length() > 0)
            {
               usd.ConditionMember = int(subElement[i].@ConditionMember);
            }
            this.unionshopArr.push(usd);
         }
      }
      
      public function GetUnionShopArr() : Array
      {
         return this.unionshopArr;
      }
   }
}

