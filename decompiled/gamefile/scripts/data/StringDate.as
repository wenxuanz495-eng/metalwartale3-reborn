package data
{
   public class StringDate
   {
      
      public var fullYear:int = 0;
      
      public var month:int = 0;
      
      public var date:int = 0;
      
      public var hours:int = 0;
      
      public var minutes:int = 0;
      
      public var seconds:int = 0;
      
      public function StringDate()
      {
         super();
      }
      
      public function inData_byStr(str0:String) : *
      {
         var arr0:Array = null;
         var arr1:Array = null;
         var arr2:Array = null;
         this.init();
         if(str0 != "")
         {
            arr0 = str0.split(" ");
            arr1 = arr0[0].split("-");
            this.fullYear = int(arr1[0]);
            this.month = int(arr1[1] - 1);
            this.date = int(arr1[2]);
            if(Boolean(arr0[1]))
            {
               arr2 = arr0[1].split(":");
               this.hours = int(arr2[0]);
               this.minutes = int(arr2[1]);
               this.seconds = int(arr2[2]);
            }
         }
      }
      
      public function inData_byObj(obj:Object) : *
      {
         var n:* = undefined;
         var pro0:String = null;
         var pro_arr:Array = ["fullYear","month","date","hours","minutes","seconds"];
         for(n in pro_arr)
         {
            pro0 = pro_arr[n];
            this[pro0] = obj[pro0];
         }
      }
      
      public function copy() : StringDate
      {
         var sd:StringDate = new StringDate();
         sd.inData_byObj(this);
         return sd;
      }
      
      public function init() : *
      {
         this.fullYear = 0;
         this.month = 0;
         this.date = 0;
         this.hours = 0;
         this.minutes = 0;
         this.seconds = 0;
      }
      
      public function getStr() : String
      {
         return this.getDateStr() + " " + this.getTimeStr();
      }
      
      public function getDateStr() : String
      {
         return this.fullYear + "-" + this.get2(this.month + 1) + "-" + this.get2(this.date);
      }
      
      public function getTimeStr() : String
      {
         return this.get2(this.hours) + ":" + this.get2(this.minutes) + ":" + this.get2(this.seconds);
      }
      
      public function getDateClass() : Date
      {
         return new Date(this.fullYear,this.month,this.date,this.hours,this.minutes,this.seconds);
      }
      
      public function getOnlyDateClass() : Date
      {
         return new Date(this.fullYear,this.month,this.date,0,0,0,0);
      }
      
      public function toString() : String
      {
         return this.getStr();
      }
      
      private function get2(num0:int) : String
      {
         var str0:String = String(num0);
         if(str0.length == 1)
         {
            str0 = "0" + str0;
         }
         return str0;
      }
      
      public function compareDate(sd0:StringDate) : int
      {
         var d0:Date = this.getOnlyDateClass();
         var d1:Date = sd0.getOnlyDateClass();
         var ct:Number = d1.getTime() - d0.getTime();
         return Math.floor(ct / 1000 / 3600 / 24);
      }
      
      public function compareDate2(sd0:StringDate) : Number
      {
         var d0:Date = this.getDateClass();
         var d1:Date = sd0.getDateClass();
         var ct:Number = d1.getTime() - d0.getTime();
         return ct / 1000 / 3600 / 24;
      }
      
      public function decDay() : *
      {
         --this.date;
      }
   }
}

