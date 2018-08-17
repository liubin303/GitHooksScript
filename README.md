# GitHooksScript
GitHooksScript使用GitHook机制在提交代码时对代码进行一些初步的检查,主动帮助开发人员发现一些明显的编码风格问题或者潜在风险。

## Git Hook 介绍

官方文档：[Git Hook](https://git-scm.com/book/zh/v2/%E8%87%AA%E5%AE%9A%E4%B9%89-Git-Git-%E9%92%A9%E5%AD%90)

[Git Hooks (1)：介绍 ](https://segmentfault.com/a/1190000000356485) 

[Git Hooks (2)：脚本分类](https://segmentfault.com/a/1190000000356487)

按照Git Hooks脚本所在的位置可以分为两类：

本地Hooks，触发事件如commit、merge等。

服务端Hooks，触发事件如receive等。

服务器端的hooks我们没有办法利用，只能利用Git的客户端钩子功能，在本地commit或push时执行自定义脚本，对提交的改动做检查，防止逻辑错误或不合规范的代码更新到远端仓库中。

## GitHooksScript 

### 基础能力

1. 本地commit时对提交内容的检查能力。
2. 检查规则可自由扩展，可以是shell、ruby或者Python脚本。
3. 检查规则团队同步，通过脚本一次性配置。

### 检查规则

| 规则名 | 描述 | 级别 |
| --- | --- | --- |
| ImageName检查 | 检查[UIImage imageNamed:]时是否使用的静态常量做为图片名 | error |
| OBJC_ASSOCIATION_ASSIGN检查 | 检查是否有使用OBJC_ASSOCIATION_ASSIGN来做属性绑定的关键字 | error |

### 如何使检查生效
1. 将本工程的githooks文件夹拷贝到你的工程的根目录（别忘记提交到远端给团队内的其他同学使用）
2. 进入githooks文件夹，运行install.sh



