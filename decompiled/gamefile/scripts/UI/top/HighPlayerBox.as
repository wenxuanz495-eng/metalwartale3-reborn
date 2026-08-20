package UI.top
{
   import body.define.OneArmsDefine;
   import body.hero.CarDefine;
   import body.hero.CarImage;
   import body.image.SingleMovieclip;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.geom.Point;
   import flash.utils.getTimer;
   import gameAll.data.GameData;
   import gameAll.high.HighDps_ExtraData;
   
   public class HighPlayerBox extends Sprite
   {
      
      public var car_sp:Sprite = new Sprite();
      
      public var rocket_sp:Sprite = new Sprite();
      
      public var arms_sp:Sprite = new Sprite();
      
      public var sub_sp:Sprite = new Sprite();
      
      public function HighPlayerBox()
      {
         super();
         this.addChild(this.car_sp);
         this.addChild(this.rocket_sp);
         this.addChild(this.arms_sp);
         this.addChild(this.sub_sp);
         this.mouseChildren = false;
         this.mouseEnabled = false;
      }
      
      public function test() : *
      {
         var tt0:int = getTimer();
         this.flesh_byData(new HighDps_ExtraData());
         trace("HighPlayerBox耗时：" + (getTimer() - tt0) + "ms");
      }
      
      public function flesh_byGameData(GD:GameData) : *
      {
         var d0:HighDps_ExtraData = GD.getHighDps_ExtraData();
         this.flesh_byData(d0,true);
      }
      
      public function flesh_byData(d0:*, useLocalAppearanceB:Boolean = false) : *
      {
         var carLabel0:String = null;
         var subCarLabel0:String = "subCar_blue";
         var skillNum0:Array = null;
         var armsLabel0:String = null;
         var subArr0:Array = null;
         this.clear();
         if(Boolean(d0.hasOwnProperty("car")))
         {
            carLabel0 = d0.car;
            skillNum0 = d0.skill;
            armsLabel0 = d0.arms[0];
            subArr0 = d0.sub;
         }
         else
         {
            carLabel0 = d0.carLabel;
            skillNum0 = d0.skillNum;
            armsLabel0 = d0.armsLabel;
            subArr0 = d0.subArr;
         }
         if(useLocalAppearanceB)
         {
            if(Game.gameData != null)
            {
               subCarLabel0 = Game.gameData.subCarLabel;
            }
            if(subCarLabel0 != "subCar_blue" && subCarLabel0 != "subCar_red" && subCarLabel0 != "subCar_yellow" && subCarLabel0 != "subCar_tvc_blue" && subCarLabel0 != "subCar_tvc_red" && subCarLabel0 != "subCar_tvc_yellow")
            {
               subCarLabel0 = "subCar_blue";
            }
         }
         var car_mc:* = this.showCar(carLabel0,useLocalAppearanceB);
         if(car_mc == null)
         {
            return;
         }
         var rocket_p:Point = this.getPoint(car_mc,"rocketPoint");
         this.showRocket(skillNum0[1],rocket_p,"rocket");
         var plasma_p:Point = this.getPoint(car_mc,"plasmaPoint");
         this.showRocket(skillNum0[2],plasma_p,"plasma");
         var arms_p:Point = this.getPoint(car_mc,"armsPoint");
         this.showArms(armsLabel0,arms_p);
         this.showSub(subArr0,subCarLabel0);
         this.clearCarMount(car_mc);
      }
      
      public function flesh_byArena(d0:*) : *
      {
         var d1:HighDps_ExtraData = new HighDps_ExtraData();
         d1.inData_byHighArena(d0);
         this.flesh_byData(d1);
      }
      
      public function flesh_byArms(label0:String) : *
      {
         this.clear();
         var d0:OneArmsDefine = Game.defineGroup.getAD_byStr(label0);
         var mc0:MovieClip = Game.swfLoaderManager.getResource(d0.father,d0.imgLabel);
         mc0.stop();
         var p1:Point = this.getPoint(mc0,"shootPoint");
         mc0.x = -p1.x;
         mc0.y = -p1.y;
         this.arms_sp.addChild(mc0);
         this.clearMc_inMc(mc0,["basePoint","shootPoint"]);
      }
      
      private function showCar(label0:String, useLocalAppearanceB:Boolean = false) : *
      {
         var d0:CarDefine = Game.defineGroup.getCarDefine(label0);
         if(d0 == null)
         {
            return null;
         }
         var car0:CarImage = new CarImage();
         var smc0:SingleMovieclip = null;
         var n:* = undefined;
         for(n in Game.defineGroup.carImgLabelArr)
         {
            smc0 = Game.swfLoaderManager.getSingleMovieclip("car",Game.defineGroup.carImgLabelArr[n],true);
            if(smc0 != null)
            {
               car0.addSingleMovieclip(smc0);
            }
         }
         if(car0.mc_arr.length == 0)
         {
            return null;
         }
         car0.showMC(d0.imgLabel);
         if(useLocalAppearanceB)
         {
            var skin0:* = Game.gameData != null && Game.gameData.carItems != null ? Game.gameData.carItems.getActiveSkin() : null;
            var skinDefine0:* = skin0 != null ? skin0.getDefine() : null;
            if(skinDefine0 != null && skinDefine0.imgLabel != null && skinDefine0.imgLabel != "")
            {
               car0.showMC(skinDefine0.imgLabel);
            }
         }
         car0.stop();
         this.car_sp.addChild(car0);
         return car0;
      }
      
      private function showRocket(level0:int, p0:Point, label0:String) : *
      {
         var mc0:MovieClip = null;
         if(level0 > 0)
         {
            if(level0 > 12)
            {
               level0 = 12;
            }
            mc0 = Game.swfLoaderManager.getResource("parts",label0 + "_lv" + level0);
            mc0.stop();
            this.rocket_sp.addChild(mc0);
            mc0.x = p0.x;
            mc0.y = p0.y;
         }
      }
      
      private function showArms(label0:String, p0:Point) : *
      {
         if(label0 == null)
         {
            return;
         }
         var d0:OneArmsDefine = Game.defineGroup.getAD_byStr(label0,"arms");
         if(!d0)
         {
            throw new Error("找不到武器定义：" + label0);
         }
         var mc0:MovieClip = Game.swfLoaderManager.getResource("arms",d0.imgLabel);
         mc0.stop();
         var p1:Point = this.getPoint(mc0,"basePoint");
         mc0.x = p0.x - p1.x;
         mc0.y = p0.y - p1.y;
         this.arms_sp.addChild(mc0);
         this.clearMc_inMc(mc0,["basePoint","shootPoint"]);
      }
      
      private function showSub(arr0:Array, carLabel0:String = "subCar_blue") : *
      {
         var n:* = undefined;
         for(n in arr0)
         {
            this.showOneSub(n,arr0[n],carLabel0);
         }
      }
      
      private function showOneSub(index0:int, label0:String, carLabel0:String = "subCar_blue") : *
      {
         var sub0:MovieClip = null;
         if(label0 == "")
         {
            return;
         }
         var p0:Point = Game.gameDefine.pointArr[index0];
         if(carLabel0 == "subCar_tvc_blue" || carLabel0 == "subCar_tvc_red" || carLabel0 == "subCar_tvc_yellow")
         {
            var tvcColor0:String = carLabel0.substr("subCar_tvc_".length);
            var tvcSource0:String = tvcColor0 == "red" ? "subCar_red" : (tvcColor0 == "yellow" ? "subCar_yellow" : "subCar_blue");
            sub0 = Game.swfLoaderManager.getResource("sub25",tvcSource0);
         }
         else
         {
            sub0 = Game.swfLoaderManager.getResource("sub",carLabel0);
         }
         if(sub0 == null)
         {
            sub0 = Game.swfLoaderManager.getResource("sub","subCar_blue");
         }
         if(sub0 == null)
         {
            return;
         }
         this.sub_sp.addChild(sub0);
         sub0.stop();
         sub0.x = p0.x;
         sub0.y = p0.y + 20;
         this.clearMc_inMc(sub0,["armsPoint"]);
         var d0:OneArmsDefine = Game.defineGroup.getAD_byStr(label0,"sub");
         var mc0:MovieClip = Game.swfLoaderManager.getResource("sub",d0.imgLabel);
         mc0.stop();
         var p1:Point = this.getPoint(mc0,"basePoint");
         mc0.x = p0.x - p1.x;
         mc0.y = p0.y - p1.y + 20;
         this.sub_sp.addChild(mc0);
         this.clearMc_inMc(mc0,["basePoint","shootPoint"]);
      }
      
      public function getPoint(mc0:*, pName:String) : Point
      {
         if(mc0 is CarImage)
         {
            if(pName == "armsPoint")
            {
               return (mc0 as CarImage).armsPoint;
            }
            if(pName == "rocketPoint")
            {
               return (mc0 as CarImage).rocketPoint;
            }
            if(pName == "plasmaPoint")
            {
               return (mc0 as CarImage).plasmaPoint;
            }
         }
         var mc1:* = mc0.getChildByName(pName);
         if(Boolean(mc1))
         {
            return new Point(mc1.x,mc1.y);
         }
         return new Point();
      }
      
      public function clear() : *
      {
         this.clearAllChildren(this.car_sp);
         this.clearAllChildren(this.rocket_sp);
         this.clearAllChildren(this.arms_sp);
         this.clearAllChildren(this.sub_sp);
      }
      
      public function clearAllChildren(sp0:Sprite) : *
      {
         var num0:int = sp0.numChildren;
         for(var n:int = 0; n < num0; n++)
         {
            sp0.removeChildAt(0);
         }
      }
      
      public function clearMc_inMc(mc0:*, arr0:Array) : *
      {
         var n:* = undefined;
         var mc1:* = undefined;
         for(n in arr0)
         {
            mc1 = mc0.getChildByName(arr0[n]);
            if(Boolean(mc1))
            {
               mc0.removeChild(mc1);
            }
         }
      }

      public function clearCarMount(car0:*) : *
      {
         if(car0 is CarImage)
         {
            var now0:SingleMovieclip = (car0 as CarImage).getNowMC();
            if(now0 != null)
            {
               this.clearMc_inMc(now0.mc,["armsPoint"]);
            }
         }
         else
         {
            this.clearMc_inMc(car0,["armsPoint"]);
         }
      }
   }
}

