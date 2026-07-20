package
{
   import com.adobe.serialization.json.JSON2;
   import data.Base64;
   import data.TextWay;
   import flash.display.MovieClip;
   import flash.text.TextField;
   import flash.utils.ByteArray;
   import gameAll.GameDefine;
   import gameAll.data.AdditionalData;
   import gameAll.facebook.fb_Save_api;
   
   public class dataMust extends MovieClip
   {
      
      public var _txt:TextField;
      
      public var subPosition:MovieClip;
      
      public var gameDefine:GameDefine = new GameDefine();
      
      public var _value0:Number;
      
      public var vvv:String = TextWay.toCode(String(37));
      
      public var api0:fb_Save_api = new fb_Save_api();
      
      public function dataMust()
      {
         super();
         this.gameDefine.fleshSubPosition(this.subPosition);
      }
      
      public function set value0(param1:Number) : *
      {
         this._value0 = param1 * 37;
      }
      
      public function get value0() : Number
      {
         return this._value0 / 37;
      }
      
      public function test1() : *
      {
         var _loc1_:String = this._txt.text;
         var _loc2_:Object = JSON2.decode(_loc1_);
         var _loc3_:ByteArray = new ByteArray();
         _loc3_.writeObject(_loc2_);
         var _loc4_:String = Base64.encode(_loc3_);
         trace(_loc1_);
         trace("-------------------------");
         var _loc5_:ByteArray = Base64.decode(_loc4_);
         _loc5_.position = 0;
         var _loc6_:Object = _loc5_.readObject();
         var _loc7_:String = JSON2.encode(_loc6_);
         trace(_loc7_);
         var _loc8_:* = 0;
      }
      
      public function test2() : *
      {
         var _loc1_:int = 0;
         while(_loc1_ < 100)
         {
            trace(_loc1_ + 1 + "  " + this.gameDefine.getEnemyExp_byLevel(_loc1_));
            _loc1_++;
         }
      }
      
      public function test3() : *
      {
         var _loc2_:Number = NaN;
         var _loc3_:Number = NaN;
         var _loc4_:Number = NaN;
         var _loc1_:int = 1;
         while(_loc1_ < 11)
         {
            _loc2_ = _loc1_;
            _loc3_ = 1;
            _loc4_ = 5;
            trace("挑战第" + _loc4_ + "名，和我dps一样，我的排名" + _loc3_ + "，我是对手血量的1/" + _loc2_ + "倍，胜利后积分：" + this.gameDefine.high.countScore("win",10,10,_loc3_,_loc4_,1,_loc2_));
            _loc1_++;
         }
      }
      
      public function armsMustItemsTest() : *
      {
      }
      
      public function chipTest2() : *
      {
         var _loc2_:AdditionalData = null;
         var _loc1_:int = 0;
         while(_loc1_ < 300)
         {
            _loc2_ = this.gameDefine.addDefine.getAdditionalData(10,65 + _loc1_ % 20);
            trace("----------------- 等级：" + (65 + _loc1_ % 20) + "  作弊代码：" + _loc2_.getCheating());
            trace(_loc2_.getPlainInfo());
            _loc1_++;
         }
      }
      
      public function chipTest() : *
      {
         var _loc9_:int = 0;
         var _loc10_:String = null;
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         var _loc7_:String = "boss";
         var _loc8_:int = 0;
         while(_loc8_ <= 7000)
         {
            _loc9_ = _loc8_;
            _loc10_ = this.gameDefine.getItemsType(_loc7_);
            if(_loc10_ == "chip")
            {
               _loc10_ = this.gameDefine.getChipType(_loc7_);
            }
            if(_loc10_ == "white_chip")
            {
               _loc2_++;
            }
            if(_loc10_ == "yellow_chip")
            {
               _loc4_++;
            }
            if(_loc10_ == "orange_chip")
            {
               _loc5_++;
            }
            if(_loc10_ == "blue_chip")
            {
               _loc3_++;
            }
            if(_loc10_ == "green_chip")
            {
               _loc1_++;
            }
            _loc8_++;
         }
         trace("白色：" + _loc2_);
         trace("蓝色：" + _loc3_);
         trace("金色：" + _loc4_);
         trace("橙色：" + _loc5_);
         trace("绿色：" + _loc1_);
      }
   }
}

