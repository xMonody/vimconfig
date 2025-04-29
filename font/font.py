#!/usr/bin/env python3
import argparse
import sys
from fontTools import ttLib
from fontTools.ttLib import TTFont
from fontTools.ttLib.tables._n_a_m_e import NameRecord

# 扩展的 CJK Unicode 范围
CJK_UNICODE_RANGES = [
    (0x4E00, 0x9FFF),    # CJK Unified Ideographs
    (0x3400, 0x4DBF),    # CJK Extension A
    (0x20000, 0x2A6DF),  # CJK Extension B
    (0x2A700, 0x2B73F),  # CJK Extension C
    (0x2B740, 0x2B81F),  # CJK Extension D
    (0x2B820, 0x2CEAF),  # CJK Extension E
    (0x2CEB0, 0x2EBEF),  # CJK Extension F
    (0x30000, 0x3134F),  # CJK Extension G
    (0x31350, 0x323AF),  # CJK Extension H
    (0xF900, 0xFAFF),    # Compatibility Ideographs
    (0x3300, 0x33FF),    # CJK Compatibility
    (0xFE30, 0xFE4F),    # CJK Compatibility Forms
    (0x3040, 0x309F),    # Hiragana
    (0x30A0, 0x30FF),    # Katakana
    (0x31F0, 0x31FF),    # Katakana Phonetic Extensions
    (0xFF65, 0xFF9F),    # Halfwidth Katakana
    (0x3000, 0x303F),    # CJK Symbols and Punctuation
    (0x3200, 0x32FF),    # Enclosed CJK Letters and Months
    (0x2E80, 0x2EFF),    # CJK Radicals Supplement
]

def is_cjk_char(codepoint):
    """检查字符是否在 CJK 范围内"""
    return any(lo <= codepoint <= hi for lo, hi in CJK_UNICODE_RANGES)

def get_cjk_glyphs(font):
    """获取字体中所有 CJK 相关的字形"""
    cjk_glyphs = set()
    for table in font["cmap"].tables:
        if not table.isUnicode():
            continue
        for codepoint, glyph_name in table.cmap.items():
            if is_cjk_char(codepoint):
                cjk_glyphs.add(glyph_name)
    return cjk_glyphs

def expand_glyphs(font, glyph_names):
    """递归扩展复合字形"""
    glyf = font["glyf"]
    expanded = set()
    stack = list(glyph_names)
    
    while stack:
        glyph_name = stack.pop()
        if glyph_name in expanded or glyph_name not in glyf:
            continue
        
        expanded.add(glyph_name)
        glyph = glyf[glyph_name]
        
        if glyph.isComposite():
            for component in glyph.components:
                if component.glyphName not in expanded:
                    stack.append(component.glyphName)
    
    return expanded

def ensure_required_tables(font):
    """确保字体包含所有必需的表"""
    required_tables = {
        "cmap": lambda: ttLib.newTable("cmap"),
        "glyf": lambda: ttLib.newTable("glyf"),
        "hmtx": lambda: ttLib.newTable("hmtx"),
        "maxp": lambda: ttLib.newTable("maxp"),
        "post": lambda: ttLib.newTable("post"),
        "head": lambda: ttLib.newTable("head"),
        "hhea": lambda: ttLib.newTable("hhea"),
        "name": lambda: ttLib.newTable("name"),
    }
    
    for table_name, creator in required_tables.items():
        if table_name not in font:
            font[table_name] = creator()
    
    # 初始化必要表数据
    if "maxp" in font:
        font["maxp"].numGlyphs = len(font.getGlyphOrder())
    if "hhea" in font:
        font["hhea"].numberOfHMetrics = len(font["hmtx"].metrics)

def copy_glyphs(source_font, target_font, glyph_names, overwrite=False):
    """复制字形及相关数据"""
    # 确保目标字体包含所有必需的表
    ensure_required_tables(target_font)
    
    # 检查设计单位是否一致
    if source_font["head"].unitsPerEm != target_font["head"].unitsPerEm:
        print("警告: 源字体和目标字体的 unitsPerEm 不一致，可能导致缩放问题", file=sys.stderr)
    
    # 复制字形数据
    for glyph_name in glyph_names:
        if glyph_name not in source_font["glyf"]:
            continue
            
        if not overwrite and glyph_name in target_font["glyf"]:
            continue
            
        # 复制 glyf 数据
        target_font["glyf"][glyph_name] = source_font["glyf"][glyph_name]
        
        # 复制 hmtx 数据
        if glyph_name in source_font["hmtx"].metrics:
            target_font["hmtx"].metrics[glyph_name] = source_font["hmtx"].metrics[glyph_name]
    
    # 复制 cmap 映射
    for table in source_font["cmap"].tables:
        if not table.isUnicode():
            continue
            
        for codepoint, glyph_name in table.cmap.items():
            if glyph_name in glyph_names:
                # 找到或创建对应的目标表
                target_table = None
                for t in target_font["cmap"].tables:
                    if t.platformID == table.platformID and t.platEncID == table.platEncID:
                        target_table = t
                        break
                
                if target_table is None:
                    target_table = ttLib.newTable("cmap")
                    target_table.platformID = table.platformID
                    target_table.platEncID = table.platEncID
                    target_table.language = table.language
                    target_table.cmap = {}
                    target_font["cmap"].tables.append(target_table)
                
                target_table.cmap[codepoint] = glyph_name

