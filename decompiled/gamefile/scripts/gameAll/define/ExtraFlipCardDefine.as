package gameAll.define
{
   import data.StringToDefine;
   import data.TextWay;
   
   public class ExtraFlipCardDefine
   {
      
      public var exp_arr:Array = [1000,1200,1400,1600,1800,2000,2200,2400,2600,4000,5000,7000,9000,11000,13000,16000,19000,22000,27000,32000,37000,42000,48000,55000,90000,100000,110000,130000,140000,160000,180000,200000,220000,240000,260000,280000,300000,320000,340000,400000,450000,500000,550000,600000,650000,700000,750000,800000,850000,900000,950000,1000000,1050000,1100000,1150000,1200000,1250000,1300000,1350000,1400000];
      
      public var coin_arr:Array = [20000];
      
      public var superalloyName_arr:Array = ["superalloy_X"];
      
      public var superalloyNum_arr:Array = [20];
      
      public var propName_arr:Array = ["justice_badge"];
      
      public var propNum_arr:Array = [1];
      
      public var materialName_arr:Array = ["red_crystal_4","yellow_crystal_4","green_crystal_4"];
      
      public var materialNum_arr:Array = [1,1,1];
      
      public var material_level:Array = [1,18,36,51,61,81,99999];
      
      public var type_arr:Array = ["mcoin","coin","superalloy","material","prop"];
      
      public var pro_arr:Array = [0.2,0.2,0.2,0.2,0.2];
      
      public var number10w:String = TextWay.toCode("20000");
      
      public function ExtraFlipCardDefine()
      {
         super();
      }
      
      public function getFlipNum(rankLevel0:int) : int
      {
         return 1;
      }
      
      public function getDefine(arr0:Array) : *
      {
      }
      
      public function test() : *
      {
         var type0:String = null;
         var arr0:Array = [];
         for(var i:int = 0; i < 5; i++)
         {
            type0 = this.getType_byArr(arr0);
            arr0.push(type0);
            trace(arr0);
            trace("文本：" + this.getGoodsDefineStr_byType(type0,30));
         }
         trace("-----------------------------------");
      }
      
      public function getType_byArr(arr0:Array) : String
      {
         var n_arr:Array = null;
         var pro_arr:Array = null;
         var n:* = undefined;
         var index1:int = 0;
         var type0:String = null;
         var str0:String = "";
         if(arr0.indexOf("") == -1)
         {
            str0 = "";
         }
         else
         {
            n_arr = [];
            pro_arr = [];
            for(n in this.type_arr)
            {
               type0 = this.type_arr[n];
               if(arr0.indexOf(type0) == -1)
               {
                  n_arr.push(type0);
                  pro_arr.push(this.getPro_byType(type0));
               }
            }
            index1 = StringToDefine.getPro_byArr2(pro_arr);
            str0 = n_arr[index1];
         }
         return str0;
      }
      
      public function getGoodsDefineStr_byType(type0:String, level0:int) : String
      {
         var len:int = 0;
         var str0:String = "";
         var name0:String = "";
         var baifen_Arr:Array = [0.75,1,1.25];
         var baifen0:Number = Number(baifen_Arr[int(baifen_Arr.length * Math.random())]);
         if(type0 == "mcoin")
         {
            str0 = "MCoin,100,1";
         }
         else if(type0.indexOf("exp") >= 0)
         {
            if(level0 > this.exp_arr.length - 1)
            {
               level0 = this.exp_arr.length - 1;
            }
            str0 = "exp," + TextWay.getText(this.number10w) + ",1";
         }
         else if(type0.indexOf("coin") >= 0)
         {
            if(level0 > this.coin_arr.length - 1)
            {
               level0 = this.coin_arr.length - 1;
            }
            str0 = "GCoin," + TextWay.getText(this.number10w) + ",1";
         }
         else if(type0 == "superalloy")
         {
            len = int(this.superalloyName_arr.length * Math.random());
            name0 = this.superalloyName_arr[len];
            str0 = "materials," + name0 + "," + this.superalloyNum_arr[len];
         }
         else if(type0 == "material")
         {
            len = int(this.materialName_arr.length * Math.random());
            name0 = this.materialName_arr[len];
            str0 = "materials," + name0 + "," + this.materialNum_arr[len];
         }
         else if(type0 == "prop")
         {
            len = int(this.propName_arr.length * Math.random());
            name0 = this.propName_arr[len];
            str0 = "props," + name0 + "," + this.propNum_arr[len];
         }
         return str0;
      }
      
      public function getMaterialLevel(level0:int) : int
      {
         var n:* = undefined;
         var num0:int = 1;
         for(n in this.material_level)
         {
            if(level0 < this.material_level[n] - 1)
            {
               num0 = n;
               break;
            }
         }
         return num0;
      }
      
      public function getMaterialNum(level0:int) : int
      {
         var num0:int = 1;
         level0++;
         if(level0 < 18)
         {
            num0 = 1 + Math.random() * 10;
         }
         else if(level0 < 36)
         {
            num0 = 5 + Math.random() * 10;
         }
         else if(level0 < 51)
         {
            num0 = 8 + Math.random() * 12;
         }
         else
         {
            num0 = 10 + Math.random() * 30;
         }
         return num0;
      }
      
      public function getSuperalloyNum(level0:int, name0:String) : int
      {
         var num0:int = 1;
         if(name0 == "superalloy")
         {
            num0 = this.getMaterialNum(level0);
         }
         else
         {
            num0 = 1;
         }
         return num0;
      }
      
      private function getPro_byType(str0:String) : Number
      {
         return this.pro_arr[this.type_arr.indexOf(str0)];
      }
   }
}

