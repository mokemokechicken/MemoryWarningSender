= これはなに？

本プログラムは、iOS シミュレータのプラグインです。メモリー警告(MemoryWarning)を繰り返し送ることができます(5秒、15秒、60秒毎)。

メモリ警告はユーザのiOS端末内で予測不能なタイミングで発生します。このプラグインは、そのような状況のテストに役立ちます。

= 必要なもの

* SIMBL(0.9.9 or later): http://www.culater.net/software/SIMBL/SIMBL.php

* 以下の環境でのみテストしています
** MacOS X Mountain Lion 10.8.2
** XCode 4.5

= インストール

MemoryWarningSender.pkg を実行してください。
次のディレクトリにインストールされます。
	"~/Library/Application\ Support/SIMBL/Plugins/MemoryWarningSender.bundle" 

= 使い方

iOS シミュレータ メニュー -> ハードウェア -> メモリ警告を繰り返し送る -> ＜モード選択＞

