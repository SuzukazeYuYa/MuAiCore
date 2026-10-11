## 安装
1.下载本仓库内容，将2个文件夹MuAiCore和TensorReactions放入 \Minionapp\Bots\FFXIVMinion64\LuaMods 中覆盖即可。
<img width="918" height="390" alt="image" src="https://github.com/user-attachments/assets/51ec7fd3-67db-46c4-b070-1fbeec8316ca" />

<br>2.进入游戏并注入之后，在profiler中添加 MuAiCore
<br>$${\color{red}注意，请勿使用名称为“Optifine”配置文件，这个配置无法添加，如一定要使用，请克隆一个！}$$
<br>![image](https://github.com/user-attachments/assets/3b6e7b7c-1365-47fa-b066-383b4a7b4e3f)
<br>重新加载后会得到如下
<br><img width="465" height="471" alt="image" src="https://github.com/user-attachments/assets/7ee15be2-4719-44dd-adb6-8c0d06e91d93" />
<br>可以通过点击这里开启插件页面，当然这与使用快捷键打开时一样的（如果你没有proflier跳过此步骤）
<br>$${\color{red}3.继承对应的时间轴等详见下面的 副本支持模块的说明。}$$
<br>$${\color{red}4.请严格检查继承关系，观察时间节点是否有重复内容，出现重复将导致大量指路BUG!}$$
##  更新
可以通过如下方式进行插件/时间轴更新：
<br>1.纯覆盖式重装，下载本仓库内容覆盖即可。
<br>2.游戏内通过本工具UI进行更新。
<br>![image](https://github.com/user-attachments/assets/a817bf0b-e0f6-4bb7-ac60-3bae417ea936)
<br>$${\color{red}如果你想使用游戏内更新，请勿随意更改文件路径}$$
<br>$${\color{red}更新过程会短暂卡屏，属于正常现象，如果无法更新，请手动覆盖}$$
<br>$${\color{red}本仓库提交记录即为更新日志，查看方式如下，请根据日志内容判断当前版本！}$$
<img width="912" height="309" alt="image" src="https://github.com/user-attachments/assets/a0340bcd-8d44-400e-b142-feb900975a93" />
<br>$${\color{red}3.勾选自动更新（注意此功能对网络要求比较严格，github下载速度慢的慎用），勾选后会在mini注入时候自动检查并更新。}$$

### 更新分支（String 分支新增）

在“基本”设置中选择“更新分支”。新配置和没有该选项的旧配置默认使用作者主分支 `main`，可继续选择 GitHub 或腾讯云下载源。

选择“String 测试分支”并确认提醒后，后续更新改为从本仓库的 `dmu-String` 分支下载。此分支有时是测试版本，可能出现 bug，但可以提前体验最新功能；目前仅支持 GitHub 下载。切换只保存选择，实际覆盖须点击更新按钮。String 分支的版本号相同也可能有新提交，可点击“更新 String 分支”获取最新内容；其更新日志链接指向该分支的提交记录。

切回 `main` 时会再次提醒：下次更新将使用作者主分支脚本，String 的额外功能会被替换，但更新设置和分支选择入口会继续保留。之后仍可在“基本”设置中选择 String 测试分支、确认提醒并进行更新，无需手动重装。两种分支更新都使用安装事务和失败回滚，保留本地配置。

切换分支后，如作者主分支版本号与当前相同，可点击“检查更新”，再在提示中选择“强制更新”，以安装该分支内容。

更新渠道由独立的 `UpdateChannels.lua` 和安装器维护。安装主分支时保留这两个组件，并把入口接入新下载的作者界面；作者其他脚本与界面内容正常更新。若未来作者调整入口结构、无法可靠接入，安装器会在改动当前安装前明确终止，避免更新后丢失分支选择。

## 支持副本
<br>1、绝伊甸：事无巨细，支持日服、国服各类型打法，可以自定义站位等，继承时间轴，   MuAi\MuAiGuideFru
<br>2、绝欧米茄：国野主流的mlm标点，斜迷拉线等， 继承时间轴  MuAi\MuAiGuideTop
<br>3、M11S，中国服野队一套： 近战固定，流星雨奶远近引导点名，王者陨石L团拉线，支持斜飞和直飞（可设置），狂奔全引导，支持十字和X字（可设置），继承全局 MuAi\MuAiGeneral
<br>4、M12S，使用联合文档攻略，4运盗火改，参考下面链接，继承全局 MuAi\MuAiGeneral
<br>    门神：https://docs.qq.com/doc/DUHZiZU54ZGx5eGZV?nlc=1
<br>    本体：https://docs.qq.com/doc/DUEVnSkFnU0hqdHRt
<br>5、异闻商客奇谭，野队一套攻略
<br>6、妖星乱舞绝境战，已支持大部分指路带配套画图。
## 免责声明
本仓库内容仅供交流学习使用，如侵犯到您的权益，请及时联系！收到联系并确认有相关问题后，会在24小时内删除本页内容。



