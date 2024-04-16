# data

`unicode-chars-ver.csv` comes from "Unicode Character Database in XML" version 15.1.0

# 產生 `unicode-chars-ver.csv` 的方法

先從 Unicode 網站下載 `ucd.all.flat.xml`

    Unihan2.chars_ver('temp/ucd.all.flat.xml', 'temp/unicode-chars-ver.csv')
