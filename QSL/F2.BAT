bcc -IC:\CLIPPER5\INCLUDE -c -ml udfs.c
if not errorlevel 1 del mouse.obj
if not errorlevel 1 ren udfs.obj mouse.obj
if not errorlevel 1 f