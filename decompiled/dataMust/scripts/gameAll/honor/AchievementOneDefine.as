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
      
      public static function getProgressTypeOther(param1:*) : String
      {
         var _loc3_:* = undefined;
         var _loc4_:Array = null;
         var _loc2_:Array = ["stateNumberType","arrayNumberType","taskNumberType"];
         for(_loc3_ in _loc2_)
         {
            _loc4_ = AchievementOneDefine[_loc2_[_loc3_]];
            if(_loc4_.indexOf(param1) >= 0)
            {
               return _loc2_[_loc3_];
            }
         }
         return "";
      }
      
      public function getMustArray() : Array
      {
         return this.must.split("_");
      }
      
      public function set must(param1:String) : *
      {
         this._must = TextWay.toCode(param1);
      }
      
      public function get must() : String
      {
         return TextWay.getText(this._must);
      }
      
      public function set acValue(param1:Number) : *
      {
         this._acValue = TextWay.toCode(String(param1));
      }
      
      public function get acValue() : Number
      {
         return Number(TextWay.getText(this._acValue));
      }
      
      public function set giftArr(param1:Array) : *
      {
         this._giftArr = param1;
         ExtraDefine.swapToCode(this._giftArr);
      }
      
      public function get giftArr() : Array
      {
         return ExtraDefine.swapToText(this._giftArr);
      }
      
      public function getProgressType(param1:String = "") : String
      {
         return getProgressTypeOther(this.type);
      }
      
      public function getProgress(param1:* = null) : String
      {
         var _loc2_:Number = 0;
         var _loc3_:Number = 0;
         var _loc4_:String = this.getProgressType();
         if(_loc4_ == "stateNumberType" || _loc4_ == "taskNumberType")
         {
            if(param1 is Array)
            {
               _loc2_ = Number(param1[int(this.getMustArray()[0])]) - 1;
               if(_loc2_ < 0)
               {
                  _loc2_ = 0;
               }
               _loc3_ = Number(int(this.getMustArray()[1])) - 1;
            }
            else
            {
               _loc2_ = Number(param1);
               _loc3_ = Number(this.must);
            }
            if(_loc2_ < _loc3_)
            {
               return StringToDefine.getFontColor(_loc2_ + "","#FF0000") + "/" + _loc3_;
            }
            return StringToDefine.getFontColor(_loc2_ + "","#00FF00") + "/" + _loc3_ + StringToDefine.getFontColor("（已完成）","#FFFF00");
         }
         if(_loc4_ == "arrayNumberType")
         {
         }
         return "";
      }
   }
}

