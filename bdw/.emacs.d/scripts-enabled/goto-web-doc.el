(require 'ido)

(setq web-docs
      '(
	("UBS Personal Login" .
	 "https://ebanking-ch2.ubs.com/workbench/WorkbenchOpenAction.do?login&isiwebuserid=11577856&goTo=challengeResponse&NavLB_EBCH=1495811740"
	 )
	("UBS Spreadie" .
	 "https://docs.google.com/spreadsheets/d/1sj74zChZKqyhDtROJOF7TmwwLTBxm_WgpmCVZoFp3Gg/edit#gid=0")
	("WebSite Brief Questionnaire / Discovery Document" .
	 "https://docs.google.com/document/d/1jDO_T9EfU9KDnJQqGnPXl3P0CsLX-nvquy1rjLt8uAE/edit"
	 )
	("Ruby Refactor Mode" .
	 "https://github.com/ajvargo/ruby-refactor")
	("Setuid Setgid sticky bit" . "https://www.thegeekdiary.com/what-is-suid-sgid-and-sticky-bit/")
	("Dispatch Service" . "https://cloud.scorm.com/docs/api_reference/dispatch.html")
	("rspec-matchers" . "https://relishapp.com/rspec/rspec-expectations/docs/built-in-matchers")
	("windows-and-registers" . "https://www.emacswiki.org/emacs/WindowsAndRegisters")
	("rspec-core" . "http://www.rubydoc.info/gems/rspec-core/rspec")
	("rspec Let function" . "http://www.betterspecs.org/#let")
	("Accounts Receivable" . "https://docs.google.com/spreadsheets/d/1ifzU6ppBjDOdou2xN793vBzPqwBlZoO8QnRWqMPNwCI/edit#gid=0")
	("factory girl" .
	 "https://github.com/thoughtbot/factory_bot/blob/master/GETTING_STARTED.md")
	("SCORM Cloud API" .
	 "https://cloud.scorm.com/docs/advanced/communication.html")
	("API best practices" .
	 "http://www.vinaysahni.com/best-practices-for-a-pragmatic-restful-api#advanced-queries")
	("nagios" .
	 "http://nagios.aura-software.com:10080/cgi-bin/nagios3/status.cgi?host=all&servicestatustypes=28&hoststatustypes=15")
	("IDO" .
	 "https://www.emacswiki.org/emacs/InteractivelyDoThings")
	("Customers Google Drive" .
	 "https://drive.google.com/drive/u/0/folders/0B-zD-uSbTXH4SnFYWS1JelhUWWlyU19VVF83b05fQQ"
	 )
	("Nagios Cron Monit Spam" .
	 "https://mail.google.com/mail/u/0/#search/nagios+OR+monit+OR+cron"
	 )
	("Sales Board" .
	 "https://code.aura-software.com/bretweinraub/sales/boards"
	 )
	("Gitlab Issues" .
	 "https://code.aura-software.com/dashboard/issues")
	("SCORM Cloud Pricing" .
	 "https://scorm.com/scorm-solved/scorm-cloud-pricing"
	 )
	("Hello sign document signing" .
	 "https://app.hellosign.com/home/manage"
	 )
	("Bright API Docs".
	 "https://github.com/bretweinraub/bright-api-doc/blob/master/v2_api_controller.md"
	 )
	(
	 "Creative Commons Attribution" .
	 "https://creativecommons.org/licenses/by-nd/3.0/"
	 )
	(
	 "Ckuru Tools" .
	 "https://engineering.aura-software.com/2017/04/13/ckurutools-helpers/")
	("AR Billable Accounts Information Collections" .
	 "https://docs.google.com/spreadsheets/d/1ifzU6ppBjDOdou2xN793vBzPqwBlZoO8QnRWqMPNwCI/edit#gid=0"
	 )
	("Total Bright/Aura Tests" .
	 "https://docs.google.com/spreadsheets/d/1E4S6MwLyGFkZwVgLSvSHBAJGNcvOI3qrTuLB_RdV5pA/edit#gid=0")
	("Chase Info" .
	 "https://docs.google.com/spreadsheets/d/1SSD5muE8iZGZ6H-orxIXjGwyzy3JXHD3FJRidUt5hOE/edit"
	 )
	("GitLab Markdown" .
	 "https://gitlab.com/gitlab-org/gitlab-ce/blob/master/doc/user/markdown.md")
	("Ruby % Commands" .
	 "https://simpleror.wordpress.com/2009/03/15/q-q-w-w-x-r-s/")
	("Ruby Quick Reference" .
	 "http://www.zenspider.com/ruby/quickref.html#table-of-contents"	 
	 )
	)
      )
      
(defun goto-web-doc () 
  "Use ido mode to search an alist, and then go to the selected item in the
browser" 
  (interactive) 
  (browse-url (cdr (assoc (ido-completing-read "Pick a web doc? " (sort (mapcar 'car web-docs) 'string<))
			  web-docs)
		   )))


(global-set-key [3 103] (quote goto-web-doc))
