thesis:
	@pdflatex $@
	@bibtex $@
	@pdflatex $@
	@pdflatex $@
	@pdflatex $@

clean:
	rm -rf *.pdf
	find . -type f \( -name "*.aux" -o -name "*.log" -o -name "*.lof" -o -name "*.lot" -o -name "*.out" -o -name "*.toc" -o -name "*.bbl" -o -name "*.blg" \) -exec rm {} \;

