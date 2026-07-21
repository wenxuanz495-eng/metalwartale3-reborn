package goods
{
   import body.define.DefineGroup;
   import body.define.OneArmsDefine;
   import body.hero.CarDefine;
   import data.TextWay;
   import gameAll.data.ArmsItemsData;
   import gameAll.data.CarItemsData;
   import gameAll.data.car.CarDataCreator;
   import items.ItemsDefine;
   import items.ItemsDefineGroup;
   
   public class GoodsDefineGroup
   {
      
      public static var nameArr:Array = ["arms","sub","car","materials","props"];
      
      public static var nameArr2:Array = ["Arms","Sub","Car","Materials","Props"];
      
      public var xml:XML;
      
      public var Mxml:XML;
      
      public var Week_xml:XML;
      
      public var Exml:XML;
      
      public var Xxml:XML;
      
      public var XYxml:XML;
      
      public var Jxml:XML;
      
      public var MJxml:XML;
      
      public var DG:DefineGroup;
      
      public var IG:ItemsDefineGroup;
      
      public var arms:Array = [];
      
      public var sub:Array = [];
      
      public var car:Array = [];
      
      public var materials:Array = [];
      
      public var props:Array = [];
      
      public var Marms:Array = [];
      
      public var Msub:Array = [];
      
      public var Mcar:Array = [];
      
      public var Mmaterials:Array = [];
      
      public var Mprops:Array = [];
      
      public var Week_Car:Array = [];
      
      public var Earms:Array = [];
      
      public var Esub:Array = [];
      
      public var Ecar:Array = [];
      
      public var Ematerials:Array = [];
      
      public var Eprops:Array = [];
      
      public var Echip:Array = [];
      
      public var Xarms:Array = [];
      
      public var Xsub:Array = [];
      
      public var Xcar:Array = [];
      
      public var Xmaterials:Array = [];
      
      public var Xprops:Array = [];
      
      public var ExchangeItems:Array = [];
      
      public function GoodsDefineGroup()
      {
         super();
      }
      
      public function GetGoodsByName(cname:String) : GoodsDefine
      {
         var temp:* = undefined;
         var tempCar2:CarDefine = null;
         var quilte:String = null;
         var eq:String = null;
         var allCanArr:Array = null;
         var tempCar:CarDefine = null;
         var arr2:Array = null;
         var i:int = 0;
         var j:int = 0;
         if(cname.indexOf("战车") > 0 && cname != "帝皇战车")
         {
            quilte = cname.split("战车")[0];
            eq = CarDataCreator.getColorCEn(quilte);
            allCanArr = this.DG.carArr;
            for(i = 0; i < allCanArr.length; i++)
            {
               temp = allCanArr[i] as CarDefine;
               if(temp.installLevel <= Game.gameData.level + 1)
               {
                  if(tempCar == null || tempCar.installLevel < temp.installLevel)
                  {
                     if(temp.type == "G")
                     {
                        tempCar = temp;
                     }
                  }
               }
            }
            if(Boolean(tempCar))
            {
               return this.getCarDefine_byID(tempCar.id,eq);
            }
            return null;
         }
         var allarmsArr:Array = this.DG.ArmsArr;
         for(i = 0; i < allarmsArr.length; i++)
         {
            arr2 = allarmsArr[i];
            for(j = 0; j < arr2.length; j++)
            {
               temp = arr2[j] as OneArmsDefine;
               if(temp.name == cname || temp.id == cname)
               {
                  if(Boolean(temp.father))
                  {
                     return this.getArmsDefine_byID(temp.id,temp.father);
                  }
               }
            }
         }
         var igarr:Array = this.IG.arr;
         for(i = 0; i < igarr.length; i++)
         {
            arr2 = igarr[i];
            for(j = 0; j < arr2.length; j++)
            {
               temp = arr2[j] as ItemsDefine;
               if(temp.name == cname || temp.cnName == cname)
               {
                  return this.getItemsDefine_byID(temp.name,temp.type);
               }
            }
         }
         var allCanArr2:Array = this.DG.carArr;
         for(i = 0; i < allCanArr2.length; i++)
         {
            tempCar2 = allCanArr2[i] as CarDefine;
            if(tempCar2.name == cname)
            {
               return this.getCarDefine_byID(tempCar2.id,"yellow");
            }
         }
         return null;
      }
      
      public function init(mgift0:String) : *
      {
         var n:* = undefined;
         var name0:String = null;
         var name1:String = null;
         var arr0:Array = null;
         var arr1:Array = null;
         var arr2:Array = null;
         this.DG = Game.defineGroup;
         this.IG = Game.itemsDefineGroup;
         this.arms = this.inData_Arms(this.xml);
         this.sub = this.inData_Sub(this.xml);
         this.car = this.inData_Car(this.xml);
         this.materials = this.inData_Materials(this.xml);
         this.props = this.inData_Props(this.xml);
         this.Marms = this.inData_Arms(this.Mxml,"Mprice");
         this.Msub = this.inData_Sub(this.Mxml,"Mprice");
         this.Mcar = this.inData_Car(this.Mxml,"Mprice");
         this.Mmaterials = this.inData_Materials(this.Mxml,"Mprice");
         this.Mprops = this.inData_Props(this.Mxml,"Mprice");
         this.Week_Car = this.inData_Car(this.Week_xml,"Mprice");
         this.changeToWeekGoods(this.Week_Car);
         this.arms = this.inArr(this.arms,this.Marms);
         this.sub = this.inArr(this.sub,this.Msub);
         this.car = this.Week_Car.concat(this.inArr(this.car,this.Mcar));
         this.materials = this.materials;
         if((this.materials == null || this.materials.length == 0) && this.Mmaterials != null && this.Mmaterials.length > 0)
         {
            this.materials = this.Mmaterials.concat();
         }
         this.props = this.inArr(this.props,this.Mprops);
         var upgradePack0:GoodsDefine = this.getItemsDefine_byID("offline_upgrade_pack","props","Mprice");
         if(upgradePack0 is GoodsDefine)
         {
            upgradePack0.Mprice = 10;
            this.props.push(upgradePack0);
         }
         this.addCustomGoods();
         this.addLegacyGoods();
         this.ensureChildrensDayShopGoods();
         for(n in nameArr)
         {
            name0 = nameArr[n];
            name1 = nameArr2[n];
            arr0 = this["inData_" + name1](this.Xxml,"Xprice");
            arr1 = this["inData_" + name1](this.XYxml,"Xprice_Yprice");
            arr2 = this["inData_" + name1](this.Jxml,"Jprice");
            this["X" + name0] = arr2.concat(arr0.concat(arr1));
         }
         this.ExchangeItems = Game.exchangeDefineGroup.getItemArrCopy();
         this.Earms = this.inData_Arms(this.Exml,"Mprice");
         this.Esub = this.inData_Sub(this.Exml,"Mprice");
         this.Ecar = this.inData_Car(this.Exml,"Mprice");
         this.Ematerials = this.inData_Materials(this.Exml,"Mprice");
         this.Eprops = this.inData_Props(this.Exml,"Mprice");
         this.Echip = this.switchItems(this.IG.getArr_byStrArr(this.delChat(String(this.Exml.chip)).split(","),1),"materials");
         this.Earms = this.inArr(this.Earms,this.Esub);
      }

      
      private function ensureChildrensDayShopGoods() : *
      {
         var snow:GoodsDefine = null;
         var heart:GoodsDefine = null;
         var spring:GoodsDefine = null;
         var labor:GoodsDefine = null;
         // Snow: 1 Children's Day heart -> 1 snow, quantity selectable in shop UI.
         if(this.findGoods_inArr(this.materials,"xuehua") == null)
         {
            snow = this.getItemsDefine_byID("xuehua","materials","Mprice");
            if(snow is GoodsDefine)
            {
               snow.Mprice = 0;
               snow.price = 0;
               snow.num = 1;
               snow.baseNum = 1;
               snow.specialType = "heartBarter1";
               this.materials.push(snow);
            }
         }
         // Optional reverse entry not required.
         if(this.findGoods_inArr(this.materials,"ertongaixin") == null)
         {
            heart = this.getItemsDefine_byID("ertongaixin","materials","Mprice");
            if(heart is GoodsDefine)
            {
               heart.Mprice = 0;
               heart.price = 0;
               heart.num = 1;
               heart.baseNum = 1;
               heart.specialType = "heartBarter1";
               this.materials.push(heart);
            }
         }
         // New Year blessing / Labor medal: 1 Children's Day heart each.
         if(this.findGoods_inArr(this.materials,"xinchunsongfu") == null)
         {
            spring = this.getItemsDefine_byID("xinchunsongfu","materials","Mprice");
            if(spring is GoodsDefine)
            {
               spring.Mprice = 0;
               spring.price = 0;
               spring.num = 1;
               spring.baseNum = 1;
               spring.specialType = "heartPrice1";
               this.materials.push(spring);
            }
         }
         if(this.findGoods_inArr(this.materials,"laodongjie") == null)
         {
            labor = this.getItemsDefine_byID("laodongjie","materials","Mprice");
            if(labor is GoodsDefine)
            {
               labor.Mprice = 0;
               labor.price = 0;
               labor.num = 1;
               labor.baseNum = 1;
               labor.specialType = "heartPrice1";
               this.materials.push(labor);
            }
         }
         // Keep Mmaterials in sync for fallback materials tab.
         if(this.Mmaterials != null)
         {
            if(this.findGoods_inArr(this.Mmaterials,"xuehua") == null && this.findGoods_inArr(this.materials,"xuehua") != null)
            {
               this.Mmaterials.push(this.findGoods_inArr(this.materials,"xuehua"));
            }
            if(this.findGoods_inArr(this.Mmaterials,"xinchunsongfu") == null && this.findGoods_inArr(this.materials,"xinchunsongfu") != null)
            {
               this.Mmaterials.push(this.findGoods_inArr(this.materials,"xinchunsongfu"));
            }
            if(this.findGoods_inArr(this.Mmaterials,"laodongjie") == null && this.findGoods_inArr(this.materials,"laodongjie") != null)
            {
               this.Mmaterials.push(this.findGoods_inArr(this.materials,"laodongjie"));
            }
         }
      }

private function getCustomWeaponPrice(label0:String) : int
      {
         var seed:int = 0;
         var i:int = 0;
         if(label0 == null)
         {
            label0 = "";
         }
         for(i = 0; i < label0.length; i++)
         {
            seed = (seed * 33 + label0.charCodeAt(i)) % 100000;
         }
         // custom weapons: 4000~9000 MB
         return 4000 + seed % 5001;
      }

      private function getCarDisplayLevel(car0:CarDefine) : int
      {
         var lv:int = 0;
         if(car0 == null)
         {
            return 0;
         }
         // Prefer installLevel / mustLevel (baseLevel); take the higher one as "car level".
         lv = int(car0.installLevel);
         if(int(car0.mustLevel) > lv)
         {
            lv = int(car0.mustLevel);
         }
         if(int(car0.beforeLevel) > lv)
         {
            lv = int(car0.beforeLevel);
         }
         return lv;
      }

      private function getCustomCarPrice(label0:String) : int
      {
         var seed:int = 0;
         var i:int = 0;
         if(label0 == null)
         {
            label0 = "";
         }
         for(i = 0; i < label0.length; i++)
         {
            seed = (seed * 37 + label0.charCodeAt(i)) % 100000;
         }
         // custom cars above level 7: 1000~2000 MB, never below 1000
         return 1000 + seed % 1001;
      }

      private function addCustomGoods() : *
      {
         var n:* = undefined;
         var m:* = undefined;
         var family:Array = null;
         var d0:OneArmsDefine = null;
         var goods0:GoodsDefine = null;
         var car0:CarDefine = null;
         for(n in this.DG.ArmsArr)
         {
            family = this.DG.ArmsArr[n];
            if(family.length > 0)
            {
               for(m in family)
               {
                  d0 = family[m];
                  if(d0.discount == -1000)
                  {
                     if(d0.father == "arms" && this.findGoods_inArr(this.arms,d0.getLabel()) == null)
                     {
                        goods0 = this.switchArms([d0],"arms","Mprice")[0];
                        goods0.Mprice = this.getCustomWeaponPrice(d0.getLabel());
                        this.arms.push(goods0);
                     }
                     else if(d0.father == "sub" && this.findGoods_inArr(this.sub,d0.getLabel()) == null)
                     {
                        goods0 = this.switchArms([d0],"sub","Mprice")[0];
                        goods0.Mprice = this.getCustomWeaponPrice(d0.getLabel());
                        this.sub.push(goods0);
                     }
                     break;
                  }
               }
            }
         }
         for(n in this.DG.carArr)
         {
            car0 = this.DG.carArr[n];
            if(car0.discount == -1000 && this.findGoods_inArr(this.car,car0.id) == null)
            {
               goods0 = this.switchCar([car0],"car","Mprice")[0];
               // Only cars above level 7 use the 1000~2000 MB custom price band.
               if(this.getCarDisplayLevel(car0) > 7)
               {
                  goods0.Mprice = this.getCustomCarPrice(car0.id);
               }
               this.car.push(goods0);
            }
         }
      }

      private function addLegacyGoods() : *
      {
         var armsLabels:Array = ["lightKnife_lv1","edge_lv1","snow_lv1","liebopao_lv1","conAries_lv1","conTaurus_lv1","conCancer_lv1","conCapricornus_lv1","conSagittarius_lv1","conLeo_lv1","conPisces_lv1","conGemini_lv1","conAquarius_lv1","conLibra_lv1","conScorpio_lv1"];
         var subLabels:Array = ["snake_lv1","goldflyBlade_lv1","Goldbanger_lv1"];
         var carLabels:Array = ["audi_r8","angelWings","taxues1","taxues2","taxues3","taxues4"];
         this.addLegacyArmsGoods(armsLabels,"arms",600);
         this.addLegacyArmsGoods(subLabels,"sub",600);
         this.addLegacyCarGoods(carLabels,1200);
      }

      private function addLegacyArmsGoods(labels:Array, type0:String, defaultMPrice:int) : *
      {
         var n:* = undefined;
         var d0:OneArmsDefine = null;
         var goods0:GoodsDefine = null;
         var target:Array = this[type0];
         for(n in labels)
         {
            if(this.findGoods_inArr(target,labels[n]) == null)
            {
               d0 = this.DG.getAD_byStr(labels[n]);
               if(d0 is OneArmsDefine)
               {
                  goods0 = this.switchArms([d0],type0,"Mprice")[0];
                  goods0.Mprice = defaultMPrice;
                  target.push(goods0);
               }
            }
         }
      }

      private function addLegacyCarGoods(labels:Array, defaultMPrice:int) : *
      {
         var n:* = undefined;
         var d0:CarDefine = null;
         var goods0:GoodsDefine = null;
         for(n in labels)
         {
            if(this.findGoods_inArr(this.car,labels[n]) == null)
            {
               d0 = this.DG.getCarDefine(labels[n]);
               if(d0 is CarDefine)
               {
                  goods0 = this.switchCar([d0],"car","Mprice")[0];
                  goods0.Mprice = defaultMPrice;
                  this.car.push(goods0);
               }
            }
         }
      }
      
      public function changeToWeekGoods(arr0:Array) : *
      {
         var n:* = undefined;
         var d0:GoodsDefine = null;
         for(n in arr0)
         {
            d0 = arr0[n];
            d0.specialType = "week";
            d0.Mprice = int(d0.Mprice / 8 / (0.7 / 0.8));
         }
      }
      
      public function getBuySite(armsName0:String) : String
      {
         var gd1:GoodsDefine = this.findGoods_inArr(this.arms,armsName0);
         var gd2:GoodsDefine = this.findGoods_inArr(this.sub,armsName0);
         var bb1:Boolean = gd1 is GoodsDefine || gd2 is GoodsDefine;
         var gd3:GoodsDefine = this.findGoods_inArr(this.Xarms,armsName0);
         var gd4:GoodsDefine = this.findGoods_inArr(this.Xsub,armsName0);
         var bb2:Boolean = gd3 is GoodsDefine || gd4 is GoodsDefine;
         if(bb1 && bb2)
         {
            return "all";
         }
         if(bb1)
         {
            return "shop";
         }
         if(bb2)
         {
            return "exchange";
         }
         if(armsName0.indexOf("lightKnife") >= 0)
         {
            return "pay";
         }
         if(armsName0.indexOf("snake_lv1") >= 0 || armsName0.indexOf("cutter_gold") >= 0 || armsName0.indexOf("Goldbanger_lv1") >= 0)
         {
            return "activity";
         }
         if(armsName0.indexOf("liebopao_lv1") >= 0)
         {
            return "star";
         }
         if(armsName0.indexOf("goldflyBlade_lv1") >= 0)
         {
            return "grow";
         }
         return "";
      }
      
      public function zuobi_findArms() : int
      {
         var n:* = undefined;
         var name0:String = null;
         var aid0:ArmsItemsData = null;
         var d0:GoodsDefine = null;
         var num0:int = 0;
         var arr0:Array = ["microwave","amplitude"];
         for(n in arr0)
         {
            name0 = arr0[n];
            aid0 = Game.gameData.armsItems.getItemsByBase(name0,false);
            if(aid0 is ArmsItemsData)
            {
               d0 = this.findGoods_inArr(this.Marms,name0 + "_lv1");
               if(d0 is GoodsDefine)
               {
                  num0 += d0.Mprice;
                  trace("找到武器：" + d0.name + "   价格：" + d0.Mprice);
               }
            }
         }
         return num0;
      }
      
      public function zuobi_findSub() : int
      {
         var n:* = undefined;
         var name0:String = null;
         var aid0:ArmsItemsData = null;
         var d0:GoodsDefine = null;
         var num0:int = 0;
         var arr0:Array = ["flyBlade","highEnergy"];
         for(n in arr0)
         {
            name0 = arr0[n];
            aid0 = Game.gameData.subItems.getItemsByBase(name0,false);
            if(aid0 is ArmsItemsData)
            {
               d0 = this.findGoods_inArr(this.Msub,name0 + "_lv1");
               if(d0 is GoodsDefine)
               {
                  num0 += d0.Mprice;
                  trace("找到武器：" + d0.name + "   价格：" + d0.Mprice);
               }
            }
         }
         return num0;
      }
      
      public function zuobi_findCar() : int
      {
         var n:* = undefined;
         var d0:GoodsDefine = null;
         var aid0:CarItemsData = null;
         var num0:int = 0;
         var arr0:Array = this.Mcar;
         for(n in arr0)
         {
            d0 = arr0[n];
            aid0 = Game.gameData.carItems.getItemsByBase(d0.id);
            if(aid0 is CarItemsData)
            {
               num0 += d0.Mprice / 6;
               trace("找到车身：" + d0.name + "   价格：" + d0.Mprice / 6);
            }
         }
         return num0;
      }
      
      public function zuobi_findAll() : int
      {
         var num0:int = 0;
         num0 += this.zuobi_findArms();
         num0 += this.zuobi_findSub();
         return int(num0 + this.zuobi_findCar());
      }
      
      private function findGoods_inArr(arr0:Array, name0:String) : GoodsDefine
      {
         var n:* = undefined;
         var gd0:GoodsDefine = null;
         for(n in arr0)
         {
            gd0 = arr0[n];
            if(gd0.id == name0)
            {
               return gd0;
            }
         }
         return null;
      }
      
      private function inArr(arr0:Array, arr1:Array) : Array
      {
         var arr2:Array = [];
         var len:int = int(arr0.length);
         if(len < arr1.length)
         {
            len = int(arr1.length);
         }
         var num0:int = 0;
         var num1:int = 0;
         for(var n:int = 0; n < len; n++)
         {
            if(n <= arr0.length - 1)
            {
               arr2.push(arr0[n]);
            }
            if(n <= arr1.length - 1)
            {
               arr2.push(arr1[n]);
            }
         }
         return arr2;
      }
      
      public function inData_byXML(xml0:XML) : *
      {
         this.xml = xml0.GCoin[0];
         this.Mxml = xml0.MCoin[0];
         this.Week_xml = xml0.week[0];
         this.Exml = xml0.explore[0];
         this.Xxml = xml0.Xexchange[0];
         this.XYxml = xml0.XYexchange[0];
         this.Jxml = xml0.Jexchange[0];
      }
      
      public function inData_Arms(xml0:XML, priceType0:String = "price") : Array
      {
         var arr0:Array = this.delChat(String(xml0.arms)).split(",");
         var arr1:Array = this.DG.getArr_byLabelArr(arr0,"arms");
         return this.switchArms(arr1,"arms",priceType0);
      }
      
      public function inData_Sub(xml0:XML, priceType0:String = "price") : Array
      {
         var arr0:Array = this.delChat(String(xml0.sub)).split(",");
         var arr1:Array = this.DG.getArr_byLabelArr(arr0,"subArms");
         return this.switchArms(arr1,"sub",priceType0);
      }
      
      public function inData_Car(xml0:XML, priceType0:String = "price") : Array
      {
         var arr0:Array = this.delChat(String(xml0.car)).split(",");
         var arr1:Array = this.DG.getCarArr_byLabelArr(arr0);
         return this.switchCar(arr1,"car",priceType0);
      }
      
      public function inData_Materials(xml0:XML, priceType0:String = "price") : Array
      {
         var arr0:Array = this.delChat(String(xml0.materials)).split(",");
         var arr1:Array = this.IG.getArr_byStrArr(arr0,1);
         return this.switchItems(arr1,"materials",priceType0);
      }
      
      public function inData_Materials2(str0:String, priceType0:String = "price") : Array
      {
         var arr0:Array = this.delChat(str0).split(",");
         var arr1:Array = this.IG.getArr_byStrArr(arr0,1);
         return this.switchItems(arr1,"materials",priceType0);
      }
      
      public function inData_Props(xml0:XML, priceType0:String = "price") : Array
      {
         var arr0:Array = this.delChat(String(xml0.props)).split(",");
         var arr1:Array = this.IG.getArr_byStrArr(arr0,2);
         return this.switchItems(arr1,"props",priceType0);
      }
      
      public function switchArms(arr0:Array, type0:String, priceType0:String = "price") : Array
      {
         var n:* = undefined;
         var d0:OneArmsDefine = null;
         var d1:GoodsDefine = null;
         var discount0:Number = NaN;
         var arr1:Array = [];
         for(n in arr0)
         {
            d0 = arr0[n];
            d1 = new GoodsDefine();
            d1.id = d0.getLabel();
            d1.imgLabel = d0.father + "/" + d0.imgLabel;
            d1.name = d0.name;
            d1.discount = d0.discount;
            discount0 = d0.discount;
            if(discount0 < 0)
            {
               discount0 = 0;
            }
            d1.price = d0.price * (1 - discount0);
            d1.Mprice = d0.Mprice * (1 - discount0);
            d1.Xprice = d0.Xprice;
            d1.Yprice = d0.Yprice;
            d1.Zprice = d0.Zprice;
            d1.Jprice = d0.Jprice;
            d1.propId = d0.propId;
            d1.propId2 = d0.propId2;
            d1.priceLevel = d0.Mprice;
            d1.type = type0;
            d1.priceType = priceType0;
            d1.define = d0;
            arr1.push(d1);
         }
         return arr1;
      }
      
      public function switchCar(arr0:Array, type0:String, priceType0:String = "price") : Array
      {
         var n:* = undefined;
         var d0:CarDefine = null;
         var d1:GoodsDefine = null;
         var discount0:Number = NaN;
         var arr1:Array = [];
         for(n in arr0)
         {
            d0 = arr0[n];
            d1 = new GoodsDefine();
            d1.id = d0.id;
            d1.imgLabel = d0.father + "/" + d0.imgLabel + "_items";
            d1.name = d0.name;
            d1.discount = d0.discount;
            discount0 = d0.discount;
            if(discount0 < 0)
            {
               discount0 = 0;
            }
            d1.price = d0.price * (1 - discount0);
            d1.Mprice = d0.Mprice * (1 - discount0);
            d1.Xprice = d0.Xprice;
            d1.Yprice = d0.Yprice;
            d1.Zprice = d0.Zprice;
            d1.Jprice = d0.Jprice;
            d1.propId = d0.propId;
            d1.propId2 = d0.propId2;
            d1.priceLevel = d0.Mprice;
            d1.type = type0;
            d1.priceType = priceType0;
            d1.define = d0;
            arr1.push(d1);
         }
         return arr1;
      }
      
      public function switchItems(arr0:Array, type0:String, priceType0:String = "price") : Array
      {
         var n:* = undefined;
         var d0:ItemsDefine = null;
         var d1:GoodsDefine = null;
         var discount0:Number = NaN;
         var arr1:Array = [];
         for(n in arr0)
         {
            d0 = arr0[n];
            d1 = new GoodsDefine();
            d1.id = d0.name;
            d1.imgLabel = d0.imgLabel;
            d1.name = d0.cnName;
            d1.discount = d0.discount;
            discount0 = d0.discount;
            if(discount0 < 0)
            {
               discount0 = 0;
            }
            d1.price = d0.price * (1 - discount0);
            d1.Mprice = Math.ceil(d0.Mprice * (1 - discount0));
            d1.priceLevel = d0.Mprice;
            d1.Xprice = d0.Xprice;
            d1.Yprice = d0.Yprice;
            d1.Zprice = d0.Zprice;
            d1.Jprice = d0.Jprice;
            d1.propId = d0.propId;
            d1.propId2 = d0.propId2;
            d1.baseNum = d0.baseNum;
            d1.type = type0;
            d1.priceType = priceType0;
            d1.define = d0;
            d1.num = d0.nowNum;
            arr1.push(d1);
         }
         return arr1;
      }
      
      private function delChat(str0:String) : String
      {
         return TextWay.delCharArr(str0,["\n","\f","\r","\t"]);
      }
      
      public function getItemsDefine_byID(str0:String, type0:String, priceType0:String = "price") : GoodsDefine
      {
         var d0:ItemsDefine = this.IG.getDefine(str0);
         if(d0 is ItemsDefine)
         {
            return this.switchItems([d0],type0,priceType0)[0];
         }
         return null;
      }
      
      public function getCarDefine_byID(str0:String, eq:String = "white") : GoodsDefine
      {
         var d0:CarDefine = this.DG.getCarDefine(str0);
         d0.itemsData.color = eq;
         if(d0 is CarDefine)
         {
            return this.switchCar([d0],"car")[0];
         }
         return null;
      }
      
      public function getArmsDefine_byID(str0:String, type0:String) : GoodsDefine
      {
         var d0:OneArmsDefine = this.DG.getAD_byStr(str0);
         if(d0 is OneArmsDefine)
         {
            return this.switchArms([d0],type0)[0];
         }
         return null;
      }
      
      public function getGood6() : Array
      {
         var car0:GoodsDefine = this.randomInArr(this.car);
         var arms0:GoodsDefine = this.randomInArr(this.Earms);
         var m2:Array = [this.randomInArr(this.Ematerials),this.randomInArr(this.Ematerials),this.randomInArr(this.Ematerials),this.randomInArr(this.Ematerials),this.randomInArr(this.Ematerials),this.randomInArr(this.Ematerials)];
         m2[0].num = 12;
         var c0:GoodsDefine = this.randomInArr(this.Echip);
         var arr0:Array = [car0,arms0,c0];
         return arr0.concat(m2);
      }
      
      public function getDefine_byStr3(str0:String, lv0:int, proIsNumB:Boolean = false, color0:String = "", carcolor:String = "white") : GoodsDefine
      {
         var d0:GoodsDefine = null;
         var arr2:Array = null;
         var arr3:Array = null;
         var lv09:int = 0;
         var n09:String = null;
         var namestr:String = null;
         var namearr:Array = null;
         var color1:String = null;
         var label4:String = null;
         var label5:String = null;
         var label6:String = null;
         var ccolor:Array = ["red","yellow","purple","green"];
         var randomMaterial:Array = ["buncher","boom","thorn"];
         str0 = this.delChat(str0);
         var arr0:Array = str0.split(",");
         var type0:String = arr0[0];
         if(type0 == "GCoin")
         {
            d0 = this.getItemsDefine_byID("GCoin_card_4","props");
            d0.price = int(arr0[1]);
         }
         else if(type0 == "MCoin")
         {
            d0 = this.getItemsDefine_byID("GCoin_card_4","props");
            d0.id = "mcoin_reward_card";
            d0.name = "M币";
            d0.price = int(arr0[1]);
            d0.specialType = "offlineMCoin";
         }
         else if(type0 == "exp")
         {
            d0 = this.getItemsDefine_byID("exp_card_directly","props");
            d0.price = int(arr0[1]);
         }
         else if(type0 == "achieve")
         {
            d0 = this.getItemsDefine_byID("achieve_card_3","props");
            d0.price = int(arr0[1]);
         }
         else if(type0 == "car")
         {
            d0 = this.getCarDefine_byID(arr0[1],carcolor);
         }
         else if(type0 == "arms" || type0 == "sub")
         {
            d0 = this.getArmsDefine_byID(arr0[1],type0);
         }
         else if(type0 == "materials")
         {
            d0 = this.getItemsDefine_byID(arr0[1],"materials");
         }
         else if(type0 == "material")
         {
            d0 = this.getItemsDefine_byID(arr0[1],"materials");
         }
         else if(type0 == "chip")
         {
            d0 = this.getItemsDefine_byID(arr0[1],"materials");
         }
         else if(type0.indexOf("_chip") >= 0)
         {
            d0 = this.getItemsDefine_byID(type0,"materials");
            d0.affixLevel = int(arr0[1] - 1);
            d0.define.affixLevel = d0.affixLevel;
         }
         else if(type0 == "props")
         {
            d0 = this.getItemsDefine_byID(arr0[1],"props");
         }
         else if(type0 == "card")
         {
            d0 = this.getItemsDefine_byID(arr0[1],"props");
         }
         else if(type0 == "random")
         {
            arr2 = this.IG.getArr_byOneLevel("material",lv0);
            arr3 = this.switchItems(arr2,"materials");
            d0 = arr3[int(arr3.length * Math.random())];
            d0.num = int(arr0[1]);
         }
         else if(type0.indexOf("random_") >= 0)
         {
            lv09 = int(type0.split("random_")[1]);
            n09 = randomMaterial[int(Math.random() * randomMaterial.length)];
            d0 = this.getItemsDefine_byID(n09 + "_" + lv09,"materials");
            d0.num = int(arr0[1]);
         }
         else if(type0 == "crystal")
         {
            namestr = arr0[1];
            namearr = namestr.split("_");
            if(namearr.length < 2)
            {
               color1 = ccolor[int(ccolor.length * Math.random())];
               if(color0 != "")
               {
                  color1 = color0;
               }
               label4 = color1 + "_crystal_" + arr0[1];
               d0 = this.getItemsDefine_byID(label4,"materials");
            }
            else
            {
               d0 = this.getItemsDefine_byID(namestr,"materials");
            }
         }
         else if(type0.indexOf("_crystal") > 0)
         {
            label5 = type0 + "_" + arr0[1];
            d0 = this.getItemsDefine_byID(label5,"materials");
            d0.num = int(arr0[1]);
         }
         else if(type0.indexOf("crystal_") >= 0)
         {
            label6 = ccolor[int(ccolor.length * Math.random())] + "_" + type0;
            d0 = this.getItemsDefine_byID(label6,"materials");
            d0.num = int(arr0[1]);
         }
         if(d0 is GoodsDefine)
         {
            d0.pro = int(arr0[2]);
            if(proIsNumB)
            {
               d0.num = d0.pro;
            }
         }
         return d0;
      }
      
      public function getArr_byStrArr(arr0:*, lv0:int, proIsNumB:Boolean = false, color0:String = "", carcolor:String = "white") : Array
      {
         var n:* = undefined;
         var d0:GoodsDefine = null;
         var arr1:Array = [];
         for(n in arr0)
         {
            d0 = this.getDefine_byStr3(arr0[n],lv0,proIsNumB,color0,carcolor);
            arr1.push(d0);
         }
         return arr1;
      }
      
      public function switchStrArr_toStr(arr0:Array, fastB:Boolean = false) : String
      {
         var arr1:Array = this.getArr_byStrArr(arr0,1,true);
         return this.switchArr_toStr(arr1,fastB);
      }
      
      public function switchArr_toStr(arr0:Array, fastB:Boolean = false) : String
      {
         var n:* = undefined;
         var str1:String = null;
         var d0:GoodsDefine = null;
         var level00:int = 0;
         var cnLevel00:String = null;
         var level02:int = 0;
         var cnLevel02:String = null;
         var cnNum:Array = ["一","二","三","四","五","六","七","八","九","十"];
         var cnNum2:Array = ["初级","中级","高级","大师级","专家级","史诗级",""];
         var str0:String = "";
         for(n in arr0)
         {
            str1 = "";
            d0 = arr0[n];
            if(d0.id == "GCoin_card_4")
            {
               if(fastB)
               {
                  str1 = d0.price + " G币";
               }
               else
               {
                  str1 = d0.num + "个" + d0.name;
               }
            }
            else if(d0.id == "achieve_card_3")
            {
               if(fastB)
               {
                  str1 = d0.price + " 功勋值";
               }
               else
               {
                  str1 = d0.num + "个" + d0.name;
               }
            }
            else if(d0.id == "exp_card_directly")
            {
               if(fastB)
               {
                  str1 = d0.price + " 经验值";
               }
               else
               {
                  str1 = d0.num + "个" + d0.name;
               }
            }
            else if(d0.id.indexOf("_crystal_") > 0)
            {
               level00 = int(d0.id.split("_crystal_")[1]);
               cnLevel00 = cnNum[level00 - 1];
               str1 = d0.num + "个" + cnLevel00 + "级随机晶体";
            }
            else if(d0.id.indexOf("_chip") == -1 && d0.id.indexOf("superalloy") == -1 && d0.type == "materials")
            {
               level02 = int(d0.id.split("_")[1]);
               cnLevel02 = cnNum2[level02 - 1];
               if(cnLevel02 == null || cnLevel02 == "null")
               {
                  cnLevel02 = "";
               }
               str1 = d0.num + "个" + cnLevel02 + "随机材料";
            }
            else
            {
               str1 = d0.num + "个" + d0.name;
            }
            str0 += "\n" + str1;
         }
         if(arr0.length == 0)
         {
            str0 = "无";
         }
         return str0;
      }
      
      public function randomInArr(arr0:Array) : GoodsDefine
      {
         return arr0[int(Math.random() * arr0.length)];
      }
      
      public function findCar_inM(carlabel0:String) : Boolean
      {
         var n:* = undefined;
         var d0:GoodsDefine = null;
         for(n in this.Mcar)
         {
            d0 = this.Mcar[n];
            if(d0.id == carlabel0)
            {
               return true;
            }
         }
         return false;
      }
   }
}


