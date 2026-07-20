package goods
{
   public class LeveLGiftDefine
   {
      
      private var ItemArr:Array = [];
      
      public function LeveLGiftDefine()
      {
         super();
      }
      
      public function inData_byXML(xmlData:XML) : void
      {
         var sDataInfo:LevelGiftData = null;
         var dg:String = null;
         var rootList:XMLList = xmlData.child("data");
         var subElement:XMLList = xmlData.child("EItem");
         for(var i:int = 0; i < subElement.length(); i++)
         {
            sDataInfo = new LevelGiftData();
            if(subElement[i].@Id.length() > 0)
            {
               sDataInfo.Id = int(subElement[i].@Id);
            }
            if(subElement[i].@Desc.length() > 0)
            {
               sDataInfo.Desc = subElement[i].@Desc.toString();
            }
            if(subElement[i].@Name.length() > 0)
            {
               sDataInfo.Name = subElement[i].@Name.toString();
            }
            if(subElement[i].@Condition.length() > 0)
            {
               sDataInfo.Condition = int(subElement[i].@Condition);
            }
            if(subElement[i].@NeedBag.length() > 0)
            {
               sDataInfo.NeedBag = int(subElement[i].@NeedBag);
            }
            if(subElement[i].@Group.length() > 0)
            {
               dg = subElement[i].@Group.toString();
               if(dg.indexOf("，") >= 0)
               {
                  sDataInfo.Group = dg.split("，");
               }
               else
               {
                  sDataInfo.Group = dg.split(",");
               }
            }
            if(subElement[i].@Num.length() > 0)
            {
               dg = subElement[i].@Num.toString();
               if(dg.indexOf("，") >= 0)
               {
                  sDataInfo.Num = dg.split("，");
               }
               else
               {
                  sDataInfo.Num = dg.split(",");
               }
            }
            if(sDataInfo.Num.length != sDataInfo.Group.length)
            {
               throw new Error(this + ":数据长度不匹配:" + sDataInfo.Name);
            }
            this.ItemArr.push(sDataInfo);
         }
      }
      
      public function getItemArrCopy() : Array
      {
         return this.ItemArr.concat();
      }
      
      public function getNeedBag(id:int) : int
      {
         return this.ItemArr[id].NeedBag;
      }
      
      public function getItemConditionArr() : Array
      {
         var ed:LevelGiftData = null;
         var arr:Array = [];
         for(var i:int = 0; i < this.ItemArr.length; i++)
         {
            ed = this.ItemArr[i];
            if(Boolean(ed))
            {
               arr.push(ed.Condition);
            }
         }
         return arr;
      }
      
      public function getItemById(id:int) : LevelGiftData
      {
         var ed:LevelGiftData = null;
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

