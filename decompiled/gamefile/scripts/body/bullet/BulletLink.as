package body.bullet
{
   import body.define.DefineGroup;
   import body.define.OneArmsDefine;
   
   public class BulletLink
   {
      
      private var DG:DefineGroup;
      
      public var father:String = "";
      
      public var bulletName:String = "";
      
      public var bulletTrueName:String = "";
      
      public var bulletLevel:int = 0;
      
      public var index:int = -1;
      
      public function BulletLink()
      {
         super();
         this.DG = Game.defineGroup;
      }
      
      public static function getBulletByDefine(d:OneArmsDefine, secondBulletImg:String = "") : *
      {
         if(d == null)
         {
            throw new Error("Cannot create bullet from a null define");
         }
         var bu0:* = undefined;
         var type0:String = d.bulletType;
         if(type0 == "bullet" || type0 == "missile")
         {
            bu0 = new OneBulletBody();
            bu0.followB = d.followB;
            bu0.bounceNum = d.bounceNum;
            bu0.bulletVra = d.bulletVra;
            bu0.gravity = d.gravity;
            bu0.floorBounce = d.floorBounce;
         }
         else if(type0 == "laser")
         {
            if(d.bulletImgLabel == "")
            {
               bu0 = new LaserBody(false);
            }
            else
            {
               bu0 = new LaserBody(true);
            }
         }
         else
         {
            throw new Error("Unsupported bulletType: " + type0 + " for " + d.father + "/" + d.name);
         }
         bu0.width = d.bulletWidth;
         bu0.width2 = d.bulletWidth;
         bu0.imgFather = d.father;
         if(secondBulletImg != "")
         {
            bu0.imgLabel = secondBulletImg;
         }
         else
         {
            bu0.imgLabel = d.bulletImgLabel;
         }
         bu0.bulletType = d.bulletType;
         bu0.smokeImgLabel = d.smokeImgLabel;
         bu0.beatBack = d.beatBack;
         bu0.lifetime = d.bulletLife;
         bu0.followDelay = d.followDelay;
         bu0.followMaxTime = d.followMaxTime;
         bu0.hitImgLabel = d.hitImgLabel;
         bu0.penetrationB = d.penetrationB;
         bu0.hurt = d.hurt;
         bu0.attackType = d.attackType;
         bu0.backTime = d.backTime;
         bu0.scale = d.scale;
         bu0.lightning = d.lightning;
         bu0.specialType = d.specialType;
         bu0.Broken_PlasmaB = d.Broken_PlasmaB;
         bu0.selfBoom = d.selfBoom;
         bu0.hurt_0_B = d.hurt_0_B;
         bu0.itemsData = d.itemsData;
         bu0.mulHurt = d.mulHurt;
         return bu0;
      }
      
      public function getDefine() : OneArmsDefine
      {
         return this.DG.getArmsDefine(this.bulletTrueName,this.bulletLevel,this.father);
      }
      
      public function inData_byName() : *
      {
         this.father = "";
         this.bulletTrueName = "";
         this.bulletLevel = 0;
         if(this.bulletName == null || this.bulletName == "")
         {
            return false;
         }
         var arr0:Array = this.bulletName.split("/");
         if(arr0.length == 2)
         {
            this.father = arr0[0];
            this.bulletTrueName = arr0[1];
         }
         else if(arr0.length == 1)
         {
            this.bulletTrueName = arr0[0];
         }
         else
         {
            return false;
         }
         var arr1:Array = this.bulletTrueName.split("_lv");
         if(arr1.length != 2 || arr1[0] == "" || arr1[1] == "")
         {
            return false;
         }
         if(isNaN(Number(arr1[1])) || int(arr1[1]) < 1 || String(int(arr1[1])) != arr1[1])
         {
            return false;
         }
         this.bulletTrueName = arr1[0];
         this.bulletLevel = int(arr1[1]) - 1;
         return true;
      }
      
      public function toString() : *
      {
         trace("BulletLink：id=" + this.bulletTrueName + "   level=" + this.bulletLevel + "   father:" + this.father);
      }
   }
}

