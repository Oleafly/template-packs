#import "Code.typ": * //樣式代碼等
#import "Cfg.typ": * //編譯配置
//#import "Info.typ": * //
#import "InfoKeys.typ": * //訊ʹ鍵
#show: Show


#let InfoDict = (a:"1") //初始化 訊ˉ字典

#if(IsReal){ //依條件ⁿ設訊ʹ真僞
	import "InfoReal.typ":*
	InfoDict = InitInfo(InfoDict)
}else{
	import "InfoFake.typ":*
	InfoDict = InitInfo(InfoDict)
}

//個人ʹ訊
#let Name = InfoDict.at(KName)
#let Phone = InfoDict.at(KPhone)
#let Gender = InfoDict.at(KGender)
#let AvatarPath = InfoDict.at(KAvatarPath)
#let Birth = InfoDict.at(KBirth)
#let Email = InfoDict.at(KEmail)
#let School = InfoDict.at(KSchool)

//頭像
//rect默認有框、box無框。或調stroke: none使無框
#let Avatar = box(
	inset:0em
	,outset: 0em
)[
	#image(
	AvatarPath
	,height: 8em	* 0.8
	,width: 6em	* 0.8
)
]


// 	,grid.cell(
// 		colspan: 2
// 		,[GitHub: https://github.com/Tsinswreng]
// 	)


//名㕥潙全文標題
#[
	#set text(
		size: 1.8em
		,MainColor
		,stroke: 0.045em+MainColor
		,font: "STSong"
	)
	#align(center)[#Name]
]

#[

