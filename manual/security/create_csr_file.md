```
$ openssl req -new -newkey rsa:2048 -nodes -keyout mydomain.com.key -out mydomain.com.csr
Generating a 2048 bit RSA private key
........+++
.....+++
writing new private key to 'mydomain.com.key'
-----
You are about to be asked to enter information that will be incorporated
into your certificate request.
What you are about to enter is what is called a Distinguished Name or a DN.
There are quite a few fields but you can leave some blank
For some fields there will be a default value,
If you enter '.', the field will be left blank.
-----
Country Name (2 letter code) [AU]:KO
State or Province Name (full name) [Some-State]:KO
Locality Name (eg, city) []:
Organization Name (eg, company) [Internet Widgits Pty Ltd]:devp
Organizational Unit Name (eg, section) []:devp
Common Name (e.g. server FQDN or YOUR name) []:*.mydomain.com
Email Address []:

Please enter the following 'extra' attributes
to be sent with your certificate request
A challenge password []:
An optional company name []:

~/ssl ssohjiro@ssohjiroUbuntu14 13s
❯ cat mydomain.com.csr
-----BEGIN CERTIFICATE REQUEST-----
X
-----END CERTIFICATE REQUEST-----
```
