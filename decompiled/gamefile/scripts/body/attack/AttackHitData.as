package body.attack
{
   import body.image.SingleMovieclip;
   import data.Lines;
   import data.Maths;
   import data.StringToDefine;
   import flash.geom.Rectangle;
   
   public class AttackHitData
   {
      
      public var father:String = "";
      
      public var label:String = "";
      
      public var frame:int = 0;
      
      public var endFrame:int = 0;
      
      public var hitRectArr:Array = [];
      
      public var hitPointArr:Array = [];
      
      public var hitLineArr:Array = [];
      
      public var level:int = 0;
      
      public var _hurt:Number;
      
      public var attackType:String;
      
      public var specialType:String;
      
      public var recoilValue:Number;
      
      public var hitImgLabel:String;
      
      public var range:Number = -1000;
      
      public var mulHurt:Number = 0;
      
      public var hurt_0_B:Boolean = true;
      
      public function AttackHitData()
      {
         super();
      }
      
      public function clone(x0:Number, y0:Number, rightB:Boolean) : AttackHitData
      {
         var ahd:AttackHitData = null;
         var n1:* = undefined;
         var n2:* = undefined;
         var rect0:Rectangle = null;
         var l0:Lines = null;
         ahd = new AttackHitData();
         ahd.father = this.father;
         ahd.label = this.label;
         ahd.frame = this.frame;
         ahd.endFrame = this.endFrame;
         ahd.attackType = this.attackType;
         ahd.recoilValue = this.recoilValue;
         ahd.specialType = this.specialType;
         ahd._hurt = this._hurt;
         ahd.hurt_0_B = this.hurt_0_B;
         ahd.hitImgLabel = this.hitImgLabel;
         ahd.range = this.range;
         ahd.mulHurt = this.mulHurt;
         if(rightB)
         {
            if(this.range != 1000)
            {
               ahd.range = Maths.flipRa_Y(this.range);
            }
         }
         ahd.level = this.level;
         for(n1 in this.hitRectArr)
         {
            rect0 = this.hitRectArr[n1].clone();
            if(rightB)
            {
               rect0.x = -(rect0.x + rect0.width);
            }
            rect0.x += x0;
            rect0.y += y0;
            ahd.hitRectArr[n1] = rect0;
         }
         for(n2 in this.hitLineArr)
         {
            l0 = this.hitLineArr[n2].clone();
            if(rightB)
            {
               l0.x *= -1;
               l0.ra = Maths.flipRa_Y(l0.ra);
            }
            l0.x += x0;
            l0.y += y0;
            ahd.hitLineArr[n2] = l0;
         }
         return ahd;
      }
      
      public function inData(smc:SingleMovieclip) : *
      {
         this.father = smc.father;
         this.label = smc.label;
      }
      
      public function inData_byXML(xml0:XML) : *
      {
         var n1:* = undefined;
         var hp:* = undefined;
         var n2:* = undefined;
         var str1:String = null;
         var str2:String = null;
         this.hurt_0_B = true;
         this.frame = int(xml0.@frame);
         this.label = String(xml0.@label);
         this.endFrame = int(xml0.@endFrame);
         this.attackType = String(xml0.attackType);
         this.recoilValue = Number(xml0.recoilValue);
         this.specialType = String(xml0.specialType);
         this._hurt = Number(xml0.hurt);
         this.mulHurt = Number(xml0.mulHurt);
         this.hitImgLabel = String(xml0.hitImgLabel);
         var rangeStr:String = String(xml0.range);
         if(rangeStr != "" && rangeStr != "-1000")
         {
            this.range = Number(rangeStr) / 180 * Math.PI;
         }
         else
         {
            this.range = -1000;
         }
         if(this.endFrame == 0)
         {
            this.endFrame = this.frame;
         }
         var hr:* = xml0.hitRect;
         for(n1 in hr)
         {
            str1 = String(hr[n1]);
            this.hitRectArr.push(StringToDefine.getRect(str1));
         }
         hp = xml0.hitLine;
         for(n2 in hp)
         {
            str2 = String(hp[n2]);
            this.hitLineArr.push(StringToDefine.getLine(str2));
         }
      }
      
      public function get hurt() : Number
      {
         return this._hurt;
      }
      
      public function toString() : String
      {
         var str:String = "";
         str += "---------------------" + "\n";
         return str + ("label:" + this.label + "   frame:" + this.frame + "   endFrame:" + this.endFrame + "\n");
      }
   }
}