#let 左上= [
	#grid(columns: (1fr,1fr,1fr,2fr)
		,[#B[性別]: #Gender]
		,[#B[出生]: #Birth]
		,[#B[電話]: #Phone]
		,[#B[郵箱]: #Email]
		,[#Micro[籍貫: 廣西 梧州 蒙山縣]]
	)
]

	#let 左下 = [
		#grid(
			columns: (2fr,1fr,1fr,1fr, 0.0001fr)
			,[#B[學校]: 本科 #School#h(0.5em)2022\~2026]
			,[#B[專業]: 網絡工程]
			,[#B[專業排名]: 2/33]
			,[]
		)
	]

	#let NonAvatarInfo = grid(
		rows: (auto, auto)
		,row-gutter: 0.5em
		,[#左上]
		,[#左下]
	)

	
	#if(IsShowAvatar){
		grid(
			columns: (auto, auto)
			,column-gutter: 0em
			,[#NonAvatarInfo#SMain]
		)
		place(
			top+right
			,dx: -3em
			,Avatar
		)
	}else{
		NonAvatarInfo
	}
]


#H[專業技能]
#[
	#set par(spacing: 0.5em)

	#let MixSkill = [
		#Diff(Tag: TendCSharp)[#I[掌握Java, C\#, TS, JS, Python, Lua, C等編程語言; 掌握基礎數據結構與算法]]
		//瞭解各語言新特性; 瞭解C/C++, Cmake, RAII等
		
		#I[精通面向對象編程, 掌握SOLID原則及常用設計模式; 了解領域驅動設計(DDD)架構]

		#Diff[#I[熟悉Springboot, ASP.NET, Express.js等後端技術]]
		#InLineSpace #I[瞭解HTML, CSS, Vue3, 等Web前端技術]

		#I[熟練編寫SQL語句, 瞭解事務, 索引, 範式, 鎖等概念; 熟悉PostgreSql, Sqlite, Redis等數據庫]
		
		#Diff[#I[熟悉Mybatis-plus, EF Core等ORM]]
		#InLineSpace
		#Add[#I[熟悉Avalonia, WPF等GUI框架, 掌握MVVM模式]]
		//#I[熟悉多綫程及async/await異步編程]
		//#Add[#InLineSpace #I[熟悉C\# unsafe編程及P/Invoke跨語言調用]]
		//(指針, 結構體, 內存佈局等)
		//- 瞭解C/C++, cmake, RAII等

		#Diff[#I[熟練使用Git, ApiFox, DataGrip等工具; 熟悉團隊協作開發流程]]
		#I[熟悉Linux, Docker; 具有雲服務器使用經驗]
		//掌握git rebase等操作
		
		#I[瞭解計算機網絡相關知識, 包括TCP/IP, HTTPS, SNMP, 密碼學, 代理, 區塊鏈, 組網, 網絡安全等]

		//#I[掌握英語和日語, 具備良好的聽說讀寫能力, 能够流利讀寫技術文檔]
		// #I[瞭解計算機網絡相關知識, 包括OSI七層模型, TCP/IP四層模型, HTTP, HTTPS, 密碼學, 公私鑰, 證書, 網絡安全等]
		//- 熟悉Cisco Packet Tracer及GNS3網絡仿真工具
		//- 掌握基礎的路由器與交換機的配置命令
		//- 熟悉typst, markdown等文檔排版標記語言
	]


	#let CSharpSkill = [
		#Diff(Tag: TendCSharp)[#I[擅長C\#, 同時掌握Java, TS, JS, Python, Lua, C等編程語言; 掌握基礎數據結構與算法]]
		//瞭解各語言新特性; 瞭解C/C++, Cmake, RAII等
		
		#Add[#I[掌握 異步, Linq, 源生成器, AOT編譯, unsafe編程, P/Invoke跨語言調用等高級特性]]
		
		#I[精通面向對象編程, 掌握SOLID原則及常用設計模式; 了解領域驅動設計(DDD)架構]

		#Diff[#I[熟悉ASP.NET, Springboot, Express.js等後端技術]]
		#InLineSpace #I[瞭解HTML, CSS, Vue3, 等Web前端技術]

		#I[熟練編寫SQL語句, 瞭解事務, 索引, 範式, 鎖等概念; 熟悉PostgreSql, Sqlite, Redis等數據庫]
		
		#Diff[#I[熟悉EF Core, Mybatis-plus等ORM]]
		#InLineSpace
		#Add[#I[熟悉Avalonia, WPF等GUI框架, 掌握MVVM模式]]

		//#I[熟悉多綫程及async/await異步編程]
		//#Add[#InLineSpace #I[熟悉C\# unsafe編程及P/Invoke跨語言調用]]
		//(指針, 結構體, 內存佈局等)
		//- 瞭解C/C++, cmake, RAII等

		#Diff[#I[熟練使用Git, ApiFox, DataGrip等工具; 熟悉團隊協作開發流程]]#I[熟悉Linux, Docker; 具有雲服務器使用經驗]
		
		
		//掌握git rebase等操作
		
		#I[瞭解計算機網絡相關知識, 包括TCP/IP, HTTPS, SNMP, 密碼學, 代理, 區塊鏈, 組網, 網絡安全等]

		// #I[掌握英語和日語, 具備良好的聽說讀寫能力, 能够流利讀寫技術文檔]
		// #I[瞭解計算機網絡相關知識, 包括OSI七層模型, TCP/IP四層模型, HTTP, HTTPS, 密碼學, 公私鑰, 證書, 網絡安全等]
		//- 熟悉Cisco Packet Tracer及GNS3網絡仿真工具
		//- 掌握基礎的路由器與交換機的配置命令
		//- 熟悉typst, markdown等文檔排版標記語言
	]

	#let JavaSkill = [
		//TODO maven
		#Diff(Tag: TendJava)[#I[擅長Java, 同時掌握C\#, TS, JS, Python, Lua, C等編程語言; 掌握基礎的數據結構與算法]]//瞭解各語言新特性; 瞭解C/C++, Cmake, RAII等
		
		//#Add[#I[熟悉JVM内存模型, GC機制, 類加載機制; 熟悉Maven]]
		#Add[#I[掌握Java 集合, Stream API, 反射, 資源管理, 多線程, Maven等; 瞭解record, 模式匹配等新特性]]
		
		#Diff(Tag: TendJava)[#I[精通面向對象編程, 掌握SOLID原則及常用設計模式; 熟悉MVVM架構; 了解領域驅動設計(DDD)架構]]

		#Diff(Tag: TendJava)[#I[熟悉Springboot, 掌握依賴注入, 日誌, 鑑權等技術]]
		#InLineSpace #I[瞭解HTML, CSS, Vue3, 等Web前端技術]

		#I[熟練編寫SQL語句, 瞭解事務, 索引, 範式, 鎖等概念; 熟悉PostgreSql, Sqlite, Redis等數據庫], #Diff(Tag: TendJava)[熟悉Mybatis-plus]
		
		#Diff[#I[熟練使用Git, ApiFox, DataGrip, Idea等工具; 熟悉團隊協作開發流程]]#I[熟悉Linux, Docker; 具有雲服務器使用經驗]
		// #InLineSpace
		// #I[熟悉多綫程及async/await異步編程]
		//掌握git rebase等操作
		
		#I[瞭解計算機網絡相關知識, 包括TCP/IP, HTTPS, SNMP, 密碼學, 代理, 區塊鏈, 組網, 網絡安全等]

		//#I[掌握英語和日語, 具備良好的聽說讀寫能力, 能够流利讀寫技術文檔]
		// #I[瞭解計算機網絡相關知識, 包括OSI七層模型, TCP/IP四層模型, HTTP, HTTPS, 密碼學, 公私鑰, 證書, 網絡安全等]
		//- 熟悉Cisco Packet Tracer及GNS3網絡仿真工具
		//- 掌握基礎的路由器與交換機的配置命令
		//- 熟悉typst, markdown等文檔排版標記語言
	]

	#if Tendency == TendMix{
		MixSkill
	}else if Tendency == TendCSharp{
		CSharpSkill
	}else if Tendency == TendJava{
		JavaSkill
	}else{
		[=== Mix]
		MixSkill
		[=== CSharp]
		CSharpSkill
		[=== Java]
		JavaSkill
	}
	
]#SMain

