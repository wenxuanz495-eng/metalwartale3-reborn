package scene
{
   import data.INIT;
   import data.StringToDefine;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.BlendMode;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import gs.TweenLite;
   import gs.easing.Strong;
   import image.GameSprite;
   import image.ShakeMotion;
   import image.TweenMoiton;
   import sound.OneSound;
   
   public class OneSence
   {
      
      public var allXML:XML;
      
      public var nowID:String = "";
      
      public var id_arr:Array = [];
      
      public var nowIndex:int = 0;
      
      private var GS:GameSprite;
      
      public var thingsArr:Array = [];
      
      public var sceneName:String = "";
      
      public var sceneWidth:int;
      
      public var sceneHeight:int;
      
      public var viewWidth:int;
      
      public var viewHeight:int;
      
      public var viewRangeRect:Rectangle = new Rectangle();
      
      public var viewRangeRect2:Rectangle;
      
      public var levels:Array = [];
      
      public var sceneImgLable:String;
      
      public var hitLevelName:String;
      
      public var TM:TweenMoiton = new TweenMoiton();
      
      public var hitRectArr:Array = [];
      
      public var moveRectArr:Array = [];
      
      public var moveRectArr2:Array = [];
      
      private var hx:int = 0;
      
      private var hy:int = 0;
      
      public var shake:ShakeMotion = new ShakeMotion();
      
      public var lockB:Boolean = false;
      
      public var enabled:Boolean = false;
      
      public var lockLight1:Sprite;
      
      public var lockLight2:Sprite;
      
      public var screenEffect:Bitmap = new Bitmap(new BitmapData(1,1),"auto",true);
      
      public var enemyOverSound:OneSound;
      
      public var screenEffectTween:TweenLite;
      
      public function OneSence()
      {
         super();
      }
      
      public function inAllXML(_allXML:XML) : *
      {
         var n:* = undefined;
         var lv1:* = undefined;
         this.allXML = _allXML;
         var lv0:* = this.allXML.scene;
         for(n in lv0)
         {
            lv1 = lv0[n];
            this.id_arr.push(lv1.@id);
         }
      }
      
      public function changeSence(_id:String) : *
      {
         var n:* = undefined;
         var xml0:XML = null;
         for(n in this.id_arr)
         {
            if(_id == this.id_arr[n])
            {
               trace("找到场景：" + _id + "   编号为：" + n);
               this.nowID = _id;
               this.nowIndex = n;
               xml0 = this.allXML.scene[n];
               this.inData_byXML(xml0);
               this.init();
               return;
            }
         }
         trace("没找到场景：" + _id);
      }
      
      public function clear() : *
      {
         var n:* = undefined;
         var lv0:SceneLevel = null;
         this.viewRangeRect = new Rectangle();
         this.viewRangeRect2 = new Rectangle();
         this.hitRectArr.length = 0;
         this.moveRectArr.length = 0;
         this.thingsArr.length = 0;
         this.shake.init();
         for(n in this.levels)
         {
            lv0 = this.levels[n];
            if(lv0.parent != null)
            {
               lv0.parent.removeChild(lv0);
            }
            lv0.clearMC();
         }
         this.levels.length = 0;
         this.screenEffect.bitmapData.dispose();
         this.unLockView(false);
         this.enabled = false;
         if(Boolean(this.enemyOverSound))
         {
            this.enemyOverSound.stop();
         }
      }
      
      public function inData_byXML(xml0:XML) : *
      {
         var n:* = undefined;
         var m:* = undefined;
         var rect3:Rectangle = null;
         var l0:SceneLevel = null;
         var xml1:XML = null;
         var strX:String = null;
         var strY:String = null;
         this.sceneName = String(xml0.sceneName);
         this.sceneImgLable = String(xml0.sceneImgLable);
         this.hitLevelName = String(xml0.hitLevelName);
         this.sceneWidth = int(xml0.sceneWidth);
         this.sceneHeight = int(xml0.sceneHeight);
         this.viewWidth = int(xml0.viewWidth);
         this.viewHeight = int(xml0.viewHeight);
         if(String(xml0.thingsArr) != "")
         {
            this.thingsArr = String(xml0.thingsArr).split(",");
         }
         var hitr:Array = String(xml0.viewRangeRect).split(",");
         this.viewRangeRect.x = hitr[0];
         this.viewRangeRect.y = hitr[1];
         this.viewRangeRect.width = hitr[2];
         this.viewRangeRect.height = hitr[3];
         if(xml0.moveRectArr.length() > 0)
         {
            for(m in xml0.moveRectArr)
            {
               rect3 = StringToDefine.getRect(xml0.moveRectArr[m]);
               this.moveRectArr2.push(rect3);
            }
         }
         else
         {
            this.moveRectArr2 = [];
         }
         var levelXML:* = xml0.level;
         for(n in levelXML)
         {
            l0 = new SceneLevel();
            xml1 = levelXML[n];
            l0.mcName = String(xml1.mcName);
            l0.levelWidth = int(xml1.width);
            l0.levelHeight = int(xml1.height);
            l0.gameLevel = String(xml1.gameLevel);
            strX = String(xml1.moveRateX);
            if(strX == "full")
            {
               l0.moveRateX = (l0.levelWidth - this.viewWidth) / this.viewRangeRect.width;
               l0.cx = this.viewRangeRect.x;
            }
            else
            {
               l0.moveRateX = Number(strX);
            }
            strY = String(xml1.moveRateY);
            if(strY == "full")
            {
               l0.moveRateY = (l0.levelHeight - this.viewHeight) / this.viewRangeRect.height;
               l0.cy = this.viewRangeRect.y;
            }
            else
            {
               l0.moveRateY = Number(strY);
            }
            this.levels.push(l0);
         }
         this.viewRangeRect2 = this.viewRangeRect.clone();
      }
      
      public function init() : *
      {
         var n:int = 0;
         var l0:SceneLevel = null;
         var mc2:DisplayObject = null;
         var rect1:Rectangle = null;
         this.GS = Game.gameSprite;
         if(this.lockLight1 == null)
         {
            this.lockLight1 = Game.swfLoaderManager.getResource("ui","lock_light");
            this.GS.effectL.addChild(this.lockLight1);
            this.lockLight1.visible = false;
         }
         else if(this.lockLight1.parent == null)
         {
            this.GS.effectL.addChild(this.lockLight1);
         }
         if(this.lockLight2 == null)
         {
            this.lockLight2 = Game.swfLoaderManager.getResource("ui","lock_light");
            this.lockLight2.scaleX = -1;
            this.GS.effectL.addChild(this.lockLight2);
            this.lockLight2.visible = false;
         }
         else if(this.lockLight2.parent == null)
         {
            this.GS.effectL.addChild(this.lockLight2);
         }
         this.TM.init(this.GS.gameL.x,this.GS.gameL.y);
         this.TM.max = 500 / INIT.FPS;
         var mc0:Sprite = Game.swfLoaderManager.getResource("",this.sceneImgLable);
         for(var len0:int = int(this.levels.length); n < len0; )
         {
            l0 = this.levels[len0 - n - 1];
            l0.loadMC(mc0.getChildByName(l0.mcName));
            if(l0.gameLevel == "back")
            {
               this.GS.backMapL.addChild(l0);
            }
            else if(l0.gameLevel == "top")
            {
               this.GS.topMapL.addChild(l0);
            }
            n++;
         }
         var hitmc:* = mc0.getChildByName(this.hitLevelName);
         var len1:int = int(hitmc.numChildren);
         for(var m:int = 0; m < len1; m++)
         {
            mc2 = hitmc.getChildAt(m);
            rect1 = new Rectangle(mc2.x,mc2.y,mc2.width,mc2.height);
            this.hitRectArr.push(rect1);
         }
         this.moveRectArr.push(new Rectangle(-100 + this.viewRangeRect.x,this.viewRangeRect.y - 100000,100,this.viewRangeRect.height + 200000));
         this.moveRectArr.push(new Rectangle(this.viewRangeRect.x + this.viewRangeRect.width,this.viewRangeRect.y - 100000,100,this.viewRangeRect.height + 200000));
         this.screenEffect.bitmapData.dispose();
         this.screenEffect.bitmapData = new BitmapData(this.viewWidth,this.viewHeight,true,16777215);
         this.GS.uiEffectL.addChild(this.screenEffect);
         this.enemyOverSound = Game.SG.getSound("enemy_coming_first");
         this.enabled = true;
      }
      
      public function inTarget(hx0:int, hy0:int) : *
      {
         this.hx = -hx0;
         this.hy = -hy0;
      }
      
      public function inTargetMiddle(hx0:int, hy0:int) : *
      {
         this.hx = -hx0 + this.viewWidth / 2;
         this.hy = -hy0 + this.viewHeight / 2;
      }
      
      public function inPosition(hx0:int, hy0:int) : *
      {
         this.GS.gameL.x = -hx0;
         this.GS.gameL.y = -hy0;
         this.TM.init(-hx0,-hy0);
      }
      
      public function inPositionMiddle(hx0:int, hy0:int) : *
      {
         this.GS.gameL.x = -hx0 + this.viewWidth / 2;
         this.GS.gameL.y = -hy0 + this.viewHeight / 2;
         this.TM.init(this.GS.gameL.x,this.GS.gameL.y);
         this.inMapPositoin(this.GS.gameL.x,this.GS.gameL.y);
      }
      
      public function getPositionMiddle() : Point
      {
         return new Point(this.viewWidth / 2 - this.GS.gameL.x,this.viewHeight / 2 - this.GS.gameL.y);
      }
      
      public function getLockMiddle() : Point
      {
         return new Point(this.viewRangeRect2.x + this.viewRangeRect2.width / 2,this.viewRangeRect2.y + this.viewRangeRect2.height / 2);
      }
      
      public function inMapPositoin(x00:Number, y00:Number) : *
      {
         var n:* = undefined;
         var l0:SceneLevel = null;
         for(n in this.levels)
         {
            l0 = this.levels[n];
            l0.inPositoin(x00,y00);
         }
      }
      
      public function showScreenEffect(firstAlpha:Number = 1, scale0:Number = 1.1, color0:uint = 4294746227, _time0:Number = 1, endAlpha:Number = 0) : *
      {
         this.screenEffect.bitmapData.fillRect(new Rectangle(0,0,this.viewWidth,this.viewHeight),color0);
         this.screenEffect.bitmapData.draw(this.GS.gamingL,null,null,BlendMode.SUBTRACT);
         this.screenEffect.scaleX = 1;
         this.screenEffect.scaleY = 1;
         this.screenEffect.x = 0;
         this.screenEffect.y = 0;
         this.screenEffect.alpha = 1;
         var mx0:int = -(scale0 - 1) * this.screenEffect.width / 2;
         var my0:int = -(scale0 - 1) * this.screenEffect.height / 2;
         this.screenEffectTween = TweenLite.to(this.screenEffect,_time0,{
            "scaleX":scale0,
            "scaleY":scale0,
            "x":mx0,
            "y":my0,
            "alpha":endAlpha,
            "ease":Strong.easeOut
         });
      }
      
      public function showScreenEffect_noTween(firstAlpha:Number = 1, scale0:Number = 1.1, color0:uint = 4294746227) : *
      {
         TweenLite.killTweensOf(this.screenEffect);
         this.screenEffect.bitmapData.fillRect(new Rectangle(0,0,this.viewWidth,this.viewHeight),color0);
         this.screenEffect.bitmapData.draw(this.GS.gamingL,null,null,BlendMode.SUBTRACT);
         this.screenEffect.scaleX = 1;
         this.screenEffect.scaleY = 1;
         this.screenEffect.x = 0;
         this.screenEffect.y = 0;
         this.screenEffect.alpha = 1;
      }
      
      public function tweenScreenEffect(scale0:Number = 1.1, _time0:Number = 1, endAlpha:Number = 0) : *
      {
         this.screenEffect.scaleX = 1;
         this.screenEffect.scaleY = 1;
         this.screenEffect.x = 0;
         this.screenEffect.y = 0;
         this.screenEffect.alpha = 1;
         var mx0:int = -(scale0 - 1) * this.screenEffect.width / 2;
         var my0:int = -(scale0 - 1) * this.screenEffect.height / 2;
         TweenLite.to(this.screenEffect,_time0,{
            "scaleX":scale0,
            "scaleY":scale0,
            "x":mx0,
            "y":my0,
            "alpha":endAlpha,
            "ease":Strong.easeOut
         });
      }
      
      public function clearScreenEffect() : *
      {
         this.screenEffect.alpha = 0;
      }
      
      public function lockView(x0:Number, _effect:String = "", len0:int = 800, len2:int = 0) : *
      {
         if(_effect != "")
         {
            if(_effect == "middle")
            {
               this.showScreenEffect(0.5,1.05);
            }
         }
         if(len0 > 100000)
         {
            return;
         }
         if(len2 == 0)
         {
            len2 = len0;
         }
         this.lockB = true;
         this.viewRangeRect2.x = x0 - len0;
         this.viewRangeRect2.width = len0 + len2;
         if(this.viewRangeRect2.x < this.viewRangeRect.x)
         {
            this.viewRangeRect2.x = this.viewRangeRect.x;
         }
         if(this.viewRangeRect2.right > this.viewRangeRect.right)
         {
            this.viewRangeRect2.right = this.viewRangeRect.right;
         }
         if(this.viewRangeRect2.x > this.viewRangeRect.x)
         {
            this.moveRectArr[0] = new Rectangle(-100 + this.viewRangeRect2.x,this.viewRangeRect.y - 1000,100,this.viewRangeRect.height + 1000);
         }
         if(this.viewRangeRect2.right < this.viewRangeRect.right)
         {
            this.moveRectArr[1] = new Rectangle(this.viewRangeRect2.x + this.viewRangeRect2.width,this.viewRangeRect.y - 1000,100,this.viewRangeRect.height + 1000);
         }
         this.lockLight1.x = this.viewRangeRect2.x;
         this.lockLight1.y = this.viewRangeRect2.y;
         this.lockLight1.height = this.viewRangeRect2.height;
         this.lockLight2.x = this.viewRangeRect2.right;
         this.lockLight2.y = this.viewRangeRect2.y;
         this.lockLight2.height = this.viewRangeRect2.height;
         this.lockLight2.scaleX = -1;
         this.lockLight1.visible = true;
         this.lockLight2.visible = true;
      }
      
      public function unLockView(tipB:Boolean = true) : *
      {
         if(this.lockB)
         {
            this.lockB = false;
            this.viewRangeRect2 = this.viewRangeRect.clone();
            this.moveRectArr[0] = new Rectangle(-100 + this.viewRangeRect2.x,this.viewRangeRect.y - 1000,100,this.viewRangeRect.height + 1000);
            this.moveRectArr[1] = new Rectangle(this.viewRangeRect2.x + this.viewRangeRect2.width,this.viewRangeRect.y - 1000,100,this.viewRangeRect.height + 1000);
            this.lockLight1.visible = false;
            this.lockLight2.visible = false;
            if(tipB)
            {
               Game.EG.addEffect("ui","unlock_tip",this.GS.gameTipL,this.viewWidth - 30,this.viewHeight / 2);
            }
            this.enemyOverSound.play();
         }
      }
      
      public function getCloseFloorRandomPoint() : Point
      {
         var rect0:Rectangle = this.viewRangeRect2;
         var x0:int = rect0.x + 100 + (rect0.width - 100) * Math.random();
         var y0:int = Game.BGHit.getMinY(x0);
         return new Point(x0,y0);
      }
      
      public function addThings() : *
      {
         var cx:int = 0;
         var len0:int = 0;
         var num0:int = 0;
         var n:int = 0;
         var mx:int = 0;
         var ranN:int = 0;
         var m:int = 0;
         var x0:int = 0;
         var label0:String = null;
         if(this.thingsArr.length > 0)
         {
            cx = 50;
            if(this.thingsArr.indexOf("car1") >= 0)
            {
               cx = 150;
            }
            len0 = 900;
            num0 = (this.sceneWidth - 2000) / len0;
            for(n = 0; n < num0; n++)
            {
               mx = n * len0 + Math.random() * 200 - 100 + 1000;
               ranN = (Math.random() * 3 + 4) * 50 / cx;
               for(m = 0; m < ranN; m++)
               {
                  x0 = (m - 1) * cx + cx * (Math.random() * 2 + 4) / 6 + mx;
                  label0 = this.thingsArr[int(this.thingsArr.length * Math.random())];
                  Game.BG.addThingsBody(label0,x0);
               }
            }
         }
      }
      
      public function senceTimer() : *
      {
         var mx:* = undefined;
         var my:* = undefined;
         var hx0:* = undefined;
         var hy0:* = undefined;
         var leftX:int = 0;
         var rightX:int = 0;
         var topY:int = 0;
         var downY:int = 0;
         if(this.enabled)
         {
            mx = this.GS.gameL.x;
            my = this.GS.gameL.y;
            hx0 = this.hx;
            hy0 = this.hy;
            leftX = this.viewRangeRect2.x;
            rightX = this.viewRangeRect2.x + this.viewRangeRect2.width;
            topY = this.viewRangeRect2.y;
            downY = this.viewRangeRect2.y + this.viewRangeRect2.height;
            if(-hx0 <= leftX)
            {
               mx = -leftX;
            }
            else if(-hx0 + this.viewWidth >= rightX)
            {
               mx = -(rightX - this.viewWidth);
            }
            else
            {
               mx = hx0;
            }
            if(-hy0 <= topY)
            {
               my = -topY;
            }
            else if(-hy0 + this.viewHeight >= downY)
            {
               my = -(downY - this.viewHeight);
            }
            else
            {
               my = hy0;
            }
            this.shake.shakeTimer();
            this.TM.inData(mx,my);
            this.GS.gameL.x = int(this.TM.x) + this.shake.x;
            this.GS.gameL.y = int(this.TM.y) + this.shake.y;
            this.inMapPositoin(this.GS.gameL.x,this.GS.gameL.y);
         }
      }
   }
}

