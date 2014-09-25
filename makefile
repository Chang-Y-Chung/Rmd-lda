stata:=/Applications/Stata/StataSE.app/Contents/MacOS/StataSE
fn:=sample

show: $(fn).pdf
	open $(fn).pdf

$(fn).pdf: $(fn).html
	pandoc $(fn).html -o $(fn).pdf --latex-engine=xelatex

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

