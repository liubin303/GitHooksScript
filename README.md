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
2. 检查规则分级能力，error会阻止提交，warning提交时会有提示。
2. 检查规则可通过json匹配文件扩展，扩展方式友好、快捷。
3. 检查规则团队同步，通过脚本自动配置。

### 初始化
1. 将本工程的githooks文件夹拷贝到你的工程的根目录（别忘记提交到远端给团队内的其他同学使用）
2. 进入githooks文件夹，运行install.sh


### 添加检查规则

1.拷贝checkRuleTemplate.json文件至pre-commit-rules文件夹并重新命名。
2.配置详细的检查规则，配置文件内容如下，fileExtentions是需要检查的文件类型集合，patterns是需要检查的正则表达式集合，level是检查的级别。
```
{
    "name": "CheckRuleName",
    "description": "检查是否包含abc",
    "fileExtentions": [
      ".h",
      ".m"
    ],
    "patterns": [
      ".*a.*",
      ".*b.*",
      ".*c.*"
    ],
    "level": "error or warning", 
    "message": "禁止使用abc,请修改后提交",
    "author": "刘彬"
  }
````







