(declare-project 
      :name "jd"
      :description "A small utility script for helping jump to JD folders by their digits")


(declare-executable 
  :name "jd-jump"
  :entry "jd.janet")

# This relies on an "inst" program on your path that copies things to a location on your path.
(phony "inst" ["build"] 
       (print "Installing...")
       (os/cd "build")
       (os/shell "inst jd-jump.exe")
       (os/cd "..")
       (print "Installed"))

