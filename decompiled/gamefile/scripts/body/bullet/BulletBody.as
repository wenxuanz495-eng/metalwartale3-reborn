package body.bullet
{
   import body.image.SingleMovieclip;
   import gameAll.data.ArmsItemsData;
   
   public class BulletBody
   {
      
      public var penetrationNum:int = 0;
      
      public var hitEnemyB:Boolean = false;
      
      public var hurt:Number = 0;
      
      public var mulHurt:Number = 0;
      
      public var attackType:String = "";
      
      public var imgB:Boolean = false;
      
      public var imgFather:String = "";
      
      public var imgLabel:String = "";
      
      public var penetrationB:int = 0;
      
      public var bulletType:String = "bullet";
      
      public var die:int = 0;
      
      public var backTime:Number = 0;
      
      public var beatBack:Number = 0;
      
      public var lifetime:Number = 2;
      
      public var live_t:Number = -1;
      
      public var followDelay:Number = 0;
      
      public var followMaxTime:Number = 100000;
      
      private var _hitImgLabel:String = "";
      
      public var smokeImgLabel:String = "";
      
      public var bounceNum:int;
      
      public var attackBody:*;
      
      public var targetBody:*;
      
      public var width:Number = 0;
      
      public var width2:Number = 0;
      
      public var scale:Number = 0;
      
      public var lightning:Number = 0;
      
      public var itemsData:ArmsItemsData;
      
      public var specialType:String = "";
      
      public var selfBoom:Number = 0;
      
      public var selfDie:Boolean = false;
      
      public var Broken_PlasmaB:int = 0;
      
      public var hurt_0_B:Boolean = true;
      
      public function BulletBody()
      {
         super();
      }
      
      public function init(img0:SingleMovieclip, x00:Number, y00:Number, v0:Number, ra0:Number, vmax:Number, va:Number) : *
      {
      }
      
      public function toDie(_selfDie:Boolean = false) : *
      {
         this.die = 2;
         this.live_t = -1;
         this.selfDie = _selfDie;
      }
      
      public function getBroken_PlasmaB() : Boolean
      {
         return this.specialType == "Broken_Plasma" || this.Broken_PlasmaB == 1;
      }
      
      public function get hitImgLabel() : String
      {
         var f0:int = this._hitImgLabel.indexOf("motion_hit_effect");
         if(f0 >= 0)
         {
            return this._hitImgLabel + "_" + int(Math.random() * 4 + 1);
         }
         return this._hitImgLabel;
      }
      
      public function set hitImgLabel(str:String) : *
      {
         this._hitImgLabel = str;
      }
      
      protected function diePan() : *
      {
         if(this.live_t >= 0)
         {
            this.live_t += 1 / 30;
            if(this.selfBoom > 0)
            {
               if(this.live_t < this.lifetime && this.live_t > this.lifetime - 0.1)
               {
                  if(this.specialType == "Fiexd_Mines")
                  {
                     this.width2 = 30;
                  }
                  this.width = this.selfBoom * this.width2;
               }
               else if(this.live_t >= this.lifetime)
               {
                  this.toDie(true);
               }
            }
            else if(this.live_t >= this.lifetime)
            {
               this.toDie(true);
            }
         }
      }
      
      public function bodyTimer() : *
      {
         this.diePan();
      }
   }
}

