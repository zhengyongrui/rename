@ECHO OFF
SETLOCAL ENABLEDELAYEDEXPANSION
COLOR 0A
TITLE zyr batch rename tool
ECHO.
ECHO =================================
ECHO     欢迎使用zyr批量命名工具
ECHO =================================
ECHO.
:START
SET /P filePath="请输入你要替换的源路径文件名(需要在批处理同目录下): "
ECHO.
CHOICE /C yn /m "是否要复制到新的文件夹: "
IF %ERRORlEVEL% equ 1 SET createDir=1
IF %ERRORlEVEL% equ 2 SET createDir=0
ECHO.
IF !createDir! equ 1 (
    SET /P newFilePath="请输入新文件夹名称: "
    IF defined newFilePath (
        xcopy !filePath! !newFilePath! /e /y /i
        SET filePath=!newFilePath!
    )
)
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
ECHO.
SET /a index=0
FOR /r %filePath% %%i in (*.!suffix!) do (
    SET fileName=%%~ni
    ECHO !fileName!|findstr !oldStr!>nul 2>nul&&(
        SET /a index=!index!+1
        ECHO 替换第!index!个文件名%%i开始.
        SET fileSuffix=%%~xi
        SET fileName=!fileName:%oldStr%=%newStr%!!fileSuffix!
        REN %%i !fileName!
        ECHO 替换第!index!个文件%%i被替换为!fileName!结束.
    )||(
        ECHO !fileName!不包含!oldStr!，文件名不被修改
    )
)
ECHO.
PAUSE
goto START