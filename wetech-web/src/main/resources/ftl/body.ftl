<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<#macro indexChannelTopicList indexTopics dateFormat="yyyy-MM-dd" grid=6>
<#assign gridSum =0>
<#list indexTopics as channelTopic>
<#if gridSum=0>
<div class="am-g am-g-fixed  cms-fixed">
</#if>
	<div class="am-u-md-${grid} am-u-sm-12">
		<div data-am-widget="titlebar" class="am-titlebar am-titlebar-default">
			<h2 class="am-titlebar-title ">${channelTopic.cname}</h2>
			<nav class="am-titlebar-nav">
				<a href="channel/${channelTopic.cid}" class="">more &raquo;</a>
			</nav>
		</div>
		<div data-am-widget="list_news" class="am-list-news am-list-news-default">
			<!--列表标题-->
			<ul class="am-list">
				<#list channelTopic.topics as topic>
				<li class="am-g am-list-item-desced am-list-item-thumbed am-list-item-thumb-left">
					<div class="am-u-sm-3 am-list-thumb">
						<a href="topic/${topic.id}"> <img src="${topic.thumb!'http://s.amazeui.org/media/i/demos/bing-1.jpg'}" alt="${topic.title}" />
						</a>
					</div>
					<div class=" am-u-sm-9 am-list-main">
						<a class="am-channel-title" href="topic/${topic.id}">${topic.title}</a> 
						<span class="am-channel-date">${(topic.publishDate)?string("yyyy-MM-dd")}</span>
						<div class="am-list-item-text">${topic.summary}</div>
					</div>
				</li>
				</#list>
			</ul>
		</div>
	</div>
	<#-- 网格总长度累加  -->
	<#assign gridSum = gridSum+grid>
	<#-- 如果大于等于12，就换行 -->
	<#if gridSum gte 12>
		<#-- 统计清零 -->
		<#assign gridSum = 0>
</div>
	</#if>
</#list>
</#macro>
<div class="am-g am-g-fixed am-u-sm-centered">
	<!-- banner start -->
	<jsp:include page="/jsp/template/banner.jsp" />
	<!-- banner end -->
	<div class="am-u-md-4 am-u-sm-12">
		<div data-am-widget="list_news" class="am-list-news am-list-news-default">
			<!--列表标题-->
            <div class="am-list-news-hd am-cf">
                <!--带更多链接-->
                <h2><span class="am-icon-send-o"></span>&nbsp;&nbsp;置顶文章</h2>
            </div>
			<div class="am-list-news-bd">
				<ul class="am-list">
				<#list news as new>
					<li class="am-g am-list-item-dated"><a href="topic/${new.id}" class="am-list-item-hd ">${new.title}</a> <span class="am-list-date">${(new.publishDate)?string("yyyy-MM-dd")}</span></li>
				</#list>
				</ul>
			</div>
		</div>
	</div>
</div>
<!-- channel start -->
<@indexChannelTopicList indexTopics=channelTopics/>
<!-- channel end -->
<!-- last topic start -->
<div class="am-g am-g-fixed cms-fixed">
    <div class="am-u-md-8">
        <div data-am-widget="list_news" class="am-list-news am-list-news-default am-no-layout">

            <div class="am-list-news-hd am-cf">

                <h2>
                    <span class="am-icon-list-ul"></span> 最新文章
                </h2>
            </div>
            <div class="am-list-news-bd">

                <ul class="am-list" id="topicList"></ul>
                <div class="am-g am-text-middle" id="loading"></div>
            </div>

        </div>
    </div>
    <div class="am-u-md-4">

        <div class="am-panel-group am-hide-sm-only">
            <section class="am-panel am-panel-default">
                <div class="am-panel-hd">推荐阅读</div>
                <ul class="am-list blog-list">

                    <li><a href="topic/86">硅谷看到特朗普上台还有些好处：能省下一大笔税</a></li>

                    <li><a href="topic/82">你好，这个是测试文章</a></li>

                    <li><a href="topic/65">被禁入华澳乳企老板来自中国 被曝使用过期奶粉</a></li>

                    <li><a href="topic/63">孵化器倒闭潮来临？数量太多创业者不够用</a></li>

                    <li><a href="topic/64">四五百元平衡车靠谱吗？成本都要七八百！</a></li>

                    <li><a href="topic/62">为了让妹子在冬天穿迷你裙露大腿，日本人足足用了100多年</a></li>

                </ul>
            </section>
            <section class="am-panel am-panel-default">
                <div class="am-panel-hd">标签云</div>
                <div class="am-panel-bd">
				<#list keywords as kw>
                    <a href="keyword/${kw.name}" class="am-badge am-badge-primary am-text-sm am-radius ${keywordClzs[kw_index]}">${kw.name}</a>
				</#list>
				</div>
            </section>
        </div>
    </div>
</div>
<!-- last topic end -->
<!-- keyword start -->
<#--<div class="am-g am-g-fixed  cms-fixed">
	<div class="am-u-sm-12" style="margin-top: 2rem;">
		<#list keywords as kw>
		<a href="keyword/${kw.name}" class="am-badge am-badge-primary am-text-sm am-radius ${keywordClzs[kw_index]}">${kw.name}</a>
		</#list>
	</div>
</div>-->
<!-- keyword end -->