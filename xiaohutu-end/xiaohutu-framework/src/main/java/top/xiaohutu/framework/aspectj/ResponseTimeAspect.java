package top.xiaohutu.framework.aspectj;

import lombok.extern.slf4j.Slf4j;
import org.aspectj.lang.ProceedingJoinPoint;
import org.aspectj.lang.annotation.Around;
import org.aspectj.lang.annotation.Aspect;
import org.springframework.stereotype.Component;

@Aspect
@Component
@Slf4j
public class ResponseTimeAspect {
     @Around("execution(* top.xiaohutu.*.controller..*(..))") // 修改为你的包路径
    public Object logExecutionTime(ProceedingJoinPoint joinPoint) throws Throwable {
        long startTime = System.currentTimeMillis();

        // 执行目标方法
        Object proceed = joinPoint.proceed();

        long duration = System.currentTimeMillis() - startTime;
        log.warn(joinPoint.getSignature() + " executed in " + duration + " ms");

        return proceed;
    }
}
