@ECHO OFF
SETLOCAL ENABLEDELAYEDEXPANSION
COLOR 0A
TITLE zyr batch rename tool
ECHO.
ECHO =================================
ECHO     ��ӭʹ��zyr������������
ECHO =================================
ECHO.
:START
SET /P filePath="��������Ҫ�滻��Դ·���ļ���(��Ҫ��������ͬĿ¼��): "
ECHO.
CHOICE /C yn /m "�Ƿ�Ҫ���Ƶ��µ��ļ���: "
IF %ERRORlEVEL% equ 1 SET createDir=1
IF %ERRORlEVEL% equ 2 SET createDir=0
ECHO.
IF !createDir! equ 1 (
    SET /P newFilePath="���������ļ�������: "
    IF defined newFilePath (
        xcopy !filePath! !newFilePath! /e /y /i
        SET filePath=!newFilePath!
    )
)
ECHO.
ECHO ��ѡ��Ҫ�����޸ĵĴ���ĺ�׺����
ECHO.
ECHO 1. �����ļ�(ֻ���޸��ļ���)
ECHO 2. java
ECHO 3. txt
ECHO 4. png
ECHO 5. ����,���Լ�������
ECHO.
CHOICE /C 12345 /m "���ѡ����: "
IF %ERRORlEVEL% equ 1 SET suffix=*
IF %ERRORlEVEL% equ 2 SET suffix=java
IF %ERRORlEVEL% equ 3 SET suffix=txt
IF %ERRORlEVEL% equ 4 SET suffix=png
IF %ERRORlEVEL% equ 5 (
    ECHO.
    SET /P suffix="������Ҫ��������ĺ�׺��: "
)
ECHO.
SET /P oldStr="��������Ҫ���滻������: "
SET /P newStr="��������Ҫ�滻������: "
ECHO.
ECHO �޸�ing...
ECHO.
SET /a index=0
FOR /r %filePath% %%i in (*.!suffix!) do (
    SET fileName=%%~ni
    ECHO !fileName!|findstr !oldStr!>nul 2>nul&&(
        SET /a index=!index!+1
        ECHO �滻��!index!���ļ���%%i��ʼ.
        SET fileSuffix=%%~xi
        SET fileName=!fileName:%oldStr%=%newStr%!!fileSuffix!
        REN %%i !fileName!
        ECHO �滻��!index!���ļ�%%i���滻Ϊ!fileName!����.
    )||(
        ECHO !fileName!������!oldStr!���ļ��������޸�
    )
)
ECHO.
PAUSE
goto START