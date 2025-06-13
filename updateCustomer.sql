ALTER TABLE Customer
ADD DEFAULT 'Not Provided' FOR idNum,
	DEFAULT 'South Africa' FOR nationality,
    DEFAULT 'noemail@gmail.com' FOR emailAddress,
	DEFAULT 'P@ssword123' FOR password,
	DEFAULT 'P@ssword123' FOR confPassword;
