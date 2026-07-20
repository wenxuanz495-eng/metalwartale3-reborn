package UI.change
{
   import UI.gaming.HeadTitle;
   import data.StringToDefine;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.Sprite;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import flash.utils.getTimer;
   import gameAll.honor.OneHonorDefine;
   import gameAll.vip.OneVipDefine;
   
   public class ChangeEquipImage extends Sprite
   {
      
      public var car:Bitmap;
      
      public var sub:Array = [];
      
      public var headTitle:HeadTitle;
      
      public function ChangeEquipImage()
      {
         super();
         this.car = new Bitmap(new BitmapData(1,1));
         addChild(this.car);
         this.headTitle = new HeadTitle();
         addChild(this.headTitle);
         this.headTitle.y = -70;
         this.headTitle.x = 0;
      }
      
      public function copyAll() : *
      {
         var tt:int = getTimer();
         Game.uiGroup.allback.fleshData();
         this.clearAll();
         var hero:* = Game.BG.hero;
         if(Boolean(hero))
         {
            hero.img.car.hurtEffectHide();
            hero.img.stopAll();
            hero.SG.stopAllImage();
            hero.img.arms.rotation = 0;
            this.copyCar(hero.img.sp);
            this.copySubGroup(hero.SG);
         }
         var d0:OneHonorDefine = Game.gameData.honorData.getNowDefine();
         var honor0:String = d0.name;
         var vip_d:OneVipDefine = Game.gameData.vipData.getNowDefine();
         if(honor0 == "no" && !vip_d)
         {
            this.headTitle.visible = false;
         }
         else
         {
            this.headTitle.visible = true;
            this.headTitle.txt.y = -30;
            if(honor0 == "no")
            {
               this.headTitle.txt.htmlText = StringToDefine.getFontColor(vip_d.honor,"#FFFF00");
            }
            else if(!vip_d)
            {
               this.headTitle.txt.htmlText = d0.cnName;
            }
            else
            {
               this.headTitle.txt.y = -45;
               this.headTitle.txt.htmlText = StringToDefine.getFontColor(vip_d.honor,"#FFFF00") + "\n" + d0.cnName;
            }
         }
      }
      
      private function copyCar(img:*) : *
      {
         var bmp:BitmapData = StringToDefine.getBmp(img);
         this.car.bitmapData = bmp;
         var rect0:Rectangle = img.getRect(img);
         this.car.x = rect0.x;
         this.car.y = rect0.y;
      }
      
      private function copySub(img:*, p0:Point) : *
      {
         img.arms.nowMC.gotoAndStop(1);
         var bmp:BitmapData = StringToDefine.getBmp(img);
         var subBmp0:Bitmap = new Bitmap(bmp);
         this.sub.push(subBmp0);
         addChild(subBmp0);
         subBmp0.x = -(subBmp0.height + 50) / 2 + p0.x;
         subBmp0.y = -subBmp0.height / 2 + p0.y;
      }
      
      private function copySubGroup(sg:*) : *
      {
         var n:* = undefined;
         var sub0:* = undefined;
         for(n in sg.arr)
         {
            sub0 = sg.arr[n];
            this.copySub(sub0.img,sub0.subPoint);
         }
      }
      
      private function clearAll() : *
      {
         var n:* = undefined;
         this.car.bitmapData.dispose();
         for(n in this.sub)
         {
            this.removeChild(this.sub[n]);
            this.sub[n].bitmapData.dispose();
         }
         this.sub.length = 0;
      }
   }
}

