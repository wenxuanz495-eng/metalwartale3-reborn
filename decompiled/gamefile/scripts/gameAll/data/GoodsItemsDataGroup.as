package gameAll.data
{
   import items.ItemsDefine;
   
   public class GoodsItemsDataGroup
   {
      
      public var lastID:int = 0;
      
      public var lastExplore:int = 0;
      
      public var bagMaxNum:int = 36;
      
      public var arr:Array = [];
      
      public function GoodsItemsDataGroup()
      {
         super();
      }
      
      public function inData_byObj(obj:Object) : *
      {
         var n:* = undefined;
         var arr0:Array = null;
         var i:* = undefined;
         var pro0:String = null;
         var aid:GoodsItemsData = null;
         var pro_arr:Array = ["lastID","bagMaxNum"];
         for(n in pro_arr)
         {
            pro0 = pro_arr[n];
            this[pro0] = obj[pro0];
         }
         this.arr.length = 0;
         arr0 = obj.arr;
         for(i in arr0)
         {
            aid = new GoodsItemsData();
            aid.inData_byObj(arr0[i]);
            this.arr.push(aid);
         }
      }
      
      public function delAll() : *
      {
         this.lastExplore = 0;
         this.arr.length = 0;
      }
      
      public function isZuobi() : Boolean
      {
         var n:* = undefined;
         var _loc2_:GoodsItemsData = null;
         return false;
      }
      
      public function addItems(label0:String, num0:int = 1, affixLevel:int = 0, newB:Boolean = true) : GoodsItemsData
      {
         var gd0:GoodsItemsData = null;
         if(num0 < 1)
         {
            return null;
         }
         var define0:ItemsDefine = Game.itemsDefineGroup.getDefine(label0);
         if(define0 is ItemsDefine)
         {
            define0.affixLevel = affixLevel;
            return this.addItemsDefine(define0,num0,newB);
         }
         return null;
      }
      
      public function addItemsDefine(define0:ItemsDefine, num0:int = 1, newB:Boolean = true, labelArr:Array = null) : GoodsItemsData
      {
         var add0:AdditionalData = null;
         var items0:GoodsItemsData = new GoodsItemsData();
         items0.inData_byDefine(define0);
         items0.affixLevel = define0.affixLevel;
         items0.nowNum = num0;
         if(items0.type == "chip")
         {
            trace("addItemsDefine词缀等级：" + define0.affixLevel);
            add0 = Game.gameDefine.addDefine.getAdditionalData(define0.dropLevel,define0.affixLevel,labelArr);
            items0.addArr = add0.getStrArr();
         }
         return this.addItemsData(items0,num0,newB);
      }
      
      public function addItemsData(id:GoodsItemsData, num0:int = 1, newB:Boolean = true) : GoodsItemsData
      {
         var id00:GoodsItemsData = null;
         var index0:int = 0;
         id.newB = newB;
         if(id.name == "superalloy")
         {
            Game.uiGroup.unionUI.CUnionTask.AddTaskGoal(3,num0);
         }
         if(id.type != "chip")
         {
            id00 = this.getItemsByName(id.name);
            if(id00 != null)
            {
               id00.nowNum += num0;
               id00.newB = newB;
               return id00;
            }
         }
         var site0:int = this.getSpaceSite();
         if(site0 >= 0)
         {
            index0 = this.getPrewCloseSite(this.arr,site0);
            id.site = site0;
            this.lastID += 1;
            id.id = String(this.lastID);
            this.arr.splice(index0,0,id);
            return id;
         }
         return null;
      }
      
      public function cleanUp() : *
      {
         var n:* = undefined;
         var d0:GoodsItemsData = null;
         var num0:String = null;
         var num1:String = null;
         var num2:String = null;
         var num3:String = null;
         var str1:String = null;
         var str2:String = null;
         var d1:GoodsItemsData = null;
         var crystal_arr:Array = ["purple","green","red","yellow"];
         var material_arr:Array = ["","drawing","superalloy","superalloy_X","superalloy_Y","superalloy_Z","buncher","boom","thorn"];
         var chip_arr:Array = ["purple","green","orange","yellow","blue","white"];
         for(n in this.arr)
         {
            d0 = this.arr[n];
            num0 = "";
            num1 = "";
            num2 = "";
            num3 = this.toLength(d0.id.substring(d0.id.length - 6),6);
            str1 = "";
            if(d0.type == "crystal")
            {
               num0 = "02";
               str1 = d0.name.split("_crystal_")[0];
               num1 = this.toLength(String(crystal_arr.indexOf(str1)),2);
               num2 = this.toLength(d0.name.split("_crystal_")[1],3);
            }
            else if(d0.type == "material")
            {
               num0 = "04";
               str2 = d0.name.split("_")[1];
               if(d0.name.indexOf("superalloy") == 0)
               {
                  str1 = d0.name;
                  str2 = "0";
               }
               else
               {
                  str1 = d0.name.split("_")[0];
               }
               num1 = this.toLength(String(material_arr.indexOf(str1)),2);
               num2 = this.toLength(int(str2),3);
            }
            else if(d0.type == "chip")
            {
               num0 = "06";
               str1 = d0.name.split("_chip")[0];
               num1 = this.toLength(String(chip_arr.indexOf(str1)),2);
               num2 = this.toLength(999 - d0.affixLevel,3);
            }
            d0.id = num0 + num1 + num2 + num3;
         }
         this.arr.sortOn("id");
         for(n in this.arr)
         {
            d1 = this.arr[n];
            d1.site = n;
         }
      }
      
      private function compareSite(d0:GoodsItemsData, d1:GoodsItemsData) : int
      {
         if(d0.site > d1.site)
         {
            return 1;
         }
         if(d0.site < d1.site)
         {
            return -1;
         }
         return 0;
      }
      
      private function toLength(num0:*, len0:int) : String
      {
         var str0:String = String(num0);
         var cx0:int = len0 - str0.length;
         for(var i:int = 0; i < cx0; i++)
         {
            str0 = "0" + str0;
         }
         return str0;
      }
      
      public function clearAllNewB() : *
      {
         var n:* = undefined;
         var aid:GoodsItemsData = null;
         for(n in this.arr)
         {
            aid = this.arr[n];
            aid.newB = false;
         }
      }
      
      public function getArr_byType(arr0:Array) : Array
      {
         var n:* = undefined;
         var str0:String = null;
         var m:* = undefined;
         var gid0:GoodsItemsData = null;
         var arr1:Array = [];
         for(n in arr0)
         {
            str0 = arr0[n];
            for(m in this.arr)
            {
               gid0 = this.arr[m];
               if(gid0.type == str0)
               {
                  arr1.push(gid0);
               }
            }
         }
         return arr1;
      }
      
      public function getArr_byExplore() : Array
      {
         var n:* = undefined;
         var delNum0:int = 0;
         var aid:GoodsItemsData = null;
         var m:int = 0;
         var aid2:GoodsItemsData = null;
         var arr1:Array = [];
         for(n in this.arr)
         {
            aid = this.arr[n];
            if(aid.exploreIndex >= 0)
            {
               if(arr1.length == 0)
               {
                  arr1.push(aid);
               }
               else
               {
                  for(m = arr1.length - 1; m >= 0; m--)
                  {
                     aid2 = arr1[m];
                     if(aid.exploreIndex >= aid2.exploreIndex)
                     {
                        arr1.splice(m + 1,0,aid);
                        break;
                     }
                     if(m == 0)
                     {
                        arr1.splice(0,0,aid);
                        break;
                     }
                  }
               }
            }
         }
         delNum0 = arr1.length - 10;
         if(delNum0 > 0)
         {
            arr1.splice(0,delNum0);
         }
         return arr1;
      }
      
      public function getArr_byColor(colorStr:String, type0:String) : Array
      {
         var n:* = undefined;
         var aid:GoodsItemsData = null;
         var str0:String = null;
         var str2:String = null;
         var arr1:Array = [];
         for(n in this.arr)
         {
            aid = this.arr[n];
            str0 = aid.name;
            str2 = colorStr + "_" + type0 + "_";
            if(type0 == "")
            {
               str2 = colorStr + "_";
            }
            if(str0.indexOf(str2) == 0 && str0.indexOf("_vip") == -1)
            {
               arr1.push(aid);
            }
         }
         arr1.sort(this.compareSite);
         return arr1;
      }
      
      public function getArr_byName(name0:String) : Array
      {
         var n:* = undefined;
         var aid:GoodsItemsData = null;
         var str0:String = null;
         var str2:String = null;
         var arr1:Array = [];
         for(n in this.arr)
         {
            aid = this.arr[n];
            str0 = aid.name;
            str2 = name0;
            if(str0.indexOf(str2) == 0)
            {
               arr1.push(aid);
            }
         }
         return arr1;
      }
      
      public function getArr_byNameArr(nameArr0:Array) : Array
      {
         var n:* = undefined;
         var aid:GoodsItemsData = null;
         var str0:String = null;
         var arr1:Array = [];
         for(n in this.arr)
         {
            aid = this.arr[n];
            str0 = aid.name;
            if(nameArr0.indexOf(str0) >= 0)
            {
               arr1.push(aid);
            }
         }
         arr1.sort(this.compareSite);
         return arr1;
      }
      
      public function inBagTest(aid:GoodsItemsData) : Boolean
      {
         if(this.getFillB())
         {
            if(aid.type == "chip")
            {
               return false;
            }
            if(this.getItemsByBase(aid.name) != null)
            {
               return true;
            }
            return false;
         }
         return true;
      }
      
      public function getItemsByBase(str:String, num0:int = 1) : GoodsItemsData
      {
         var n:* = undefined;
         var aid:GoodsItemsData = null;
         for(n in this.arr)
         {
            aid = this.arr[n];
            if(aid.name == str && aid.nowNum >= num0)
            {
               return aid;
            }
         }
         return null;
      }
      
      public function getItemsNumByBase(str:String) : GoodsItemsData
      {
         var num0:int = 1;
         var arr0:Array = str.split("_num");
         if(arr0.length >= 2)
         {
            num0 = int(arr0[1]);
         }
         str = this.arr[0];
         return this.getItemsByBase(str,num0);
      }
      
      public function getNumByBase(str0:String) : int
      {
         var aid:GoodsItemsData = this.getItemsByBase(str0);
         if(aid is GoodsItemsData)
         {
            return aid.nowNum;
         }
         return 0;
      }
      
      public function useItemsData(id:GoodsItemsData, num0:int = 1) : *
      {
         if(id.nowNum < num0)
         {
            trace("物品数量不够，不使用");
         }
         else if(id.nowNum == num0)
         {
            trace("使用完毕，删除物品");
            this.delItemsData(id);
         }
         else if(id.nowNum > num0)
         {
            trace("使用后，还有剩余");
            id.nowNum -= num0;
         }
      }
      
      public function useItemsNum(str:String, num0:int = 1) : Boolean
      {
         var gid0:GoodsItemsData = this.getItemsByBase(str);
         if(gid0 != null)
         {
            if(num0 == -1)
            {
               this.delItemsData(gid0);
            }
            else
            {
               this.useItemsData(gid0,num0);
            }
            return true;
         }
         return false;
      }
      
      public function delItemsData(id:GoodsItemsData) : *
      {
         var f0:int = this.arr.indexOf(id);
         if(f0 >= 0)
         {
            this.delItemsAt_arr(this.arr,f0);
         }
         else
         {
            trace("没找到指定物品，删除无法完成。");
         }
      }
      
      public function getItemsByName(str:String) : GoodsItemsData
      {
         var n:* = undefined;
         var aid:GoodsItemsData = null;
         for(n in this.arr)
         {
            aid = this.arr[n];
            if(aid.name == str)
            {
               return aid;
            }
         }
         return null;
      }
      
      public function getArrByName(str:String, affixMaxLevel0:int = -1, affixMinLevel0:int = -1) : Array
      {
         var n:* = undefined;
         var aid:GoodsItemsData = null;
         var arr0:Array = [];
         for(n in this.arr)
         {
            aid = this.arr[n];
            if(aid.name == str)
            {
               if(affixMaxLevel0 != -1)
               {
                  if(aid.affixLevel >= affixMinLevel0 && aid.affixLevel <= affixMaxLevel0)
                  {
                     arr0.push(aid);
                  }
               }
               else
               {
                  arr0.push(aid);
               }
            }
         }
         return arr0;
      }
      
      public function bag_to_bag(site1:int, site2:int) : *
      {
         this.swapTo(this.arr,site2,this.bagMaxNum,this.arr,site1,this.bagMaxNum);
      }
      
      private function swapTo(arr1:Array, site1:int, maxNum1:int, arr2:Array, site2:int, maxNum2:int) : *
      {
         var aid1:GoodsItemsData = null;
         var aid2:GoodsItemsData = null;
         var index2:int = 0;
         var index1:int = 0;
         if(site1 > maxNum1 - 1 || site2 > maxNum2 - 1)
         {
            return;
         }
         var f0:int = this.getIndexBySite(this.arr,site1);
         var f1:int = this.getIndexBySite(this.arr,site2);
         if(f0 >= 0 && f1 >= 0)
         {
            aid1 = arr1[f0];
            aid2 = arr2[f1];
            aid1.site = site2;
            aid2.site = site1;
            arr1[f0] = aid2;
            arr2[f1] = aid1;
         }
         else if(!(f0 == -1 && f1 == -1))
         {
            if(f0 >= 0 && f1 == -1)
            {
               aid1 = arr1[f0];
               this.delItemsAt_arr(arr1,f0);
               index2 = this.getPrewCloseSite(arr2,site2);
               aid1.site = site2;
               arr2.splice(index2,0,aid1);
            }
            else if(f0 == -1 && f1 >= 0)
            {
               aid2 = arr2[f1];
               this.delItemsAt_arr(arr2,f1);
               index1 = this.getPrewCloseSite(arr1,site1);
               aid2.site = site1;
               arr1.splice(index1,0,aid2);
            }
         }
      }
      
      private function getIndexBySite(arr0:Array, site0:int) : int
      {
         var n:* = undefined;
         var aid:GoodsItemsData = null;
         for(n in arr0)
         {
            aid = arr0[n];
            if(aid.site == site0)
            {
               return n;
            }
         }
         return -1;
      }
      
      private function delItemsAt_arr(arr0:Array, index0:int) : *
      {
         arr0.splice(index0,1);
      }
      
      private function getSpaceSite() : int
      {
         var n:* = undefined;
         var aid:GoodsItemsData = null;
         var cs0:int = 0;
         var arr0:* = this.arr;
         var maxnum:* = this.bagMaxNum;
         var prevSite:int = -1;
         for(n in arr0)
         {
            aid = arr0[n];
            cs0 = aid.site - prevSite;
            if(cs0 > 1)
            {
               return prevSite + 1;
            }
            prevSite = aid.site;
         }
         if(maxnum > prevSite + 1)
         {
            return prevSite + 1;
         }
         return -1;
      }
      
      public function getFillB() : Boolean
      {
         if(this.arr.length >= this.bagMaxNum)
         {
            return true;
         }
         return false;
      }
      
      public function getSurplus() : int
      {
         return this.bagMaxNum - this.arr.length;
      }
      
      public function getPrewCloseSite(arr0:Array, site0:int) : int
      {
         var n:* = undefined;
         var aid:GoodsItemsData = null;
         var index0:int = -1;
         for(n in arr0)
         {
            aid = arr0[n];
            if(aid.site < site0)
            {
               index0 = n;
            }
            else
            {
               if(aid.site == site0)
               {
                  return -1;
               }
               if(aid.site > site0)
               {
                  if(index0 == -1)
                  {
                     return 0;
                  }
                  return index0 + 1;
               }
            }
         }
         return index0 + 1;
      }
   }
}

