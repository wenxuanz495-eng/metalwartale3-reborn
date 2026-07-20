package items
{
   import body.hero.HeroCarBody;
   import bodyGroup.BodyGroup;
   import data.Maths;
   import flash.display.Bitmap;
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.geom.Rectangle;
   import gameAll.GameDefine;
   import gameAll.data.GameData;
   import gameAll.data.GoodsItemsData;
   import gameAll.data.car.CarDataCreator;
   import gameAll.data.collect.CollectTaskDefine;
   
   public class ItemsGroup
   {
      
      public var arr:Array = [];
      
      public var GD:GameData;
      
      public var BG:BodyGroup;
      
      public var IDG:ItemsDefineGroup;
      
      public var DD:GameDefine;
      
      public var hero:HeroCarBody;
      
      public function ItemsGroup()
      {
         super();
      }
      
      public function init() : *
      {
         this.GD = Game.gameData;
         this.BG = Game.BG;
         this.IDG = Game.itemsDefineGroup;
         this.DD = Game.gameDefine;
         this.hero = this.BG.hero;
      }
      
      public function getLeft_X() : int
      {
         var n:* = undefined;
         var i0:ItemsBody = null;
         var max0:int = 100000;
         for(n in this.arr)
         {
            i0 = this.arr[n];
            if(i0.mot.x0 < max0)
            {
               max0 = i0.mot.x0;
            }
         }
         return max0;
      }
      
      public function getLeft_X_limit(mx0:int, minLen0:int) : int
      {
         var n:* = undefined;
         var i0:ItemsBody = null;
         var cx0:int = 0;
         var max0:int = 100000;
         for(n in this.arr)
         {
            i0 = this.arr[n];
            cx0 = mx0 - i0.mot.x0;
            if(i0.mot.x0 < max0 && cx0 < minLen0)
            {
               max0 = i0.mot.x0;
            }
         }
         return max0;
      }
      
      public function getRight_X() : int
      {
         var n:* = undefined;
         var i0:ItemsBody = null;
         var max0:int = -100000;
         for(n in this.arr)
         {
            i0 = this.arr[n];
            if(i0.mot.x0 > max0)
            {
               max0 = i0.mot.x0;
            }
         }
         return max0;
      }
      
      public function addItemsBody(d0:ItemsDefine, x0:Number, y0:Number, ra0:Number = -1000, b0:* = null) : *
      {
         var mc:MovieClip = null;
         var bit:Bitmap = null;
         var items0:ItemsBody = new ItemsBody();
         items0.label = d0.name;
         items0.define = d0;
         var temp:* = Game.swfLoaderManager.getResource("",d0.imgLabel);
         if(!(temp is DisplayObject))
         {
            mc = new MovieClip();
            bit = new Bitmap(temp);
            mc.addChild(bit);
            bit.x = -bit.width / 2;
            bit.y = -bit.height / 2;
         }
         else
         {
            mc = temp;
         }
         items0.img = mc;
         Game.gameSprite.bulletL.addChild(items0.img);
         if(Boolean(b0))
         {
            items0.enemyType = b0.type;
         }
         this.shootItems(items0,x0,y0,ra0);
         this.arr.push(items0);
      }
      
      public function addItemsBody_byLabel(label0:String, x0:Number, y0:Number, ra0:Number = -1000) : *
      {
         var d0:ItemsDefine = this.IDG.getDefine(label0);
         if(d0 is ItemsDefine)
         {
            this.addItemsBody(d0,x0,y0,ra0);
         }
      }
      
      public function addAddBall(_type:String, _value:Number, x0:Number, y0:Number, ra0:Number = -1000, hitFloorDisappearB:Boolean = false, moneyRangeB:Boolean = true) : ItemsBody
      {
         var items0:ItemsBody = new ItemsBody();
         items0.addType = _type;
         items0.addValue = _value;
         items0.hitFloorDisappearB = hitFloorDisappearB;
         items0.label = "add";
         if(_type == "money" && moneyRangeB)
         {
            items0.addValue = int(items0.addValue * (0.5 + Math.random()));
         }
         items0.img = Game.swfLoaderManager.getResource("items",_type);
         Game.gameSprite.bulletL.addChild(items0.img);
         this.shootItems(items0,x0,y0,ra0);
         this.arr.push(items0);
         return items0;
      }
      
      public function addAddBall2(_type:String, _value:Number, b0:*, num0:int = 1) : *
      {
         var num00:Number = NaN;
         for(var n4:int = 0; n4 < num0; n4++)
         {
            num00 = _value / num0;
            if(_type == "money")
            {
               num00 = int(num00);
            }
            this.addAddBall(_type,Number(num00),b0.MX,b0.MY);
         }
      }
      
      private function shootItems(items0:ItemsBody, x0:Number, y0:Number, ra0:Number = -1000) : *
      {
         items0.x = x0;
         items0.y = y0;
         var minY:Number = Game.BGHit.getMinY(x0);
         if(ra0 == -1000)
         {
            ra0 = -(Math.random() * 60 + 60) * Math.PI / 180;
         }
         var rect0:Rectangle = Game.oneScene.viewRangeRect2;
         if(x0 < rect0.x + 200)
         {
            if(ra0 < -Math.PI / 2)
            {
               ra0 = Maths.flipRa_Y(ra0);
            }
         }
         else if(x0 > rect0.x + rect0.width - 200)
         {
            if(ra0 > -Math.PI / 2)
            {
               ra0 = Maths.flipRa_Y(ra0);
            }
         }
         var v00:Number = Math.random() * 5 + 7;
         var cy0:int = Math.abs(minY - y0) + 1;
         var cx0:int = v00 * Math.cos(ra0) * cy0 / 20;
         var minY2:Number = Game.BGHit.getMinY(x0 + cx0);
         if(minY > minY2)
         {
            minY = minY2;
         }
         items0.mot.minY = minY - 20;
         items0.mot.shoot(v00,ra0);
      }
      
      public function removeItemsBody(items0:ItemsBody) : *
      {
         var f0:int = this.arr.indexOf(items0);
         if(f0 >= 0)
         {
            this.arr.splice(f0,1);
            items0.img.parent.removeChild(items0.img);
         }
      }
      
      public function hitItemsBody(b0:*) : *
      {
         var n:* = undefined;
         var items0:ItemsBody = null;
         var rect0:Rectangle = b0.hitRect;
         for(n in this.arr)
         {
            items0 = this.arr[n];
            if(items0.die == 0)
            {
               if(rect0.contains(items0.x,items0.y))
               {
                  if(!items0.hitB)
                  {
                     this.useItemsBody(items0);
                  }
                  items0.hitB = true;
               }
               else
               {
                  items0.hitB = false;
               }
            }
         }
      }
      
      public function useItemsBody(items0:ItemsBody) : *
      {
         var d0:ItemsDefine = null;
         var id0:* = undefined;
         var gid0:GoodsItemsData = null;
         var cd2:CollectTaskDefine = null;
         var num2:int = 0;
         if(items0.label == "add")
         {
            if(items0.addType == "lifePer")
            {
               this.GD.setLife(items0.addValue,"mul");
               Game.textGroup.addText("HP+ " + int(items0.addValue * 100) + " %",items0.x,items0.y - 20,16777215,1.5);
            }
            else if(items0.addType == "money")
            {
               this.GD.addCoin(items0.addValue);
               Game.textGroup.addText("G币+ " + items0.addValue,items0.x,items0.y - 20,16776960,1.5);
            }
            else if(items0.addType == "clearEnemy")
            {
               Game.eventGroup.killAllNormalEnemy();
               Game.textGroup.addText("清除怪物！",items0.x,items0.y - 20,16776960,1.5);
            }
            else if(items0.addType == "timeRecover")
            {
               if(Boolean(Game.LG.level.hasOwnProperty("now_t")))
               {
                  Game.LG.level.now_t += 10;
               }
               Game.textGroup.addText("时间回复！",items0.x,items0.y - 20,16776960,1.5);
            }
            else if(items0.addType == "superAttack")
            {
               if(Boolean(Game.LG.level.hasOwnProperty("set_superAttack")))
               {
                  Game.LG.level.set_superAttack();
               }
               Game.textGroup.addText("攻击力增加100%！",items0.x,items0.y - 20,16776960,1.5);
            }
            this.removeItemsBody(items0);
         }
         else
         {
            d0 = items0.define;
            if(d0.name == "car_capsule")
            {
               if(this.GD.carItems.getSurplus() == 0)
               {
                  Game.textGroup.addText("车身背包已满！",items0.x,items0.y - 20,3407718,1.5,false,1.5);
               }
               else
               {
                  Game.textGroup.addText("获得车身",items0.x,items0.y - 20,16777215,1.5);
                  CarDataCreator.hitAddData(items0);
                  this.removeItemsBody(items0);
               }
            }
            else
            {
               id0 = null;
               if(d0.getPropB())
               {
                  id0 = this.GD.propsItems.addItemsDefine(d0);
               }
               else
               {
                  id0 = this.GD.materialsItems.addItemsDefine(d0);
                  gid0 = id0;
                  if(Boolean(id0))
                  {
                     if(gid0.name.indexOf("purple_chip") >= 0)
                     {
                        gid0.affixLevel = gid0.getDefine().price - 1;
                        gid0.addArr = Game.gameDefine.purpleChip.getAddArr(gid0.name);
                     }
                  }
               }
               if(id0 == null)
               {
                  Game.textGroup.addText("材料背包已满！",items0.x,items0.y - 20,16724736,1.5);
               }
               else
               {
                  cd2 = this.GD.collectTaskData.nowTask;
                  if(cd2 is CollectTaskDefine)
                  {
                     this.removeItemsBody(items0);
                     Game.textGroup.addText("获得物品",items0.x,items0.y - 20,16777215,1.5);
                     if(d0.name == cd2.targetItems)
                     {
                        num2 = this.GD.materialsItems.getNumByBase(d0.name);
                        this.GD.collectTaskData.setNum(num2);
                        Game.uiGroup.mainUI.taskUI.collectUI.fleshData();
                        Game.uiGroup.gamingUI.fleshTaskBox();
                     }
                  }
                  else
                  {
                     this.removeItemsBody(items0);
                     Game.textGroup.addText("获得物品",items0.x,items0.y - 20,16777215,1.5);
                  }
               }
            }
         }
         Game.SG.playSound("useItems");
      }
      
      public function clearAll() : *
      {
         var n:* = undefined;
         var items0:ItemsBody = null;
         for(n in this.arr)
         {
            items0 = this.arr[n];
            items0.img.parent.removeChild(items0.img);
         }
         this.arr.length = 0;
      }
      
      public function dropCar(b0:*) : void
      {
         this.dropAppointItems(b0,"car_capsule",b0.define.level);
      }
      
      public function dropItems(b0:*, coin0:int, zra0:Number = 0, levelState0:String = "normal") : *
      {
         var n20:* = undefined;
         var dropran:Number = NaN;
         var iarr06:Array = null;
         var d06:* = undefined;
         var diff00:int = 0;
         var lv0123:int = 0;
         var type0:String = null;
         var v00:Number = NaN;
         var d0:ItemsDefine = null;
         var lv2:int = 0;
         var minLv2:int = 0;
         var chip_label:String = null;
         var iarr0:Array = null;
         var i3:int = 0;
         var label20:String = null;
         var d20:* = undefined;
         var carStr0:String = this.DD.drop.getCarItemsType(b0.type,this.GD.nowDifficult);
         if(carStr0 == "car")
         {
            this.dropAppointItems(b0,"car_capsule",b0.define.level);
         }
         Game.uiGroup.gamingUI.addTestText("dropItems：coin0：" + coin0);
         var lv0:int = int(b0.define.level);
         var moreCoinNum:* = 1;
         var num0:int = 1;
         if(b0.type == "super" || b0.type == "champion")
         {
            if(Math.random() < 0.1)
            {
               dropran = Math.random();
               if(dropran < 0.6)
               {
                  this.addItemsBody_byLabel("drop_box",b0.MX,b0.MY);
               }
               else if(dropran < 0.9)
               {
                  this.addItemsBody_byLabel("drop_box_2",b0.MX,b0.MY);
               }
               else
               {
                  this.addItemsBody_byLabel("drop_box_3",b0.MX,b0.MY);
               }
            }
         }
         if(b0.type == "super" || b0.type == "champion")
         {
            if(Math.random() < 0.19)
            {
               this.addItemsBody_byLabel("superalloy_Z",b0.MX,b0.MY);
            }
         }
         if(b0.type == "super")
         {
            lv0 += 1;
            num0 = 1;
            moreCoinNum = 3;
         }
         else if(b0.type == "champion")
         {
            lv0 += 1;
            num0 = 1;
            moreCoinNum = 4;
            this.addAddBall2("money",coin0,b0,moreCoinNum);
            Game.uiGroup.gamingUI.addTestText("超合金掉率：" + zra0);
         }
         else if(b0.type == "boss")
         {
            lv0 += 2;
            num0 = 4;
            moreCoinNum = 3;
            this.addAddBall2("money",coin0,b0,moreCoinNum);
            Game.uiGroup.gamingUI.addTestText("超合金掉率：" + zra0);
            if(Math.random() <= zra0)
            {
               this.addItemsBody_byLabel("superalloy_Z",b0.MX,b0.MY);
            }
            if(this.GD.level >= 6)
            {
               iarr06 = this.IDG.getArr_byOneLevel("crystal",lv0);
               if(iarr06.length > 0)
               {
                  d06 = iarr06[int(iarr06.length * Math.random())];
                  this.addItemsBody(d06,b0.MX,b0.MY);
               }
            }
         }
         if(Game.LG.state == "normal" && b0.define.certainChip != "")
         {
            diff00 = Game.gameData.nowDifficult;
            lv0123 = lv0 - 4 + 5 * Math.random();
            if(diff00 == 1 || diff00 == 2)
            {
               if(b0.type == "super")
               {
                  this.dropAppointItems(b0,"orange_chip",lv0123);
               }
               else if(b0.type == "boss")
               {
                  this.dropAppointItems(b0,"orange_chip",lv0123);
               }
            }
            else if(diff00 == 3)
            {
               if(b0.type == "super")
               {
                  this.dropAppointItems(b0,"orange_chip",lv0123);
               }
               else if(b0.type == "boss")
               {
                  this.dropAppointItems(b0,"orange_chip",lv0123);
                  this.dropAppointItems(b0,"orange_chip",lv0123);
               }
            }
         }
         for(var n:int = 0; n < num0; n++)
         {
            type0 = this.DD.drop.getItemsType(b0.type,this.GD.nowDifficult,n + 1);
            if(type0 != "")
            {
               if(type0 == "money" || type0 == "lifePer")
               {
                  v00 = this.GD.getLifePer();
                  if(type0 == "money")
                  {
                     v00 = coin0;
                     this.addAddBall2(type0,v00,b0,moreCoinNum);
                  }
                  else
                  {
                     this.addAddBall(type0,v00,b0.MX,b0.MY);
                  }
               }
               else
               {
                  d0 = null;
                  lv2 = this.DD.drop.getItemsLevel(lv0);
                  minLv2 = this.DD.drop.getMinLevel(type0,lv2);
                  if(type0 == "chip")
                  {
                     chip_label = this.DD.drop.getChipType(b0.type,this.GD.nowDifficult);
                     d0 = this.IDG.getDefine(chip_label);
                     d0.affixLevel = lv2;
                  }
                  else
                  {
                     iarr0 = this.IDG.getArr_byTypeLevel(type0,lv2,minLv2);
                     if(iarr0.length > 0)
                     {
                        d0 = iarr0[int(iarr0.length * Math.random())];
                     }
                  }
                  if(d0 is ItemsDefine)
                  {
                     if(!(d0.name.indexOf("crystal") >= 0 && this.GD.level < 6))
                     {
                        this.addItemsBody(d0,b0.MX,b0.MY);
                     }
                     if(d0.name == "superalloy")
                     {
                        for(i3 = 0; i3 < 1; i3++)
                        {
                           this.dropAppointItems(b0,d0.name,1);
                        }
                     }
                  }
               }
            }
         }
         var iarr20:Array = b0.define.dropItemsArr;
         for(n20 in iarr20)
         {
            label20 = iarr20[n20];
            d20 = this.IDG.getDefine(label20);
            if(d20 is ItemsDefine)
            {
               d20.affixLevel = lv0;
               this.addItemsBody(d20,b0.MX,b0.MY);
            }
         }
      }
      
      public function dropMaterials(b0:*) : *
      {
         var lv0:int = int(b0.define.level);
         var d0:ItemsDefine = null;
         var lv2:int = this.DD.drop.getItemsLevel(lv0);
         var minLv2:int = this.DD.drop.getMinLevel("material",lv2);
         var iarr0:Array = this.IDG.getArr_byTypeLevel("material",lv2,minLv2);
         if(iarr0.length > 0)
         {
            d0 = iarr0[int(iarr0.length * Math.random())];
            this.addItemsBody(d0,b0.MX,b0.MY);
         }
      }
      
      public function dropAppointItems(b0:*, label0:String, affixLevel:int) : *
      {
         var d0:ItemsDefine = this.IDG.getDefine(label0);
         if(d0 is ItemsDefine)
         {
            if(affixLevel < 1)
            {
               affixLevel = 1;
            }
            d0.affixLevel = affixLevel;
            this.addItemsBody(d0,b0.MX,b0.MY,-1000,b0);
         }
      }
      
      public function fleshDel() : *
      {
         var n:* = undefined;
         var items0:ItemsBody = null;
         var arr2:Array = [];
         for(n in this.arr)
         {
            items0 = this.arr[n];
            if(items0.die == 0)
            {
               arr2.push(items0);
            }
            else
            {
               items0.img.parent.removeChild(items0.img);
            }
         }
         this.arr = arr2;
      }
      
      public function itemsGroupTimer() : *
      {
         var n:* = undefined;
         var items0:ItemsBody = null;
         for(n in this.arr)
         {
            items0 = this.arr[n];
            items0.bodyTimer();
         }
         if(this.hero.die == 0)
         {
            this.hitItemsBody(this.hero);
         }
         this.fleshDel();
      }
   }
}

