---
title: 你好，世界
date: 2026-10-15 12:00:00
categories:
  - 随笔
tags:
  - 
  -
---

欢迎来到我的博客。这是第一篇示例文章，用来验证站点能正常生成和渲染。

## 这一篇是怎么写出来的

在博客根目录执行：

```bash
hexo new post "文章标题"
```

然后就会在 `source/_posts/` 下生成一个 Markdown 文件，写内容就行。前面 `---` 包起来的部分是「front-matter」，用来写标题、日期、分类和标签。

## 支持代码高亮

```javascript
// 代码块会自动高亮
const greet = (name) => `你好，${name}！`;
console.log(greet('世界'));
```

## 支持表格

| 项目 | 说明 |
| --- | --- |
| Hexo | 静态博客生成器，基于 Node.js |
| 主题 | 本博客用 Fluid，也可一键换成 Redefine |
| 部署 | 本地生成静态文件，再丢给服务器 / GitHub Pages |

写完之后，本地预览：

```bash
hexo server
```

浏览器打开 <http://localhost:4000> 即可。
