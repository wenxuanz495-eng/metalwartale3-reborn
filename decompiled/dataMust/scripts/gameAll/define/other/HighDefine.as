package gameAll.define.other
{
   import com.adobe.serialization.json.JSON2;
   
   public class HighDefine
   {
      
      public var verticalLabel_arr:Array;
      
      public var verticalLabel_arr2:Array;
      
      public var verticalLabel_cn_arr2:Array;
      
      public var id_arr0:Array;
      
      public var id_arr1:Array;
      
      public var id_arr2:Array;
      
      public var id_arr3:Array;
      
      public var id_arr4:Array;
      
      public var id_arr5:Array;
      
      public var all_id:Array;
      
      public var cn_arr:Array;
      
      public var name_arr:Array;
      
      public var arr:Array;
      
      public function HighDefine()
      {
         var _loc1_:* = undefined;
         var _loc2_:Normal_HighDefine = null;
         this.verticalLabel_arr = ["top_dps","top_defence","top_life","top_arms","top_sub","top_level","top_pay"];
         this.verticalLabel_arr2 = ["top_group1","top_group2","top_group3","top_group4","top_group5","top_group6","top_group7","top_group10"];
         this.verticalLabel_cn_arr2 = ["魔神联盟","冰雪の領域","世外桃源","流星花园","巅峰","鬼魅之城","凹凸曼","杀神@领域"];
         this.id_arr0 = [160,161,162,163,164,403,328,568,569,570,571,577,578,580,583];
         this.id_arr1 = [180,181,182,183,184,403,328,568,569,570,571,577,578,580,583];
         this.id_arr2 = [142,143,144,145,146,402,147,568,569,570,571,577,578,580,583];
         this.id_arr3 = [];
         this.id_arr4 = [];
         this.id_arr5 = [];
         this.all_id = [this.id_arr0,this.id_arr1,this.id_arr2,this.id_arr3,this.id_arr4,this.id_arr5];
         this.cn_arr = [];
         this.name_arr = [];
         this.arr = [];
         super();
         this.cn_arr.push(["排名","账号","角色","战队","战斗力"]);
         this.name_arr.push(["rank","userName","extra.playerName","extra.group","score"]);
         this.cn_arr.push(["排名","账号","角色","战队","防御值"]);
         this.name_arr.push(["rank","userName","extra.playerName","extra.group","score"]);
         this.cn_arr.push(["排名","账号","角色","战队","耐久值"]);
         this.name_arr.push(["rank","userName","extra.playerName","extra.group","score"]);
         this.cn_arr.push(["排名","武器名称","武器类型","拥有者","战斗力"]);
         this.name_arr.push(["rank","extra.name","extra.type","extra.playerName","score"]);
         this.cn_arr.push(["排名","武器名称","武器类型","拥有者","战斗力"]);
         this.name_arr.push(["rank","extra.name","extra.type","extra.playerName","score"]);
         this.cn_arr.push(["排名","账号","角色","战队","星级总数量"]);
         this.name_arr.push(["rank","userName","extra.playerName","extra.group","score"]);
         this.cn_arr.push(["排名","账号","角色","战队","充值金额"]);
         this.name_arr.push(["rank","userName","extra.playerName","extra.group","score"]);
         for(_loc1_ in this.verticalLabel_cn_arr2)
         {
            this.cn_arr.push(["排名","账号","角色","战队","战斗力"]);
            this.name_arr.push(["rank","userName","extra.name","extra.group","score"]);
         }
         _loc2_ = new Normal_HighDefine();
         _loc2_.id_arr = [165,185,152,0,0,0];
         _loc2_.type = "top_arena";
         _loc2_.cn_arr = ["排名","账号","角色","积分"];
         _loc2_.name_arr = ["rank","userName","extra.name","score"];
         this.arr.push(_loc2_);
      }
      
      public function getDefine_byType(param1:String) : Normal_HighDefine
      {
         var _loc2_:* = undefined;
         var _loc3_:Normal_HighDefine = null;
         for(_loc2_ in this.arr)
         {
            _loc3_ = this.arr[_loc2_];
            if(_loc3_.type == param1)
            {
               return _loc3_;
            }
         }
         return null;
      }
      
      public function getBarData(param1:Object, param2:Array) : Array
      {
         var _loc4_:* = undefined;
         var _loc5_:String = null;
         var _loc6_:String = null;
         var _loc7_:Object = null;
         var _loc8_:* = undefined;
         var _loc3_:Array = [];
         for(_loc4_ in param2)
         {
            _loc5_ = String(param2[_loc4_]).split(".")[0];
            _loc6_ = String(param2[_loc4_]).split(".")[1];
            if(param1.extra is String)
            {
               _loc7_ = JSON2.decode(param1.extra);
            }
            else
            {
               _loc7_ = param1.extra;
            }
            if(Boolean(_loc6_) && _loc6_ != "")
            {
               if(_loc7_.hasOwnProperty(_loc6_))
               {
                  _loc8_ = _loc7_[_loc6_];
               }
               else
               {
                  _loc8_ = "4399小战士";
               }
            }
            else
            {
               _loc8_ = param1[_loc5_];
            }
            if(_loc5_ == "userName")
            {
               _loc8_ = this.changeStar(_loc8_);
            }
            _loc3_.push(_loc8_);
         }
         return _loc3_;
      }
      
      public function changeStar(param1:String) : String
      {
         if(param1.length < 3)
         {
            return "***";
         }
         return param1.substr(0,param1.length - 3) + "***";
      }
      
      public function getAllObj(param1:String, param2:int) : Object
      {
         var _loc3_:Array = this.verticalLabel_arr.concat(this.verticalLabel_arr2);
         var _loc4_:Object = new Object();
         var _loc5_:int = _loc3_.indexOf(param1);
         _loc4_.id = this.all_id[param2][_loc5_];
         _loc4_.name_arr = this.name_arr[_loc5_];
         _loc4_.title_arr = this.cn_arr[_loc5_];
         return _loc4_;
      }
      
      public function test2() : *
      {
      }
      
      public function test() : *
      {
         var _loc3_:Object = null;
         var _loc4_:Object = null;
         var _loc1_:Array = [];
         var _loc2_:int = 0;
         while(_loc2_ < 10)
         {
            _loc3_ = new Object();
            _loc3_.rank = _loc2_ + 1;
            _loc3_.uId = "sountoone";
            _loc3_.userName = "迈居";
            _loc4_ = new Object();
            _loc4_.group = "巅峰";
            _loc3_.extra = JSON2.encode(_loc4_);
            _loc3_.score = 12345 - _loc2_ * 10;
            _loc1_.push(_loc3_);
            _loc2_++;
         }
         return _loc1_;
      }
      
      public function countScore(param1:String, param2:Number, param3:Number, param4:int, param5:int, param6:Number, param7:Number) : Number
      {
         var _loc8_:Number = (param3 - param2) / param2;
         var _loc9_:Number = int((param4 - param5) / 11);
         if(_loc9_ > 10)
         {
            _loc9_ = 10;
         }
         var _loc10_:Number = (param7 - param6) / param7;
         if(param7 > param6)
         {
            _loc10_ = 0;
         }
         var _loc11_:Number = 0;
         if(param1 == "win")
         {
            _loc11_ = 15 + _loc8_ + _loc9_ + _loc10_;
            if(_loc11_ < 12)
            {
               _loc11_ = 12;
            }
            else if(_loc11_ > 25)
            {
               _loc11_ = 25;
            }
         }
         else if(param1 == "fail")
         {
            _loc11_ = 5 + _loc8_;
            if(_loc11_ < 3)
            {
               _loc11_ = 3;
            }
            else if(_loc11_ > 8)
            {
               _loc11_ = 8;
            }
         }
         return Math.ceil(_loc11_);
      }
   }
}

