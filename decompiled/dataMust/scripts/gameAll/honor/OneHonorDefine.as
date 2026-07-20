package gameAll.honor
{
   public class OneHonorDefine
   {
      
      public var name:String = "";
      
      public var cnName:String = "";
      
      public var pro:String = "";
      
      public var condition:String = "";
      
      public var add:Array = [];
      
      public function OneHonorDefine()
      {
         super();
      }
      
      public function inData_byObj(param1:Object) : *
      {
         var _loc3_:* = undefined;
         var _loc4_:String = null;
         var _loc2_:Array = ["name","cnName","pro","condition"];
         for(_loc3_ in _loc2_)
         {
            _loc4_ = _loc2_[_loc3_];
            this[_loc4_] = param1[_loc4_];
         }
         this.add = this.copyArray(param1.add);
      }
      
      public function copy() : OneHonorDefine
      {
         var _loc1_:OneHonorDefine = new OneHonorDefine();
         _loc1_.inData_byObj(this);
         return _loc1_;
      }
      
      private function copyArray(param1:Array) : Array
      {
         var _loc3_:* = undefined;
         var _loc4_:* = undefined;
         var _loc2_:Array = [];
         for(_loc3_ in param1)
         {
            _loc4_ = param1[_loc3_];
            if(_loc4_ is String || _loc4_ is int || _loc4_ is Number)
            {
               _loc2_.push(_loc4_);
            }
            else if(_loc4_.hasOwnProperty("clone"))
            {
               _loc2_.push(_loc4_.clone());
            }
         }
         return _loc2_;
      }
   }
}

