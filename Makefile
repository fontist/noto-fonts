#!make
SHELL ?= /bin/bash
ifdef ComSpec
	PATHSEP2 := \\
else
	PATHSEP2 := /
endif
PATHSEP := $(strip $(PATHSEP2))

LATN := \
	NotoSans-Black.ttf \
	NotoSans-BlackItalic.ttf \
	NotoSans-Bold.ttf \
	NotoSans-BoldItalic.ttf \
	NotoSans-ExtraBold.ttf \
	NotoSans-ExtraBoldItalic.ttf \
	NotoSans-ExtraLight.ttf \
	NotoSans-ExtraLightItalic.ttf \
	NotoSans-Italic.ttf \
	NotoSans-Light.ttf \
	NotoSans-LightItalic.ttf \
	NotoSans-Medium.ttf \
	NotoSans-MediumItalic.ttf \
	NotoSans-Regular.ttf \
	NotoSans-SemiBold.ttf \
	NotoSans-SemiBoldItalic.ttf \
	NotoSans-Thin.ttf \
	NotoSans-ThinItalic.ttf \
	NotoSerif-Black.ttf \
	NotoSerif-BlackItalic.ttf \
	NotoSerif-Bold.ttf \
	NotoSerif-BoldItalic.ttf \
	NotoSerif-ExtraBold.ttf \
	NotoSerif-ExtraBoldItalic.ttf \
	NotoSerif-ExtraLight.ttf \
	NotoSerif-ExtraLightItalic.ttf \
	NotoSerif-Italic.ttf \
	NotoSerif-Light.ttf \
	NotoSerif-LightItalic.ttf \
	NotoSerif-Medium.ttf \
	NotoSerif-MediumItalic.ttf \
	NotoSerif-Regular.ttf \
	NotoSerif-SemiBold.ttf \
	NotoSerif-SemiBoldItalic.ttf \
	NotoSerif-Thin.ttf \
	NotoSerif-ThinItalic.ttf \
	NotoSansMono-Black.ttf \
	NotoSansMono-Bold.ttf \
	NotoSansMono-ExtraBold.ttf \
	NotoSansMono-ExtraLight.ttf \
	NotoSansMono-Light.ttf \
	NotoSansMono-Medium.ttf \
	NotoSansMono-Regular.ttf \
	NotoSansMono-SemiBold.ttf \
	NotoSansMono-Thin.ttf \
	NotoColorEmoji.ttf

CJK_STATIC_SANS := \
	NotoSansHK-Regular.otf \
	NotoSansHK-Bold.otf \
	NotoSansJP-Regular.otf \
	NotoSansJP-Bold.otf \
	NotoSansKR-Regular.otf \
	NotoSansKR-Bold.otf \
	NotoSansSC-Regular.otf \
	NotoSansSC-Bold.otf \
	NotoSansTC-Regular.otf \
	NotoSansTC-Bold.otf

CJK_STATIC_SERIF := \
	NotoSerifHK-Regular.otf \
	NotoSerifHK-Bold.otf \
	NotoSerifJP-Regular.otf \
	NotoSerifJP-Bold.otf \
	NotoSerifKR-Regular.otf \
	NotoSerifKR-Bold.otf \
	NotoSerifSC-Regular.otf \
	NotoSerifSC-Bold.otf \
	NotoSerifTC-Regular.otf \
	NotoSerifTC-Bold.otf

CJK_STATIC_MONO_HK := \
	NotoSansMonoCJKhk-Regular.otf \
	NotoSansMonoCJKhk-Bold.otf

CJK_STATIC_MONO_JP := \
	NotoSansMonoCJKjp-Regular.otf \
	NotoSansMonoCJKjp-Bold.otf

CJK_STATIC_MONO_KR := \
	NotoSansMonoCJKkr-Regular.otf \
	NotoSansMonoCJKkr-Bold.otf

CJK_STATIC_MONO_SC := \
	NotoSansMonoCJKsc-Regular.otf \
	NotoSansMonoCJKsc-Bold.otf

CJK_STATIC_MONO_TC := \
	NotoSansMonoCJKtc-Regular.otf \
	NotoSansMonoCJKtc-Bold.otf

CJK_STATIC_MONO_ZIPS := \
	11_NotoSansMonoCJKjp.zip \
	12_NotoSansMonoCJKkr.zip \
	13_NotoSansMonoCJKsc.zip \
	14_NotoSansMonoCJKtc.zip \
	15_NotoSansMonoCJKhk.zip

