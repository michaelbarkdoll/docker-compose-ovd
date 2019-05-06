# Examples of guacamole api usage


shell
```
curl -X POST -H 'Content-Type: application/x-www-form-urlencoded' -d 'username=guacadmin&password=guacadmin' localhost:8080/guacamole/api/tokens
```

bash
```
{"authToken":"9AB218C016868F5636548E2E5B0A21FFF681BD80CD379CD7A748EB62BBDC4B30","username":"guacadmin","dataSource":"mysql","availableDataSources":["mysql","mysql-shared"]}
```

shell
```
curl -k -X POST -H 'Content-Type: application/x-www-form-urlencoded' -d 'username=guacadmin&password=guacadmin' https://10.100.70.96/guacamole/api/tokens
```
bash
```
{"authToken":"1D9F0703DDB683C8D580F7A604AAADFC5571398B4570F852B21125F98DAD83D9","username":"guacadmin","dataSource":"mysql","availableDataSources":["mysql","mysql-shared"]}
```

This will generate a one time token for that user to login with then it will 
expire, but the connection will remain as long as the session is active in 
the browser.  The return/redirect link should look like this: 

https://<Guacamole>/guacamole/#/client/?token=5AD2069FD0F6788848BBE23B6095816EA2B5CEBB1EF07F76051010E050C70063 

Our Provisioning system does all this on the fly and manages Guacamole 
directly. 

#

Yes, just about everything that is part of the Guacamole Client operates via an API.  My best suggestion for seeing these calls would be to use the Developer Console in a web browser (e.g. Chrome Developer Console) to view the network calls while going through the web interface and you'll be able to pick out the API calls and see the various responses.  For retrieving the current users, you should see calls to the following endpoint:

http://hostname:8080/guacamole/api/session/data/<DATASOURCE>/users?token=<LOGIN TOKEN>
 
Where <DATASOURCE> is the name of the location where the users are stored (e.g. postgresql, ldap, etc.) and <LOGIN TOKEN> is the login token you
received from logging into the Guacamole interface.  I also wrote some sample Python code that leverages the API - you can take a look at that and see an example of programmatically logging into the interface and getting a token, and then gathering data from various endpoints.  I don't think I did anything with users, but it should be pretty easy to see how it works.

