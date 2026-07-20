package gameAll.data
{
   import data.StringDate;
   
   public class ItemsData
   {
      
      public var id:String = "";
      
      public var site:int = 0;
      
      public var type:String = "";
      
      public var name:String = "";
      
      public var cnName:String = "";
      
      public var imgLabel:String = "";
      
      public var newB:Boolean = false;
      
      public var exploreIndex:int = -1;
      
      public var buyDate:String = "";
      
      public function ItemsData()
      {
         super();
      }
      
      public function inData_byObj(obj0:Object) : *
      {
         this.id = obj0.id;
         this.site = obj0.site;
         this.type = obj0.type;
         this.name = obj0.name;
         this.cnName = obj0.cnName;
         this.imgLabel = obj0.imgLabel;
         if(!obj0.hasOwnProperty("buyDate"))
         {
            this.buyDate = "";
         }
         else
         {
            this.buyDate = obj0.buyDate;
         }
      }
      
      public function setBuyTime() : *
      {
         this.buyDate = Game.timeDate.getSaveDate.getStr();
      }
      
      public function getBuyTimeGap() : Number
      {
         var d0:StringDate = null;
         var d1:StringDate = null;
         var day0:Number = -1;
         if(this.buyDate != "")
         {
            d0 = new StringDate();
            d0.inData_byStr(this.buyDate);
            d1 = Game.timeDate.getSaveDate;
            day0 = d0.compareDate2(d1);
         }
         else
         {
            day0 = -1;
         }
         return day0;
      }
      
      public function getSurplusDay() : Number
      {
         return Math.ceil(7 - this.getBuyTimeGap());
      }
   }
}

