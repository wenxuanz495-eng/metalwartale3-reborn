package gameAll.data
{
   import body.hero.CarDefine;
   import gameAll.data.car.CarDataCreator;
   
   public class CarItemsDataGroup
   {
      
      public var lastID:int = 0;
      
      public var armsState:Array = [""];
      
      public var arr:Array = [];
      
      public var bagMaxNum:int = 60;
      
      public var equArr:Array = [];
      
      public var equMaxNum:int = 1;
      
      public var verNumber:String = "3.0";
      
      public function CarItemsDataGroup()
      {
         super();
      }
      
      public function inData_byObj(obj:Object) : *
      {
         var n:* = undefined;
         var arr0:Array = null;
         var i:* = undefined;
         var arr1:Array = null;
         var m:* = undefined;
         var pro0:String = null;
         var aid:CarItemsData = null;
         var aid1:CarItemsData = null;
         var pro_arr:Array = ["lastID","bagMaxNum","equMaxNum","armsState"];
         for(n in pro_arr)
         {
            pro0 = pro_arr[n];
            this[pro0] = obj[pro0];
         }
         if(this.bagMaxNum < 60)
         {
            this.bagMaxNum = 60;
         }
         this.arr.length = 0;
         arr0 = obj.arr;
         for(i in arr0)
         {
            aid = new CarItemsData();
            aid.inData_byObj(arr0[i]);
            this.arr.push(aid);
         }
         this.equArr.length = 0;
         arr1 = obj.equArr;
         for(m in arr1)
         {
            aid1 = new CarItemsData();
            aid1.inData_byObj(arr1[m]);
            this.equArr.push(aid1);
         }
         if(obj.hasOwnProperty("verNumber"))
         {
            this.verNumber = obj.verNumber;
            if(Number(this.verNumber) < 3.1)
            {
               this.changeToVer3();
            }
         }
         else
         {
            this.changeToVer3();
         }
         this.verNumber = "3.1";
      }
      
      public function changeToVer3() : *
      {
         trace("转换");
         this.equArr = this.changeToVer3_arr(this.equArr);
         this.arr = this.changeToVer3_arr(this.arr);
      }
      
      private function changeToVer3_arr(arr0:Array) : Array
      {
         var n:* = undefined;
         var da0:CarItemsData = null;
         var d0:CarDefine = null;
         var lv0:int = 0;
         var da2:CarItemsData = null;
         var arr4:Array = [];
         for(n in arr0)
         {
            da0 = arr0[n];
            d0 = da0.getArmsDefine();
            if(d0)
            {
               arr4.push(da0);
               lv0 = d0.beforeLevel + da0.upgradeNum * 5;
               if(d0.getType() == "G")
               {
                  if(d0.discount != -1000)
                  {
                     da2 = CarDataCreator.getNormalData(lv0,"blue");
                     da0.swapToData(da2);
                     da0.fleshByDefine();
                  }
                  else
                  {
                     CarDataCreator.setCustomData(da0);
                  }
               }
               else
               {
                  da0.setMcarNowLevel(lv0);
                  CarDataCreator.setShopData(da0);
               }
            }
         }
         return arr4;
      }
      
      public function getAdd() : Object
      {
         var obj0:Object = {};
         var da0:CarItemsData = this.getNow();
         if(Boolean(da0))
         {
            return da0.extraObj;
         }
         return obj0;
      }
      
      public function cleanUp() : *
      {
         var car0:CarItemsData = null;
         var i:int = 0;
         while(i < this.arr.length)
         {
            if(i >= this.bagMaxNum)
            {
               break;
            }
            car0 = this.arr[i];
            car0.site = i;
            i++;
         }
      }
      
      public function OverduePan() : *
      {
         var n:* = undefined;
         var i:* = undefined;
         var car0:CarItemsData = null;
         var car2:CarItemsData = null;
         var car3:CarItemsData = null;
         var delArr:Array = [];
         for(n in this.arr)
         {
            car0 = this.arr[n];
            if(car0.getSurplusDay() <= 0)
            {
               delArr.push(car0);
            }
         }
         for(i in delArr)
         {
            car2 = delArr[i];
            this.delItems_arr(this.arr,car2.id);
         }
         if(this.equArr.length > 0)
         {
            car3 = this.equArr[0];
            if(car3.getSurplusDay() <= 0)
            {
               if(this.arr.length == 0)
               {
                  trace("没车，则添加新车，交换，删除");
                  this.addItems("beetle");
               }
               this.bag_to_equip(this.arr[0].site,car3.site);
               this.delItems_arr(this.arr,car3.id);
            }
         }
      }
      
      public function clearAllNewB() : *
      {
         var n:* = undefined;
         var aid:CarItemsData = null;
         for(n in this.arr)
         {
            aid = this.arr[n];
            aid.newB = false;
         }
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
      
      public function getNow() : CarItemsData
      {
         return this.equArr[0];
      }
      
      public function addItems(label0:String, newB:Boolean = false, define:* = null) : CarItemsData
      {
         var aid:CarItemsData = new CarItemsData();
         aid.baseLabel = label0;
         aid.id = String(this.arr.length - 1);
         aid.type = "car";
         var oad:CarDefine = Game.defineGroup.getCarDefine(label0);
         aid.name = oad.id;
         aid.cnName = oad.name;
         aid.imgLabel = oad.father + "/" + oad.imgLabel + "_items";
         aid.newB = newB;
         if(define is CarDefine && Boolean(define.itemsData))
         {
            aid.color = (define as CarDefine).itemsData.color;
         }
         this.addItemsData(aid);
         return aid;
      }
      
      public function addItemsData(aid:CarItemsData) : int
      {
         if(this.arr.length >= this.bagMaxNum)
         {
            trace("武器包裹满了，添加武器失败");
            return -1;
         }
         var s0:int = this.findBagSpace();
         aid.site = s0;
         this.lastID += 1;
         aid.id = String(this.lastID);
         var i0:int = this.getPrewCloseSite(this.arr,s0);
         this.arr.splice(i0,0,aid);
         return s0;
      }
      
      public function addArmsToEquip(label0:String) : *
      {
         var items0:* = this.addItems(label0);
         this.bag_to_equip(items0.site,0);
      }
      
      public function getItemsByBase(label0:String) : CarItemsData
      {
         var n:* = undefined;
         var m:* = undefined;
         var car0:CarItemsData = null;
         var car1:CarItemsData = null;
         for(n in this.arr)
         {
            car0 = this.arr[n];
            if(car0.baseLabel == label0)
            {
               return car0;
            }
         }
         for(m in this.equArr)
         {
            car1 = this.equArr[m];
            if(car1.baseLabel == label0)
            {
               return car1;
            }
         }
         return null;
      }
      
      public function getEquipBySite(site0:int) : CarItemsData
      {
         return this.getItemsBySite(this.equArr,site0);
      }
      
      public function loadFirstEquip() : *
      {
         this.moveArmsItems(this.arr[0].id,this.arr,this.equArr,0);
      }
      
      public function bag_to_bag(site1:int, site2:int) : *
      {
         this.swapTo(this.arr,site2,this.bagMaxNum,this.arr,site1,this.bagMaxNum);
      }
      
      public function equip_to_equip(site1:int, site2:int) : *
      {
         this.swapTo(this.equArr,site2,this.equMaxNum,this.equArr,site1,this.equMaxNum);
      }
      
      public function bag_to_equip(site1:int, site2:int) : *
      {
         this.swapTo(this.equArr,site2,this.equMaxNum,this.arr,site1,this.bagMaxNum);
      }
      
      public function equip_to_bag(site1:int, site2:int) : *
      {
         this.bag_to_equip(site2,site1);
      }
      
      public function bagEquip_id(id0:String, site2:int) : *
      {
         var site1:int = this.getItemsById(id0).site;
         this.bag_to_equip(site1,site2);
      }
      
      public function equipBag_id(id0:String, site2:int) : *
      {
         var site1:int = this.getItemsById_arr(this.equArr,id0).site;
         this.bag_to_equip(site2,site1);
      }
      
      private function swapTo(arr1:Array, site1:int, maxNum1:int, arr2:Array, site2:int, maxNum2:int) : *
      {
         var aid1:CarItemsData = null;
         var aid2:CarItemsData = null;
         var index2:int = 0;
         var index1:int = 0;
         if(site1 > maxNum1 - 1 || site2 > maxNum2 - 1)
         {
            return;
         }
         var f0:int = this.getIndexBySite(arr1,site1);
         var f1:int = this.getIndexBySite(arr2,site2);
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
               trace("sdfsdf");
            }
         }
      }
      
      public function loadEquip(id0:String, site0:int) : *
      {
         this.moveArmsItems(id0,this.arr,this.equArr,site0);
      }
      
      public function unloadEquip(id0:String, site0:int) : *
      {
         this.moveArmsItems(id0,this.equArr,this.arr,site0);
      }
      
      public function equipToBag(id0:String, id1:String) : *
      {
         this.swapItems(this.equArr,this.arr,id0,id1);
      }
      
      public function swapEquip(id0:String, id1:String) : *
      {
         this.swapItems(this.equArr,this.equArr,id0,id1);
      }
      
      public function swapBag(id0:String, id1:String) : *
      {
         this.swapItems(this.arr,this.arr,id0,id1);
      }
      
      public function swapEquipSpace(id0:String, site1:int) : *
      {
         this.swapSpace(this.equArr,id0,site1);
      }
      
      public function swapBagSpace(id0:String, site1:int) : *
      {
         this.swapSpace(this.arr,id0,site1);
      }
      
      private function swapItems(arr0:Array, arr1:Array, id0:String, id1:String) : *
      {
         var aid0:CarItemsData = null;
         var aid1:CarItemsData = null;
         var site0:int = 0;
         var index0:int = this.getIndexById(arr0,id0);
         var index1:int = this.getIndexById(arr1,id1);
         if(index0 >= 0 && index1 >= 0)
         {
            aid0 = arr0[index0];
            aid1 = arr1[index1];
            site0 = aid0.site;
            aid0.site = aid1.site;
            aid1.site = site0;
            arr0[index0] = aid1;
            arr1[index1] = aid0;
         }
      }
      
      private function swapSpace(arr0:Array, id0:String, site1:int) : *
      {
         var aid0:CarItemsData = null;
         var index0:int = this.getIndexById(arr0,id0);
         var index1:int = this.getPrewCloseSite(arr0,site1);
         if(index1 >= 0)
         {
            aid0 = arr0[index0];
            aid0.site = site1;
            arr0.splice(index0,1);
            arr0.splice(index1,0,aid0);
         }
      }
      
      public function findEquipSpace() : int
      {
         return this.getSpaceSite(this.equArr,this.equMaxNum);
      }
      
      public function findBagSpace() : int
      {
         return this.getSpaceSite(this.arr,this.bagMaxNum);
      }
      
      private function getSpaceSite(arr0:Array, maxnum:int) : int
      {
         var n:* = undefined;
         var aid:CarItemsData = null;
         var cs0:int = 0;
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
      
      public function moveArmsItems(id0:String, arr1:Array, arr2:Array, site0:int) : *
      {
         var aid:CarItemsData = this.delItems_arr(arr1,id0);
         if(aid is CarItemsData)
         {
            aid.site = site0;
            arr2.push(aid);
         }
      }
      
      public function getIndexById(arr0:Array, id0:String) : int
      {
         var n:* = undefined;
         var aid:CarItemsData = null;
         for(n in arr0)
         {
            aid = arr0[n];
            if(aid.id == id0)
            {
               return n;
            }
         }
         return -1;
      }
      
      private function getIndexBySite(arr0:Array, site0:int) : int
      {
         var n:* = undefined;
         var aid:CarItemsData = null;
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
      
      private function getItemsBySite(arr0:Array, site0:int) : CarItemsData
      {
         var index0:int = this.getIndexBySite(arr0,site0);
         if(index0 >= 0)
         {
            return arr0[index0];
         }
         return null;
      }
      
      public function getPrewCloseSite(arr0:Array, site0:int) : int
      {
         var n:* = undefined;
         var aid:CarItemsData = null;
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
      
      public function getItemsById(str:String) : CarItemsData
      {
         return this.getItemsById_arr(this.arr,str);
      }
      
      private function getItemsById_arr(arr0:Array, str:String) : CarItemsData
      {
         var n:* = undefined;
         var aid:CarItemsData = null;
         for(n in arr0)
         {
            aid = arr0[n];
            if(aid.id == str)
            {
               return aid;
            }
         }
         return null;
      }
      
      public function delItems_arr(arr0:Array, id0:String) : CarItemsData
      {
         var n:* = undefined;
         var aid:CarItemsData = null;
         for(n in arr0)
         {
            aid = arr0[n];
            if(aid.id == id0)
            {
               arr0.splice(n,1);
               return aid;
            }
         }
         return null;
      }
      
      private function delItemsAt_arr(arr0:Array, index0:int) : *
      {
         arr0.splice(index0,1);
      }
      
      public function getArrByBase(str:String) : Array
      {
         var n:* = undefined;
         var aid:CarItemsData = null;
         var arr0:Array = [];
         for(n in this.arr)
         {
            aid = this.arr[n];
            if(aid.baseLabel == str)
            {
               arr0.push(aid);
            }
         }
         return arr0;
      }
      
      public function getArrByColor(str:String) : Array
      {
         var n:* = undefined;
         var aid:CarItemsData = null;
         var arr0:Array = [];
         for(n in this.arr)
         {
            aid = this.arr[n];
            if(aid.color == str)
            {
               arr0.push(aid);
            }
         }
         return arr0;
      }
      
      public function getArrByLevel(affixMaxLevel0:int = -1, affixMinLevel0:int = -1) : Array
      {
         var n:* = undefined;
         var aid:CarItemsData = null;
         var arr0:Array = [];
         for(n in this.arr)
         {
            aid = this.arr[n];
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
         return arr0;
      }
   }
}

