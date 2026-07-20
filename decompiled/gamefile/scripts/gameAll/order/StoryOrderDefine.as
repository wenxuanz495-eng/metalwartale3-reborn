package gameAll.order
{
   import enemy._die.DieDelayGroup;
   
   public class StoryOrderDefine
   {
      
      public var index:int = 0;
      
      public var trigger:String = "";
      
      public var body:String = "";
      
      public var action:String = "";
      
      public var overTime:Number = 5;
      
      public var overAction:String = "";
      
      public var b0:*;
      
      public var state:String = "no";
      
      public var now_t:Number = 0;
      
      public function StoryOrderDefine()
      {
         super();
      }
      
      public function inData_byXML(xml0:*) : *
      {
         this.trigger = String(xml0.@trigger);
         this.body = String(xml0.@body);
         this.action = String(xml0.@action);
         if(String(xml0.@overTime) != "")
         {
            this.overTime = int(xml0.@overTime);
         }
         if(this.trigger == "")
         {
            this.trigger = "catch:" + (this.index - 1);
         }
         if(Boolean(this.action.indexOf("say")) && String(xml0.@overTime) == "")
         {
            this.overTime = this.action.length / 4;
            if(this.overTime < 2)
            {
               this.overTime = 2;
            }
            if(this.overTime > 8)
            {
               this.overTime = 8;
            }
         }
      }
      
      public function toString() : *
      {
         return "【" + this.index + "】【" + this.body + "】【" + this.action + "】【" + this.overTime + "】";
      }
      
      public function doAction() : *
      {
         if(this.state == "no")
         {
            trace("执行事件：" + this.toString());
            this.state = "ing";
            if(this.body == "hero")
            {
               this.b0 = Game.BG.hero;
            }
            else
            {
               this.b0 = Game.BG.getEnemy_byName(this.body,this.body);
            }
            trace("              寻找目标：" + this.b0);
            this.doOne(this.action);
         }
      }
      
      public function doOverAction() : *
      {
         this.state = "over";
         this.doOne(this.overAction);
         this.b0 = null;
      }
      
      private function doOne(str0:String) : *
      {
         var s0:String = null;
         var s1:String = null;
         var s11:String = null;
         var s12:String = null;
         if(str0 == "")
         {
            return;
         }
         if(Boolean(this.b0))
         {
            s0 = str0.split(":")[0];
            s1 = str0.split(":")[1];
            s11 = s1.split(",")[0];
            s12 = s1.split(",")[1];
            if(s0 == "say")
            {
               Game.dialogboxGroup.showDialog(this.b0,s1,null,this.overTime);
            }
            else if(s0 == "order")
            {
               if(s11 == "stopAttack")
               {
                  DieDelayGroup.stopAttack(this.b0,s12);
               }
               else if(s1 == "startAttack")
               {
                  DieDelayGroup.startAttack(this.b0);
               }
               else if(s1 == "stopDie")
               {
                  DieDelayGroup.stopDie(this.b0);
               }
               else if(s1 == "die")
               {
                  DieDelayGroup.startDie(this.b0);
               }
            }
         }
      }
   }
}

