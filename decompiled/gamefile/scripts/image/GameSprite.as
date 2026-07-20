package image
{
   import flash.display.Shape;
   import flash.display.Sprite;
   
   public class GameSprite extends Sprite
   {
      
      public var goHomeL:Sprite = new Sprite();
      
      public var shootMouseL:Sprite = new Sprite();
      
      public var UIL:Sprite = new Sprite();
      
      public var topUIL:Sprite = new Sprite();
      
      public var topTipL:Sprite = new Sprite();
      
      public var gamingUIL:Sprite = new Sprite();
      
      public var gameTipL:Sprite = new Sprite();
      
      public var uiEffectL:Sprite = new Sprite();
      
      public var gamingL:Sprite = new Sprite();
      
      public var topMapL:Sprite = new Sprite();
      
      public var gameL:Sprite = new Sprite();
      
      public var dialopL:Sprite = new Sprite();
      
      public var textL:Sprite = new Sprite();
      
      public var effectL:Sprite = new Sprite();
      
      public var bulletL:Sprite = new Sprite();
      
      public var smokeL:Sprite = new Sprite();
      
      public var goldL:Sprite = new Sprite();
      
      public var flyL:Sprite = new Sprite();
      
      public var enemyL:Sprite = new Sprite();
      
      public var heroL:Sprite = new Sprite();
      
      public var effectL2:Sprite = new Sprite();
      
      public var backMapL:Sprite = new Sprite();
      
      public function GameSprite()
      {
         super();
         this.gameL.addChild(this.effectL2);
         this.gameL.addChild(this.heroL);
         this.gameL.addChild(this.enemyL);
         this.gameL.addChild(this.flyL);
         this.gameL.addChild(this.goldL);
         this.gameL.addChild(this.smokeL);
         this.gameL.addChild(this.bulletL);
         this.gameL.addChild(this.effectL);
         this.gameL.addChild(this.textL);
         this.gameL.addChild(this.dialopL);
         this.UIL.addChild(this.uiEffectL);
         this.UIL.addChild(this.gameTipL);
         this.UIL.addChild(this.gamingUIL);
         this.UIL.addChild(this.topTipL);
         this.UIL.addChild(this.topUIL);
         this.gamingL.addChild(this.backMapL);
         this.gamingL.addChild(this.gameL);
         this.gamingL.addChild(this.topMapL);
         this.addChild(this.gamingL);
         this.addChild(this.UIL);
         this.addChild(this.shootMouseL);
         this.addChild(this.goHomeL);
         this.gameL.mouseChildren = false;
         this.gameL.mouseEnabled = false;
         var shootMouseShape:Shape = new Shape();
         shootMouseShape.graphics.beginFill(16777215,0);
         shootMouseShape.graphics.drawRect(0,0,950,560);
         this.shootMouseL.addChild(shootMouseShape);
         this.shootMouseL.visible = false;
      }
      
      public function clearAll() : *
      {
         this.clearAllChildren(this.effectL2);
         this.clearAllChildren(this.enemyL);
         this.clearAllChildren(this.goldL);
         this.clearAllChildren(this.smokeL);
         this.clearAllChildren(this.bulletL);
         this.clearAllChildren(this.effectL);
         this.clearAllChildren(this.textL);
         this.clearAllChildren(this.backMapL);
         this.clearAllChildren(this.topMapL);
      }
      
      public function clearAllChildren(sp0:Sprite) : *
      {
         var num0:int = sp0.numChildren;
         for(var n:int = 0; n < num0; n++)
         {
            sp0.removeChildAt(0);
         }
      }
   }
}

