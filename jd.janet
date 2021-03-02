(import path)
(import stringx :as str)
# For now, this is going to rely on fd existing on your system
(defn main [_ & sargs]
  (os/cd (or (os/getenv "JD_FOLDER") (error "jj doesn't work without JD_FOLDER set!")))
  (def fdproc (os/spawn ["fd" ;sargs] :p {:out :pipe}))
  (def output (:read (fdproc :out) :all))
  (if output
    (print (path/join (os/getenv "JD_FOLDER") (first (str/lines output))))
    (print "."))
  (:kill fdproc))
