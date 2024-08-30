#!/bin/sh

emacs -Q --batch --eval "(require 'org)" ./assets/cv/gmarin.org --funcall org-latex-export-to-pdf
emacs -Q --script build.el
