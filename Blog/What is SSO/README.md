![image](https://github.com/user-attachments/assets/3cd73913-4483-4ccc-8fcf-517ec37395b8)

What is SSO (Single Sign-On)?

Single Sign-On (SSO) is an authentication scheme that allows users to access multiple systems with just one set of login credentials.

First-Time Login Process

Step 1: A user visits a service (in this example, Gmail). The service detects the user is not logged in and redirects them to their configured SSO authentication server. The SSO server confirms the user is not logged in and directs them to the SSO login page, where they enter their credentials.

Steps 2-3: The SSO authentication server:

- Validates the user's credentials
- Creates a global session for the user
- Generates a security token

Steps 4-7: The original service (Gmail):

- Validates the token with the SSO authentication server
- Gets registered in the authentication server
- Receives confirmation that the token is "valid"
- Grants the user access to their protected resources

Accessing Additional Services

Step 8: From the first service, the user navigates to another service that uses the same SSO provider (for example, YouTube).

Steps 9-10: The second service:

- Detects the user is not logged in within its system
- Requests authentication from the SSO server
- The SSO server recognizes the user is already logged in and provides the token

Step 11-14: The second service:

- Validates the token with the SSO authentication server
- Gets registered in the authentication server
- Receives confirmation that the token is "valid"
- Grants the user access to their protected resources

The process is now complete, and the user can access both services without having to log in again.

--
Subscribe to our weekly newsletter to get a Free System Design PDF (158 pages): https://bit.ly/496keA7
