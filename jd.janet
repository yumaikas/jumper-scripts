(import path)
(import stringx :as str)

(defn s. [& args] (string ;args))

(def jd-patt (peg/compile ~{ :main (* (<- (between 1 3 :d) ) "." (<- (between 1 3 :d))) }))

(defn exit-no-jump [msg] 
  (eprint msg)
  (print "."))



(defn main [_ & sargs]
  (unless (> (length sargs) 0)
    (exit-no-jump "No JD number given") (break))
  (def argy (string/join sargs " "))
  (def drill (peg/match jd-patt argy))

  (unless drill
    (exit-no-jump (s. argy " isn't a valid JD number!")) (break))

  (def jd-folder (os/getenv "JD_FOLDER"))
  (unless jd-folder
    (exit-no-jump "JD_FOLDER isn't set, we can't do a jj jump!") (break))


  (def first-dig (get-in drill [0 0]))
  (os/cd jd-folder)
  (def [dive] (filter |(= ($ 0) first-dig) (os/dir ".")) )
  # XX.XX
  # ^--------
  (unless dive
    (exit-no-jump "The number you gave didn't correspond to a folder!"))
  (os/cd dive)
  # XX.XX
  # ^^-------
  (def [dive] (filter |(= (slice $ 0 2) (drill 0)) (os/dir ".")))
  (unless dive
    (exit-no-jump "The number you gave didn't correspond to a folder!"))
  (os/cd dive)

  # XX.XX
  #    ^^-----
  (def [dest] (as-> (map |[$ (peg/match jd-patt $)] (os/dir ".")) it
                    # Make sure we have matching dirs
                    (filter |(match $ [dir _] dir) it) 
                    # Second half of drill, 
                    (filter |(= (drill 1) (get-in $ [1 1]) ) it)
                    (first it)))
  (unless dest
    (exit-no-jump "The number you gave didn't correspond to a folder!"))
  (print (path/join (os/cwd) dest)))
