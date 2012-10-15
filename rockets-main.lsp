#!/usr/bin/env newlisp

(load "newlisp-rockets.lisp") ; this is where the magic happens!

; Rockets - Main Page
; 
; This is the first version of the self-hosted blog for newLISP on Rockets.
; The blog is designed to showcase how you would use Rockets for a real application.
; 
; Written 2012 by Rocket Man

(display-header "The newLISP on Rockets Blog")
(open-database "ROCKETS-BLOG")
(display-partial "rockets-checksignin") ; checks to see if user is signed in
(display-partial "rockets-common-functions") ; loads functions common to the blog but not part of Rockets
(set 'active-page "rockets-main")
(display-partial "rockets-navbar") ; shows the navigation bar with Rockets blog menus

(start-div "hero-unit")
	(display-image "rockets.png")
	(displayln "<h2>The newLISP on Rockets Blog</h2>")
	(displayln "<P>Currently running newLISP on Rockets version: " $ROCKETS_VERSION "</p>")
(end-div)

; get all existing posts
(set 'posts-count (int (first (first (query (string "SELECT Count(*) FROM Posts"))))))
(displayln "<p>Total posts: " posts-count)
(set 'posts-query-sql (string "SELECT * from Posts ORDER BY Id DESC LIMIT " Blog:posts-per-page ";"))
(set 'posts-result (query posts-query-sql))
; print out all posts
(dolist (x posts-result)
	(display-individual-post x)
)

; Twitter stuff
;(set 'twitter-term "salesforce")
;(displayln "<h3>Twitter searches containing: " twitter-term "</h3>")
;(twitter-search twitter-term 8)

; print post entry box
(if (= Rockets:UserId 0) (begin
	(display-post-box "Post something..." "postsomething" "rockets-post.lsp" "subjectline" "replybox" "Post Message")
)) ; only the site administrator may make new blog posts at the moment

; table structure:  ((0 "Id" "INTEGER" 0 nil 1) (1 "PosterId" "TEXT" 0 nil 0) (2 "PostDate" "DATE" 0 nil 0) (3 "PostSubject" "TEXT" 0 nil 0) (4 "PostContent" "TEXT" 0 nil 0))

(close-database)
(display-footer "Rocket Man")
(display-page) ; this is needed to actually display the page!

