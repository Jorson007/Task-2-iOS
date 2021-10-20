# Task-2-iOS
环信MQTT实时图表Demo
使用说明：
1.从git上拉取代码，进入项目所在文件夹，命令行执行pod install安装依赖库；
2.双击NWRTChartDemo.xcworkspace文件，用xcode打开工程，运行代码进入主页面；
3.点击Add按钮可添加柱状图，点击Clear按钮可清空图表；
3.点击对应的每一根柱子都会增加柱子的高度，左侧y轴对应的就是柱子的点击次数；

注：NWRTMainViewController 类的 __loadConfiguation方法里访问环信消息云的appid、username、password请自行前往环信官网注册使用，参考文档：https://docs-im.easemob.com/mqtt/qsiossdk
