package effect.text
{
   import data.INIT;
   import flash.display.Sprite;
   
   public class RiseTextGroup
   {
      
      public var arr:Array = [];
      
      public var attackText:RiseText = new RiseText();
      
      public var hurtText:RiseText = new RiseText();
      
      public var con:Sprite;
      
      public function RiseTextGroup()
      {
         super();
      }
      
      public function init() : *
      {
         this.con = Game.gameSprite.textL;
         this.con.addChild(this.attackText);
         this.attackText.visible = false;
         this.con.addChild(this.hurtText);
         this.hurtText.visible = false;
      }
      
      public function addAttackText(str:String, x0:Number = 0, y0:Number = 0, color0:uint = 16777215, life0:Number = 1.5) : *
      {
         if(this.attackText.parent == null)
         {
            this.con.addChild(this.attackText);
         }
         this.attackText.visible = true;
         this.attackText.life_t = 0;
         this.attackText.life = life0 * INIT.FPS;
         this.attackText.textColor = color0;
         this.attackText.setText(str);
         this.attackText.x = x0;
         this.attackText.y = y0;
      }
      
      public function addHurtText(str:String, x0:Number = 0, y0:Number = 0, color0:uint = 16730698, life0:Number = 1.5) : *
      {
         if(this.hurtText.parent == null)
         {
            this.con.addChild(this.hurtText);
         }
         this.hurtText.visible = true;
         this.hurtText.life_t = 0;
         this.hurtText.life = life0 * INIT.FPS;
         this.hurtText.textColor = color0;
         this.hurtText.setText(str);
         this.hurtText.x = x0;
         this.hurtText.y = y0;
      }
      
      public function addText(str:String, x0:Number = 0, y0:Number = 0, color0:uint = 16777215, life0:Number = 2, boarderB:Boolean = false, scale:Number = 1) : RiseText
      {
         var text:RiseText = new RiseText();
         text.life = life0 * INIT.FPS;
         text.setText(str);
         text.textColor = color0;
         if(boarderB)
         {
            text.addFilter();
         }
         text.x = x0;
         text.y = y0;
         this.con.addChild(text);
         text.scaleX = text.scaleY = scale;
         this.arr.push(text);
         return text;
      }
      
      public function clearAll() : *
      {
         var n:* = undefined;
         var text:RiseText = null;
         for(n in this.arr)
         {
            text = this.arr[n];
            if(text.parent != null)
            {
               text.parent.removeChild(text);
            }
         }
         if(this.attackText.parent != null)
         {
            this.attackText.parent.removeChild(this.attackText);
         }
         if(this.hurtText.parent != null)
         {
            this.hurtText.parent.removeChild(this.hurtText);
         }
         this.arr.length = 0;
      }
      
      public function textTimer() : *
      {
         var n:* = undefined;
         var text:RiseText = null;
         var arr2:Array = [];
         for(n in this.arr)
         {
            text = this.arr[n];
            if(text.life_t >= text.life)
            {
               text.parent.removeChild(text);
            }
            else
            {
               text.FTimer();
               arr2.push(text);
            }
         }
         this.arr = arr2;
         if(this.attackText.life_t >= this.attackText.life)
         {
            this.attackText.visible = false;
         }
         else
         {
            this.attackText.FTimer();
         }
         if(this.hurtText.life_t >= this.hurtText.life)
         {
            this.hurtText.visible = false;
         }
         else
         {
            this.hurtText.FTimer();
         }
      }
   }
}

