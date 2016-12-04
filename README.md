### wetech
wetech project for cms branch.
 
 此项目为Maven聚合项目，主要分为以下子模块：
 

    1.  wetech-parent 是所有子模块的父类，同时也是项目聚合器，无实质代码
    2.   wetech-basic-common 主要是放一些通用工具类
    3.  wetech-basic-hibernate 对hibernate进行封装，目前就放了IBaseDao和BaseDao
    4.   wetech-core 项目核心模块，用来放POJO、DAO对象，以及ORM映射


如何启动项目：
    
    1. 打开终端
    2. cd wetech-web
    3. mvn jetty:run