package gameAll.data
{
   public class ArmsItemsDataGroup
   {
      
      public var lastID:int = 0;
      
      public var armsState:Array = ["","","","lock","lock","lock","lock","lock"];
      
      public var arr:Array = [];
      
      public var bagMaxNum:int = 30;
      
      public var equArr:Array = [];
      
      public var equMaxNum:int = 8;
      
      public function ArmsItemsDataGroup()
      {
         super();
      }
      
      public function inData_byObj(obj:Object) : *
      {
         var n:* = undefined;
         var j:* = undefined;
         var arr0:Array = null;
         var i:* = undefined;
         var arr1:Array = null;
         var m:* = undefined;
         var pro0:String = null;
         var aid:ArmsItemsData = null;
         var aid1:ArmsItemsData = null;
         var pro_arr:Array = ["lastID","bagMaxNum"];
         for(n in pro_arr)
         {
            pro0 = pro_arr[n];
            this[pro0] = obj[pro0];
         }
         for(j in obj.armsState)
         {
            this.armsState[j] = obj.armsState[j];
         }
         this.arr.length = 0;
         arr0 = obj.arr;
         for(i in arr0)
         {
            aid = new ArmsItemsData();
            aid.inData_byObj(arr0[i]);
            this.arr.push(aid);
         }
         this.equArr.length = 0;
         arr1 = obj.equArr;
         for(m in arr1)
         {
            aid1 = new ArmsItemsData();
            aid1.inData_byObj(arr1[m]);
            this.equArr.push(aid1);
         }
      }
      
      public function getMaxDpsArms() : ArmsItemsData
      {
         var n:* = undefined;
         var aid1:ArmsItemsData = null;
         var dps0:Number = NaN;
         var aid0:ArmsItemsData = null;
         var maxdps0:Number = 0;
         for(n in this.equArr)
         {
            aid1 = this.equArr[n];
            dps0 = aid1.define.getAllDps();
            if(dps0 >= maxdps0)
            {
               aid0 = aid1;
               maxdps0 = dps0;
            }
         }
         return aid0;
      }
      
      public function delPositron_lv1() : Boolean
      {
         var aid0:ArmsItemsData = this.getItemsByBase("positron",false);
         if(aid0 is ArmsItemsData)
         {
            this.delItems_arr(this.arr,aid0.id);
            this.delItems_arr(this.equArr,aid0.id);
            return true;
         }
         return false;
      }
      
      public function addPositron_lv1() : *
      {
         var aid0:ArmsItemsData = this.getItemsByBase("positron",false);
         if(!(aid0 is ArmsItemsData))
         {
            this.addItems("positron_lv1");
         }
      }
      
      public function getEquipList() : Array
      {
         var n:* = undefined;
         var d0:ArmsItemsData = null;
         var arr1:Array = [];
         for(n in this.equArr)
         {
            d0 = this.equArr[n];
            arr1.push(d0.baseLabel);
         }
         return arr1;
      }
      
      public function getEquipSiteList() : Array
      {
         var n:* = undefined;
         var d0:ArmsItemsData = null;
         var arr1:Array = [];
         for(var i:int = 0; i < this.equMaxNum; i++)
         {
            arr1.push("");
         }
         for(n in this.equArr)
         {
            d0 = this.equArr[n];
            arr1[d0.site] = d0.baseLabel;
         }
         return arr1;
      }
      
      public function getMust_M(arr0:Array) : int
      {
         var n:* = undefined;
         var num0:int = 0;
         for(n in this.armsState)
         {
            if(this.armsState[n] == "")
            {
               num0 += arr0[n];
               trace("武器位：" + (n + 1) + "，需要M币：" + arr0[n]);
            }
         }
         return num0;
      }
      
      public function isZuobi() : Boolean
      {
         var m:* = undefined;
         var _loc2_:ArmsItemsData = null;
         return false;
      }
      
      public function Level_Growth_fleshData() : *
      {
         var n:* = undefined;
         var m:* = undefined;
         var aid0:ArmsItemsData = null;
         var aid1:ArmsItemsData = null;
         for(n in this.arr)
         {
            aid0 = this.arr[n];
            if(aid0.define.specialType.indexOf("Level_Growth") >= 0)
            {
               aid0.fleshData();
            }
         }
         for(m in this.equArr)
         {
            aid1 = this.equArr[m];
            if(aid1.define.specialType.indexOf("Level_Growth") >= 0)
            {
               aid1.fleshData();
            }
         }
      }
      
      public function getOneDps() : Number
      {
         var dps0:Number = this.getAllDps();
         if(this.equArr.length == 0)
         {
            return 0;
         }
         return dps0 / this.equArr.length;
      }
      
      public function getAllDps() : Number
      {
         var n:* = undefined;
         var aid1:ArmsItemsData = null;
         var dps0:Number = 0;
         for(n in this.equArr)
         {
            aid1 = this.equArr[n];
            dps0 += aid1.define.getAllDps();
            if(aid1.getCrit_mul() > 30)
            {
               Game.uiGroup.zuobile("修改了武器的暴击伤害！");
               return int(9.2);
            }
         }
         return dps0;
      }
      
      public function unlockSite(site0:int) : *
      {
         this.armsState[site0] = "";
      }
      
      public function getAdd() : AdditionalData
      {
         var n:* = undefined;
         var aid:AdditionalData = new AdditionalData();
         for(n in this.equArr)
         {
            aid.addData(this.equArr[n].add);
         }
         return aid;
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
      
      public function addItems(label0:String, newB:Boolean = false) : ArmsItemsData
      {
         if(this.arr.length >= this.bagMaxNum)
         {
            trace("武器包裹满了，添加武器失败");
            return null;
         }
         var aid:ArmsItemsData = new ArmsItemsData();
         aid.baseLabel = label0;
         aid.newB = newB;
         aid.id = String(this.arr.length);
         aid.type = "arms";
         aid.inData_byDefine();
         this.addItemsData(aid);
         return aid;
      }
      
      public function addItemsData(aid:ArmsItemsData) : int
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
         aid.fleshData();
         return s0;
      }
      
      public function changeArmsByLabel(label0:String) : *
      {
         var arr0:Array = this.getArrByBase(label0);
         if(arr0.length > 0)
         {
            this.bag_to_equip(arr0[0].site,1);
         }
      }
      
      public function addArmsToEquip(label0:String) : *
      {
         var items0:ArmsItemsData = this.addItems(label0);
         var f0:int = this.findEquipSpace();
         if(f0 >= 0)
         {
            this.bag_to_equip(items0.site,f0);
         }
      }
      
      public function fleshData() : *
      {
         var n:* = undefined;
         var m:* = undefined;
         var aid:ArmsItemsData = null;
         var aid2:ArmsItemsData = null;
         for(n in this.equArr)
         {
            aid = this.equArr[n];
            aid.inData_byDefine();
            aid.fleshData();
         }
         for(m in this.arr)
         {
            aid2 = this.arr[m];
            aid2.inData_byDefine();
            aid2.fleshData();
         }
      }
      
      public function fleshAllArmsEnergy() : *
      {
         var n:* = undefined;
         var aid:ArmsItemsData = null;
         for(n in this.equArr)
         {
            aid = this.equArr[n];
            aid.fillEnergy();
         }
      }
      
      public function clearAllArmsEnergy() : *
      {
         var n:* = undefined;
         var aid:ArmsItemsData = null;
         for(n in this.equArr)
         {
            if(n > 0)
            {
               aid = this.equArr[n];
               aid.nowEnergy = 0;
            }
         }
      }
      
      public function getEquipBySite(site0:int) : ArmsItemsData
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
      
      public function bag_to_equip(site1:int, site2:int, isTobag:Boolean = false) : *
      {
         var fid:ArmsItemsData = null;
         var e:ArmsItemsData = null;
         if(isTobag == false)
         {
            fid = this.getItemsBySite(this.arr,site1);
            for each(e in this.equArr)
            {
               if(fid.baseLabel == e.baseLabel)
               {
                  Game.uiGroup.checkTip.showCheck2("不能装备同样的武器!",2);
                  return;
               }
            }
         }
         this.swapTo(this.equArr,site2,this.equMaxNum,this.arr,site1,this.bagMaxNum);
      }
      
      public function equip_to_bag(site1:int, site2:int) : *
      {
         var e:ArmsItemsData = null;
         var fid:ArmsItemsData = this.getItemsBySite(this.arr,site2);
         if(Boolean(fid))
         {
            for each(e in this.equArr)
            {
               if(fid.baseLabel == e.baseLabel)
               {
                  Game.uiGroup.checkTip.showCheck2("不能装备同样的武器!",2);
                  return;
               }
            }
         }
         this.bag_to_equip(site2,site1,true);
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
         var aid1:ArmsItemsData = null;
         var aid2:ArmsItemsData = null;
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
         var aid0:ArmsItemsData = null;
         var aid1:ArmsItemsData = null;
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
         var aid0:ArmsItemsData = null;
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
         var aid:ArmsItemsData = null;
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
         var aid:ArmsItemsData = this.delItems_arr(arr1,id0);
         if(aid is ArmsItemsData)
         {
            aid.site = site0;
            arr2.push(aid);
         }
      }
      
      public function getIndexById(arr0:Array, id0:String) : int
      {
         var n:* = undefined;
         var aid:ArmsItemsData = null;
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
         var aid:ArmsItemsData = null;
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
      
      private function getItemsBySite(arr0:Array, site0:int) : ArmsItemsData
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
         var aid:ArmsItemsData = null;
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
      
      public function getItemsById(str:String) : ArmsItemsData
      {
         return this.getItemsById_arr(this.arr,str);
      }
      
      private function getItemsById_arr(arr0:Array, str:String) : ArmsItemsData
      {
         var n:* = undefined;
         var aid:ArmsItemsData = null;
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
      
      public function delItems_arr(arr0:Array, id0:String) : ArmsItemsData
      {
         var n:* = undefined;
         var aid:ArmsItemsData = null;
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
      
      public function delItemByBaseLabel(str:String, levelB:Boolean = true) : void
      {
         var n:* = undefined;
         var aid:ArmsItemsData = null;
         for(n in this.arr)
         {
            aid = this.arr[n];
            if(!levelB)
            {
               if(aid.getID() == str)
               {
                  trace("getItemsByBase:在背包中找到指定类型的武器：" + aid.baseLabel);
                  this.arr.splice(n,1);
               }
            }
            else if(aid.baseLabel == str)
            {
               trace("getItemsByBase:在背包中找到指定武器：" + str);
               this.arr.splice(n,1);
            }
         }
      }
      
      private function delItemsAt_arr(arr0:Array, index0:int) : *
      {
         arr0.splice(index0,1);
      }
      
      public function getArrByBase(str:String) : Array
      {
         var n:* = undefined;
         var aid:ArmsItemsData = null;
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
      
      public function getConArms() : Array
      {
         var n:* = undefined;
         var aid:ArmsItemsData = null;
         var arr1:Array = [];
         var arr0:Array = this.arr.concat(this.equArr);
         for(n in arr0)
         {
            aid = arr0[n];
            if(aid.baseLabel.indexOf("con") == 0)
            {
               arr1.push(aid);
            }
         }
         return arr1;
      }
      
      public function getItemsByBase(str:String, levelB:Boolean = true) : ArmsItemsData
      {
         var n:* = undefined;
         var n2:* = undefined;
         var aid:ArmsItemsData = null;
         var aid2:ArmsItemsData = null;
         for(n in this.arr)
         {
            aid = this.arr[n];
            if(!levelB)
            {
               if(aid.getID() == str)
               {
                  trace("getItemsByBase:在背包中找到指定类型的武器：" + aid.baseLabel);
                  return aid;
               }
            }
            else if(aid.baseLabel == str)
            {
               trace("getItemsByBase:在背包中找到指定武器：" + str);
               return aid;
            }
         }
         for(n2 in this.equArr)
         {
            aid2 = this.equArr[n2];
            if(!levelB)
            {
               if(aid2.getID() == str)
               {
                  trace("getItemsByBase:在装备中找到指定类型的武器：" + aid2.baseLabel);
                  return aid2;
               }
            }
            else if(aid2.baseLabel == str)
            {
               trace("getItemsByBase:在装备中找到指定武器：" + str);
               return aid2;
            }
         }
         return null;
      }
   }
}

