### LogBackup Scripts By Leejuho. svn_backup_v1.ps1 
### 특정 날짜의 파일을 압축 후 S3에 업로드 함
### 소스폴더에서 특정기간이 지난 파일은 삭제함(로컬에 일정기간 보유가 필요한 경우...)

### AWS S3 Default input params
$access = "Input the accesskey"
$private = "Input the secretkey"
$region = "ap-northeast-2"   # Regions: us-east-1, us-west-2, us-west-1, eu-west-1, ap-southeast-1, ap-southeast-2, ap-northeast-1, sa-east-1

# AWS SDK 설치 후, PowerShell에서 아래 모듈을 Import 하여야 함
import-module "C:\Program Files (x86)\AWS Tools\PowerShell\AWSPowerShell\AWSPowerShell.psd1"
import-module "C:\Program Files\VisualSVN Server\PowerShellModules\VisualSVN\VisualSVN.psd1" ## SVN Module
Set-AWSCredentials -AccessKey $access -SecretKey $private
Set-DefaultAWSRegion $region

# AWS S3 Bucket 경로
$bucket = "my-svn-mybackup"

# SVN Directory
$svn = "C:\Program Files\VisualSVN Server\bin"

# 날짜 포맷 정의
$today = Get-Date -format "yyyy-MM-dd"                         # 오늘

# 저장 폴더
$svnFolder = "E:\Repositories\project_name_deploy"
$backupFolder = "E:\Backup"
$backupfile = "project_name_$today.dump"

# SVN Dump 생성하기
cmd /c "svnadmin dump $svnFolder > E:\Backup\$backupfile"

# Dump 파일 S3 업로드
aws s3 cp E:\Backup\$backupfile s3://my-svn-backup/$backupfile

### 특정기간이 지난 파일 삭제
$DeleteDay = (Get-Date).AddDays(-14)
Get-ChildItem $backupFolder -Recurse | Where-Object {$_.LastWriteTime -lt $DeleteDay} | Remove-Item