def update_font_names(font, family_name, style_name="Regular"):
    """更新字体命名信息"""
    name_table = font["name"]
    
    # 生成各种名称变体
    full_name = f"{family_name} {style_name}"
    ps_name = f"{family_name.replace(' ', '')}-{style_name.replace(' ', '')}"
    
    # NameID 映射
    name_ids = {
        1: family_name,    # Font Family name
        2: style_name,     # Font Subfamily name
        4: full_name,      # Full font name
        6: ps_name,       # PostScript name
        16: family_name,  # Typographic Family name
        17: style_name,   # Typographic Subfamily name
    }
    
    # 更新现有记录
    for record in name_table.names:
        if record.nameID in name_ids:
            try:
                if record.platformID == 3:  # Windows
                    record.string = name_ids[record.nameID].encode("utf-16be")
                else:  # Mac
                    record.string = name_ids[record.nameID].encode("mac_roman")
            except UnicodeEncodeError:
                record.string = name_ids[record.nameID].encode("utf-8")
    
    # 确保必要记录存在
    required_records = [
        (1, 3, 1, 0x0409),  # Windows US English
        (2, 3, 1, 0x0409),
        (4, 3, 1, 0x0409),
        (6, 3, 1, 0x0409),
        (16, 3, 1, 0x0409),
        (17, 3, 1, 0x0409),
    ]
    
    existing = {(r.nameID, r.platformID, r.platEncID, r.langID) for r in name_table.names}
    
    for name_id, platform_id, encoding_id, lang_id in required_records:
        if (name_id, platform_id, encoding_id, lang_id) not in existing and name_id in name_ids:
            record = NameRecord()
            record.nameID = name_id
            record.platformID = platform_id
            record.platEncID = encoding_id
            record.langID = lang_id
            
            if platform_id == 3:  # Windows
                record.string = name_ids[name_id].encode("utf-16be")
            else:  # Mac
                record.string = name_ids[name_id].encode("mac_roman")
            
            name_table.names.append(record)

def main():
    parser = argparse.ArgumentParser(
        description="合并 CJK 字形到 Nerd Font，并保留原有 Nerd Font 图标"
    )
    parser.add_argument("cjk_font", help="包含 CJK 字形的源字体文件")
    parser.add_argument("nerd_font", help="目标 Nerd Font 文件")
    parser.add_argument("-o", "--output", required=True, help="输出字体文件")
    parser.add_argument("--family-name", help="自定义字体家族名称")
    parser.add_argument("--style-name", default="Regular", help="字体样式名称")
    parser.add_argument("--overwrite", action="store_true", help="覆盖目标字体中已存在的字形")
    args = parser.parse_args()

    # 加载字体
    print(f"加载字体: {args.cjk_font} 和 {args.nerd_font}")
    cjk_font = TTFont(args.cjk_font)
    nerd_font = TTFont(args.nerd_font)

    # 获取 CJK 字形
    print("收集 CJK 字形...")
    cjk_glyphs = get_cjk_glyphs(cjk_font)
    if not cjk_glyphs:
        print("错误: 源字体中没有找到 CJK 字形", file=sys.stderr)
        sys.exit(1)
    
    print(f"找到 {len(cjk_glyphs)} 个 CJK 字形")

    # 扩展复合字形
    print("扩展复合字形...")
    expanded_glyphs = expand_glyphs(cjk_font, cjk_glyphs)
    print(f"扩展后总计 {len(expanded_glyphs)} 个字形")

    # 复制字形到目标字体
    print("复制字形到目标字体...")
    copy_glyphs(cjk_font, nerd_font, expanded_glyphs, args.overwrite)

    # 更新字体名称
    family_name = args.family_name if args.family_name else \
        f"{nerd_font['name'].getName(1, 3, 1).toStr()} CJK"
    print(f"更新字体名称为: {family_name}")
    update_font_names(nerd_font, family_name, args.style_name)

    # 优化输出
    print("优化输出字体...")
    if "DSIG" in nerd_font:  # 完全移除数字签名
        del nerd_font["DSIG"]
    nerd_font["maxp"].numGlyphs = len(nerd_font.getGlyphOrder())
    
    # 检查所有表是否有效
    for tag in list(nerd_font.keys()):
        if nerd_font[tag] is None:
            print(f"警告: 移除无效的表 {tag}")
            del nerd_font[tag]

    # 保存字体
    print(f"保存到: {args.output}")
    try:
        nerd_font.save(args.output)
        print("合并完成!")
    except Exception as e:
        print(f"保存失败: {str(e)}", file=sys.stderr)
        sys.exit(1)

if __name__ == "__main__":
    main()
