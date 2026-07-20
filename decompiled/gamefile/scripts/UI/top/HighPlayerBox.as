package UI.top
{
   import body.define.OneArmsDefine;
   import body.hero.CarDefine;
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
         this.flesh_byData(d0);
      }
      
      public function flesh_byData(d0:*) : *
      {
         var carLabel0:String = null;
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
         var car_mc:MovieClip = this.showCar(carLabel0);
         var rocket_p:Point = this.getPoint(car_mc,"rocketPoint");
         this.showRocket(skillNum0[1],rocket_p,"rocket");
         var plasma_p:Point = this.getPoint(car_mc,"plasmaPoint");
         this.showRocket(skillNum0[2],plasma_p,"plasma");
         var arms_p:Point = this.getPoint(car_mc,"armsPoint");
         this.showArms(armsLabel0,arms_p);
         this.showSub(subArr0);
         this.clearMc_inMc(car_mc,["rocketPoint","plasmaPoint","armsPoint"]);
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
      
      private function showCar(label0:String) : MovieClip
      {
         var d0:CarDefine = Game.defineGroup.getCarDefine(label0);
         var mc0:MovieClip = Game.swfLoaderManager.getResource("car",d0.imgLabel);
         mc0.stop();
         this.car_sp.addChild(mc0);
         return mc0;
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
      
      private function showSub(arr0:Array) : *
      {
         var n:* = undefined;
         for(n in arr0)
         {
            this.showOneSub(n,arr0[n]);
         }
      }
      
      private function showOneSub(index0:int, label0:String) : *
      {
         var sub0:MovieClip = null;
         if(label0 == "")
         {
            return;
         }
         var p0:Point = Game.gameDefine.pointArr[index0];
         sub0 = Game.swfLoaderManager.getResource("sub","subCar_blue");
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
      
      public function getPoint(mc0:MovieClip, pName:String) : Point
      {
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
   }
}

