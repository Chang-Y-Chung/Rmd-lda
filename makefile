stata = /Applications/Stata/StataSE.app/Contents/MacOS/StataSE
pwd = /Users/cchung/Dropbox/Professional/Workshops/Stata/lda
fn = sample

show: $(fn).pdf
	open $(fn).pdf

$(fn).pdf: $(fn).html
	./ref/url2pdf --url=file://$(pwd)/$(fn).html --autosave-path=$(pwd)
	mv Untitled.pdf $(fn).pdf
#	pandoc $(fn).html -o $(fn).pdf --latex-engine=xelatex

$(fn).html: $(fn).log
	$(stata) -q -e do ./ref/weave.do

$(fn).log: $(fn).do
	$(stata) -q -e do $(fn).do

$(fn).do: $(fn)_pre.html
	./ref/html2lda.py $(fn)

$(fn)_pre.html: $(fn).Rmd
	pandoc $(fn).Rmd -o $(fn)_pre.html

clean:
	rm -f $(fn)_pre.html $(fn).do $(fn).log $(fn).html weave.log