#H[獎項證書]

#grid(
  columns: (2fr,1fr,1fr, 2fr,1fr,1fr),  // 定义列宽比例（1:2）
  gutter: 0.5em,          // 列间距
  //[- 大學英語四級(CET4): 575分],[2023年]
	[#I[大學英語六級(CET6)]],[553/710(分)],[2023年]
  ,[#I[學習優秀獎學金]],[二等獎],[大二, 大三]
	,[#I[日語能力測試(JLPT) N2]],[162/180(分)],[2025年]
	//,[- 機動車駕駛證(C1)],[2022年]
)#SMain



// 	,grid.cell(rowspan: 2,
// 		[]
// 	)


#H[實習經歷]

#let CompanyName = InfoDict.at(KCompanyName)
#let CompanyProjectsDescr = InfoDict.at(KCompanyProjectsDescr)
== #grid(
	columns: (1fr, 1fr, 1fr),
	[#CompanyName],[Web後端開發實習生],[#align(right)[2025.4\~2025.6]]
)
#[


#I[#CompanyProjectsDescr 兩個項目的後端開發, 主要技術棧包括Java, Spring Boot, MyBatis-Plus, MySQL, Redis, MongoDB, RocketMQ等]

#I[參與需求評審，與產品經理對接，並協同前端與測試組推進項目開發]

#I[設計並實現了Webhook消息通知模塊, 支持釘釘, 飛書, 企業微信及通用Webhook, 實現用戶增刪改查Webhook及關聯設置功能; 掃描任務完成後發送消息通知用戶]
#InLineSpace
#I[將Webhook模塊抽成公共庫, 提交公司內網倉庫, 促進復用]

#I[開發統計數據功能，實現風險項目及資產的統計數據接口，提升平台數據可視化表現]

#I[參與老項目維護, 包含接口調整與Bug修復, 保障系統穩定運行]


]#SMain

#H[個人獨立項目經歷]
#[
	//只蔿二級標題編號
	#set heading(numbering: (..nums) => {
		let level = nums.pos().len()  // 取當前標題層級
		if level == 2 {
			return numbering("1.", nums.pos().at(level - 1))
		} else {
			return none
		}
	})
	#show heading.where(level: 2): it=>{
		set text(
			size: 1.05em
			,weight: 100
			,stroke: 0.045em+MainColor
		)
		it
	}

	//段ʹ正文 往右偏移
	#show par: it => pad(left: 0.2em, it)

	#let OrmTitle = grid(
		columns: (1fr, 1fr, 1fr),
		[簡易ORM],[],[#align(right)[
			#Micro[2025.6\~2025.8]
		]]
	)
	== #box[#OrmTitle]


	#let MixSqlHelper = [
		#I[項目地址 `https://github.com/Tsinswreng/CsSqlHelper`] #Diff[#I[支持C\#和Java兩種語言]]

		
		#I[支持流式API配置表與實體並生成建表SQL語句] #InLineSpace
		#I[基于可迭代集合實現查詢結果懶加載, 節約內存]
		
		#I[支持自定義類型字段映射, 解决領域驅動設計(DDD)中值對象與始類型的映射問題]
		
		#Diff[#I[基于抽象層接口屏蔽不同數據庫及SQL方言的差異, 可適配Sqlite, PostgreSql, EFCore等多種數據庫/ORM]]
	
		#I[封裝了通用倉儲類, 提供基礎的CRUD方法]
		#I[支持軟刪除]
		#InLineSpace
		#I[事務管理]
		#InLineSpace
		#I[分頁查詢]
		
		#Diff[#I[分別基于Ado.net/JDBC/spring-jdbc實現SQL命令接口, 簡化SQL命令到字典/實體對象的映射]]

		#Add[#I[C\#版基于源生成器實現字典與對象互轉, 避免動態反射, 兼容AOT編譯]]

		#I[基于高階函數, 數據庫查詢中#Diff[使用]閉包機制進行參數化SQL預編譯, 增強復用性及提升性能]

		
	]

	#let CsSqlHelper = MixSqlHelper

	#let JavaSqlHelper = [

		#I[項目地址 `https://github.com/Tsinswreng/CsSqlHelper`] #Diff[#I[支持Java和C\#兩種語言]]

		#I[支持流式API配置表與實體並生成建表SQL語句] #InLineSpace
		#I[基于可迭代集合實現查詢結果懶加載, 節約內存]
		
		#I[支持自定義類型字段映射, 解决領域驅動設計(DDD)中值對象與始類型的映射問題]
		
		#Diff[#I[基于抽象層接口屏蔽不同數據庫及SQL方言的差異, 可適配Sqlite, PostgreSql等多種數據庫]]
	
		#I[封裝了通用倉儲類, 提供基礎的CRUD方法]
		#I[支持軟刪除]
		#InLineSpace
		#I[事務管理]
		#InLineSpace
		#I[分頁查詢]

		#Diff[#I[分別基于JDBC和spring-jdbc提供了兩套SQL命令的實現, 簡化SQL命令到字典/實體對象的映射]]

		

		#I[基于高階函數, 數據庫查詢中#Diff[便于]使用閉包機制進行參數化SQL預編譯, 增強復用性及提升性能]
		
	]

	#if Tendency == TendMix{
		MixSqlHelper
	}else if Tendency == TendCSharp{
		CsSqlHelper
	}else if Tendency == TendJava{
		JavaSqlHelper
	}else{
		[=== Mix]
		MixSqlHelper
		[=== CSharp]
		CsSqlHelper
		[=== Java]
		JavaSqlHelper
	}


	#let CsNgaq = grid(
		columns: (1fr, 1fr, 1fr),
		[跨平臺單詞記憶App],[],[#align(right)[#Micro[2025.5\~2025.7]]]
	)
	== #box[#CsNgaq]
	

	#I[項目地址 `https://github.com/Tsinswreng/CsNgaq`]#Micro[項目職責: 獨立開發]

	#I[技術棧: 後端: C\#, Asp.net, EFCore, PostgreSql, Docker, Redis; 客戶端: Avalonia, Sqlite]

	#I[客戶端使用自己開發的SqlHelper作爲ORM, 支持Windows, Linux, Android平臺, 兼容AOT編譯]

	#I[服務端使用Docker compose管理依賴, 支持容器化部署; 使用Redis實現防抖]

	#I[設計了一套單詞表標記語言及解析器, 方便用戶在純文本中記錄單詞, 并從中解析單詞對象以批量導入數據庫]
	// #I[設計了單詞表詞法解析器, ]
	// #I[设计了独特的，支持用户从文章或词典复制词汇，自动解析为结构化对象（如词头、释义和音标）。该格式使用时间块（ISO 8601格式）标记添加时间，便于后续权重计算，并支持键值对元数据（如标签和来源），提升灵活性]

	#I[設計了單詞權重算法, 基于词汇添加和學習記錄及時間计算權重, 从而动态调整学习计划，提高记忆效率]

	#I[後端支持用戶管理, 用戶密碼使用Argon哈希算法; 使用雙令牌機制, 訪問令牌採用JWT, 保障信息安全]


	#let RimeLua = grid(
		columns: (1fr, 0fr, 1fr),
		[Rime輸入法引擎的Lua擴展腳本],[],[#align(right)[#Micro[2024.1\~2024.5]]]
	)
	== #box[#RimeLua]
	#I[項目地址: `https://github.com/Tsinswreng/rime-TswG` (12 Stars#emoji.star)]
	#InLineSpace
	#I[技術棧: TypeScript, C\#, Lua] #Micro[項目職責: 獨立開發]
	
	//#I[為Rime輸入法引擎編寫Lua擴展, 最初使用純Lua編寫, 後改用TypeScript編寫並使用TsToLua工具編譯為Lua。]

	#I[使用C++/C\#調用Win32剪貼板API與Lua API, 採用AOT編譯, 將函數導出到動態庫中供Lua調用]

	#I[使用TypeScript編寫以獲得更好的面向對象支持及保障類型安全, 通過TsToLua工具編譯爲Lua嵌入輸入法引擎]

	#I[實現了動態聯想詞, 自動造詞, 輸入法命令等功能]
	//個人收穫: 熟悉了Lua腳本的編寫和調試, 掌握了TsToLua工具的使用, 提升了跨語言協同開發能力

	// == 單詞記憶網頁(ngaq)
	// - 技術棧: 前端 (TypeScript, Vue3), 後端 (TypeScript, Node.js, Express.js, SQLite)
	// - 設計了一套單詞表標記語言, 方便用戶在純文本文件中記錄單詞
	// - 設計了單詞表詞法解析器, 從文本單詞表中解析單詞對象以批量導入數據庫
	// - 單詞記憶頁面: 
	// 	- 依據單詞的添加次數、記憶情況與時間計算權重
	// 	- 支持自定義單詞權重算法, 由Webpack打包, 瀏覽器端動態加載並執行
	// - 支持多用戶, 使用JWT作身份驗證, 後端用Argon算法作密碼哈希
	// - 使用pkg將後端與前端構建產物服務打包成exe, 便於分發, 作為單機程序使用
	// 個人收穫: 熟悉了前端Vue3框架和後端Node.js/Express.js的開發流程, 掌握了JWT身份驗證和Argon密碼哈希等安全技術, 掌握了關係型數據庫的使用, 提升了全棧Web應用開發能力

	// == 基於Avalonia實現的輸入法前端(Avalime)
	// - 技術棧: C\#, Avalonia, C
	// - 項目地址: `https://github.com/Tsinswreng/Avalime`
	// - 使用Avalonia框架構建跨平台輸入法前端
	// - 後端使用開源的Rime輸入法引擎, 通過P/Invoke調用動態庫中的C接口與後端引擎交互
	//個人收穫: 掌握了Avalonia GUI框架的使用, 理解了MVVM模式, 掌握了C\# P/Invoke跨語言調用及unsafe編程
]#SMain


#H[個人評價]
#[
#I[熱愛編程, 學習能力強。個人github上最近一年有超過1000次commit]

#I[身體健康, 愛好運動。大學以來已有累積超過1200公里的跑步里程]
]#SMain

