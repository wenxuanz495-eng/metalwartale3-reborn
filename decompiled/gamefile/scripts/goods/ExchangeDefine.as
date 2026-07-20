package goods
{
   public class ExchangeDefine
   {
      
      private var ItemArr:Array = [];
      
      public function ExchangeDefine()
      {
         super();
      }
      
      public function inData_byXML(xmlData:XML) : void
      {
         var sDataInfo:ExchangeData = null;
         var dg:String = null;
         var rootList:XMLList = xmlData.child("data");
         var subElement:XMLList = xmlData.child("EItem");
         for(var i:int = 0; i < subElement.length(); i++)
         {
            sDataInfo = new ExchangeData();
            if(subElement[i].@Id.length() > 0)
            {
               sDataInfo.Id = int(subElement[i].@Id);
            }
            if(subElement[i].@Desc.length() > 0)
            {
               sDataInfo.Desc = subElement[i].@Desc.toString();
            }
            if(subElement[i].@EPayType.length() > 0)
            {
               sDataInfo.EPayType = subElement[i].@EPayType.toString();
            }
            if(subElement[i].@Name.length() > 0)
            {
               sDataInfo.Name = subElement[i].@Name.toString();
            }
            if(subElement[i].@Proba.length() > 0)
            {
               sDataInfo.Proba = Number(subElement[i].@Proba);
            }
            if(subElement[i].@EPayCount.length() > 0)
            {
               sDataInfo.EPayCount = int(subElement[i].@EPayCount);
            }
            if(subElement[i].@DropGroup.length() > 0)
            {
               dg = subElement[i].@DropGroup.toString();
               if(dg.indexOf("，") >= 0)
               {
                  sDataInfo.DropGroup = dg.split("，");
               }
               else
               {
                  sDataInfo.DropGroup = dg.split(",");
               }
            }
            if(subElement[i].@DropProba.length() > 0)
            {
               dg = subElement[i].@DropProba.toString();
               if(dg.indexOf("，") >= 0)
               {
                  sDataInfo.DropProba = dg.split("，");
               }
               else
               {
                  sDataInfo.DropProba = dg.split(",");
               }
            }
            if(subElement[i].@DropNum.length() > 0)
            {
               dg = subElement[i].@DropNum.toString();
               if(dg.indexOf("，") >= 0)
               {
                  sDataInfo.DropNum = dg.split("，");
               }
               else
               {
                  sDataInfo.DropNum = dg.split(",");
               }
            }
            if(sDataInfo.DropProba.length != sDataInfo.DropGroup.length && sDataInfo.DropGroup.length != sDataInfo.DropNum.length)
            {
               throw new Error(this + ":数据长度不匹配:" + sDataInfo.Name);
            }
            this.ItemArr.push(sDataInfo);
         }
      }
      
      public function getItemArrCopy() : Array
      {
         var arr:Array = this.ItemArr.concat();
         arr.sortOn("Proba",Array.NUMERIC);
         return arr;
      }
      
      public function getItemById(id:int) : ExchangeData
      {
         var ed:ExchangeData = null;
         for(var i:int = 0; i < this.ItemArr.length; i++)
         {
            ed = this.ItemArr[i];
            if(Boolean(ed) && ed.Id == id)
            {
               return ed;
            }
         }
         return null;
      }
   }
}

