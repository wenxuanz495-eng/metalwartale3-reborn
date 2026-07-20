package goods
{
   public class TurnTableDefine
   {
      
      private var gamedata_turntable:TurnTableData = null;
      
      public function TurnTableDefine()
      {
         super();
      }
      
      public function inData_byXML(xmlData:XML) : void
      {
         var rootList:XMLList = xmlData.child("Data");
         var subElement:XMLList = xmlData.child("TurnTable");
         for(var i:int = 0; i < subElement.length(); i++)
         {
            this.gamedata_turntable = new TurnTableData();
            if(subElement[i].@TimeOneDay.length() > 0)
            {
               this.gamedata_turntable.TimeOneDay = int(subElement[i].@TimeOneDay);
            }
            if(subElement[i].@Cost.length() > 0)
            {
               this.gamedata_turntable.Cost = int(subElement[i].@Cost);
            }
            if(subElement[i].@GoodID_1.length() > 0)
            {
               this.gamedata_turntable.GoodArr.push(subElement[i].@GoodID_1.toString());
            }
            if(subElement[i].@GoodID_2.length() > 0)
            {
               this.gamedata_turntable.GoodArr.push(subElement[i].@GoodID_2.toString());
            }
            if(subElement[i].@GoodID_3.length() > 0)
            {
               this.gamedata_turntable.GoodArr.push(subElement[i].@GoodID_3.toString());
            }
            if(subElement[i].@GoodID_4.length() > 0)
            {
               this.gamedata_turntable.GoodArr.push(subElement[i].@GoodID_4.toString());
            }
            if(subElement[i].@GoodID_5.length() > 0)
            {
               this.gamedata_turntable.GoodArr.push(subElement[i].@GoodID_5.toString());
            }
            if(subElement[i].@GoodID_6.length() > 0)
            {
               this.gamedata_turntable.GoodArr.push(subElement[i].@GoodID_6.toString());
            }
            if(subElement[i].@GoodID_7.length() > 0)
            {
               this.gamedata_turntable.GoodArr.push(subElement[i].@GoodID_7.toString());
            }
            if(subElement[i].@GoodID_8.length() > 0)
            {
               this.gamedata_turntable.GoodArr.push(subElement[i].@GoodID_8.toString());
            }
            if(subElement[i].@GoodID_9.length() > 0)
            {
               this.gamedata_turntable.GoodArr.push(subElement[i].@GoodID_9.toString());
            }
            if(subElement[i].@GoodID_10.length() > 0)
            {
               this.gamedata_turntable.GoodArr.push(subElement[i].@GoodID_10.toString());
            }
            if(subElement[i].@GoodID_11.length() > 0)
            {
               this.gamedata_turntable.GoodArr.push(subElement[i].@GoodID_11.toString());
            }
            if(subElement[i].@GoodID_12.length() > 0)
            {
               this.gamedata_turntable.GoodArr.push(subElement[i].@GoodID_12.toString());
            }
         }
      }
      
      public function GetGameTurnData() : TurnTableData
      {
         return this.gamedata_turntable;
      }
   }
}

