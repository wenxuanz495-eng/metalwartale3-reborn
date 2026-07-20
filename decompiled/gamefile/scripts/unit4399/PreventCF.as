package unit4399
{
   public class PreventCF
   {
      
      public static var instance:PreventCF;
      
      private var varObj:Object;
      
      private var cout:int = 0;
      
      public function PreventCF()
      {
         super();
         if(PreventCF.instance != null)
         {
            throw new Error("只能实例一次！");
         }
         PreventCF.instance = this;
      }
      
      public static function getInstance() : PreventCF
      {
         if(instance == null)
         {
            instance = new PreventCF();
         }
         return instance;
      }
      
      public function setAttributeByFun(varName:String, opFun:Function) : Number
      {
         var tmpVal:* = undefined;
         if(isNaN(this.getAttribute(varName)))
         {
            tmpVal = 0;
         }
         else
         {
            tmpVal = this.getAttribute(varName);
         }
         var tmpVal2:* = opFun(tmpVal);
         this.setAttribute(varName,tmpVal2);
         return this.getAttribute(varName);
      }
      
      public function setAttribute(varName:String, varValue:*) : *
      {
         var i:* = undefined;
         if(!(varValue is Number) && !(varValue is Boolean))
         {
            return;
         }
         var tmpObj:Object = new Object();
         tmpObj = {"value":varValue};
         var tmpObj2:Object = new Object();
         for(i in this.varObj)
         {
            tmpObj2[i] = this.varObj[i];
         }
         tmpObj2[varName] = tmpObj.value;
         tmpObj = null;
         this.varObj = null;
         this.varObj = tmpObj2;
      }
      
      public function getAttribute(varName:String) : *
      {
         if(this.varObj == null || this.varObj[varName] == undefined)
         {
            return Number.NaN;
         }
         var tmpObj:Object = new Object();
         tmpObj.value = this.varObj[varName];
         return tmpObj.value;
      }
   }
}

