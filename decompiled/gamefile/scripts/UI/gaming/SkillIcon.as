package UI.gaming
{
   import body.skill.*;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.text.TextField;
   
   public class SkillIcon extends Sprite
   {
      
      public var timeBar:*;
      
      public var sector:MovieClip;
      
      public var numTxt:TextField;
      
      public var icon:MovieClip;
      
      public var boader:MovieClip;
      
      public var keyTxt:TextField;
      
      public function SkillIcon()
      {
         super();
         this.icon.stop();
         this.boader.stop();
         this.sector.stop();
         this.sector.visible = false;
         this.mouseChildren = false;
         this.mouseEnabled = false;
      }
      
      public function init(d0:SkillDefine) : *
      {
         this.icon.gotoAndStop(d0.name);
         this.keyTxt.text = d0.key;
         if(this.keyTxt.text == "SPACE")
         {
            this.keyTxt.text = "空格";
         }
         if(d0.key.length > 2)
         {
            this.boader.gotoAndStop(2);
         }
         else
         {
            this.boader.gotoAndStop(1);
         }
         this.numTxt.visible = false;
         this.timeBar.visible = false;
         if(d0.skillType == "number")
         {
            this.numTxt.visible = true;
         }
         else if(d0.skillType == "time")
         {
            this.timeBar.visible = true;
            this.showSector(0);
         }
      }
      
      public function inData(da0:OneSkill) : *
      {
         this.numTxt.text = String(da0.nowNum);
         if(da0.define.skillType == "number")
         {
            if(da0.cool_t == -1)
            {
               this.sector.visible = false;
            }
            else
            {
               this.sector.visible = true;
               this.showSector(da0.getCoolPer());
            }
            if(da0.define.name == "change")
            {
               if(da0.time_t > 0)
               {
                  this.timeBar.visible = true;
                  this.setBar(1 - da0.getTimePer());
               }
               else
               {
                  this.timeBar.visible = false;
               }
            }
            if(da0.levelDefine.maxNum == 0)
            {
               this.sector.visible = true;
               this.showSector(0);
            }
         }
         else
         {
            this.setBar(da0.getTimePer());
            if(da0.time_t <= 0)
            {
               this.sector.visible = true;
               this.showSector(0);
            }
            else
            {
               this.sector.visible = da0.cool_t != -1;
               this.showSector(da0.getCoolPer());
            }
         }
      }
      
      private function showSector(baifen:Number) : *
      {
         var frame0:int = int(baifen * 360) + 1;
         this.sector.gotoAndStop(frame0);
      }
      
      private function setBar(baifen:Number) : *
      {
         this.timeBar.mc.scaleX = baifen;
      }
   }
}