CJK_VF := \
	NotoSansCJK-VF.ttf.ttc \
	NotoSerifCJK-VF.ttf.ttc \
	NotoSansMonoCJKjp-VF.ttf

FONTS_LATN := $(addprefix fonts-latn/,$(LATN))
FONTS_CJK_VF := $(addprefix fonts-cjk-vf/,$(CJK_VF))
FONTS_CJK_STATIC := \
	$(addprefix fonts-cjk-static/,$(CJK_STATIC_SANS)) \
	$(addprefix fonts-cjk-static/,$(CJK_STATIC_SERIF)) \
	$(addprefix fonts-cjk-static/,$(CJK_STATIC_MONO_HK)) \
	$(addprefix fonts-cjk-static/,$(CJK_STATIC_MONO_JP)) \
	$(addprefix fonts-cjk-static/,$(CJK_STATIC_MONO_KR)) \
	$(addprefix fonts-cjk-static/,$(CJK_STATIC_MONO_SC)) \
	$(addprefix fonts-cjk-static/,$(CJK_STATIC_MONO_TC))

all: noto-fonts-latn.zip noto-fonts-cjk-static.zip noto-fonts-cjk-vf.zip

test:

clean:
	rm -rf noto-fonts-*.zip fonts-latn fonts-cjk-static fonts-cjk-vf tmp

distclean: clean
	rm -rf .archive

noto-fonts-latn.zip: $(FONTS_LATN)
	zip -9 -r $@ fonts-latn

noto-fonts-cjk-vf.zip: $(FONTS_CJK_VF)
	zip -9 -r $@ fonts-cjk-vf

noto-fonts-cjk-static.zip: $(FONTS_CJK_STATIC)
	zip -9 -r $@ fonts-cjk-static

fonts-%:
	mkdir -p $(subst /,$(PATHSEP),$@)

fonts-latn/NotoSans-%: | fonts-latn
	curl -ssL -o $@ https://github.com/googlefonts/noto-fonts/raw/main/hinted/ttf/NotoSans/$(notdir $@)

fonts-latn/NotoSansMono-%: | fonts-latn
	curl -ssL -o $@ https://github.com/googlefonts/noto-fonts/raw/main/hinted/ttf/NotoSansMono/$(notdir $@)

fonts-latn/NotoSerif-%: | fonts-latn
	curl -ssL -o $@	https://github.com/googlefonts/noto-fonts/raw/main/hinted/ttf/NotoSerif/$(notdir $@)

fonts-latn/NotoColorEmoji.ttf: fonts-latn
	curl -ssL -o $@ https://github.com/googlefonts/noto-emoji/blob/main/fonts/NotoColorEmoji.ttf

fonts-cjk-vf/NotoSansCJK-VF.ttf.ttc fonts-cjk-vf/NotoSansMonoCJKjp-VF.ttf: .archive/noto-sans-cjk-vf.zip | fonts-cjk-vf
	mkdir -p tmp/noto-sans-cjk; \
	unzip -j $< '*$(notdir $@)' -d tmp/noto-sans-cjk ; \
	cp tmp/noto-sans-cjk/$(notdir $@) $@

fonts-cjk-vf/NotoSerifCJK-VF.ttf.ttc: .archive/noto-serif-cjk-vf.zip | fonts-cjk-vf
	mkdir -p tmp/noto-serif-cjk; \
	unzip -j $< '*$(notdir $@)' -d tmp/noto-serif-cjk ; \
	cp tmp/noto-serif-cjk/$(notdir $@) $@

$(addprefix fonts-cjk-static/,$(CJK_STATIC_SANS)): .archive/noto-sans-cjk-static.zip | fonts-cjk-static
	mkdir -p tmp/noto-sans-cjk-static; \
	unzip -j $< '*$(notdir $@)' -d tmp/noto-sans-cjk-static ; \
	cp tmp/noto-sans-cjk-static/$(notdir $@) $@

$(addprefix fonts-cjk-static/,$(CJK_STATIC_SERIF)): .archive/noto-serif-cjk-static.zip | fonts-cjk-static
	mkdir -p tmp/noto-serif-cjk-static; \
	unzip -j $< '*$(notdir $@)' -d tmp/noto-serif-cjk-static ; \
	cp tmp/noto-serif-cjk-static/$(notdir $@) $@

