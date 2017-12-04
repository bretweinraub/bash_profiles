;; aura stuff

(defun aura-search-docs (&optional search)
  "search the aura internal sites for a string"
  (interactive)
  (setq search (read-from-minibuffer "Search string? "))
  (mapcar (lambda (url)
	    (browse-url (concat url search) [t])
	    ) '(
		 "https://engineering.aura-software.com/search/"
		 "https://help.aura-software.com/search/"
		 "https://finance.aura-software.com/search/"
		 "http://trac.aura-software.com/aura/search?q="
		 "https://code.aura-software.com/search?utf8=%E2%9C%93&search="
		 "https://drive.google.com/drive/u/0/search?q="
		 "https://bitbucket.org/search?account=%7B989e0804-9e5c-466e-bc7d-28f71d2e9cee%7D&q="
		 "https://bitbucket.org/search?account=%7B8e505b06-f4ce-49cf-89f1-f387d9e492d2%7D&q="
		 ))
  )


(defun bulk-open (list-of-sites &optional name &optional)
  ;;
  (if name
      (browse-url (concat "http://bright.backbone.experiments/personal.html?title=" name))
    )
  (mapcar 'browse-url list-of-sites)
  )


(setq web-doc-alist
      '(
	(
	 "AvidAlly" . (
		       "https://mail.google.com/mail/u/0/#search/Eric+Korb+OR+Avid"
		       "https://code.aura-software.com/bretweinraub/sales/boards"
		       "https://drive.google.com/drive/u/0/folders/0B-zD-uSbTXH4X2x3TTl2dHNpSDg" ; AvidAlly drive
		       "https://drive.google.com/drive/u/0/folders/1Kf5U8FtyJ12P9zt1UouyCmzEZ1T7eN0k" ;; google doc ant's proposal
		      )
	 )
	(
	 "LSU" . (
		  "https://wordpress.org/plugins/document-gallery/"
		  "https://barn2.co.uk/posts-table/"
		  "https://drive.google.com/drive/u/0/folders/1c9Yjkgyrt1tRQVh9mmwSCWyvmyijcoq_"
		  )
	 )
	(
	 "CTAA/NCMM" . (
			"https://drive.google.com/drive/u/0/folders/0B-zD-uSbTXH4VGhkeDktU0dnTTQ"
			)
	 )
	(
	 "New MDT Pricing" . (
			      "https://code.aura-software.com/aura/neuro-bright-customizations/issues/10"
			      "https://drive.google.com/drive/u/0/folders/0B-zD-uSbTXH4cFNRazM3ZVEzYXM"
			      "https://code.aura-software.com/bretweinraub/sales/issues/27"
			      "https://code.aura-software.com/bretweinraub/fin3/issues/29"
			      "https://code.aura-software.com/aura/aura-quote/commit/dd5c8a1870512e8cc76610b78bd4d906683900a5"
			      )
	 )
	(
	 "Madeira" . (
		      "https://www.booking.com/hotel/pt/casa-da-graca-machico.html?aid=304142;label=gen173nr-1FCAEoggJCAlhYSDNYBGgsiAEBmAExuAEHyAEM2AEB6AEB-AECkgIBeagCAw;sid=88f78bf29a6ebaaf48db9044c2dd254c;age=12;all_sr_blocks=198559301_97026209_3_0_0;checkin=2017-12-21;checkout=2017-12-27;dest_id=2254;dest_type=region;dist=0;group_adults=2;group_children=1;hapos=15;highlighted_blocks=198559301_97026209_3_0_0;hpos=15;nflt=ht_id%3D220;no_rooms=1;req_adults=2;req_age=12;req_children=1;room1=A%2CA%2C12;sb_price_type=total;srepoch=1511817241;srfid=920775381f8ebb3cae2c736a48e587a8092ac1f8X15;srpvid=2524954c427a0017;type=total;ucfs=1&#map_closed"
		      "https://www.booking.com/searchresults.html?label=gen173nr-1FCAEoggJCAlhYSDNYBGgsiAEBmAExuAEHyAEM2AEB6AEB-AECkgIBeagCAw&sid=88f78bf29a6ebaaf48db9044c2dd254c&age=12&checkin_month=12&checkin_monthday=21&checkin_year=2017&checkout_month=12&checkout_monthday=27&checkout_year=2017&class_interval=1&dest_id=2254&dest_type=region&from_sf=1&group_adults=2&group_children=1&label_click=undef&map=1&no_rooms=1&raw_dest_type=region&room1=A%2CA%2C12&sb_price_type=total&search_selected=1&show_non_age_message=1&src=index&ss=Madeira%20Islands%2C%20Portugal&ss_raw=Madeira&ssb=empty&nflt=ht_id%3D220%3B&lsf=ht_id%7C220%7C76&unchecked_filter=hoteltype#map_opened"
		      "https://www.google.ch/maps/place/Grotta+Mangiapane+(Grotta+di+Scurati)/@38.0919541,12.6619119,1667m/data=!3m1!1e3!4m13!1m7!3m6!1s0x13106268d05359b3:0x10b042967b67d50!2sSicily,+Italy!3b1!8m2!3d37.5999938!4d14.0153557!3m4!1s0x13197a4e992b1a53:0x2bf98cc4f0b14f87!8m2!3d38.0933536!4d12.6708949!5m2!1e4!1e3"
		      "https://en.wikipedia.org/wiki/Madeira"
		      "https://www.google.com/flights/#search;f=GVA,ZHT;t=FNC;d=2017-12-20;r=2018-01-03;s=0;mc=m"
		      )
	 )
	)
      )

(defun google-it ()
  ""
  (interactive)
  (browse-url
   (concat "https://www.google.com/search?q=" (buffer-substring (mark) (point)))
   ))


(defun open-library ()
  "Opens all sites necessary to work on a customer"
  (interactive)
  (setq name (ido-completing-read "Pick a library? " (sort (mapcar 'car web-doc-alist) 'string<)))
  (bulk-open
   (append '(
	     "https://www.toggl.com/app/timer"
	     "https://mail.google.com/mail/u/0/?tab=mm#inbox"
	     )
	   (cdr (assoc name web-doc-alist)))
   name))


(defun update-wordpress ()
  "Run the import tool on each site"
  (interactive)
  (mapcar (lambda (site)
	    (browse-url (concat site "/wp-admin/update-core.php"))
	    ) '(
			"https://yntp.prod.medtronic-learning.com"
			"https://www.aura-software.com"
			"https://education.usada.org"
			"https://www.myenergytraining.com"
			"https://ynltp.com"
			"http://ccgcloud.aura-software.com"
			"http://demo.aura-software.com"
			"http://test.medtronic-learning.com"
			"http://yntp.test.medtronic-learning.com"
			"https://ncmm.aura-software.com"
			)
	  )
  )

