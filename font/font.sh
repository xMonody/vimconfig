#!/bin/bash

python3 font.py ../cn/MapleMonoNL-CN-Regular.ttf ../en/SauceCodeProNerdFontMono-Regular.ttf -o ./SauceCodeProNFM_CN-Regular.ttf --family-name "SauceCodePro NFM CN" --style-name "Regular"

python3 font.py ../cn/MapleMonoNL-CN-Italic.ttf ../en/SauceCodeProNerdFontMono-Italic.ttf -o ./SauceCodeProNFM_CN-Italic.ttf --family-name "SauceCodePro NFM CN" --style-name "Italic"

python3 font.py ../cn/MapleMonoNL-CN-Bold.ttf ../en/SauceCodeProNerdFontMono-Bold.ttf -o ./SauceCodeProNFM_CN-Bold.ttf --family-name "SauceCodePro NFM CN" --style-name "Bold"

python3 font.py ../cn/MapleMonoNL-CN-BoldItalic.ttf ../en/SauceCodeProNerdFontMono-BoldItalic.ttf -o ./SauceCodeProNFM_CN-BoldItalic.ttf --family-name "SauceCodePro NFM CN" --style-name "BoldItalic"
