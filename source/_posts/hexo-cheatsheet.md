---
title: Hexo 常用命令速查
date: 2026-10-15 12:30:00
categories:
  - 教程
tags:
  - Hexo
  - 速查
---

把最常用的几条命令记在这里，免得每次都去翻文档。

## 日常写作

```bash
hexo new post "标题"      # 新建文章 → source/_posts/
hexo new page "about"     # 新建页面 → source/about/index.md
hexo new draft "草稿"     # 新建草稿，默认不发布
hexo publish "草稿"       # 把草稿转为正式文章
```

## 预览与生成

```bash
hexo server               # 本地预览，默认 http://localhost:4000
hexo server -p 5000       # 换端口
hexo generate             # 生成静态文件到 public/
hexo clean                # 清缓存和 public，改完配置建议先 clean
```

## 换主题

本博客同时装了两个主题，改根目录 `_config.yml` 里的 `theme:` 一行就行：

- `theme: fluid` —— 清爽卡片风格
- `theme: redefine` —— 更现代的 UI

改完记得 `hexo clean && hexo server`。
