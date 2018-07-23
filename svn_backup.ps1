### LogBackup Scripts By Leejuho. svn_backup_v1.ps1 
### Ư�� ��¥�� ������ ���� �� S3�� ���ε� ��
### �ҽ��������� Ư���Ⱓ�� ���� ������ ������(���ÿ� �����Ⱓ ������ �ʿ��� ���...)

### AWS S3 Default input params
$access = "Input the accesskey"
$private = "Input the secretkey"
$region = "ap-northeast-2"   # Regions: us-east-1, us-west-2, us-west-1, eu-west-1, ap-southeast-1, ap-southeast-2, ap-northeast-1, sa-east-1

# AWS SDK ��ġ ��, PowerShell���� �Ʒ� ����� Import �Ͽ��� ��
import-module "C:\Program Files (x86)\AWS Tools\PowerShell\AWSPowerShell\AWSPowerShell.psd1"
import-module "C:\Program Files\VisualSVN Server\PowerShellModules\VisualSVN\VisualSVN.psd1" ## SVN Module
Set-AWSCredentials -AccessKey $access -SecretKey $private
Set-DefaultAWSRegion $region

# AWS S3 Bucket ���
$bucket = "my-svn-mybackup"

# SVN Directory
$svn = "C:\Program Files\VisualSVN Server\bin"

# ��¥ ���� ����
$today = Get-Date -format "yyyy-MM-dd"                         # ����

# ���� ����
$svnFolder = "E:\Repositories\project_name_deploy"
$backupFolder = "E:\Backup"
$backupfile = "project_name_$today.dump"

# SVN Dump �����ϱ�
cmd /c "svnadmin dump $svnFolder > E:\Backup\$backupfile"

# Dump ���� S3 ���ε�
aws s3 cp E:\Backup\$backupfile s3://my-svn-backup/$backupfile

### Ư���Ⱓ�� ���� ���� ����
$DeleteDay = (Get-Date).AddDays(-14)
Get-ChildItem $backupFolder -Recurse | Where-Object {$_.LastWriteTime -lt $DeleteDay} | Remove-Item