package UI.gameover
{
   import UI.icon.ItemsArmsIcon;
   import UI.items.ItemsIcon;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import goods.GoodsDefine;
   import gs.TweenLite;
   
   public class FlipCardBar extends Sprite
   {
      
      public var index:int = 0;
      
      public var box:*;
      
      public var itemsIcon:ItemsIcon = new ItemsIcon();
      
      public var armsIcon:ItemsArmsIcon = new ItemsArmsIcon();
      
      public var txt:MovieClip;
      
      public var _mc:MovieClip;
      
      public var goodsDefineStr:String = "";
      
      public var showTextB:Boolean = false;
      
      public var showYouGetB:Boolean = true;
      
      public function FlipCardBar()
      {
         super();
         this.itemsIcon.x = -26;
         this.itemsIcon.y = -9;
         this.box.addChild(this.itemsIcon);
         this.armsIcon.x = -57;
         this.armsIcon.y = -22;
         this.box.addChild(this.armsIcon);
         this.txt = this.box.txt;
         this._mc.mouseChildren = false;
      }
      
      public function init() : *
      {
         this.txt.stop();
         this.showYouGetB = true;
         this.showTextB = false;
         this.showOpposite();
         this.goodsDefineStr = "";
         this.itemsIcon.clearData();
         this.armsIcon.clearData();
      }
      
      public function showOpposite() : *
      {
         this._mc.gotoAndStop("to1");
         this.box.visible = false;
         this.showTextB = false;
      }
      
      public function playToPositive() : *
      {
         this._mc.gotoAndPlay("to1");
         this.box.visible = false;
      }
      
      public function showGoodsDefine() : *
      {
         var d0:GoodsDefine = null;
         d0 = this.getDefine();
         if(d0 is GoodsDefine)
         {
            this.showTextB = true;
            this.box.visible = true;
            this.itemsIcon.visible = false;
            this.armsIcon.visible = false;
            if(d0.type == "sub" || d0.type == "arms")
            {
               this.armsIcon.visible = true;
               this.armsIcon.inData_byGoodsDefine(d0);
            }
            else
            {
               this.itemsIcon.visible = true;
               this.itemsIcon.inData_byGoodsDefine(d0,true);
            }
            this.txt.visible = this.showYouGetB;
            this.box.alpha = 0;
            TweenLite.to(this.box,1,{"alpha":1});
         }
      }
      
      public function getDefine() : GoodsDefine
      {
         var d0:GoodsDefine = null;
         if(this.goodsDefineStr != "")
         {
            d0 = Game.goodsDefineGroup.getDefine_byStr3(this.goodsDefineStr,-1,true);
         }
         return d0;
      }
   }
}