$(addprefix fonts-cjk-static/,$(CJK_STATIC_MONO_HK)): .archive/noto-mono-cjk-static-hk.zip | fonts-cjk-static
	mkdir -p tmp/noto-mono-cjk-static; \
	unzip -j $< '*$(notdir $@)' -d tmp/noto-mono-cjk-static ; \
	cp tmp/noto-mono-cjk-static/$(notdir $@) $@

$(addprefix fonts-cjk-static/,$(CJK_STATIC_MONO_JP)): .archive/noto-mono-cjk-static-jp.zip | fonts-cjk-static
	mkdir -p tmp/noto-mono-cjk-static; \
	unzip -j $< '*$(notdir $@)' -d tmp/noto-mono-cjk-static ; \
	cp tmp/noto-mono-cjk-static/$(notdir $@) $@

$(addprefix fonts-cjk-static/,$(CJK_STATIC_MONO_KR)): .archive/noto-mono-cjk-static-kr.zip | fonts-cjk-static
	mkdir -p tmp/noto-mono-cjk-static; \
	unzip -j $< '*$(notdir $@)' -d tmp/noto-mono-cjk-static ; \
	cp tmp/noto-mono-cjk-static/$(notdir $@) $@

$(addprefix fonts-cjk-static/,$(CJK_STATIC_MONO_SC)): .archive/noto-mono-cjk-static-sc.zip | fonts-cjk-static
	mkdir -p tmp/noto-mono-cjk-static; \
	unzip -j $< '*$(notdir $@)' -d tmp/noto-mono-cjk-static ; \
	cp tmp/noto-mono-cjk-static/$(notdir $@) $@

$(addprefix fonts-cjk-static/,$(CJK_STATIC_MONO_TC)): .archive/noto-mono-cjk-static-tc.zip | fonts-cjk-static
	mkdir -p tmp/noto-mono-cjk-static; \
	unzip -j $< '*$(notdir $@)' -d tmp/noto-mono-cjk-static ; \
	cp tmp/noto-mono-cjk-static/$(notdir $@) $@


tmp:
	mkdir -p $@

.archive:
	mkdir -p $@

.archive/noto-sans-cjk-vf.zip: | .archive
	curl -ssL -o $@ https://github.com/googlefonts/noto-cjk/releases/download/Sans2.004/02_NotoSansCJK-TTF-VF.zip

.archive/noto-serif-cjk-vf.zip: | .archive
	curl -ssL -o $@ https://github.com/googlefonts/noto-cjk/releases/download/Serif2.001/03_NotoSerifCJK-TTF-VF.zip

.archive/noto-sans-cjk-static.zip: | .archive
	curl -ssL -o $@ https://github.com/googlefonts/noto-cjk/releases/download/Sans2.004/05_NotoSansCJK-SubsetOTF.zip

.archive/noto-serif-cjk-static.zip: | .archive
	curl -ssL -o $@ https://github.com/googlefonts/noto-cjk/releases/download/Serif2.001/06_NotoSerifCJKSubsetOTF.zip

.archive/noto-mono-cjk-static-hk.zip: | .archive
	curl -ssL -o $@ https://github.com/googlefonts/noto-cjk/releases/download/Sans2.004/15_NotoSansMonoCJKhk.zip

.archive/noto-mono-cjk-static-jp.zip: | .archive
	curl -ssL -o $@ https://github.com/googlefonts/noto-cjk/releases/download/Sans2.004/11_NotoSansMonoCJKjp.zip

.archive/noto-mono-cjk-static-kr.zip: | .archive
	curl -ssL -o $@ https://github.com/googlefonts/noto-cjk/releases/download/Sans2.004/12_NotoSansMonoCJKkr.zip

.archive/noto-mono-cjk-static-sc.zip: | .archive
	curl -ssL -o $@ https://github.com/googlefonts/noto-cjk/releases/download/Sans2.004/13_NotoSansMonoCJKsc.zip

.archive/noto-mono-cjk-static-tc.zip: | .archive
	curl -ssL -o $@ https://github.com/googlefonts/noto-cjk/releases/download/Sans2.004/14_NotoSansMonoCJKtc.zip

# version:
# 	echo "${JAR_VERSION}"

.PHONY: all clean distclean test
