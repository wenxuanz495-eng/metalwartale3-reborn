package gameAll.honor
{
   import data.StringToDefine;
   import data.TextWay;
   import gameAll.define.ExtraDefine;
   
   public class AchievementOneDefine
   {
      
      public static var stateNumberType:Array = ["lv","dps","enemy","level"];
      
      public static var arrayNumberType:Array = [];
      
      public static var taskNumberType:Array = [];
      
      public var type:String = "";
      
      public var name:String = "";
      
      public var cnName:String = "";
      
      public var info:String = "";
      
      public var honor:String = "";
      
      private var _must:String = "";
      
      private var _acValue:String = "";
      
      private var _giftArr:Array = [];
      
      public function AchievementOneDefine()
      {
         super();
         this.acValue = 10;
      }
      
      public static function getProgressTypeOther(type0:*) : String
      {
         var n:* = undefined;
         var arr1:Array = null;
         var arr0:Array = ["stateNumberType","arrayNumberType","taskNumberType"];
         for(n in arr0)
         {
            arr1 = AchievementOneDefine[arr0[n]];
            if(arr1.indexOf(type0) >= 0)
            {
               return arr0[n];
            }
         }
         return "";
      }
      
      public function getMustArray() : Array
      {
         return this.must.split("_");
      }
      
      public function set must(str0:String) : *
      {
         this._must = TextWay.toCode(str0);
      }
      
      public function get must() : String
      {
         return TextWay.getText(this._must);
      }
      
      public function set acValue(str0:Number) : *
      {
         this._acValue = TextWay.toCode(String(str0));
      }
      
      public function get acValue() : Number
      {
         return Number(TextWay.getText(this._acValue));
      }
      
      public function set giftArr(arr0:Array) : *
      {
         this._giftArr = arr0;
         ExtraDefine.swapToCode(this._giftArr);
      }
      
      public function get giftArr() : Array
      {
         return ExtraDefine.swapToText(this._giftArr);
      }
      
      public function getProgressType(type0:String = "") : String
      {
         return getProgressTypeOther(this.type);
      }
      
      public function getProgress(nowStr:* = null) : String
      {
         var now0:Number = 0;
         var max0:Number = 0;
         var p_type0:String = this.getProgressType();
         if(p_type0 == "stateNumberType" || p_type0 == "taskNumberType")
         {
            if(nowStr is Array)
            {
               now0 = Number(nowStr[int(this.getMustArray()[0])]) - 1;
               if(now0 < 0)
               {
                  now0 = 0;
               }
               max0 = Number(int(this.getMustArray()[1])) - 1;
            }
            else
            {
               now0 = Number(nowStr);
               max0 = Number(this.must);
            }
            if(now0 < max0)
            {
               return StringToDefine.getFontColor(now0 + "","#FF0000") + "/" + max0;
            }
            return StringToDefine.getFontColor(now0 + "","#00FF00") + "/" + max0 + StringToDefine.getFontColor("（已完成）","#FFFF00");
         }
         if(p_type0 == "arrayNumberType")
         {
         }
         return "";
      }
   }
}

