package body.hero
{
   import body.attack.ArmsAttack;
   import body.define.EnemyDefine;
   import flash.geom.Point;
   import gameAll.data.ArmsItemsData;
   import image.ShakeMotion;
   
   public class SubBody
   {
      
      public var img:SubImage = new SubImage();
      
      public var shake:ShakeMotion = new ShakeMotion();
      
      public var define:EnemyDefine = new EnemyDefine();
      
      public var carDefine:CarDefine = new CarDefine();
      
      public var armsDefine:ArmsDefine = new ArmsDefine("subArms");
      
      public var attack:ArmsAttack;
      
      public var mot:SubMotion = new SubMotion();
      
      public var AAHD:HeroCarAAHD;
      
      public var visible:Boolean = true;
      
      public var subPoint:Point;
      
      public var label:String = "";
      
      public var father:*;
      
      public var camp:String = "we";
      
      public var index:int = 0;
      
      public var die:* = 0;
      
      public var hitHurtB:int = 1;
      
      public function SubBody()
      {
         super();
         this.AAHD = new HeroCarAAHD(this);
         this.attack = new ArmsAttack(this,this.AAHD,this.armsDefine);
      }
      
      public function changeArmsItems(itemsData:ArmsItemsData) : *
      {
         this.changeArms(itemsData.baseLabel,0,itemsData);
      }
      
      public function changeArms(id0:String, level0:int = 0, itemsData:ArmsItemsData = null) : *
      {
         var arr:Array = id0.split("_lv");
         if(arr.length > 1)
         {
            id0 = arr[0];
            level0 = int(arr[1]) - 1;
         }
         this.armsDefine.inData(id0,level0,"",itemsData);
         this.img.arms.showMC(this.armsDefine.armsImgLabel);
      }
      
      public function changeCar(id0:String) : *
      {
         this.carDefine.inData(id0);
         this.img.car.showMC(this.carDefine.imgLabel);
      }
      
      public function moveToLeft() : *
      {
         this.img.flipToRight();
      }
      
      public function moveToRight() : *
      {
         this.img.flipToLeft();
      }
      
      public function hide() : *
      {
         this.visible = false;
         this.img.visible = false;
      }
      
      public function show() : *
      {
         this.visible = true;
         this.img.visible = true;
      }
      
      public function bodyTimer() : *
      {
         if(this.visible)
         {
            this.mot.motionTimer();
            this.img.imageTimer();
            this.attack.attackTimer();
            this.shake.shakeTimer();
            this.img.x = int(this.mot.x0) + this.shake.x;
            this.img.y = int(this.mot.y0) + this.shake.y;
            if(this.attack.state == "shoot" && this.father is HeroCarBody)
            {
               if(Game.oneScene.lockB)
               {
                  Game.gameData.bulletNum += this.armsDefine.bulletNum * this.armsDefine.shootNum;
               }
            }
         }
      }
   }
}

