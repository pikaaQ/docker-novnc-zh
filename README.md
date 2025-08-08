# docker-novnc-zh
docker-novnc-zh是一个中文linux桌面环境docker镜像.主要包含:
1. ubuntu + xfce4桌面
2. vnc + novnc实现web访问
3. 中文环境 + 中文输入法
4. novnc双向剪切板支持, 剪切板中文支持
5. firefox浏览器(非snap版)
6. 修改apt源地址
7. noVNC增加集成音频，开箱即用

启动内存400M, 浏览器轻度使用内存600M-800M, 正常使用建议有2G内存.

如果你本身有ubuntu要安装上面内容, 可以参考dockerfile中的脚本, 可以避免一些坑(虽然但是应该没有人会拒绝docker吧).

### 自己打镜像

如果你在墙内进行打包, 请使用inside分支. inside分支在最开始就修改了国内源, 并使用国内git镜像.
```
cd ./docker && docker build -t pikaaq/vnc .
```
现在本镜像已经上传到dockerhub, 你也可以直接拉取, 本地没有镜像时运行启动命令也会自动拉取.

### ~~(原神)~~ 启动

#### 简单启动
```
docker run -itd --rm -p 6080:6080 pikaaq/vnc
```
即可在浏览器访问6080端口进入web桌面, 默认密码是password, 分辨率1280x800.


#### 其他参数

* `VNC_PASSWORD` 登录密码
* `RESOLUTION` 分辨率

```
docker run -itd \
           --name desktop \
           -e VNC_PASSWORD=password \
           -e RESOLUTION=1600x1200 \
           -p 6080:6080 \
           -p 5901:5901 \
           pikaaq/vnc
```

### Tips
1. 输入法切换快捷方式建议换成`shift+空格`之类, 避免使用Ctrl/Alt/Tab导致不能流畅使用(novnc不能很好兼容或本地热键冲突)
2. vnc内部选中就会贴到剪切板上, 输入到剪切板就可以在vnc内部粘贴
3. firefox可在设置中选择并安装中文语言
999. 觉得不错麻烦动动发财的小手⁠给个star吧
