package gameAll.order
{
   public class StoryOrderDefineGroup
   {
      
      public var arr:Array = [];
      
      public function StoryOrderDefineGroup()
      {
         super();
      }
      
      public function inData_byXML(xml0:XML) : *
      {
         var n2:* = undefined;
         var story0:StoryOrderDefine = null;
         this.arr.length = 0;
         var s_xml0:* = xml0.storyOrder.story;
         for(n2 in s_xml0)
         {
            story0 = new StoryOrderDefine();
            story0.index = int(n2);
            story0.inData_byXML(s_xml0[n2]);
            this.arr.push(story0);
         }
      }
      
      public function findOrderBodyTrigger(b0:*, str0:String) : *
      {
         var n:* = undefined;
         var s0:StoryOrderDefine = null;
         var n0:String = null;
         var type0:String = b0.type;
         var name0:String = b0.define.name;
         for(n in this.arr)
         {
            s0 = this.arr[n];
            n0 = s0.trigger.split(":")[1];
            if(n0 == type0 || n0 == name0)
            {
               if(s0.trigger.indexOf(str0) >= 0)
               {
                  return s0;
               }
            }
         }
         return null;
      }
      
      public function findOrderTrigger(trigger0:String) : *
      {
         var n:* = undefined;
         var s0:StoryOrderDefine = null;
         for(n in this.arr)
         {
            s0 = this.arr[n];
            if(s0.trigger == trigger0)
            {
               return s0;
            }
         }
         return null;
      }
      
      public function FTimer() : *
      {
         var n:* = undefined;
         var s0:StoryOrderDefine = null;
         var s1:StoryOrderDefine = null;
         for(n in this.arr)
         {
            s0 = this.arr[n];
            if(s0.state != "over")
            {
               if(s0.state == "ing")
               {
                  s0.now_t += 1 / 6;
                  if(s0.now_t >= s0.overTime)
                  {
                     s0.doOverAction();
                     s1 = this.findOrderTrigger("catch:" + s0.index);
                     if(Boolean(s1))
                     {
                        s1.doAction();
                     }
                  }
               }
            }
         }
      }
   }
}

