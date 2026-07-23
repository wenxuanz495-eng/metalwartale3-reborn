package items
{
   public class ItemsDefineGroup
   {
      
      public var arr:Array = [];
      
      private var typeArr:Array = [];
      
      public var crystalObj:Object = new Object();
      
      public var materialObj:Object = new Object();
      
      public function ItemsDefineGroup()
      {
         super();
      }
      
      public function addData_byXML(xml0:XML) : *
      {
         var n:* = undefined;
         var xml2:XML = null;
         var type0:String = null;
         var xml3:* = undefined;
         var m:* = undefined;
         var xml4:XML = null;
         var items0:ItemsDefine = null;
         var xml1:* = xml0.type;
         for(n in xml1)
         {
            xml2 = xml1[n];
            type0 = String(xml2.@id);
            this.typeArr.push(type0);
            this.arr[n] = [];
            xml3 = xml2.items;
            for(m in xml3)
            {
               xml4 = xml3[m];
               items0 = new ItemsDefine();
               items0.inData_byXML(xml4,type0);
               this.arr[n][m] = items0;
            }
         }
         this.addOfflineUpgradePack();
      }

      private function addOfflineUpgradePack() : *
      {
         if(this.getDefine("offline_upgrade_pack") is ItemsDefine)
         {
            return;
         }
         var source0:ItemsDefine = this.getDefine("superalloyStone");
         var d0:ItemsDefine = new ItemsDefine();
         d0.type = "card";
         d0.name = "offline_upgrade_pack";
         d0.cnName = "自选强化礼包";
         d0.dropLevel = 9999;
         d0.cardType = "offlineUpgradePack";
         d0.cardValue = 0;
         d0.Mprice = 10;
         d0.price = 0;
         d0.description = "开启后可选择随机材料或随机晶体，奖励等级不会超过当前人物等级可获取的范围。";
         if(source0 is ItemsDefine)
         {
            d0.iconImgLabel = source0.iconImgLabel;
            d0.imgLabel = source0.imgLabel;
         }
         this.arr[this.getIndex_byType("card")].push(d0);
      }
      
      public function addMaterialGift() : String
      {
         var n:* = undefined;
         var i:int = 0;
         this.addOneGift("superalloy",10,8);
         this.addOneGift("superalloy_Z",10,32);
         this.addOneGift("xuehua",5,10);
         var garr0:String = "";
         var arr0:Array = ["buncher","boom","thorn"];
         for(n in arr0)
         {
            for(i = 1; i <= 4; i++)
            {
               garr0 += this.addOneGift(arr0[n] + "_" + i,10);
            }
         }
         return garr0;
      }
      
      private function addOneGift(label0:String, num0:int, price0:int = 0) : String
      {
         var source0:ItemsDefine = this.getDefine(label0);
         if(!(source0 is ItemsDefine))
         {
            // The embedded production item table predates a few event materials.
            // Do not let an unavailable optional shop bundle stop offline startup.
            trace("跳过缺失的材料礼包定义：" + label0);
            return "";
         }
         var d0:ItemsDefine = source0.copyAll();
         d0.name += "_pack" + num0;
         d0.cnName += "包";
         if(price0 == 0)
         {
            d0.Mprice = 8;
         }
         else
         {
            d0.Mprice = price0;
         }
         d0.dropLevel = 9999;
         this.arr[0].push(d0);
         return label0 + "_pack" + num0 + ",";
      }
      
      public function getDefineByCn(label0:String) : ItemsDefine
      {
         var n:* = undefined;
         var arr0:Array = null;
         var m:* = undefined;
         var define0:ItemsDefine = null;
         for(n in this.arr)
         {
            arr0 = this.arr[n];
            for(m in arr0)
            {
               define0 = arr0[m];
               if(define0.cnName == label0)
               {
                  return define0.copyAll();
               }
            }
         }
         return null;
      }
      
      public function getDefine(label0:String) : ItemsDefine
      {
         var n:* = undefined;
         var arr0:Array = null;
         var m:* = undefined;
         var define0:ItemsDefine = null;
         var num0:int = 1;
         var arr3:Array = label0.split("_num");
         if(arr3.length >= 2)
         {
            num0 = int(arr3[1]);
            label0 = arr3[0];
         }
         for(n in this.arr)
         {
            arr0 = this.arr[n];
            for(m in arr0)
            {
               define0 = arr0[m];
               if(define0.name == label0)
               {
                  define0.nowNum = num0;
                  return define0.copyAll();
               }
            }
         }
         return null;
      }
      
      public function getArr_byTypeLevel(type0:String, maxLevel0:int, minLevel0:int = 0) : Array
      {
         var n:* = undefined;
         var d0:ItemsDefine = null;
         var arr0:Array = [];
         var num0:int = this.getIndex_byType(type0);
         if(num0 >= 0)
         {
            for(n in this.arr[num0])
            {
               d0 = this.arr[num0][n];
               if(d0.dropLevel <= maxLevel0 + 1 && d0.dropLevel >= minLevel0 + 1)
               {
                  arr0.push(d0);
               }
            }
            if(minLevel0 > 1)
            {
               arr0.push(this.getDefine("superalloy"));
            }
         }
         else
         {
            trace("没找到这个物品类型：" + type0);
         }
         return arr0;
      }
      
      public function getArr_byOneLevel(type0:String, maxLevel0:int) : Array
      {
         var minLv2:int = Game.gameDefine.drop.getMinLevel(type0,maxLevel0);
         return this.getArr_byTypeLevel(type0,maxLevel0,minLv2);
      }
      
      private function getIndex_byType(str0:String) : int
      {
         var n:* = undefined;
         for(n in this.typeArr)
         {
            if(str0 == this.typeArr[n])
            {
               return n;
            }
         }
         return -1;
      }
      
      public function getCrystalArr(str0:String) : Array
      {
         var max0:int = Game.gameDefine.crystalMax;
         var strArr:Array = [];
         for(var n:int = 2; n <= max0; n++)
         {
            strArr.push(str0 + "_crystal_" + n);
         }
         return this.getArr_byStrArr(strArr,1);
      }
      
      public function getMaterialsArr(str0:String) : Array
      {
         var max0:int = 7;
         var strArr:Array = [];
         for(var n:int = 2; n <= max0; n++)
         {
            strArr.push(str0 + "_" + n);
         }
         return this.getArr_byStrArr(strArr,1);
      }
      
      public function getCnName(str0:String) : String
      {
         var d0:ItemsDefine = this.getDefine(str0);
         if(d0 is ItemsDefine)
         {
            return d0.cnName;
         }
         return "";
      }
      
      public function getArr_byStrArr(arr0:Array, propsB:int = 0) : Array
      {
         var n:* = undefined;
         var str0:String = null;
         var strArr:Array = null;
         var nowNum:int = 0;
         var d0:ItemsDefine = null;
         var arr1:Array = [];
         for(n in arr0)
         {
            str0 = String(arr0[n]);
            strArr = str0.split("_num");
            nowNum = 1;
            if(strArr.length > 1)
            {
               str0 = strArr[0];
               nowNum = int(strArr[1]);
            }
            d0 = this.getDefine(str0);
            if(d0 is ItemsDefine)
            {
               d0.nowNum = nowNum;
               d0.baseNum = nowNum;
               if(d0 != null)
               {
                  if(propsB == 0)
                  {
                     arr1.push(d0);
                  }
                  else if(propsB == 1)
                  {
                     if(d0.type != "card")
                     {
                        arr1.push(d0);
                     }
                  }
                  else if(propsB == 2)
                  {
                     if(d0.type == "card")
                     {
                        arr1.push(d0);
                     }
                  }
               }
            }
         }
         return arr1;
      }
   }
}

