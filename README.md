
# RPG Maker MV 游戏图标错误及其解决方法

有些时候当你打开一个RPG Maker MV的游戏的时候，你可能会发现其窗口图标不正确。游戏的窗口图标是你玩的上一个RPG Maker MV游戏的图标。本文将尝试解释这个现象的原理及其解决方法。

* [直接看解决方法](#解决方法)

# 原理解释

RPG Maker MV 引擎是基于 nw.js 制作的。因此引擎会将很多的游戏数据储存在同一个 “chromium游览器” 的文件夹里面。

```
%USERPROFILE%\AppData\Local\User Data\Default
```

如果游戏根目录的 `package.json` 和游戏文件夹 `www` 下的 `package.json` 没有设置一个独一无二的 `name`

```jsonc
// 例如
{
    "name": "", // 不填写任何字符
    // or
    "name": "mygame", // 使用重复名字
    // ...
}
```

那么游戏引擎会将游戏的窗口图标给缓存到上面提到的chromium引擎文件夹下，并且会让所有其他没有正确设置 `name` 的游戏都使用同其窗口图标。

# 例子

1. 我先打开游戏A，看到其窗口图标。

![game_a_title.png](./res/game_a_title.png)

* 游戏A图标文件:

![game_a_icon.png](./res/game_a_icon.png)

* 游戏A `package.json`:

```jsonc
// package.json
{
    "name": "",
    "main": "www/index.html",
    "js-flags": "--expose-gc",
    "window": {
        "title": "",
        "toolbar": false,
        "width": 816,
        "height": 624,
        "icon": "www/icon/icon.png"
    }
}

// www/package.json
{
    "name": "",
    "main": "index.html",
    "js-flags": "--expose-gc",
    "window": {
        "title": "",
        "toolbar": false,
        "width": 816,
        "height": 624,
        "icon": "icon/icon.png"
    }
}
```

* 我们可以看到游戏A的两个 `package.json` 文件都没有设置一个独一无二的 `name` 值，不过游戏A可以正确的显示图标。

2. 我们接着打开游戏B

![game_b_title.png](./res/game_b_title.png)

* 游戏B图标文件:

![game_b_icon.png](./res/game_b_icon.png)

* 游戏B `package.json`:

```jsonc
// package.json
{
    "name": "",
    "main": "www/index.html",
    "js-flags": "--expose-gc",
    "window": {
        "title": "",
        "toolbar": false,
        "width": 816,
        "height": 624,
        "icon": "www/icon/icon.png"
    }
}

// www/package.json
{
    "name": "",
    "main": "index.html",
    "js-flags": "--expose-gc",
    "window": {
        "title": "",
        "toolbar": false,
        "width": 816,
        "height": 624,
        "icon": "icon/icon.png"
    }
}
```

此时，游戏B的图标为游戏A的图标。引擎使用了之前缓存在chromium引擎文件夹下的游戏A的图标，游戏B窗口图标错误。

# 解决方法

* 这些方法应该是可以作用于RPG Maker MZ的游戏的，MZ和MV都是基于nw.js做的。

## 方法1：修改游戏 `package.json`：

如果我们为游戏B的两个 `package.json` 填上一个名字，游戏B就可以加载正确的图标。

```jsonc
// package.json
{
    "name": "same random name",
    "main": "www/index.html",
    "js-flags": "--expose-gc",
    "window": {
        "title": "",
        "toolbar": false,
        "width": 816,
        "height": 624,
        "icon": "www/icon/icon.png"
    }
}

// www/package.json
{
    "name": "same random name",
    "main": "index.html",
    "js-flags": "--expose-gc",
    "window": {
        "title": "",
        "toolbar": false,
        "width": 816,
        "height": 624,
        "icon": "icon/icon.png"
    }
}
```

* **请注意，两个 `package.json` 必须有相同的 `name` 值。**

![game_b_title_2.png](./res/game_b_title_2.png)

* 我们可以看到现在游戏B的窗口图标变为正确的图标了。

## 方法2：清理chromium引擎缓存的图标：

如果你不想更改游戏文件，你也可以清理chromium引擎缓存的图标。

在引擎文件夹下

```
%USERPROFILE%\AppData\Local\User Data\Default
```

游戏窗口图标将被存在两个文件和一个文件夹下

* 所有图标的sqite3数据库 `Favicons`
* 所有图标的sqite3数据库档案文件 `Favicons-journal`
* 图标文件在文件夹 `Web Applications` 下面

只需要删除这两个文件和一个文件夹，就可以强行使游戏读取其自身的图标。

请注意：如果新游戏的 `package.json` 还是没有设置一个独一无二的 `name`，那么游戏引擎会将新游戏的图标给缓存到上述文件夹下。

我写的 Powershell Script [RPGMakerMV-icon-cleaner.ps1](./RPGMakerMV-icon-cleaner.ps1) 可以自动寻找图标缓存文件并删除。直接用Powershell运行就行了。


