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
      
      public var id_arr6:Array;
      
      public var id_arr7:Array;
      
      public var all_id:Array;
      
      public var cn_arr:Array;
      
      public var name_arr:Array;
      
      public var arr:Array;
      
      public function HighDefine()
      {
         var n:* = undefined;
         var d0:Normal_HighDefine = null;
         this.verticalLabel_arr = ["top_dps","top_defence","top_life","top_arms","top_sub","top_level","top_pay"];
         this.verticalLabel_arr2 = ["top_group1","top_group2","top_group3","top_group4","top_group5","top_group6","top_group7","top_group8"];
         this.verticalLabel_cn_arr2 = ["凹凸曼","冰雪の領域","鬼魅之城","魔神联盟","巅峰","火云邪神","龙魂九天","圣者无双"];
         this.id_arr0 = [160,161,162,163,164,403,328,786,787,788,789,790,791,792,793,794];
         this.id_arr1 = [160,161,162,163,164,403,328,786,787,788,789,790,791,792,793,794];
         this.id_arr2 = [160,161,162,163,164,403,328,786,787,788,789,790,791,792,793,794];
         this.id_arr3 = [160,161,162,163,164,403,328,786,787,788,789,790,791,792,793,794];
         this.id_arr4 = [160,161,162,163,164,403,328,786,787,788,789,790,791,792,793,794];
         this.id_arr5 = [160,161,162,163,164,403,328,786,787,788,789,790,791,792,793,794];
         this.id_arr6 = [160,161,162,163,164,403,328,786,787,788,789,790,791,792,793,794];
         this.id_arr7 = [160,161,162,163,164,403,328,786,787,788,789,790,791,792,793,794];
         this.all_id = [this.id_arr0,this.id_arr1,this.id_arr2,this.id_arr3,this.id_arr4,this.id_arr5,this.id_arr6,this.id_arr7];
         this.cn_arr = [];
         this.name_arr = [];
         this.arr = [];
         super();
         this.cn_arr.push(["排名","账号","角色","公会","战斗力"]);
         this.name_arr.push(["rank","userName","extra.playerName","extra.group","score"]);
         this.cn_arr.push(["排名","账号","角色","公会","防御值"]);
         this.name_arr.push(["rank","userName","extra.playerName","extra.group","score"]);
         this.cn_arr.push(["排名","账号","角色","公会","耐久值"]);
         this.name_arr.push(["rank","userName","extra.playerName","extra.group","score"]);
         this.cn_arr.push(["排名","武器名称","武器类型","拥有者","战斗力"]);
         this.name_arr.push(["rank","extra.name","extra.type","extra.playerName","score"]);
         this.cn_arr.push(["排名","武器名称","武器类型","拥有者","战斗力"]);
         this.name_arr.push(["rank","extra.name","extra.type","extra.playerName","score"]);
         this.cn_arr.push(["排名","账号","角色","公会","星级总数量"]);
         this.name_arr.push(["rank","userName","extra.playerName","extra.group","score"]);
         this.cn_arr.push(["排名","账号","角色","公会","充值金额"]);
         this.name_arr.push(["rank","userName","extra.playerName","extra.group","score"]);
         for(n in this.verticalLabel_cn_arr2)
         {
            this.cn_arr.push(["排名","账号","角色","公会","战斗力"]);
            this.name_arr.push(["rank","userName","extra.name","extra.group","score"]);
         }
         d0 = new Normal_HighDefine();
         d0.id_arr = [755,755,755,755,755,755,755,755];
         d0.type = "top_arena";
         d0.cn_arr = ["排名","账号","角色","积分"];
         d0.name_arr = ["rank","userName","extra.name","score"];
         this.arr.push(d0);
      }
      
      public function getDefine_byType(type0:String) : Normal_HighDefine
      {
         var n:* = undefined;
         var d0:Normal_HighDefine = null;
         for(n in this.arr)
         {
            d0 = this.arr[n];
            if(d0.type == type0)
            {
               return d0;
            }
         }
         return null;
      }
      
      public function getBarData(obj0:Object, arr0:Array) : Array
      {
         var n:* = undefined;
         var name0:String = null;
         var name1:String = null;
         var extraData0:Object = null;
         var value0:* = undefined;
         var arr1:Array = [];
         for(n in arr0)
         {
            name0 = String(arr0[n]).split(".")[0];
            name1 = String(arr0[n]).split(".")[1];
            if(obj0.extra is String)
            {
               extraData0 = JSON2.decode(obj0.extra);
            }
            else
            {
               extraData0 = obj0.extra;
            }
            if(Boolean(name1) && name1 != "")
            {
               if(extraData0.hasOwnProperty(name1))
               {
                  value0 = extraData0[name1];
               }
               else
               {
                  value0 = "4399小战士";
               }
            }
            else
            {
               value0 = obj0[name0];
            }
            if(name0 == "userName")
            {
               value0 = this.changeStar(value0);
            }
            arr1.push(value0);
         }
         return arr1;
      }
      
      public function changeStar(str0:String) : String
      {
         if(str0 == null || str0.length < 3)
         {
            return "***";
         }
         return str0.substr(0,str0.length - 3) + "***";
      }
      
      public function getAllObj(type0:String, nowSaveIndex0:int) : Object
      {
         var v_arr:Array = this.verticalLabel_arr.concat(this.verticalLabel_arr2);
         var obj0:Object = new Object();
         var index0:int = v_arr.indexOf(type0);
         obj0.id = this.all_id[nowSaveIndex0][index0];
         obj0.name_arr = this.name_arr[index0];
         obj0.title_arr = this.cn_arr[index0];
         return obj0;
      }
      
      public function test2() : *
      {
      }
      
      public function test() : *
      {
         var obj0:Object = null;
         var obj02:Object = null;
         var arr0:Array = [];
         for(var i:int = 0; i < 10; i++)
         {
            obj0 = new Object();
            obj0.rank = i + 1;
            obj0.uId = "sountoone";
            obj0.userName = "迈居";
            obj02 = new Object();
            obj02.group = "巅峰";
            obj0.extra = JSON2.encode(obj02);
            obj0.score = 12345 - i * 10;
            arr0.push(obj0);
         }
         return arr0;
      }
      
      public function countScore(state0:String, dps1:Number, dps2:Number, rank1:int, rank2:int, life1:Number, life2:Number) : Number
      {
         var cdps:Number = (dps2 - dps1) / dps1;
         var crank:Number = int((rank1 - rank2) / 11);
         if(crank > 10)
         {
            crank = 10;
         }
         var clife:Number = (life2 - life1) / life2;
         if(life2 > life1)
         {
            clife = 0;
         }
         var num0:Number = 0;
         if(state0 == "win")
         {
            num0 = 15 + cdps + crank + clife;
            if(num0 < 12)
            {
               num0 = 12;
            }
            else if(num0 > 25)
            {
               num0 = 25;
            }
         }
         else if(state0 == "fail")
         {
            num0 = 5 + cdps;
            if(num0 < 3)
            {
               num0 = 3;
            }
            else if(num0 > 8)
            {
               num0 = 8;
            }
         }
         return Math.ceil(num0);
      }
   }
}

