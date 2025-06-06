# 写在前面
首先，感谢大家的支持。
<br>由于Reactions逻辑限制（比如代码量，行数等），有很多东西没法实现，虽然之前做好了，但是也大幅度提高炸游戏或者其他问题概率（虽然新版可能有同样问题，但是经过测试有所缓解）。
<br>基于上述原因在跟DC群友讨论之后和学习相关知识后，决定将本指路工具正式修改为插件形式实现，所以MuAiCore诞生了。
<br>当然，用开源插件的复杂程度是比直接用轴高的，但是这是没办法的事，所以请仔细阅读下面说明！
<br>$${\color{red}已添加快捷键设置，你可以定义自己喜欢的呼出方式了！！！}$$
# 安装
1.下载本仓库内容，将2个文件夹MuAiCore和TensorReactions放入 \Minionapp\Bots\FFXIVMinion64\LuaMods 中覆盖即可。
<br>2.进入游戏并注入之后，在profiler中添加 MuAiCore
<br>$${\color{red}注意，请勿使用名称为“Optifine”配置文件，这个配置无法添加，如一定要使用，请克隆一个！}$$
<br>![image](https://github.com/user-attachments/assets/3b6e7b7c-1365-47fa-b066-383b4a7b4e3f)
<br>重新加载后会得到如下（目前插件图标已修改，请以实际版本为准）
<br>![image](https://github.com/user-attachments/assets/df23e701-311c-496b-b3fb-3a42b542d89f)，安装成功后，可以通过点击这里开启插件页面，当然这与使用快捷键打开时一样的（如果你没有proflier跳过此步骤）
<br>$${\color{red}3.继承时间轴：MuAi\MuAiGuideFru(绝伊甸)  MuAi\MuAiGuideTop(绝欧) }$$
<br>$${\color{red}其他文件为减伤轴使用，请参考减伤UI上的说明进行使用 }$$
<br>$${\color{red}4.请严格检查继承关系，观察时间节点是否有重复内容，出现重复将导致大量指路BUG!}$$
# 更新
可以通过如下方式进行插件/时间轴更新：
<br>1.纯覆盖式重装，下载本仓库内容覆盖即可。
<br>2.游戏内通过本工具UI进行更新。
<br>![image](https://github.com/user-attachments/assets/a817bf0b-e0f6-4bb7-ac60-3bae417ea936)
<br>$${\color{red}如果你想使用游戏内更新，请勿随意更改文件路径}$$
<br>$${\color{red}更新过程会短暂卡屏，属于正常现象，如果无法更新，请手动覆盖}$$
<br>$${\color{red}本仓库提交记录即为更新日志，查看方式为点右上角小时钟}$$
<br>$${\color{red}3.勾选自动更新（注意此功能对网络要求比较严格，github下载速度慢的慎用），勾选后会在mini注入时候自动检查并更新。}$$
## ---------- 绝伊甸说明 ----------
## 攻略说明：
1、攻略：莫古力、日基（全局设置=>一键配置）
<br>2、其他攻略可以使用本工具的设置UI进行调整，通过设置调整基本上可以兼容绝大多数打法，如果仍然不能兼容请联系本人，会酌情考虑添加。
<br>3、指路工具表现形式为：目前位置圆圈绘制且连线到玩家角色，如果是分摊部分机制会指路到搭档身上。部分机制会指向移动物体，如撞头等。
<br>4、针对P5做了部分绘制补充：左右刀&远近死刑范围、分摊范围、挡枪当前目标以及范围。地火范围（搬运自DC,作者megaminx）

## UI说明
 1、进入副本后UI会自动弹出，如果不小心关了，可以按下ctrl+f打开、如果你需要在副本外进行设置也可以按下ctrl+f打开。
<br>$${\color{red}请务必在进本后调整小队列表，且所有人位置均正确！否则不能保证指路逻辑的正确性！！!}$$
<br>$${\color{red}如果需要修改副本设置，请尽量在开始战斗之前设置好，最好是进本之前就调好。}$$
## 主UI细节说明
![image](https://github.com/user-attachments/assets/bf5bbc0f-f639-4815-9a3d-689982f95e88)
### 一、全局设置： 
#### 1、ANYONE是否开启
比较重要，如果你没开ANYONE 一定取消勾选，这里为了不那么花，写的重复功能都关了。
<br>取消勾选后。会开启这几个anyone本来就做了的几个功能：P3 1运的，指向12点箭头、引导灯时候方向箭头、自动背对。
#### 2、2个颜色设置
这个主要是之前和anyone用了用一个颜色，结果看不到我画的线了，就简单做了2个设置，大家按照自己喜好来设置下就好。
#### 3、聊天栏输出信息
这个字面意思，就是会显示出当前计算的结果指路位置等。
![image](https://github.com/user-attachments/assets/612bf2aa-e124-4972-a282-07ec1f0331f6)
<br>我个人是习惯只在第四栏开默语和系统设置，那么就是上图的效果，属于防走神或者抓内鬼用的。

### 二、职能设置
拖动一下就可以改变优先级 目前默认优先如下。
<br>骑士 > 战士 > 黑骑 > 绝枪
<br>白魔 > 占星 > 贤者 > 学者
<br>武士 > 武僧 > 龙骑 > 忍者 > 钐镰 > 蝰蛇
<br>机工 > 诗人 > 舞者 
<br>赤魔 > 黑魔 > 绘灵 >召唤
<br>如果自动弹出之后内容和实际小队不符只能手动拖一下，只能说尽量贴近主流。

### 三、调试工具
这里是我自己的开发工具。非必要尽量乱动哈！
<br>当然有兴趣也可以玩玩，对于用户的你来说，最大的功能就是观察其他职能怎么跑位，
<br>具体方案是：使用卫月的回放，填写上职能。然后点击【设置调试视角】，然后在小队列表里面选中这个人，就可以看从他开始的指路了，当然这需要在倒计时之前就设置好中途设置总会有些奇奇怪怪的问题。

## 伊甸UI重点说明
![image](https://github.com/user-attachments/assets/f7354dec-95a1-43be-a94a-9a01720a979e)
 $${\color{red}不要被繁琐的设置吓到，这里只是为了支持各种攻略做的设置而已，实际上打本过程中进需要做少量修改就可以了。}$$
### 1、一键设置
点这几个按钮会加载默认的设置，比如莫古力，点击之后会自动载入国服的莫古力视频攻略，但是吧，比如P2光爆有田园郡式和灰9式，P3二运等多个选项的， $${\color{red}你仍需要到对应的位置进行调整以匹配你当前的队伍}$$。

### 2、P1分组抓人线这里
![image](https://github.com/user-attachments/assets/0802f4c1-a0c5-42f1-9c78-0e825aea492d)
<br>点名2个人去上还是去下有多重分配方案，这里说明下如果兼容设置，点不同组就不说了，怎么写都没影响，下面说下同组优先级问题。
<br>1.全队优先级，优先级靠前的去上，靠后的去下。那么这里填写就是顺序填写，比如：MTSTH1H2/D1234, 或者 MTH1D1D3/STH2D2D4等。直接就支持，本来我这里就是按照这个方案设计的。
<br>2.高/低优先级去另一组，比如日基，高优先级去另外一组，比如MT和H1点名，那么MT去下，这个时候，这里的设置就变成 H2H1STMT, D1D2D3D4，理由不在赘述，简单的一个逻辑题而已，总之可以灵活修改顺序以适配你得打法。

### 3、P3 2运 $${\color{red}这里可能是各类攻略不同出问题的重灾区，请检查好你使用的攻略和设置是否匹配！}$$
   （1）、这里有个选项 只有T玩家需要填写，其他人填不填都行！<br>
![image](https://github.com/user-attachments/assets/315df902-93e7-4788-9394-960c2eda035e)
<br> （2）、日基地火做了新老2个版本! 国服目前请选择 预站位 => 车头法 or 人群基准<br>
![image](https://github.com/user-attachments/assets/85d47019-e769-4c62-967b-f0b19ae16d14)
<br>  （3）、车头法在 【预站位】这个选项下面

### 其他功能比较好理解，请自行研究吧

## 免责声明
本仓库内容仅供交流学习使用，如侵犯到您的权益，请及时联系！收到联系并确认有相关问题后，会在24小时内删除本页内容。

## BUG 反馈
1、绝伊甸维护周期从发布日起截止到国服7.2零式开放，后续维护与否看心情。
<br>2、请带上截图、视频、轴的log(不是logs哈)、卫月回放等关键信息，发送到2437365584@qq.com或者添添加QQ2437365584备注BUG反馈。
<br>3、本人承诺对BUG提供人提供的信息严格保密，且不会直接或间接对BUG提供人进行举报。



