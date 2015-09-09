{ 	echo 'mail from: noreply@company.com'; 
	echo 'rcpt to: zachreed@company.com';
	echo 'data';
	echo $logError;
	echo '.';
	echo 'quit';
} 

| telnet company.com.1.0001.arsmtp.com smtp