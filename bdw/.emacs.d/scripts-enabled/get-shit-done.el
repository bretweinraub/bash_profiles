(defun Gitlab-build-ticket-urls (repo-spec &optional suffix)
  (let ((repo-owner (car repo-spec))
	(repo-list (cdr repo-spec)))
    (mapcar (lambda (repo)
	      (cons repo (concat "https://code.aura-software.com/" repo-owner "/" repo
				 (if suffix
				     (concat "/" suffix)))))
	    repo-list)))

(defun Gitlab-url-builder (l &optional suffix)
  "Takes a list of lists ... calls Gitlab-build-ticket-urls on each element a appends to result to itself
\(fn LIST)"
  (if l
      (append (Gitlab-build-ticket-urls (car l) suffix) (Gitlab-url-builder (cdr l) suffix))
    nil))

 (defun Gitlab-select-and-browse-to-repo (url-list)
   (browse-url (cdr (assoc (ido-completing-read "Pick a repo? " (sort (mapcar 'car url-list) 'string<))
			   url-list))))

(defun Gitlab-build-urls (repo-list key-spec)
  "Takes two arguments.  Argument one is list of repo lists.   Each repo list should be of format

(owner repo-name1 repo-name2 .... repo-nameN) ; all strings

Argument 2 is a key spec, a list of cons pairs of format

(url-part-to-append key-binding)

\(fn REPO-LIST-LIST KEY-SPEC)
"
  (mapcar (lambda (gitlab-spec)
	  (lexical-let ((url-assoc-list (Gitlab-url-builder repo-list (car gitlab-spec)))
			(key-binding (cdr gitlab-spec)))
	    (global-set-key (kbd (concat "C-c C-g " key-binding))
			    (lambda ()
			      (interactive)
			      (Gitlab-select-and-browse-to-repo url-assoc-list)
			      ))))
	key-spec))

(Gitlab-build-ur
 (list
  (list "bretweinraub" "bdw" "fin3" "bash_profiles" "sales")
  (list "aura" "BrightSettings" "alexion" "aura-bright-child-theme" "aur-bright-login-box-plugin" "aura-bright-multisite-search" 
	"aura-bright-multisite-setup" "aura-di" "aura-docs" "aura-extensions" "aura-quote" "aura-rover-config" "aura-scorm-course-uploader"
	"aura-scripts" "aura-site" "aura-store" "aura-website" "aura_dashboard" "aura_dashboard_app" "aura_dashboard_sample" "aura_visualize"
	"aurawww-apacheconfig" "bright" "bright-backbone-experiments" "bright-bright-customizations" "bright-divi-child" "bright-editor"
	"bright-hover-launchers" "bright-network-blogdumps" "bright-overreact" "bright-simple-ui.js" "bright-telegram-client"
	"bright_app" "bright_ci" "brookings" "brookings-gap" "careofskills-bright-customizations" "ccgcloud-bright-customizations"
	"ckuru-tools" "configuratrix" "coursefair" "csmaprb" "dashboard-widget-builder" "docker-builds" "dominknow"
	"event-espresso" "fishnick-bright-customizations" "fishnick-storefront-child-theme" "fk_generator" "fulcra"
	"handlebars.rb" "hobo" "insight-admin-console" "internal" "justculture-bright-customizations" "legacy_onswipe"
	"marketing" "mdt_bright_integration" "medonline-bright-customizations" "medtronic"
	"medtronic-brightapp-extensions" "medtronic-network-theme" "medtronic_auto_open" "mma-brightapp-extensions"
	"ncmm-bright-customizations" "ncmm-survey-quizzage-generator" "ncmm-theme" "neuro-bright-customizations"
	"oe-magnium-child" "oe-rca-server" "oe-scroller-child" "overreact" "qna" "rails_sql_views" "restore_courses"
	"rover" "rover-mma" "scorm-cloud" "scorm_cloud_ftp" "scormcloud_archive" "scroller"
	"silverbullet-bright-customizations" "slimtimer4trac" "st-bright-customizations" "tensentric-scripts"
	"toggl-button" "usada-storefront-child-theme" "vinca-bright-customizations" "wedocs-aura-child"
	"wordpress_hooks" "wp-advanced-taxonomy-terms-order" "wp-aura-edudip" "wp-aura-social-connect"
	"wp-aura_bulk_register" "wp-bolder-theme" "wp-bright-learning-paths" "wp-bright-plugin"
	"wp-bright-template-pack" "wp-bright-woocommerce-integration" "wp-canvas" "wp-category-posts-list"
	"wp-courseware" "wp-dorayaki" "wp-download-manager" "wp-email-login" "wp-ematico" "wp-embed-rails"
	"wp-eventure-theme" "wp-filebase-pro" "wp-frank-derma" "wp-grassblade" "wp-headway" "wp-jnewsticker"
	"wp-learningpaths" "wp-limit-login-attempts" "wp-login-logger" "wp-medmed-woodojo"
	"wp-medonline-authentication" "wp-medonline-bright-customizations" "wp-medonline-jscreensaver"
	"wp-medtronic-plugin" "wp-modal-login" "wp-multisite-url-fixer" "wp-myhub-onswipe" "wp-mystile-theme"
	"wp-newsletter-custom" "wp-openid" "wp-penman-bright-customizations" "wp-public-pages" "wp-scorm-cloud-plugin"
	"wp-seedprod-coming-soon-pro" "wp-symposium" "wp-symposium-blogpost" "wp-typekit-fonts-for-wordpress"
	"wp-usada-auth" "wp-usada-bright-customizations" "wp-usada-mantra-child" "wp-usada-waipoua" "wp-waipoua"
	"wp-white-label-branding-multisite" "ws3-admin" "ws3-services" "wsccf" "www.22000-tools.com" "yntp-ynltp"
	"yogau-paypal"))
 '(
   ("issues" . "i")
   ("". "r")
   ("boards" . "b")
   ))
     




