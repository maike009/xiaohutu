package top.xiaohutu;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.autoconfigure.jdbc.DataSourceAutoConfiguration;

/**
 * 启动程序
 * 
 * @author maike
 */
@SpringBootApplication(exclude = { DataSourceAutoConfiguration.class })
public class XiaoHutuApplication
{
    public static void main(String[] args)
    {
        // System.setProperty("spring.devtools.restart.enabled", "false");
        SpringApplication.run(XiaoHutuApplication.class, args);
        System.out.println("(♥◠‿◠)ﾉﾞ  小糊涂启动成功   ლ(´ڡ`ლ)ﾞ  \n" );
        
    }
}
