package unit4399.singleTimer
{
   public class TimerTaskRunErrorType
   {
      
      public static const TIME_SHORT:String = "添加任务的时间间隔太短";
      
      public static const INTERVAL_SHORT:String = "设置的最小时间间隔太短";
      
      public static const DEL_ID_ERROR:String = "删除不存在的任务";
      
      public static const RUN_FUNC_ERROR:String = "Observer没有初始化";
      
      public static const OBSERVER_NOT_CONTEXT:String = "Observer没有设置context";
      
      public static const OBSERVER_NOT_FUNC:String = "Observer没有设置Func";
      
      public function TimerTaskRunErrorType()
      {
         super();
      }
   }
}

