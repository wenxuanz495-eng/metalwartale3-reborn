package body.hero
{
   import body.key.Keys;
   import body.key.KeysGroup;
   import body.motion.BodyMotion;
   import body.skill.OneLevelSkillDefine;
   import body.skill.OneSkill;
   import body.skill.SkillDefine;
   import flash.ui.Keyboard;
   import gameAll.data.GameData;
   import gameAll.level.ArenaLevel;
   import gameAll.level.extra.JuneExtraLevel;
   import gameAll.level.extra.SpecialExtraLevel_1;
   import gameAll.level.extra.SpecialExtraLevel_2;
   import gameAll.level.extra.SpecialExtraLevel_5;
   import gameAll.level.extra.SpecialExtraLevel_7;
   
   public class HeroCarKey
   {

      internal var KG:KeysGroup;
      
      internal var BB:HeroCarBody;
      
      internal var mot:BodyMotion;
      
      internal var img:HeroCarImage;
      
      internal var GD:GameData;
      
      public var enabled:Boolean = true;
      
      public function HeroCarKey(_BB:*)
      {
         super();
         this.BB = _BB;
         this.img = this.BB.img;
         this.mot = this.BB.mot;
         this.KG = Game.keysGroup;
         this.GD = Game.gameData;
      }
      
      public function keyTimer() : *
      {
         var kA:Keys = null;
         var kD:Keys = null;
         var kW:Keys = null;
         var kS:Keys = null;
         if(!this.BB.ai.enabled)
         {
            if(this.enabled)
            {
               kA = this.KG.arr[this.KG.getBinding("moveLeft")];
               kD = this.KG.arr[this.KG.getBinding("moveRight")];
               kW = this.KG.arr[this.KG.getBinding("jump")];
               kS = this.KG.arr[this.KG.getBinding("interact")];
               if(kA.state == kD.state)
               {
                  if(kA.s == "up" || kD.s == "up")
                  {
                     this.BB.toStop();
                  }
                  else if(kA.s == "down" && kD.s == "downing")
                  {
                     this.BB.moveToLeft();
                  }
                  else if(kD.s == "down" && kA.s == "downing")
                  {
                     this.BB.moveToRight();
                  }
               }
               else if(kA.state == "downing")
               {
                  this.BB.moveToLeft();
               }
               else
               {
                  this.BB.moveToRight();
               }
               if(kS.s == "down")
               {
                  if(Game.LG.level.supplyB == 1)
                  {
                     Game.uiGroup.showSupply();
                  }
                  else if(Game.LG.level.supplyB == 2)
                  {
                     Game.LG.level.gotoPortal();
                  }
               }
               if(kW.s == "down")
               {
                  this.toJump();
               }
               this.attackKey(this.KG);
            }
         }
      }
      
      public function toJump() : *
      {
         var bb12:Boolean = false;
         var bb13:Boolean = false;
         if(this.BB.mot.getFloorB())
         {
            this.BB.mot.toJump();
            Game.EG.addEffect("car","jet_effect",Game.gameSprite.effectL,this.img.x,this.img.y);
         }
         else
         {
            if(this.BB.consumeAirGravity())
            {
               this.BB.mot.toAirGravity();
               Game.EG.addEffect("car","jet_effect",Game.gameSprite.effectL,this.img.x,this.img.y);
            }
         }
      }

      public function toAIJump() : *
      {
         if(this.BB.mot.toLimitedAirJump(4))
         {
            Game.EG.addEffect("car","jet_effect",Game.gameSprite.effectL,this.img.x,this.img.y);
         }
      }
      
      private function attackKey(KG:KeysGroup) : *
      {
         var knum:Keys = null;
         var index0:int = 0;
         var kQ:Keys = KG.arr[Keyboard.Q];
         var kE:Keys = KG.arr[Keyboard.E];
         var kF:Keys = KG.arr[Keyboard.F];
         var k1:Keys = KG.arr[49];
         var k2:Keys = KG.arr[50];
         var k3:Keys = KG.arr[51];
         var k4:Keys = KG.arr[52];
         var kSpace:Keys = KG.arr[Keyboard.SPACE];
         var bb14:Boolean = Game.LG.level is SpecialExtraLevel_5;
         for(var n:int = 0; n < 8; n++)
         {
            knum = KG.arr[KG.weaponKeys[n]];
            index0 = n;
            if(knum.s == "down")
            {
               if(!bb14)
               {
                  Game.eventGroup.changArms(index0);
               }
            }
         }
         this.skillKey(KG);
      }
      
      public function skillKey(KG:KeysGroup) : *
      {
         var n:* = undefined;
         var s0:OneSkill = null;
         var d0:SkillDefine = null;
         var code0:int = 0;
         var key0:Keys = null;
         var openB0:Boolean = false;
         var closeB0:Boolean = false;
         var bb0:Boolean = false;
         var arr0:Array = this.BB.skill.dataArr;
         for(n in arr0)
         {
            s0 = arr0[n];
            d0 = s0.define;
            if(d0.name == "jump" && this.KG.getBinding("jump") == this.KG.getBinding("jumpSkill"))
            {
               continue;
            }
            code0 = int(KG.skillKeys[s0.define.name]);
            if(code0 <= 0)
            {
               code0 = int(Keyboard[s0.define.key]);
            }
            key0 = KG.arr[code0];
            openB0 = false;
            closeB0 = false;
            if(d0.keyEvent == "clickOpen")
            {
               if(key0.s == "down")
               {
                  openB0 = true;
               }
            }
            else if(d0.keyEvent == "clickOpen_clickClose")
            {
               if(key0.s == "down")
               {
                  if(s0.timeUseB)
                  {
                     closeB0 = true;
                  }
                  else
                  {
                     openB0 = true;
                  }
               }
            }
            else if(d0.keyEvent == "downOpen_upClose")
            {
               if(key0.s == "downing")
               {
                  openB0 = true;
               }
               else if(key0.s == "up")
               {
                  closeB0 = true;
               }
            }
            if(openB0)
            {
               bb0 = s0.getUseB();
               if(bb0)
               {
                  this.useSkill(s0);
               }
            }
            else if(closeB0)
            {
               s0.closeSkill();
            }
         }
      }
      
      public function useSkillName(name0:String) : Boolean
      {
         var s0:OneSkill = this.BB.skill.getSkill(name0);
         return this.useSkill(s0);
      }
      
      private function useSkill(s0:OneSkill) : Boolean
      {
         var bb22:Boolean = false;
         var bb24:Boolean = false;
         var bb12:Boolean = false;
         var bb13:Boolean = false;
         var bb15:Boolean = false;
         var bb0:Boolean = s0.getUseB();
         if(!bb0)
         {
            return false;
         }
         var d0:SkillDefine = s0.define;
         var l_d0:OneLevelSkillDefine = s0.levelDefine;
         var name0:String = d0.name;
         var isArenaB:Boolean = Game.LG.level is ArenaLevel;
         if(name0 == "jump")
         {
            if(this.mot.getFloorB())
            {
               return false;
            }
            if(this.BB.consumeAirGravity())
            {
               this.mot.toAirGravity();
               Game.EG.addEffect("car","jet_effect",Game.gameSprite.effectL,this.img.x,this.img.y);
               return true;
            }
            return false;
         }
         else
         {
            if(name0 == "rocket")
            {
               bb22 = Game.LG.level is SpecialExtraLevel_2 && this.BB.skill.getSkill("rocket").getUseNum() >= 3;
               bb24 = Game.LG.level is SpecialExtraLevel_7;
               if(!this.BB.getSpeedUpB())
               {
                  this.BB.speedUp();
                  s0.useSkill();
               }
               return true;
            }
            if(name0 == "plasma")
            {
               bb12 = Game.LG.level is SpecialExtraLevel_2 && this.BB.skill.getSkill("plasma").getUseNum() >= 3;
               bb13 = Game.LG.level is SpecialExtraLevel_1 && this.BB.skill.getSkill("plasma").getUseNum() >= 3;
               bb15 = Game.LG.level is SpecialExtraLevel_7 || Game.LG.level is JuneExtraLevel;
               if(bb12 || bb13 || bb15)
               {
                  return false;
               }
               if(!this.BB.getPlasmaB())
               {
                  this.BB.openPlasma(s0.time_t);
                  s0.useSkill();
                  return true;
               }
            }
            else if(name0 == "change")
            {
               trace("isArenaB:" + isArenaB);
               if(this.img.bodyState == "stand")
               {
                  this.BB.changeState("fly",s0.levelDefine.maxTime);
                  s0.useSkill();
                  return true;
               }
            }
            else if(name0 == "lighting")
            {
               Game.BG.skill.fullLighting(s0.levelDefine.hurt);
               s0.useSkill();
               return true;
            }
         }
         return false;
      }
   }
}

