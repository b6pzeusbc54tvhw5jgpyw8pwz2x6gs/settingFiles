# Multiple Names on One Certificate

[From http://apetec.com/support/GenerateSAN-CSR.htm](http://apetec.com/support/GenerateSAN-CSR.htm)
	
## Configuring ssl requests with SubjectAltName with openssl

With Multiple Domain Certificates you can secure a larger number of domains with only one certificate. Subject Alternative Names are a X509 Version 3 (RFC 2459) extension to allow an SSL certificate to specify multiple names that the certificate should match. SubjectAltName can contain email addresses, IP addresses, regular DNS host names, etc. This uses an SSL feature called SubjectAlternativeName (or SAN, for short).

## Generate the Certificate Request File

For a generic SSL certificate request (CSR), openssl doesn't require much fiddling. Since we're going to add a SAN or two to our CSR, we'll need to add a few things to the openssl conf file. You need to tell openssl to create a CSR that includes x509 V3 extensions and you also need to tell openssl to include a list of subject alternative names in your CSR.

Create an openssl configuration file which enables subject alternative names (openssl.cnf):

In the `[req]` section. This is the section that tells openssl what to do with certificate requests (CSRs).
Within that section should be a line that begins with `req_extensions`. We'll want that to read as follows:

```
[req]
distinguished_name = req_distinguished_name
req_extensions = v3_req
```

This tells openssl to include the v3_req section in CSRs. 
Now we'll go own down to the v3_req section and make sure that it includes the following:

```

[req_distinguished_name]
countryName = Country Name (2 letter code)
countryName_default = US
stateOrProvinceName = State or Province Name (full name)
stateOrProvinceName_default = MN
localityName = Locality Name (eg, city)
localityName_default = Minneapolis
organizationalUnitName	= Organizational Unit Name (eg, section)
organizationalUnitName_default	= Domain Control Validated
commonName = Internet Widgits Ltd
commonName_max	= 64

[ v3_req ]
# Extensions to add to a certificate request
basicConstraints = CA:FALSE
keyUsage = nonRepudiation, digitalSignature, keyEncipherment
subjectAltName = @alt_names

[alt_names]
DNS.1 = kb.example.com
DNS.2 = helpdesk.example.org
DNS.3 = systems.example.net
IP.1 = 192.168.1.1
IP.2 = 192.168.69.14
```

Note that whatever we put here will appear on all CSRs generated from this point on: if at a later date you want to generate a CSR with different SANs, you'll need to edit this file and change the DNS.x entries.

## Generate a private key

You'll need to make sure your server has a private key created:
```
openssl genrsa -out san_domain_com.key 2048
```
Where doman is the FQDN of the server you're using. That's not necessary, BTW, but it makes things a lot clearer later on.

## Create the CSR file

Then the CSR is generated using:
```
openssl req -new -out san_domain_com.csr -key san_domain_com.key -config openssl.cnf
```
You'll be prompted for information about your organization, and it'll ask if you want to include a passphrase (you don't). It'll then finish with nothing much in the way of feedback. But you can see that san_domain_com.csr has been created.

It's nice to check our work, so we can take a look at what the csr contains with the following command:
```
openssl req -text -noout -in san_domain_com.csr         
```

You should see some output like below. Note the Subject Alternative Name section:
```
Certificate Request:
Data:
Version: 0 (0x0)
Subject: C=US, ST=Texas, L=Fort Worth, O=My Company, OU=My Department, CN=server.example
Subject Public Key Info: Public Key Algorithm: rsaEncryption RSA Public Key: (2048 bit)
Modulus (2048 bit): blahblahblah
Exponent: 65537 (0x10001)
Attributes:
Requested Extensions: X509v3
Basic Constraints: CA:FALSE
X509v3 Key Usage: Digital Signature, Non Repudiation, Key Encipherment
X509v3 Subject Alternative Name: DNS:kb.example.com, DNS:helpdesk.example.com
Signature Algorithm: sha1WithRSAEncryption
blahblahblah        
```
So now we've got a shiny new CSR. But, of course, we have to sign it.

## Self-sign and create the certificate:
```
openssl x509 -req -days 3650 -in san_domain_com.csr -signkey san_domain_com.key
 -out san_domain_com.crt-extensions v3_req -extfile openssl.cnf
```

## Package the key and cert in a PKCS12 file:

The easiest way to install this into IIS is to first use openssl’s pkcs12 command to export both the private key and the certificate into a pkcs12 file:
```
openssl pkcs12 -export -in san_domain_com.crt -inkey san_domain_com.key
 -out san_domiain_com.p12
```

## Import the certificate

Copy the file over to the server and import it there. You need to import it into the local computer’s certificate store. Open IIS Manager, select your server on right pane, double click Server Certificates, and click Import under Actions on the right pane. Browse to your *.p12 file and enter the p/w (allow cert to be exported checked).

Now you can go to one of your servers, edit the “bindings” and select this certificate for SSL. However, you will probably find the “Host name” box greyed out, which is something IIS routinely does for SSL bindings.

The fix is simple: Start mmc, add the Certificates snap-in for the local computer, find your certificate under “Personal”, double click on it, go to Details and click “Edit Properties…”. Now you get to add a “friendly name” to the certificate, and there’s the key. Set the name to “*.domain.com” and go back to the IIS Management Console. Vollalla! Now you can edit the Host name.

After this fix, you can change the SSL binding for all those web servers to use the same certificate and IP address, and also to use name-based virtual host selection!

## Configure SSL Settings

Configure SSL settings if you want your site to require SSL, or to interact in a specific way with client certificates. Click the site node in the tree view to go back to the site's home page. Double-click the `SSL Settings` feature in the middle pane.




# my case
rootCA 로 부터 발급받기
```
openssl x509 -req -days 3650 -in san_domain_com.csr -signkey san_domain_com.key -out san_domain_com.crt -CA rootCA.crt -CAkey rootCA.key
```

이때 rootCA 와 san_domain_com 의 commonName 은 반드시 같아야한다.
그렇지 않으면 기관과 이슈어의 commonName 이 다르다면서 INVALID_COMMON_NAME ? 이런 에러가난다(크롬에서)

rootCA 키 발급부터 정리하자면,

```
openssl genrsa -out rootCA.key 2048
openssl req -x509 -new -nodes -key rootCA.key -days 365 -out rootCA.crt
openssl genrsa -out san_domain_com.key 2048
openssl req -new -out san_domain_com.csr -key san_domain_com.key -config openssl.cnf
openssl x509 -req -days 3650 -in san_domain_com.csr -signkey san_domain_com.key -out san_domain_com.crt -CA rootCA.crt -CAkey rootCA.key
```

내가 사용한 `openssl.cnf`
```
[req]
distinguished_name = req_distinguished_name
req_extensions = v3_req

[req_distinguished_name]
countryName = Country Name (2 letter code)
countryName_default = US
stateOrProvinceName = State or Province Name (full name)
stateOrProvinceName_default = MN
localityName = Locality Name (eg, city)
localityName_default = Minneapolis
organizationalUnitName	= Organizational Unit Name (eg, section)
organizationalUnitName_default	= Domain Control Validated
commonName = Common Name(max 64)
commonName_default = Your own utopos
commonName_max	= 64

[ v3_req ]
# Extensions to add to a certificate request
basicConstraints = CA:FALSE
keyUsage = nonRepudiation, digitalSignature, keyEncipherment
subjectAltName = @alt_names

[alt_names]
DNS.1 = utopos.me
DNS.2 = *.utopos.me
IP.1 = 127.0.0.1
```
