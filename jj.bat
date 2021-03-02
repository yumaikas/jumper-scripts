@echo off

jd-jump.exe %* > C:\Users\yumai\Dev\.jmpfile
SET /P CD_TARGET=<C:\Users\yumai\Dev\.jmpfile
del C:\Users\yumai\Dev\.jmpfile
cd "%CD_TARGET%"
SET CD_TARGET=
