;;; publish.el --- Build gbrlmarn.github.io/org-blog

;; Copyright (C) 2024 Gabriel Marin <marin.gabriel@protonmail.com>

;; Author: Gabriel Marin <marin.gabriel@protonmail.com>
;; Maintainer: Gabriel Marin <marin.gabriel@protonmail.com>
;; URL: https://github.com/gbrlmarn/org-blog
;; Version: 0.0.1
;; Package-Requires: ((emacs "28.2"))
;; Keywords: hypermedia, blog, feed, rss

;; This file is not part of GNU Emacs.

;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Docs License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.
;;
;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Docs License for more details.
;;
;; You should have received a copy of the GNU General Docs License
;; along with this program.  If not, see <http://www.gnu.org/licenses/>.

;;; Usage:
;; emacs -Q --script build.el

;;; Code:

;; Initialize package sources
(require 'package)

;; Set the package installation directory so that packages aren't stored in the
;; ~/.emacs.d/elpa path.
(setq package-user-dir (expand-file-name "./.packages"))

(setq package-archives '(("melpa" . "https://melpa.org/packages/")
                         ("elpa" . "https://elpa.gnu.org/packages/")))

;; Initialize the package system
(package-initialize)
(unless package-archive-contents
  (package-refresh-contents))

;; Install dependencies
(package-install 'htmlize)

;; Load the publishing system
(require 'ox-publish)

;; Custom options used for publishing
(setq make-backup-files nil      ;; Don't make backup files
      org-export-with-latex nil) ;; Don't export .tex files

;; Customize the HTML output
(setq org-html-validation-link nil            ;; Don't show validation link
      org-html-head-include-scripts nil       ;; Use our own gscripts
      org-html-head-include-default-style nil ;; Use our own styles
      org-html-head "<link rel=\"stylesheet\" href=\"https://cdn.simplecss.org/simple.min.css\" />")

;; Define the publishing project
(setq org-publish-project-alist
      (list
       '("org-site:main"
         :recursive t
         :base-directory "./content"
         :publishing-directory "./public"
         :publishing-function org-html-publish-to-html
         :with-author nil      ;; Don't include author name
         :with-creator nil     ;; Don't include Emacs and Org versions in footer
         :with-toc nil         ;; Don't include a table of contents
         :section-numbers nil  ;; Don't include section numbers
         :time-stamp-file nil) ;; Don't include time stamp in file
       '("org-site:assets"
         :base-directory "./assets"
         :base-extension "css\\|js\\|png\\|jpg\\|gif\\|pdf\\|mp3\\|ogg\\|woff2\\|ttf\\|zip"
         :publishing-directory "./public"
         :recursive t
         :publishing-function org-publish-attachment)))

(setq org-html-validation-link nil)

;; Generate the site output
(org-publish-all t)

(message "Build complete")
;;; build.el ends here
