#
# Makefile
# prashant, 2021-08-19 14:25
#

a: compile do
	
compile:
	cd resume-short/ && xelatex prashant_resume.tex
	cd cv-long/ && pdflatex CV.tex
	
do:
	cp cv-long/CV.pdf prashant-full.pdf 
	cp resume-short/prashant_resume.pdf prashant-short.pdf
	
	scp prashant-short.pdf prashant:/home/prashant/rails_prashant.at/public/files
	scp prashant-full.pdf prashant:/home/prashant/rails_prashant.at/public/files 

# vim:ft=make
#

