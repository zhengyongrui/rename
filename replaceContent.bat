@ECHO OFF
SETLOCAL ENABLEDELAYEDEXPANSION
COLOR 0A
TITLE zyr batch ReplaceContent tool
ECHO.
ECHO =================================
ECHO     欢迎使用zyr批量替换文件内容工具
ECHO =================================
ECHO.
:START
SET /P filePath="请输入你要替换的源路径文件名(需要在批处理同目录下): "
ECHO.
ECHO 请选择要批量修改的处理的后缀名：
ECHO.
ECHO 1. 所有文件(只会修改文件名)
ECHO 2. java
ECHO 3. txt
ECHO 4. png
ECHO 5. 其他,我自己来输入
ECHO.
CHOICE /C 12345 /m "你的选择是: "
IF %ERRORlEVEL% equ 1 SET suffix=*
IF %ERRORlEVEL% equ 2 SET suffix=java
IF %ERRORlEVEL% equ 3 SET suffix=txt
IF %ERRORlEVEL% equ 4 SET suffix=png
IF %ERRORlEVEL% equ 5 (
    ECHO.
    SET /P suffix="请输入要批量处理的后缀名: "
)
ECHO.
SET /P oldStr="请输入你要被替换的文字: "
SET /P newStr="请输入你要替换的文字: "
ECHO.
ECHO 修改ing...
SET /a index=0
FOR /r %filePath% %%i in (*.!suffix!) do (
    SET fileFullName=%%i
    (for /f "tokens=1* delims=:" %%a in ('findstr /n ".*" !fileFullName!') do (
        SET str=%%b
        IF "!str!" neq "" (
            ECHO !str!|findstr !oldStr!>nul 2>nul&&(
                SET str=!str:%oldStr%=%newStr%!
            )
        )
        echo,!str!
    ))>!fileFullName!.tmp
    move !fileFullName!.tmp !fileFullName!>nul 2>nul
)
ECHO.
PAUSE
goto START